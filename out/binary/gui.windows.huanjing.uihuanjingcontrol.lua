
UIHuanJingControl=gameState.addListener(fullScreenUI.create())

function UIHuanJingControl:onAppStart()
socketManager:register_receiver(25,6,self.recv_25_6)
socketManager:register_receiver(25,7,self.recv_25_7)
socketManager:register_receiver(25,8,self.recv_25_8)
socketManager:register_receiver(25,9,self.recv_25_9)
socketManager:register_receiver(25,10,self.recv_25_10)
socketManager:register_receiver(25,11,self.recv_25_11)
socketManager:register_receiver(25,12,self.recv_25_12)
socketManager:register_receiver(25,13,self.recv_25_13)
socketManager:register_receiver(25,14,self.recv_25_14)
socketManager:register_receiver(25,51,self.recv_25_51)


self:onAppStart_ZhengLing()

local menulist=
{
{tabType=FULL_TAB_TYPE.eShiLianRuKou,callback=function(...)self:showSelectWindow(...)end,
sendCallback=function()end},
{tabType=FULL_TAB_TYPE.eHouShanShiLian,callback=function(...)self:showLiLianWindow(...)end,
sendCallback=function()end},
{tabType=FULL_TAB_TYPE.eMeiRiTiaoZhan,callback=function(...)self:showDayChallengeWindow(...)end,
sendCallback=function()end},
{tabType=FULL_TAB_TYPE.eHouShanJinDi,callback=function(...)self:showJinDiWindow(...)end,
sendCallback=function()end},
{tabType=FULL_TAB_TYPE.eHouShanZhenLing,callback=function(...)self:showZhenLingWindow(...)end,
sendCallback=function()end},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eHouShanShiLian,
skinType=fullScreenSkinType.eSkin13,
}
self:initUI(args)
end

function UIHuanJingControl:onEnterState(isReconnect)
if isReconnect then
return
end

self.data={}

self.data.zlServerData={}

self.levelRewardCheck={}
self.levelRewardRecord={}

self.tzRewardCheck={}
self.tzRewardRecord={}

self.caphaterRewardDict={}
self.levelRewardDict={}

self.caphaterLevelDict={}

self.data.jindiWaitTeZhiData={}

local cfgs=cfg_chapternewconfig()
for k,v in pairs(cfgs)do
self.caphaterRewardDict[k]={id=k,level=v.rw_level}
for l,v2 in ipairs(v.guanqia_ids)do
self.caphaterLevelDict[v2]={k,l}
end
end
cfgs=cfg_guanqianewconfig()
for k,v in pairs(cfgs)do
local rwId=v.extra_rewards
if rwId then
local cpt=self.caphaterRewardDict[v.chapter_id]
if cpt.level==k then
cpt.rwId=rwId
end
self.levelRewardDict[k]={id=k,rwId=rwId}
end
end

notifySystem:listenNotify(notifyConfig.onNewMonth,self.onNewMonth)
notifySystem:listenNotify(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)

notifySystem:listenNotify(notifyConfig.home_event,self.onHomeEvent)
end

function UIHuanJingControl:onLeaveState(isReconnect)
self.data.autoFlag=nil

if isReconnect then
return
end

