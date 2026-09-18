






local _MODULENAME="WDCQModel"


def_table(_MODULENAME)
WDCQModel.name=_MODULENAME
WDCQModel.data={}

function WDCQModel:onAppStart()

end


function WDCQModel:onEnterState(isReconnect)

end


function WDCQModel:onProtocolReq()

end


function WDCQModel:onLeaveState(isReconnect)

self.data={}
self.lookUpCfg=nil
self:resetBookData()
self:resetFightRecord()
self:clearBookWin()
end








































































function WDCQModel:initLookUpConfig()
self.lookUpCfg={}
for i,groupEnum in ipairs(WDCQCGroupEnumList)do
local groupCfgtemp={}
for ii,stageEnum in ipairs(WDCQCGameStageEnumList)do
local stageCfgTemp={}
stageCfgTemp.roundCfgList={}
groupCfgtemp[stageEnum]=stageCfgTemp
end
self.lookUpCfg[groupEnum]=groupCfgtemp
end

local cfg=cfg_wendingcangqiongmatchconfig()

local rank_reward_time=cfgHelper.get2(cfg_wendingcangqiongconfig_get,1,'rank_reward_time')
self.data.rankRewardTime=WDCQController.changeCfgTime(rank_reward_time[1],rank_reward_time[2],rank_reward_time[3])

for k,v in pairs(cfg)do
local groupCfgtemp=self.lookUpCfg[k]
for i2,v2 in ipairs(v)do
local stage=v2.match_type_id
local stageCfgTemp=groupCfgtemp[stage]
local roundCfgList=stageCfgTemp.roundCfgList


local time_conf=v2.time_conf
local stageStartTime,stageEndTime
for i3,v3 in ipairs(time_conf)do
local N=v3[1]
local begin_hour=v3[2]
local begin_min=v3[3]
local end_hour=v3[4]
local end_min=v3[5]
local mid_group_id=v3[6]
local rival_idx=v3[7]

local idx=WDCQModel:getIdx(stage,mid_group_id,rival_idx)
if not roundCfgList[idx]then
roundCfgList[idx]={}
end

local roundCfgTemp=roundCfgList[idx]

roundCfgTemp.endFlagStr=FMT.fmt("RoundEndFlag_{0}_{1}_{2}",k,stage,idx)
roundCfgTemp.req_38_8_Key=FMT.fmt("req_38_8_{0}_{1}_{2}",k,stage,idx)
roundCfgTemp.startTime=WDCQController.changeCfgTime(N,begin_hour,begin_min)
roundCfgTemp.endTime=WDCQController.changeCfgTime(N,end_hour,end_min)
if stageStartTime then
stageStartTime=math.min(stageStartTime,roundCfgTemp.startTime)
else
stageStartTime=roundCfgTemp.startTime
end
if stageEndTime then
stageEndTime=math.max(stageEndTime,roundCfgTemp.endTime)
else
stageEndTime=roundCfgTemp.endTime
end
end

stageCfgTemp.stageStartTime=stageStartTime
stageCfgTemp.stageEndTime=stageEndTime
local end_time_conf=v2.end_time_conf
stageCfgTemp.stageSettleMentTime=WDCQController.changeCfgTime(end_time_conf[1],end_time_conf[2],end_time_conf[3])
stageCfgTemp.req_38_1_Key=FMT.fmt("req_38_1_{0}_{1}_{2}",k,stage)

local pre_time_conf=v2.pre_time_conf
for i4,v4 in ipairs(pre_time_conf)do

local timecfg=v4[1]
local mid_group_id=v4[2]
local rival_idx=v4[3]

local idx=WDCQModel:getIdx(stage,mid_group_id,rival_idx)
if not roundCfgList[idx]then
roundCfgList[idx]={}
end

local roundCfgTemp=roundCfgList[idx]

local preTime_selectDzTime=timecfg[1]
local preTime_selectDzTime_N=preTime_selectDzTime[1]
local preTime_selectDzTime_hour=preTime_selectDzTime[2]
local preTime_selectDzTime_min=preTime_selectDzTime[3]

local preTime_banDzTime=timecfg[2]
local preTime_banDzTime_N=preTime_banDzTime[1]
local preTime_banDzTime_hour=preTime_banDzTime[2]
local preTime_banDzTime_min=preTime_banDzTime[3]

local preTime_endTime=timecfg[4]
local preTime_endTime_N=preTime_endTime[1]
local preTime_endTime_hour=preTime_endTime[2]
local preTime_endTime_min=preTime_endTime[3]

local preTime_teamUpTime=timecfg[3]


