
UILiLianControl=gameState.addListener(fullScreenUI.create())

function UILiLianControl:onAppStart()
socketManager:register_receiver(25,1,self.recv_25_1)
socketManager:register_receiver(25,2,self.recv_25_2)
socketManager:register_receiver(25,3,self.recv_25_3)
socketManager:register_receiver(25,4,self.recv_25_4)
socketManager:register_receiver(25,5,self.recv_25_5)

local args=
{
fullType=FULL_TYPE.eLiLianTuiTu,
skinType=fullScreenSkinType.eSkin1,
}
self:initUI(args)
end

function UILiLianControl:onEnterState(...)
self.data={}

self.levelRewardCheck={}
self.levelRewardRecord={}

self.tzRewardCheck={}
self.tzRewardRecord={}

self.caphaterRewardDict={}
self.levelRewardDict={}
local cfgs=cfg_chapterconfig()
for k,v in pairs(cfgs)do
self.caphaterRewardDict[k]={id=k,level=v.rw_level}
end
cfgs=cfg_guanqiaconfig()
for k,v in pairs(cfgs)do
local rwId=v.extra_rewards
if rwId then
local cpt=self.caphaterRewardDict[v.chapter_id]
if cpt.level==k then
cpt.rwId=rwId
else
self.levelRewardDict[k]={id=k,rwId=rwId}
end
end
end
end

function UILiLianControl:onLeaveState(...)
self.data=nil
end

function UILiLianControl:showLiLianWindow(argstable)
local args=
{
showBg=false,
showFg=false,
viewNames={'UILiLianWin'},
viewArgs={['UILiLianWin']=argstable},
showMain=false,
}
self:showUI(args)
end

function UILiLianControl:recordZFID(zfId)
self.data.zfId=zfId
end

function UILiLianControl:getZFID()
return self.data.zfId or 0
end

function UILiLianControl:isCanChallenge(id)
local cfg=cfgHelper.get1(cfg_guanqiaconfig_get,id)
for i,v in ipairs(cfg.conditions)do
local ltype=v[1]
local val=v[2]
if ltype==1 then
local zmLevel=zongmenModel:getLevel()
if zmLevel<val then
return false
end
end
end
return true
end

function UILiLianControl:isCanChallengeNext()
local clevel=self:getCurrentLevel()
local nlevel=self:getNextLevel()
if nlevel>clevel then
if self:isCanChallenge(nlevel)then
return true
end
end

return false
end

function UILiLianControl:getLevelName(prefix,id)
local chapter=cfgHelper.get2(cfg_guanqiaconfig_get,id,'chapter_id')
local stLevel=cfgHelper.get2(cfg_chapterconfig_get,chapter,'st_level')
local name=FMT.fmt('{0}{1}-{2}',prefix,chapter,id-stLevel+1)
return name
end

function UILiLianControl:getTZRewardList(rechargeId)
local levelRewards=cfgHelper.get2(cfg_guanqiainvestconfig_get,rechargeId,'guanqia_rewards')
local rlist={}
local investData=UILiLianControl:getInvestData()
for k,v in pairs(levelRewards)do
table.insert(rlist,{level=k,rwId=v[1],receive=investData.receivedData[k]==true})
end
table.sort(rlist,function(a,b)
if not a.receive and b.receive then
return true
elseif a.receive==b.receive then
return a.level<b.level
else
return false
end
end)
return rlist
end

function UILiLianControl:recordLevelReward(id)
local extra_rewards=cfgHelper.get2(cfg_guanqiaconfig_get,id,'extra_rewards')
local rwId=extra_rewards[1]
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,rwId)
local rewards=rwcfg.showItems

for i,v in ipairs(rewards)do
local count=self.levelRewardRecord[v[1]]or 0
self.levelRewardRecord[v[1]]=count+v[2]
end

self.levelRewardCheck[id]=nil
local isFinish=next(self.levelRewardCheck)==nil
if isFinish then
local showRW={}
for k,v in pairs(self.levelRewardRecord)do
showPrizeControl.insertTemp(showRW,nil,k,v)
end
showPrizeControl.showWindow(showRW,nil)
self.levelRewardRecord={}
UIManager:invokeUIMethod('UILiLianRewardWin','refresh')
UIManager:invokeUIMethod('UILiLianWin','refresh')
end
end

function UILiLianControl:setLevelRewardCheck(id)
self.levelRewardCheck[id]=true
end

function UILiLianControl:recordTZReward(id)
local investData=UILiLianControl:getInvestData()
local levelRewards=cfgHelper.get2(cfg_guanqiainvestconfig_get,investData.rechargeId,'guanqia_rewards')
local rwId=levelRewards[id][1]
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,rwId)
local rewards=rwcfg.showItems

for i,v in ipairs(rewards)do
local count=self.tzRewardRecord[v[1]]or 0
self.tzRewardRecord[v[1]]=count+v[2]
end

self.tzRewardCheck[id]=nil
local isFinish=next(self.tzRewardCheck)==nil
if isFinish then
local showRW={}
for k,v in pairs(self.tzRewardRecord)do
showPrizeControl.insertTemp(showRW,nil,k,v)
end
showPrizeControl.showWindow(showRW,nil)
self.tzRewardRecord={}
UIManager:invokeUIMethod('UILiLianTouZiWin','refresh')
UIManager:invokeUIMethod('UILiLianWin','refresh')
end
end

function UILiLianControl:setTZRewardCheck(id)
self.tzRewardCheck[id]=true
end



function UILiLianControl:setData(datas)
local currId=datas[1]
local arr=datas[3]

local chapter
local cfg=cfgHelper.get1(cfg_guanqiaconfig_get,currId)
if cfg then
chapter=cfg.chapter_id
else
chapter=1
end

self.data.currentLevel=currId