notifySystem:removelistener(notifyConfig.onNewMonth,self.onNewMonth)
notifySystem:removelistener(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:removelistener(notifyConfig.on_item_list_changed,self.on_item_list_changed)

notifySystem:removelistener(notifyConfig.home_event,self.onHomeEvent)

self.data=nil
end

function UIHuanJingControl.onHomeEvent(etype)
if etype==homeEvent.eEnterHome then
UIHuanJingControl:addHouTaiHUD()
end
end

function UIHuanJingControl:showLiLianWindow(argstable)
local tabType=FULL_TAB_TYPE.eHouShanShiLian
local args=
{
skinType=fullScreenSkinType.eSkin13,
tabType=tabType,
showBg=true,
showTopMask=true,
showFg=false,
viewNames={'UIHuanJingWin','UIHuanJingSimpleSelectWin'},
viewArgs={['UIHuanJingWin']=argstable,['UIHuanJingSimpleSelectWin']={index=1}},
showMain=false,
}
self:showUI(args)
end

function UIHuanJingControl:showDayChallengeWindow(argstable)
local tabType=FULL_TAB_TYPE.eMeiRiTiaoZhan
local args=
{
skinType=fullScreenSkinType.eSkin13,
tabType=tabType,
showBg=true,
showTopMask=true,
showFg=false,
viewNames={'UIHuanJingDayChallengeWin','UIHuanJingSimpleSelectWin'},
viewArgs={['UIHuanJingDayChallengeWin']=argstable,['UIHuanJingSimpleSelectWin']={index=2}},
showMain=false,
}
self:showUI(args)
end

function UIHuanJingControl:showJinDiWindow(argstable)
local tabType=FULL_TAB_TYPE.eHouShanJinDi
local args=
{
skinType=fullScreenSkinType.eSkin13,
tabType=tabType,
showBg=true,
showTopMask=true,
showFg=false,
viewNames={'UIHuanJingJinDiWin','UIHuanJingSimpleSelectWin'},
viewArgs={['UIHuanJingJinDiWin']=argstable,['UIHuanJingSimpleSelectWin']={index=3}},
showMain=false,
}
self:showUI(args)
end

function UIHuanJingControl:showJinDiSelectWindow(id,disciple)
local args={
openType=dzSelectWinOpenType.eHouShanJinDi,
cfgId=id,
select=disciple,
callback=function(cId,dzId)
UIManager:invokeUIMethod("UIHuanJingJinDiWin","refreshSelectDz",id,dzId)
end,
}
discipleSelectController:openDiscipleSelect(args,"派遣弟子")








end

function UIHuanJingControl:showJinDiResultWindow(id,effectId,changeList,disciple)
local mCfg=cfgHelper.get1(cfg_backmountainareaconfig_get,id)
local eCfg=cfgHelper.get1(cfg_backmountaineffectconfig_get,effectId)
local list,dis=UIHuanJingControl:getJinDiResultUnits(changeList)
local guid=disciple or int64.new(dis)



















local speData=UIHuanJingControl:getWaitTeZhiData(id)
if speData then
local temp={
showType=2,
special={speData[1].param_2,speData[1].param_3},
sort=100,
name="获得特质："
}
list[#list+1]=temp
end

table.sort(list,function(a,b)
return a.sort<b.sort
end)
local args={
id=id,
image=eCfg.image,
desc=eCfg.desc,
disciple=guid,
sixAttrType=mCfg.attr_id,
list=list,
before=function()
UIManager:invokeUIMethod("UIHuanJingJinDiWin","startResutlAI",id,guid)
end
}
UIHuanJingControl:showWindow("UIHuanJingJinDiResultWin",args)
end

function UIHuanJingControl:showSelectWindow(argstable)
local tabType=FULL_TAB_TYPE.eShiLianRuKou
local args=
{
skinType=fullScreenSkinType.eSkin5,
tabType=tabType,
showBg=true,
showFg=false,
viewNames={'UIHuanJingSelectWin'},
viewArgs={['UIHuanJingSelectWin']=argstable},
showMain=false,
}
self:showUI(args)
end

function UIHuanJingControl:showZhenLingWindow(argstable)
if not UIHuanJingControl:isZhenlingFuncOpen()then return end

local tabType=FULL_TAB_TYPE.eHouShanZhenLing
local args=
{
skinType=fullScreenSkinType.eSkin13,
tabType=tabType,
showBg=true,
showTopMask=true,
showFg=false,
viewNames={'UIHuanJingZhenLingChallengeWin','UIHuanJingSimpleSelectWin'},
viewArgs={['UIHuanJingZhenLingChallengeWin']=argstable,['UIHuanJingSimpleSelectWin']={index=4}},
showMain=false,
}
self:showUI(args)
end

function UIHuanJingControl:showAndOpenHuanJingWin(argstable)
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eIsPlayHuanJingOpenAnim)
local isPlayedAnim=argstable.isPlayedAnim or flag or false
local enterFunc=function()
local startCallback=function()
isometricMapSystem:leaveStoryMode()
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")


UIHuanJingControl:selectWin(argstable.index)
end
UIFullDouFaTaiControl:showWindow("UIFightPrepareLoading",{
startCallback=startCallback
})
end
if isPlayedAnim then
enterFunc()
else
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eIsPlayHuanJingOpenAnim,true)
local bdData=argstable.data
isometricMapSystem:enterStoryMode()

AudioManager.playAudio(564)