roundCfgTemp.selectDzStartTime=WDCQController.changeCfgTime(preTime_selectDzTime_N,preTime_selectDzTime_hour,preTime_selectDzTime_min)
roundCfgTemp.banDzStartTime=WDCQController.changeCfgTime(preTime_banDzTime_N,preTime_banDzTime_hour,preTime_banDzTime_min)
roundCfgTemp.preEndTime=WDCQController.changeCfgTime(preTime_endTime_N,preTime_endTime_hour,preTime_endTime_min)

local teamUpTime={}
for i5,v5 in ipairs(preTime_teamUpTime)do
local teamUpTimeTemp={}
teamUpTimeTemp.teamUpStartTime=WDCQController.changeCfgTime(v5[1],v5[2],v5[3])
local nextTeamUpTime=preTime_teamUpTime[i5+1]
if nextTeamUpTime then
teamUpTimeTemp.teamUpEndTime=WDCQController.changeCfgTime(nextTeamUpTime[1],nextTeamUpTime[2],nextTeamUpTime[3])
else
teamUpTimeTemp.teamUpEndTime=roundCfgTemp.preEndTime
end
table.insert(teamUpTime,teamUpTimeTemp)
end
roundCfgTemp.teamUpTime=teamUpTime
roundCfgTemp.selectDzEndTime=roundCfgTemp.banDzStartTime
roundCfgTemp.banDzEndTime=roundCfgTemp.teamUpTime[1].teamUpStartTime
end
if v2.bc_conf then
stageCfgTemp.horseList={}
for i5,v5 in ipairs(v2.bc_conf)do
stageCfgTemp.horseList[i5]={}
stageCfgTemp.horseList[i5].triggerTime=WDCQController.changeCfgTime(v5[1],v5[2],v5[3])
stageCfgTemp.horseList[i5].maxTriggerTime=WDCQController.changeCfgTime(v5[1],v5[2],v5[3])+5
stageCfgTemp.horseList[i5].langCfg=cfg_lang_get(v5[4])
stageCfgTemp.horseList[i5].triggerKey=FMT.fmt("horseList_{0}_{1}_{2}",k,stage,i5)
end
end
if v2.chat_conf then
stageCfgTemp.chatList={}
for i6,v6 in ipairs(v2.chat_conf)do
stageCfgTemp.chatList[i6]={}
stageCfgTemp.chatList[i6].triggerTime=WDCQController.changeCfgTime(v6[1],v6[2],v6[3])
stageCfgTemp.chatList[i6].maxTriggerTime=WDCQController.changeCfgTime(v6[1],v6[2],v6[3])+5
stageCfgTemp.chatList[i6].langCfg=cfg_lang_get(v6[4])
stageCfgTemp.chatList[i6].triggerKey=FMT.fmt("chatList_{0}_{1}_{2}",k,stage,i6)
end
end
if v2.danmu_conf then
stageCfgTemp.danmuList={}
for i7,v7 in ipairs(v2.danmu_conf)do
stageCfgTemp.danmuList[i7]=cfg_lang_get(v7)
end
end
end
end
end

function WDCQModel:checkRefreshCfg(currtime)
local xfBeginTime=UIXianFaWenDaoControl:getSessionEndTime()
local refresh=false
if not xfBeginTime then
refresh=true
else
local isTruce=UIXianFaWenDaoControl:isInTruceTime()
if self.data.lastTruceFlag~=isTruce then
self.data.lastTruceFlag=isTruce
refresh=true
end
end

if refresh then
UIXianFaWenDaoControl:setSessionOpenTime()
WDCQModel:initActTime()
self:initLookUpConfig()
end
end

function WDCQModel:getGroupLookUpCfg(groupEnum)
if not self.lookUpCfg then

return
end
return self.lookUpCfg[groupEnum]
end

function WDCQModel:getIdx(stage,mid_group_id,rival_idx)
local idx
local halfValue
if stage==WDCQCGameStageEnum.eSixteen then
halfValue=8
elseif stage==WDCQCGameStageEnum.eEighth then
halfValue=4
elseif stage==WDCQCGameStageEnum.eFourth then
halfValue=2
elseif stage==WDCQCGameStageEnum.eSemi then
halfValue=1
elseif stage==WDCQCGameStageEnum.eThird or stage==WDCQCGameStageEnum.eChampion then
halfValue=0
end
idx=(mid_group_id-1)*halfValue+rival_idx
return idx
end