local levelData={}
if arr then
for i,v in ipairs(arr)do
levelData[v.param_1]=v.param_2
end
end
self.data.levelData=levelData

local finishChapter={}
if datas[7]then
for i,v in ipairs(datas[7])do
finishChapter[v]=true
end
end
self.data.finishChapter=finishChapter

if self:isChapterFinish(chapter)then
chapter=self:getNextChapter()
end
self.data.chapter=chapter

local investData={}
if datas[9]then
local data=datas[9][1]
investData.rechargeId=data.recharge_id
investData.paid=data.status==1
local rwlevel={}
if data.guanqiaIds then
for i,v in ipairs(data.guanqiaIds)do
rwlevel[v]=true
end
end
investData.receivedData=rwlevel
end
self.data.investData=investData
end

function UILiLianControl:getInvestData()
return self.data.investData
end

function UILiLianControl:finishChapter(cId)
self.data.finishChapter[cId]=true
end

function UILiLianControl:isChapterFinish(cId)
return self.data.finishChapter[cId]==true
end

function UILiLianControl:setChapter(id)
self.data.chapter=id
end

function UILiLianControl:getChapter()
return self.data.chapter
end

function UILiLianControl:getNextChapter()
local level=self:getNextLevel()
return self:getChapterById(level)
end

function UILiLianControl:getChapterById(id)
local chapter=cfgHelper.get2(cfg_guanqiaconfig_get,id,'chapter_id')
return chapter
end

function UILiLianControl:getCurrentLevel()
return self.data.currentLevel
end

function UILiLianControl:getNextLevel()
if self.data.currentLevel>0 then
local cfg=cfgHelper.get1(cfg_guanqiaconfig_get,self.data.currentLevel)
return cfg.next_id and cfg.next_id or self.data.currentLevel
end
return 1
end

function UILiLianControl:getLevelReceiveState(id)
local state=self.data.levelData[id]
if state then
return state
else
return-1
end
end

function UILiLianControl:setlevelReceiveState(id,state)
self.data.levelData[id]=state
end

function UILiLianControl:isLevelComplete(id)
local curr=self:getCurrentLevel()
return id<=curr
end

function UILiLianControl:getChapterRewardData()
return self.caphaterRewardDict
end

function UILiLianControl:getLevelRewardData()
return self.levelRewardDict
end

function UILiLianControl:getChapterProgressRate(id)
local cfg=cfgHelper.get1(cfg_chapterconfig_get,id)
local count=0
for i,v in ipairs(cfg.guanqia_ids)do
local state=self:getLevelReceiveState(v)
if state>=0 then
count=count+1
end
end
return count,#cfg.guanqia_ids
end

function UILiLianControl:isChapterComplete(id)
local cfg=cfgHelper.get1(cfg_chapterconfig_get,id)
for i,v in ipairs(cfg.guanqia_ids)do
local state=self:getLevelReceiveState(v)
if state==-1 then
return false
end
end
return true
end

function UILiLianControl:onLevelComplete()
self.data.currentLevel=self:getNextLevel()

self:setlevelReceiveState(self.data.currentLevel,0)
end



function UILiLianControl:reqLevelData()
socketManager:send_25_1()
end

function UILiLianControl:reqLevelReward(id)
socketManager:send_25_2(id)
end

function UILiLianControl:reqFinishChapter(id)
socketManager:send_25_3(id)
end

function UILiLianControl:reqReceiveInvest(payId,level)
socketManager:send_25_4(payId,level)
end



function UILiLianControl.recv_25_1(datas)
UILiLianControl:setData(datas)
end

function UILiLianControl.recv_25_2(id)
UILiLianControl:setlevelReceiveState(id,1)
UILiLianControl:recordLevelReward(id)
end

function UILiLianControl.recv_25_3(id)
UILiLianControl:setChapter(UILiLianControl:getNextChapter())
UILiLianControl:finishChapter(id)
UIManager:invokeUIMethod('UILiLianWin','refresh')
end

function UILiLianControl.recv_25_4(payId,level)
local data=UILiLianControl:getInvestData()
data.receivedData[level]=true
UILiLianControl:recordTZReward(level)
end

function UILiLianControl.recv_25_5(payId)
local data=UILiLianControl:getInvestData()
data.paid=true
UIManager:invokeUIMethod('UILiLianTouZiWin','refresh')
UIManager:invokeUIMethod('UILiLianWin','refresh')

local lcfg=cfgHelper.get1(cfg_guanqiainvestconfig_get,data.rechargeId)
local rwId=lcfg.recharge_rewards[1]
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,rwId)
local rewards=rwcfg.showItems

local showRW={}
for i,v in ipairs(rewards)do
showPrizeControl.insertTemp(showRW,nil,v[1],v[2])
end
showPrizeControl.showWindow(showRW,nil)
end



function UILiLianControl:isShowLiLianReddot()
return self:isShowRewardReddot()or self:isShowTouZiReddot()
end

function UILiLianControl:isShowRewardReddot()
local datas=UILiLianControl:getChapterRewardData()
for k,v in pairs(datas)do
local state=UILiLianControl:getLevelReceiveState(v.level)
if state==0 then
return true
end
end

datas=UILiLianControl:getLevelRewardData()
for k,v in pairs(datas)do
local state=UILiLianControl:getLevelReceiveState(k)
if state==0 then
return true
end
end

return false
end

function UILiLianControl:isShowTouZiReddot()
local investData=UILiLianControl:getInvestData()
local levelRewards=UILiLianControl:getTZRewardList(investData.rechargeId)
local unlock=investData.paid
if not unlock then
return false
end
for i,v in ipairs(levelRewards)do
local complete=UILiLianControl:isLevelComplete(v.level)
if complete and not v.receive then
return true
end
end
return false
end