local pos=_MapManager.GetObjectAreaC(bdData.entityId)
_MapManager.PlayEffectByPos(pos,10199)
isometricMapSystem:moveCameraToObject(bdData.entityId,true,nil,0.5)
isometricMapSystem:setCameraOrthoSize(3.3,2.5,function()
enterFunc()
end)
end
end

function UIHuanJingControl:selectWin(index)
if index==1 then
UIHuanJingControl:showLiLianWindow()
elseif index==2 then
UIHuanJingControl:showDayChallengeWindow()
elseif index==3 then
UIHuanJingControl:showJinDiWindow()
elseif index==4 then
UIHuanJingControl:showZhenLingWindow()
end
end

function UIHuanJingControl:checkAndOpenSelectWin(argstable)
local battleId=self:getPlayingBattle()
if battleId and fightController:isBattlePlaying(battleId)then
fightController:openBattle(battleId)
return
end

local check1=UIHuanJingControl:isDayChallengeOpen()
local check2=UIHuanJingControl:isJinDiFuncOpen()

local check3=UIHuanJingControl:isZhenlingFuncOpen()
if check1 or check2 or check3 then
UIHuanJingControl:showSelectWindow(argstable)
else
local isJump=argstable.args and argstable.args.isjump or false
local isPlayedAnim=false
if isJump then
isPlayedAnim=true
end
UIHuanJingControl:showAndOpenHuanJingWin({data=argstable.data,index=1,isPlayedAnim=isPlayedAnim})
end
end

function UIHuanJingControl:clearTeamSaveData()
UIHuanJingControl:setTeamSaveData()
end

function UIHuanJingControl:setCurrentPlayAnimLevel(level)
userActorSetting.set('HJ_CURRENT_PLAY_ANIM_LEVEL',level)
userActorSetting.flush()
end

function UIHuanJingControl:getCurrentPlayAnimLevel()
local level=userActorSetting.get('HJ_CURRENT_PLAY_ANIM_LEVEL',-1)
return level
end

function UIHuanJingControl:setTeamSaveData(data)

userActorArraySetting.set(ACTOR_SETTING_TYPE.eMulTeam,'HUANJING_TEAM_DATA',data)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eMulTeam)
end

function UIHuanJingControl:getTeamSaveData(tNum)
local data=userActorArraySetting.get(ACTOR_SETTING_TYPE.eMulTeam,'HUANJING_TEAM_DATA',{})
for i,v in ipairs(data)do
local pl={}
for k,vv in pairs(v)do
local ntype=fightPreSelectModel.teamEntityType.dizi
local guid=int64.new(k)
pl[k]={vv,ntype,guid}
end
data[i]=pl
end
local len=#data
if len<tNum then
local dis=tNum-len
for i=1,dis do
table.insert(data,{})
end
end
return data
end

function UIHuanJingControl:recordZFID(zfId)
self.data.zfId=zfId
end

function UIHuanJingControl:getZFID()
return self.data.zfId or 0
end

function UIHuanJingControl:isCanChallenge(id)
local cfg=cfgHelper.get1(cfg_guanqianewconfig_get,id)
local zmLevel=zongmenModel:getLevel()
if zmLevel<cfg.unlock_level then
return false
end
return true
end

function UIHuanJingControl:isCanChallengeNext()
local clevel=self:getCurrentLevel()
local nlevel=self:getNextLevel()
if nlevel>clevel then
if self:isCanChallenge(nlevel)then
return true
end
end

return false
end

function UIHuanJingControl:getLevelName(prefix,id)
local chapter=cfgHelper.get2(cfg_guanqianewconfig_get,id,'chapter_id')
local stLevel=cfgHelper.get2(cfg_chapternewconfig_get,chapter,'st_level')
local name=FMT.fmt('{0}{1}-{2}',prefix,chapter,id-stLevel+1)
return name
end

function UIHuanJingControl:handleTeamList(conditions,teamList)
if not conditions then
return
end
for i,v in ipairs(conditions)do
if v[1]==1 then
for ii,vv in ipairs(v[2])do
if teamList[ii]then
local count=0
for kkk,vvv in pairs(teamList[ii])do
count=count+1
end

if count>vv then
teamList[ii]={}
end
end
end
end
end
end

