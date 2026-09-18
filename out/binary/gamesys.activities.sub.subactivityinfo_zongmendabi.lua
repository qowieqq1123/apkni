









local subActivityInfo_zongmendabi={name='zongmendabi'}

function subActivityInfo_zongmendabi:onInit()
self:initRankRewardList()
self:initRewardShareList()
end

function subActivityInfo_zongmendabi:onStart()

end

function subActivityInfo_zongmendabi:onUpdate()

end

function subActivityInfo_zongmendabi:onDelete()
self.guidList_temp=nil
self.isInitRankRewardList=nil
self.rankRewardList_lookup=nil
self.isInitRewardShareList=nil
self.rewardShareList_lookup=nil
end

function subActivityInfo_zongmendabi:checkReddot()
local data=self.data
if data then
local idx=self:getOpenDayIndex()
if idx<=1 then
return not self:isBaoMing()
else
return self:hasScoreReward()or self:hasFreeBattle()
or zongmenModel:checkZongMenScoreRewardReddot()or self:hasTargetReward()
end
end
return false
end


function subActivityInfo_zongmendabi:checkNewDay()
if self:checkDoing()then
local data=self.data
if data then
activitiesHandle_zongmendabi.refreshBatteNum(data)

data.matchList=nil

UIManager:invokeUIMethod('UISubAct_zongmendabi_enter_win','rec_newday')
UIManager:invokeUIMethod('UISubAct_zongmendabi_battle_win','rec_newday')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end
end
end


function subActivityInfo_zongmendabi:isBaoMing()
return self.data.is_enter==1
end

function subActivityInfo_zongmendabi:hasScoreReward()
local score=self.data.score
local lv,cur,max,isfull=activitiesHandle_zongmendabi.getZMRewardLevel(self.sub_act_id,score)
local curRewardLevel=lv
local getreward_lv=self.data.recv_lv
return getreward_lv<curRewardLevel
end

function subActivityInfo_zongmendabi:hasFreeBattle()
local challengelist=self:getSubActConfig('challengelist')
local battlenum=self.data.use_times
local max_battlenum=challengelist[1]
local lerp=max_battlenum-battlenum
return lerp>0
end

function subActivityInfo_zongmendabi:hasTargetReward()
local sectTaskLookup=self.data.sectTaskLookup
for task_id,task in pairs(sectTaskLookup)do
if task.task_state==2 then
return true
end
end
return false
end

function subActivityInfo_zongmendabi:getHeadReward(idx)
local data=self.data
if data then
if idx==nil then
if data.zone_type>0 then
idx=data.zone_type
else
idx=1
end
end
local giftLst=data.giftLst
local result={}
for i=(idx-1)*3+1,idx*3 do
table.insert(result,giftLst[i])
end
return result
end
end

function subActivityInfo_zongmendabi:findHeadReward(itemguid)
local data=self.data
if data then
for i,v in ipairs(data.giftLst)do
if mathHelper.compareInt64(itemguid,v.itemguid)then
return v
end
end
end
end

function subActivityInfo_zongmendabi:getDefTeamFive(idx)
local data=self.data
if data then
local guidList=data.guidList
local result={}
for i=(idx-1)*5+1,idx*5 do
table.insert(result,guidList[i])
end
return result
end
end

function subActivityInfo_zongmendabi:getDefTeamThree(idx)
local data=self.data
if data then
local guidList=data.guidList
local result={}
for i=(idx-1)*5+1,idx*5 do
local dis_guid=guidList[i]
if mathHelper.validInt64(dis_guid)then
table.insert(result,dis_guid)
end
end
return result
end
end

function subActivityInfo_zongmendabi:getDefTeamsFight(idx)
local fight=0
local data=self.data
if data then
local guidList=data.guidList
local cur,max
if idx==nil then
cur=1
max=10
else
cur=(idx-1)*5+1
max=idx*5
end
for i=cur,max do
local dis_guid=guidList[i]
if mathHelper.validInt64(dis_guid)then
fight=fight+UIDiscipleModel:getDiscipleFightValue(dis_guid)
end
end
end
return fight
end

function subActivityInfo_zongmendabi:checkInDefTeam(dis_guid)
local data=self.data
if data then
local guidList=data.guidList
for i,dis_guid_ in ipairs(guidList)do
if mathHelper.compareInt64(dis_guid_,dis_guid)then
return true
end
end
end
return false
end


function subActivityInfo_zongmendabi:initRankRewardList()
if not self.isInitRankRewardList then

local rankRewardCfg=self:getSubActConfig('rankreward')
self.rankRewardList_lookup={}
for i=1,#rankRewardCfg do
local startIndex=rankRewardCfg[i][1]
local endIndex=rankRewardCfg[i][2]
local rewards=rankRewardCfg[i][3]

for j=startIndex,endIndex do
self.rankRewardList_lookup[j]=rewards
end
end

self.isInitRankRewardList=true
end
end


function subActivityInfo_zongmendabi:initRewardShareList()
if not self.isInitRewardShareList then

local rewardShareCfg=self:getSubActConfig('rewardshare')
self.rewardShareList_lookup={}
for zoneTypeIndex,cfg in pairs(rewardShareCfg)do
if not self.rewardShareList_lookup[zoneTypeIndex]then
self.rewardShareList_lookup[zoneTypeIndex]={}
end

for i=1,#cfg do
local startIndex=cfg[i][1]
local endIndex=cfg[i][2]
local percent=cfg[i][3]