function WDCQModel:initActTime()
local xfCurEndTime=UIXianFaWenDaoControl:getSessionEndTime()
local oldSessionEndTime=UIXianFaWenDaoControl:getOldSessionEndTime()
local _,xfNextEndTime=UIXianFaWenDaoControl:getNextSessionTime()
if not xfCurEndTime or not oldSessionEndTime or not xfNextEndTime then
UIXianFaWenDaoControl:setSessionOpenTime()
xfCurEndTime=UIXianFaWenDaoControl:getSessionEndTime()
oldSessionEndTime=UIXianFaWenDaoControl:getOldSessionEndTime()
_,xfNextEndTime=UIXianFaWenDaoControl:getNextSessionTime()
end

local isTruce=UIXianFaWenDaoControl:isInTruceTime()
self.data.lastTruceFlag=isTruce


if isTruce then

self.data.beginTime=xfCurEndTime
self.data.nextbeginTime=xfNextEndTime
else
self.data.beginTime=oldSessionEndTime

self.data.nextbeginTime=xfCurEndTime
end
end

function WDCQModel:getSessionBeginTime()
if not self.data.beginTime then
WDCQModel:initActTime()
end
return self.data.beginTime
end

function WDCQModel:getNextSessionBeginTime()
if not self.data.nextbeginTime then
WDCQModel:initActTime()
end
return self.data.nextbeginTime
end







function WDCQModel:setData(data)
self.data=data
end

function WDCQModel:getData()
return self.data
end

function WDCQModel:getData_startTime()
return self.data.startTime or 0
end

function WDCQModel:getData_GroupList()
return self.data.groubList
end

function WDCQModel:getData_GroupTemp(groupEnum)
local groubList=self:getData_GroupList()
if groubList then
return groubList[groupEnum]
else

end
return
end

function WDCQModel:getData_StageList(groupEnum)
local grouptemp=self:getData_GroupTemp(groupEnum)
if grouptemp then
return grouptemp.stageList
else

end
return
end

function WDCQModel:getData_StageTemp(groupEnum,stageEnum)
local stageList=self:getData_StageList(groupEnum)
if stageList then
return stageList[stageEnum]
else

end
return
end

function WDCQModel:getData_MacthList(groupEnum,stageEnum)
local stageTemp=self:getData_StageTemp(groupEnum,stageEnum)
if stageTemp then
return stageTemp.macthList
else

end
return
end

function WDCQModel:setData_MacthInfo(groupEnum,stageEnum,idx,info)
local macthList=self:getData_MacthList(groupEnum,stageEnum)
if macthList then
macthList[idx]=info
else

end
end

function WDCQModel:getData_RankIdx()
return self.data.rank
end

function WDCQModel:getData_RankGroup()
return self.data.groupId
end

function WDCQModel:getData_RewardEndTime()
return self.data.rewardEndTime
end

function WDCQModel:getData_RewardFlag()
return self.data.serverRewardFlag
end

function WDCQModel:getData_ActorDataList()
return self.data.actorDataList
end

function WDCQModel:getData_ActorData(actorId)
local actorDataList=self:getData_ActorDataList()
if actorDataList then
return actorDataList[tostring(actorId)]
end
return
end

function WDCQModel:getRankList(group,ranks)
local temp={}

if self.data.rankList then
for index,rank in ipairs(ranks)do
temp[index]=WDCQModel:getRankRoleInfo(group,rank)
end
end

return temp
end

function WDCQModel:getRankRoleInfo(group,rank)
if self.data.rankList then
if self.data.rankList[group]then
return self.data.rankList[group][rank]or{}
end
end
end

function WDCQModel:getRankRoleInfo2(actorid)
if self.data.actorRankLookup then
local rankInfo=self.data.actorRankLookup[tostring(actorid)]
if rankInfo then
return rankInfo
end
end
end

function WDCQModel:getRankRoleInfoLookUp(actorid,idx)
idx=idx or 3
if self.data.actorRankLookup then
local rankInfo=self.data.actorRankLookup[tostring(actorid)]
if rankInfo then
return rankInfo[idx]
end
end
end

function WDCQModel:getRYBRankInfo(group,rank)
if self.data.rankInfoList and self.data.rankInfoList[group]then
if rank then
return self.data.rankInfoList[group][rank]
else
return self.data.rankInfoList[group]
end
end
end

function WDCQModel:haveRYBTopData()
if self.data.rankInfoList then
for i,v in pairs(self.data.rankInfoList)do
if v[1]~=nil then
return true
end
end
end
return false
end

function WDCQModel:getRYBRankIconInfo(actorId)
if self.data.rankIconInfoList then
return self.data.rankIconInfoList[tostring(actorId)]
end
end

function WDCQModel:getRewardRankInfo(group,rank)
if self.data.rewardInfoList and self.data.rewardInfoList[group]then
if rank then
return self.data.rewardInfoList[group][rank]
else
return self.data.rewardInfoList[group]
end
end
end