function UIHuanJingControl:openFighting(id,htype)
local cfg=cfgHelper.get1(cfg_guanqianewconfig_get,id)
local mId=cfg.mon_ids[1][1]
local mcfg=cfgHelper.get1(cfg_monstergroup_get,mId)
local monList=UIHuanJingControl:getMultipleMonsterList(cfg)
local title=''
local temNum=#monList
local teamData=fightPreSelectModel:getMulTeamSaveData(eFightPreSelectType.huanjing,temNum)
local cndlist=UIHuanJingControl:getChallengeConditions(cfg)
local faZeData={}
if htype==1 then
title='每日挑战'
local data=UIHuanJingControl:getDayChallengeData()
faZeData[1]=data.fzId
for i,v in ipairs(cfg.fazelist)do
faZeData[#faZeData+1]=v
end
else
title=UIHuanJingControl:getLevelName('试炼',id)
faZeData=cfg.fazelist
end

UIHuanJingControl:handleTeamList(cfg.conditions,teamData)
fightController.showPrepareWin(fightPreSelectModel.fightType.huanjing,{
enterTxt=title,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
isHomeBattle=true,

multipleMonsterList=monList,
conditionDatas=cndlist,
groupId=mId,
multipleTeams=teamData,
showZhenFa=false,
faZeData=faZeData,
statePriorityCheck=false,
enterCallBack=function(teamList,zfId)
UIHuanJingControl:recordZFID(zfId)
fightLaunchController:sendFightEx(eBattleLaunch.huanjing,teamList,{id,htype})
end,
cancelCallBack=function()
if htype==1 then
UIHuanJingControl:showDayChallengeWindow()
else
UIHuanJingControl:showLiLianWindow()
end
end,
})
end

function UIHuanJingControl:skipFight(id,completeCall)
local time=timeHelper.getServerShortTime()
local last=self.lastSendSkip

if last and time-last<=3 then
return false
end
local cfg=cfgHelper.get1(cfg_guanqianewconfig_get,id)
local mId=cfg.mon_ids[1][1]
local mcfg=cfgHelper.get1(cfg_monstergroup_get,mId)
local monList=UIHuanJingControl:getMultipleMonsterList(cfg)
local temNum=#monList
local teamData=fightPreSelectModel:getMulTeamSaveData(eFightPreSelectType.huanjing,temNum)

UIHuanJingControl:handleTeamList(cfg.conditions,teamData)
local hasTeamEmpty=false
for i,v in ipairs(teamData)do
if next(v)==nil then
hasTeamEmpty=true
break
end
end
if hasTeamEmpty then
local discipleList=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort,nil,eSortOrder.eDown)
local maxTeamCount={}
teamData={}
for teamIdx=1,temNum do
teamData[teamIdx]={}
maxTeamCount[teamIdx]=5
end
for i,v in ipairs(cfg.conditions or{})do
if v[1]==1 then
for ii,vv in ipairs(v[2])do
maxTeamCount[ii]=vv
end
end
end

local curTeamIndex=1
local curTeamNum=0
for i,v in ipairs(discipleList)do
local netData=v.netData
local discipleguid=netData.net.discipleguid
local discipleguidStr=netData.net.discipleguidStr
curTeamNum=curTeamNum+1
teamData[curTeamIndex][discipleguidStr]={curTeamNum,eTeamEntityType.dizi,discipleguid}
if curTeamNum>=maxTeamCount[curTeamIndex]then
curTeamIndex=curTeamIndex+1
curTeamNum=0
end
if curTeamIndex>temNum then
break
end
end

end

teamData=fightPreSelectModel:getSendData(teamData,mcfg.mapId,UIHuanJingControl:getZFID())
fightModel:setSendExtraArgs(eBattleType.huanjing,{isSkip=true,quickCallback=completeCall})
fightLaunchController:sendFightEx(eBattleLaunch.huanjing,teamData,{id,1,1})
self.lastSendSkip=time
return true
end

function UIHuanJingControl:getDiziList(guidList)
local list={}
for k,v in pairs(guidList)do
if v[1]==fightPreSelectModel.teamEntityType.dizi then
list[k]=v[2]
end
end
return list
end

function UIHuanJingControl:selectDiscipleCallback(teamData,id,htype,hideStage)
fightLaunchController:sendFightEx(eBattleLaunch.huanjing,teamData,{id,htype},hideStage)
end