for j=startIndex,endIndex do
self.rewardShareList_lookup[zoneTypeIndex][j]=percent
end
end
end

self.isInitRewardShareList=true
end
end

function subActivityInfo_zongmendabi:setDefTeams_temp(guidList)
self.guidList_temp=guidList
end

function subActivityInfo_zongmendabi:setDefTeams()
if self.guidList_temp~=nil then
self.data.guidList=self.guidList_temp
self.guidList_temp=nil
end
end

function subActivityInfo_zongmendabi:checkRankTopThree()
local check=false
local data=self.data
if data then
if data.top3RankList==nil or gameUtilityModel.getServerShortTime()-data.top3RankList_time>=10 then
check=true
end
end
if check then
local json_str=jsonHelper.encode({7})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end
return check
end

function subActivityInfo_zongmendabi:checkBattleList()
local check=false
local data=self.data
if data then
if data.matchList==nil or gameUtilityModel.getServerShortTime()-data.matchList_time>=10 then
check=true
end
end
if check then
local json_str=jsonHelper.encode({5})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end
return check
end

function subActivityInfo_zongmendabi:checkPoolNoteList()
local check=false
local data=self.data
if data then
if not data.lock_recordList then
if data.recordList==nil or gameUtilityModel.getServerShortTime()-data.recordList_time>=10 then
check=true
end
end
end
if check then
local json_str=jsonHelper.encode({1})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
data.lock_recordList=true
end
return check
end

function subActivityInfo_zongmendabi:onBattleBack(batteData)
local data=self.data
if data then
activitiesHandle_zongmendabi.refreshBatteNum(data)
data.use_times=data.use_times+1
local old_score=data.score
data.score=batteData.pk_score
batteData.old_score=old_score
local old_my_rank=data.my_rank
data.my_rank=batteData.new_rank_idx
batteData.old_my_rank=old_my_rank
local select_idx=batteData.select_idx
if data.matchList then
for i,v in ipairs(data.matchList)do
if v.idx==select_idx then
v.fight_result=batteData.fight_result
v.log_len=batteData.log_len
v.logList=batteData.logList
break
end
end
end


data.top3RankList=nil
end
end










function subActivityInfo_zongmendabi:getRobotScore(idx,isRefresh)
local idx_str=tostring(idx)
local change=false
local robotScore=userActorArraySetting.get(ACTOR_SETTING_TYPE.eZongMenDaBi,'robotScore',nil)
if robotScore==nil then
robotScore={}
change=true
end
local data=robotScore[idx_str]
if data~=nil then
if type(data)=='number'then
data=nil
elseif data.refreshTime==nil then
data=nil
elseif data.refreshTime~=nil and not timeHelper.checkInSameDay(data.refreshTime,gameUtilityModel.getServerLongTime())then
data=nil
end
end
if data==nil then
change=true
data={}

local temp={}
local rewards=self:getSubActConfig('rewards')
for i,v in ipairs(rewards)do
table.insert(temp,v[2])
table.insert(temp,-v[2])
end
table.insert(temp,0)
local r=math.random(1,5)
local n=table.randomIndex(temp)
local s=self.data.score+r*n
if s<0 then s=0 end
data[1]=s

local f=self:getDefTeamsFight(1)+self:getDefTeamsFight(2)
local f_
xpcall(function()
f_=mathHelper.getRandomNum_precent2(f,-0.3,-0.2)
end,function(err)
f_=mathHelper.getRandomNum_precent2(1000,-0.3,-0.2)
logErr("错误数值：",f)
end)

data[3]=f_
local fights={}
fights[1]=mathHelper.getRandomNum_precent2(f_,-0.6,-0.4)
fights[2]=f_-fights[1]
data[2]=fights



robotScore[idx_str]=data
end
if data.refreshTime==nil then
change=true
data.refreshTime=gameUtilityModel.getServerLongTime()
end
if change then
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZongMenDaBi,'robotScore',robotScore)
end
return data,change
end

function subActivityInfo_zongmendabi:getMySaveTeam()
return self.mySaveTeam
end

function subActivityInfo_zongmendabi:initMySaveTeam()
local deflist=self:getSubActConfig('deflist')
local num=deflist[2]
local savedata=userActorSetting.get("zongmendabi_adjust_myteam",nil)
if not savedata or not savedata[tostring(num)]then
return nil
end
local args=savedata[tostring(num)]
local teams={}
for i,v in ipairs(args.list)do
teams[i]={}
for ii,vv in pairs(v.team)do
teams[i][vv.pos]=int64.new(vv.guid)
end
end

self.mySaveTeam=teams
end

function subActivityInfo_zongmendabi:setSaveMyTeam(myTeam)
local deflist=self:getSubActConfig('deflist')
local num=deflist[2]
local teams={}
local args={}
args.list={}
for i,v in ipairs(myTeam)do
teams[i]={}
local team={}
for ii,vv in pairs(v[2])do
table.insert(team,{pos=ii,guid=tostring(vv[2])})
teams[i][ii]=vv[2]
end
table.insert(args.list,{team=team})
end
self.mySaveTeam=teams

local savedata=userActorSetting.get("zongmendabi_adjust_myteam",{})
if savedata then
savedata[tostring(num)]=args
end
userActorSetting.flushVal("zongmendabi_adjust_myteam",savedata)
end

return subActivityInfo_zongmendabi