function UIHuanJingControl:setAutoFlag(flag)
self.data.autoFlag=flag
end

function UIHuanJingControl:getAutoFlag()
return self.data.autoFlag
end

function UIHuanJingControl:setPlayingBattle(battle)
self.data.battleId=battle
end

function UIHuanJingControl:getPlayingBattle()
return self.data.battleId
end

function UIHuanJingControl:setGuaJILayer(battleID)
self.data.gjbattleId=battleID
end

function UIHuanJingControl:getGuaJILayer()
return self.data.gjbattleId
end

function UIHuanJingControl:setGuaJILoseArgs(atgs)
self.data.guaJILoseArgs=atgs
end
function UIHuanJingControl:getGuaJILoseArgs()
return self.data.guaJILoseArgs
end


function UIHuanJingControl:onContinue(hideStage,level)
local nextLevel=UIHuanJingControl:getNextLevel(level)
local continueLayer=cfgHelper.get2(cfg_guanqianewbasicconfig_get,1,"auto_open")
if nextLevel<=continueLayer and hideStage then
return
end

if not self:isCanChallenge(nextLevel)or nextLevel==level then
if hideStage then
UIHuanJingControl:setGuaJILoseArgs({})
msgWinControl:addMsgWin(msgWinType.eHouShanGuaJi,{})
end
return
end
local cfg=cfgHelper.get1(cfg_guanqianewconfig_get,nextLevel)
local mId=cfg.mon_ids[1][1]
local mcfg=cfgHelper.get1(cfg_monstergroup_get,mId)
local monList=UIHuanJingControl:getMultipleMonsterList(cfg)
local temNum=#monList


local teamData=fightPreSelectModel:getMulTeamSaveData(eFightPreSelectType.huanjing,temNum)


UIHuanJingControl:handleTeamList(cfg.conditions,teamData)
teamData=fightPreSelectModel:getSendData(teamData,mcfg.mapId,UIHuanJingControl:getZFID())

if not teamData then
return
end




if hideStage then
UIHuanJingControl:setAutoFlag(true)
else
UIHuanJingControl:setAutoFlag(nil)
end

UIHuanJingControl:selectDiscipleCallback(teamData,nextLevel,0,hideStage)
end

function UIHuanJingControl:insertGuaJIReward(list)
if not self.data.guaJIReward then
self.data.guaJIReward={}
end
for i,v in ipairs(list)do
table.insert(self.data.guaJIReward,v)
end
end
function UIHuanJingControl:getGuaJIReward()
return self.data.guaJIReward or{}
end
function UIHuanJingControl:clearGuaJIReward()
self.data.guaJIReward={}
end

function UIHuanJingControl:setGuaJILayer(layer)
self.data.guaJILayer=layer
end
function UIHuanJingControl:getGuaJILayer()
return self.data.guaJILayer
end


function UIHuanJingControl.onBackStageCompleteBattle(battle,result,args)
local param=args.prizeList
if param then
UIHuanJingControl:insertGuaJIReward(param or{})
end
end

function UIHuanJingControl:getTZRewardList(rechargeId)
local levelRewards=cfgHelper.get2(cfg_guanqianewinvestconfig_get,rechargeId,'guanqia_rewards')
local rlist={}
for k,v in pairs(levelRewards)do
local state=UIHuanJingControl:getInvestFlag(k)
table.insert(rlist,{level=k,rwId=v[1],receive=state==1})
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

function UIHuanJingControl:recordLevelReward(id)
local extra_rewards=cfgHelper.get2(cfg_guanqianewconfig_get,id,'extra_rewards')
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
UIManager:invokeUIMethod('UIHuanJingWin','refreshRewardReddot',true)
UIManager:invokeUIMethod('UIHuanJingRewardWin','refresh')
UIManager:invokeUIMethod('UIHuanJingSimpleSelectWin','refresh')
UIHuanJingControl:refreshHUD()
end
end

function UIHuanJingControl:setLevelRewardCheck(id)
self.levelRewardCheck[id]=true
end

function UIHuanJingControl:recordTZReward(id)
local investData=UIHuanJingControl:getInvestData()
local levelRewards=cfgHelper.get2(cfg_guanqianewinvestconfig_get,investData.rechargeId,'guanqia_rewards')
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

function UIHuanJingControl:setTZRewardCheck(id)
self.tzRewardCheck[id]=true
end



function UIHuanJingControl:setData(datas)
local currId=datas[1]


local chapter







self.data.currentLevel=currId

chapter=self:getNextChapter()




















self.data.chapter=chapter

self.data.levelRWData=datas[3]or{}

local investData
if datas[9]then
local data=datas[9][1]
investData.rechargeId=data.recharge_id
investData.paid=data.len>0
investData.receivedData=data.guanqiaIds or{}
end
if not investData then
investData={rechargeId=13,paid=false,len=0,receivedData={}}
end
self.data.investData=investData
end

function UIHuanJingControl:getInvestData()
return self.data.investData
end

function UIHuanJingControl:getInvestFlag(id)
if id>self.data.currentLevel then
return-1
end
local data=self:getInvestData()
local p=math.ceil(id/32)
local m=id%32
local v=data.receivedData[p]
if v then
return bitHelper.get(v,m)
else
return 0
end
end

function UIHuanJingControl:setInvestFlag(id,state)
local data=self:getInvestData()
local p=math.ceil(id/32)
local m=id%32
local v=data.receivedData[p]or 0
if state==1 then
v=bitHelper.set_1(v,m)
else
v=bitHelper.set_0(v,m)
end
data.receivedData[p]=v
end









function UIHuanJingControl:setChapter(id)
self.data.chapter=id
end

function UIHuanJingControl:getChapter()
return self.data.chapter
end

function UIHuanJingControl:getNextChapter()
local level=self:getNextLevel()
return self:getChapterById(level)
end

function UIHuanJingControl:getChapterById(id)
local chapter=cfgHelper.get2(cfg_guanqianewconfig_get,id,'chapter_id')
return chapter
end

function UIHuanJingControl:getCurrentLevel()
if self.data then
return self.data.currentLevel
end
return 0
end

function UIHuanJingControl:getNextLevel(level)
level=level or self.data.currentLevel
if level>0 then
local cfg=cfgHelper.get1(cfg_guanqianewconfig_get,level)
return cfg.next_id and cfg.next_id or level
end
return 1
end

function UIHuanJingControl:getLevelReceiveState(id)






if id>self.data.currentLevel then
return-1
end
local p=math.ceil(id/32)
local m=id%32
local v=self.data.levelRWData[p]
if v then
return bitHelper.get(v,m)
else
return 0
end
end

function UIHuanJingControl:setlevelReceiveState(id,state)

local p=math.ceil(id/32)
local m=id%32
local v=self.data.levelRWData[p]or 0
if state==1 then
v=bitHelper.set_1(v,m)
else
v=bitHelper.set_0(v,m)
end
self.data.levelRWData[p]=v
end

function UIHuanJingControl:isLevelComplete(id)
local curr=self:getCurrentLevel()
return id<=curr
end

function UIHuanJingControl:getChapterRewardData()
return self.caphaterRewardDict
end

function UIHuanJingControl:getChapterRewardDataCaphater(id)
return self.caphaterRewardDict[id]
end


function UIHuanJingControl:getLevelRewardData()
return self.levelRewardDict
end

function UIHuanJingControl:getChapterFirstLevel(id)
local cfg=cfgHelper.get1(cfg_chapternewconfig_get,id)
return cfg.guanqia_ids[1]
end

function UIHuanJingControl:getChapterProgressRate(id)
local cfg=cfgHelper.get1(cfg_chapternewconfig_get,id)
local count=0
for i,v in ipairs(cfg.guanqia_ids)do
local state=self:getLevelReceiveState(v)
if state>=0 then
count=count+1
end
end
return count,#cfg.guanqia_ids
end

function UIHuanJingControl:isChapterComplete(id)
local cfg=cfgHelper.get1(cfg_chapternewconfig_get,id)
for i,v in ipairs(cfg.guanqia_ids)do
local state=self:getLevelReceiveState(v)
if state==-1 then
return false
end
end
return true
end

function UIHuanJingControl:onLevelComplete(level)
self.data.currentLevel=level

self:setlevelReceiveState(self.data.currentLevel,0)
notifySystem:postNotify(notifyConfig.onHouShanShiLianLVChange,self.data.currentLevel)
UIHuanJingControl:refreshHUD()
end

function UIHuanJingControl:setDayChallengeData(fzId,len,arr)
local dayChallengeData={}
dayChallengeData.fzId=fzId
dayChallengeData.levels=arr
local levelDict={}
if len>0 then
for i,v in ipairs(arr)do
levelDict[v.param_1]=v
end
end
dayChallengeData.levelDict=levelDict
self.data.dayChallengeData=dayChallengeData
end

function UIHuanJingControl:setDayChallengeRewardData(len,arr)
local levelDict=self.data.dayChallengeData.levelDict
if len>0 then
for i,guanqia_id in pairs(arr)do
local data=levelDict[guanqia_id]
if data then
data.param_3=1
end
end
end
self.data.dayChallengeData.levelDict=levelDict
end

function UIHuanJingControl:getDayChallengeData()
return self.data.dayChallengeData
end

function UIHuanJingControl:setDayChallengeResult(level,result)
local data=self:getDayChallengeData()
if data then
data.levelDict[level].param_2=result
UIHuanJingControl:refreshHUD()
end
end

function UIHuanJingControl:isDayChallengeOpen()
local data=self:getDayChallengeData()
if data then
return data.fzId>0
end
return false
end

function UIHuanJingControl:checkDayChallengeReddot()
local data=self:getDayChallengeData()
if data and data.fzId>0 and data.levels then
for i,v in ipairs(data.levels)do
if v.param_2>0 then
return false
end
end
return true
end
return false
end

function UIHuanJingControl:checkDayChallengeReddot2()
local data=self:getDayChallengeData()
if data and data.fzId>0 and data.levels then
for i,v in ipairs(data.levels)do
if v.param_2==0 then
return true
end
end
return false
end
return false
end

function UIHuanJingControl:isShowDayChallengeRewardReddot()
local data=UIHuanJingControl:getDayChallengeData()
if data and data.fzId>0 and data.levelDict then
for i,v in pairs(data.levelDict)do
if v.param_2==1 and v.param_3==0 then
return true
end
end
return false
end
return false
end


function UIHuanJingControl:reqLevelReward(len,idList)
socketManager:send_25_7(len,idList)
end

function UIHuanJingControl:reqReceiveInvest(payId,level)
socketManager:send_25_8(payId,level)
end



function UIHuanJingControl.recv_25_6(...)
UIHuanJingControl:setData({...})
notifySystem:postNotify(notifyConfig.onHouShanShiLianLVChange,nil)
end

function UIHuanJingControl.recv_25_7(len,idList)
for i,v in ipairs(idList)do
UIHuanJingControl:setlevelReceiveState(v,1)
UIHuanJingControl:recordLevelReward(v)
end
end

function UIHuanJingControl.recv_25_8(payId,level)


UIHuanJingControl:setInvestFlag(level,1)
UIHuanJingControl:recordTZReward(level)
UIManager:invokeUIMethod('UIHuanJingTouZiWin','refresh')
end

function UIHuanJingControl.recv_25_9(payId)
local data=UIHuanJingControl:getInvestData()
data.paid=true

UIManager:invokeUIMethod('UIHuanJingTouZiWin','refresh')
UIManager:invokeUIMethod('UIHuanJingWin','refresh')

local lcfg=cfgHelper.get1(cfg_guanqianewinvestconfig_get,data.rechargeId)
local rwId=lcfg.recharge_rewards[1]
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,rwId)
local rewards=rwcfg.showItems

local showRW={}
for i,v in ipairs(rewards)do
showPrizeControl.insertTemp(showRW,nil,v[1],v[2])
end
showPrizeControl.showWindow(showRW,nil)
end

function UIHuanJingControl.recv_25_10(fzId,len,arr)
UIHuanJingControl:setDayChallengeData(fzId,len,arr)
UIManager:invokeUIMethod('UIHuanJingDayChallengeWin','refresh')
UIHuanJingControl:refreshHUD()
end

function UIHuanJingControl.recv_25_13(len,guanqia_ids)
UIHuanJingControl:setDayChallengeRewardData(len,guanqia_ids)
UIManager:invokeUIMethod('UIHuanJingDayChallengeWin','refreshRewards')
UIManager:invokeUIMethod('UIHuanJingSimpleSelectWin','refresh')
UIHuanJingControl:refreshHUD()
end

function UIHuanJingControl.recv_25_51(guanqia_id,result)
UIHuanJingControl:setDayChallengeResult(guanqia_id,result==0 and 1 or 2)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_hs_1
xiaoZhuShouModel:callDetailFunc(detailId,"skipDayChallengeCallback",guanqia_id,result)
end


function UIHuanJingControl:isShowLiLianReddot()
return self:isShowRewardReddot()or self:isShowTouZiReddot()
end

function UIHuanJingControl:isShowRewardReddot()
local datas=UIHuanJingControl:getChapterRewardData()
for k,v in pairs(datas)do
local state=UIHuanJingControl:getLevelReceiveState(v.level)
if state==0 then
return true
end
end

datas=UIHuanJingControl:getLevelRewardData()
for k,v in pairs(datas)do
local state=UIHuanJingControl:getLevelReceiveState(k)
if state==0 then
return true
end
end

return false
end

function UIHuanJingControl:isShowTouZiReddot()
local investData=UIHuanJingControl:getInvestData()
local levelRewards=UIHuanJingControl:getTZRewardList(investData.rechargeId)
local unlock=investData.paid
if not unlock then
return false
end
for i,v in ipairs(levelRewards)do
local complete=UIHuanJingControl:isLevelComplete(v.level)
if complete and not v.receive then
return true
end
end
return false
end



function UIHuanJingControl:getChapterLevel(id)
return self.caphaterLevelDict[id]
end

function UIHuanJingControl:refreshHUD()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eHouShanMiJing)
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
else

end
end

function UIHuanJingControl:addHouTaiHUD()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eHouShanMiJing)
if bdData then
local battleId=self:getPlayingBattle()
local hud=self.data.houtaiHUD
if not hud and battleId then
local level=UIHuanJingControl:getCurrentLevel()
local cha=UIHuanJingControl:getChapterLevel(level)
if cha then
hud=hudControl:addHUD(INSTANCE_TYPE.eShiLianTa,
bdData.entityId,Vector3(0,-1.8,0),false,true,function(id)
local bw=hudControl:getHUDWidget(id)



bw:SetChildUIModelShowTarget(0,2076,1,{},eAnimationID.stand,false,false,0,nil)
bw:SetChildText(1,FMT.fmt("当前通关{0}-{1}",cha[1],cha[2]))
bw:SetChildButtonClick(2,function()
UIHuanJingControl:checkAndOpenSelectWin()
end)
end)

self.data.houtaiHUD=hud
else

end
end
end
end

function UIHuanJingControl:clearHud()
local hud=self.data.houtaiHUD
if hud then
hudControl:removeHUD(hud)
self.data.houtaiHUD=nil
end
end


function UIHuanJingControl:getMultipleMonsterList(cfg)
local list={}
for i,v in ipairs(cfg.mon_ids)do
local mcfg=cfgHelper.get1(cfg_monstergroup_get,v[1])
list[i]=mcfg.monList
end
return list
end

function UIHuanJingControl:getChallengeConditions(cfg)
local cnd_des=cfgHelper.get2(cfg_guanqianewbasicconfig_get,1,'cnd_des')
local list={{},{}}
if cfg.conditions then
local data=list[1]
for i,v in ipairs(cfg.conditions)do
if v[1]==1 then
local cd=cnd_des[1][1]
data[#data+1]={text=cd.desc,cnd={1,v[2]},image=cd.image}
end
end
end
if cfg.pass_conditions then
local data=list[2]
for i,v in ipairs(cfg.pass_conditions)do
if v[1]==1 then
local cd=cnd_des[2][1]
data[#data+1]={text=cd.desc}
elseif v[1]==2 then
local cd=cnd_des[2][2]
data[#data+1]={text=FMT.fmt(cd.desc,v[2])}
end
end
end
return list
end

function UIHuanJingControl:checkAndGetUnlockArgs(id)
local cfg=cfgHelper.get1(cfg_guanqianewconfig_get,id)

local zmLevel=zongmenModel:getLevel()
if zmLevel<cfg.unlock_level then
local tips=FMT.fmt('宗门达到{0}级可挑战',cfg.unlock_level)
return false,tips
end

return true
end

function UIHuanJingControl.onNewDay5am(islogin)
if not islogin then
UIHuanJingControl:dealZlNewDay5Am()
end
end

function UIHuanJingControl.on_item_list_changed(list)
if list==nil then return end
UIHuanJingControl:onZLSaoDangCostChange(list)
end
