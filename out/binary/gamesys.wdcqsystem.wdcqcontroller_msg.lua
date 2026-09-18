







local localMsgSaveKey={
[msgWinType.eWDCQYQCS]="WDCQ_YQCS_Flag",
[msgWinType.eWDCQGJXX]="WDCQ_GJXX_Flag",
[msgWinType.eWDCQQFZY]="WDCQ_QFZY_Flag",
[msgWinType.eWDCQCSJG]="WDCQ_CSJG_Flag",
[msgWinType.eWDCQZZJG]="WDCQ_ZZJG_Flag",
}

local clearFlagToSeaSonStart={
msgWinType.eWDCQGJXX,
msgWinType.eWDCQQFZY,
msgWinType.eWDCQCSJG,
msgWinType.eWDCQZZJG
}

local clearFlagToSeaSonEnd={
}

function WDCQController:onEnterState_Msg(isReconnect)
notifySystem:listenNotify(notifyConfig.onXianFaLunDaoRankUpdate,self.onXianFaLunDaoRankUpdate)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)

self.data.listenerMsgList={}
self.data.listenerMsgLookup={}
end

function WDCQController:onProtocolReq_Msg()

end

function WDCQController:onLeaveState_Msg(isReconnect)
notifySystem:listenNotify(notifyConfig.onXianFaLunDaoRankUpdate,self.onXianFaLunDaoRankUpdate)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
end

function WDCQController.clearMsgLocalFlag_SeasonStart()
for index,type in ipairs(clearFlagToSeaSonStart)do
userActorArraySetting.remove(ACTOR_SETTING_TYPE.eWenDingCangQiong,localMsgSaveKey[type])
end
end

function WDCQController.clearFlagToSeaSonEnd()
for index,type in ipairs(clearFlagToSeaSonEnd)do
userActorArraySetting.remove(ACTOR_SETTING_TYPE.eWenDingCangQiong,localMsgSaveKey[type])
end
end

function WDCQController:clearListenerMsg()
self.data.listenerMsgList={}
self.data.listenerMsgLookup={}
end

function WDCQController:addListenerMsg(group,stage,idx,isSkip)
local key=group*1000+stage*100+idx
local roundCfgList=WDCQController.getRoundListCfg(group,stage)
local roundCfg=roundCfgList[idx]
local temp
if self.data.listenerMsgLookup[key]then
temp=self.data.listenerMsgLookup[key]
else
temp={}
self.data.listenerMsgLookup[key]=temp
local len=#self.data.listenerMsgList
self.data.listenerMsgList[len+1]=temp
end

temp.key=key
temp.group=group
temp.stage=stage
temp.idx=idx
temp.isSkip=isSkip
temp.roundCfg=roundCfg

table.sort(self.data.listenerMsgList,function(a,b)
return a.key<b.key
end)
end

function WDCQController:checkListenerMsgTrigger()
if not WDCQController.checkSysOpen()then return end

if#self.data.listenerMsgList>0 then
local stage,dData,roundCfg,isSkip

if WDCQController.checkMsgWinOpenFlag(msgWinType.eWDCQZZJG)then return end

local lStage=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWenDingCangQiong,localMsgSaveKey[msgWinType.eWDCQCSJG],-1)
local curTime=timeHelper.getServerShortTime()

for key,data in ipairs(self.data.listenerMsgList)do
stage=data.stage
roundCfg=data.roundCfg
isSkip=data.isSkip
if stage>lStage and(isSkip and(curTime>=roundCfg.startTime)or(curTime>=roundCfg.endTime))then
dData=data
end
end



if dData then
local dGroup=dData.group
local dStage=dData.stage
local dIdx=dData.idx

local matchList=WDCQModel:getData_MacthList(dGroup,dStage)
local matchData=matchList[dIdx]
local playActorId=playerModel:getActorID()

local isEmptyWin=mathHelper.compareInt64(Int64_0,matchData.win_actor_id)
if isEmptyWin then

return
end

local isInMatch=mathHelper.compareInt64(playActorId,matchData.actor_id_1)or mathHelper.compareInt64(playActorId,matchData.actor_id_2)

if not isInMatch then
logErr(FMT.fmt("玩家不属于该小组，组别：{0}，阶段：{1}，小组：{2}",dGroup,dStage,dIdx))
return
end

local isWin=mathHelper.compareInt64(playActorId,matchData.win_actor_id)

if dStage==WDCQCGameStageEnum.eChampion or dStage==WDCQCGameStageEnum.eThird then

WDCQController.checkShowRankMsg()
elseif dStage==WDCQCGameStageEnum.eSemi then

WDCQController.checkShowStageResultMsg(dGroup,dStage,isWin)
else
if isWin then

WDCQController.checkShowStageResultMsg(dGroup,dStage,isWin)
else

WDCQController.checkShowRankMsg()
end
end
end
end
end


































function WDCQController.checkShowEndMsg()
if WDCQController.checkMsgWinOpenFlag(msgWinType.eWDCQGJXX)then return end

local groupCfgList=WDCQController:getUnlockGroupCfgList()
local selectGroup

local groupLen=#groupCfgList
for index=groupLen,1,-1 do
local groupCfg=groupCfgList[index]
local group=groupCfg.id

if WDCQController.checkChampionStageEnd(group)then
local selectPlayerData=WDCQModel:getRankRoleInfo(group,1)
selectPlayerData=selectPlayerData and selectPlayerData[1]
if selectPlayerData~=nil then
selectGroup=group
break
end
end
end


if selectGroup then
if not WDCQController.checkMsgWinOpenFlag(msgWinType.eWDCQGJXX)then
msgWinControl:addMsgWin(msgWinType.eWDCQGJXX,nil,nil,true)
end

local bfChampionRoleInfo=WDCQModel:getRewardRankInfo(selectGroup,1)
if bfChampionRoleInfo then
local actorid=bfChampionRoleInfo.actorid
local championRoleInfo=WDCQModel:getRankRoleInfoLookUp(actorid)

if championRoleInfo and(not WDCQController.checkMsgWinOpenFlag(msgWinType.eWDCQQFZY))then
msgWinControl:addMsgWin(msgWinType.eWDCQQFZY,{championRoleInfo=championRoleInfo,group=selectGroup},nil,true)
end
end
end
end


function WDCQController.checkShowRankMsg()
msgWinControl:addMsgWin(msgWinType.eWDCQZZJG,nil,nil,true)
end


function WDCQController.checkShowStageResultMsg(group,stage,winFlag)

if WDCQController.checkGameEndTime()then return end

local args={}

args.result=winFlag
args.group=group
args.stage=stage

local stageName=cfgHelper.get3(cfg_wendingcangqiongmatchconfig_get,group,stage,'name')

if winFlag then

local step=stage==WDCQCGameStageEnum.eSemi and 2 or 1
local toStage=stage+step
local nextStageName=cfgHelper.get3(cfg_wendingcangqiongmatchconfig_get,group,toStage,'name')
args.descGroup=FMT.fmt("<color=#7d3b17>恭喜祖师在问鼎苍穹-{0}中\n获得胜利</color>",stageName)
args.descResult=FMT.fmt("<color=#7d3b17>成功晋级<size=40><color=#c82c2c>{0}</color></size>!</color>",nextStageName)
args.toStage=toStage
else

local nextStageName=WDCQCGameStageNmae[WDCQCGameStageEnum.eThird]

local curTime=timeHelper.getServerShortTime()
local stageCfgTemp=WDCQController.getStageCfgTemp(group,WDCQCGameStageEnum.eThird)
local startTime=stageCfgTemp.stageStartTime
if startTime>curTime then


local curDay=timeHelper.getServerOpenDay_Time(timeHelper.convertLongStamp(curTime))
local startDay=timeHelper.getServerOpenDay_Time(timeHelper.convertLongStamp(startTime))
local left=startDay-curDay
local timeStr=""
if left==0 then
timeStr="今天"
elseif left==1 then
timeStr="明天"
elseif left==2 then
timeStr="后天"
else
local syear,smonth,sday,shour,smin,ssec=timeHelper.getServerStampData(timeHelper.convertLongStamp(startTime))
timeStr=FMT.fmt("{0}月{1}日",smonth,sday)
end

args.descGroup=FMT.fmt("<color=#171311>祖师在问鼎苍穹-{0}中\n惜败</color>",stageName)
args.descResult=FMT.fmt("<color=#171311>将参加{0}<size=40><color=#7d3b17>{1}</color></size>!</color>",timeStr,nextStageName)
args.toStage=WDCQCGameStageEnum.eThird
end
end
msgWinControl:addMsgWin(msgWinType.eWDCQCSJG,args,nil,true)
end


function WDCQController.checkSelfCanJoinWDCQ()
local selfActorId=playerModel:getActorID()

local isInvit=WDCQModel:getRankRoleInfo2(selfActorId)~=nil
if not isInvit then return end

local level=UIXianFaWenDaoControl:getLevel()
level=math.max(level,1)
local rankDatas=UIXianFaWenDaoControl:getRankDataByLevel(level)

for index=1,#rankDatas do
local data=rankDatas[index]
if data and next(data)then
if mathHelper.compareInt64(data.actorid,selfActorId)then
return level,data.rank
end
end
end
end

function WDCQController.checkMsgWinOpenFlag(msgType)
local flag=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWenDingCangQiong,localMsgSaveKey[msgType],false)
return flag
end

function WDCQController.checkShowYQCS()
if UIXianFaWenDaoControl:checkIsInit()then
local isInTrustTime=UIXianFaWenDaoControl:isInTruceTime()
if isInTrustTime then
local curTime=timeHelper.getServerShortTime()
local endTime=WDCQController.getGameEndTime()
return endTime>curTime
end
end
return false
end



function WDCQController.onInvitWDCQ()























end

function WDCQController.onXianFaLunDaoRankUpdate()















end

function WDCQController.checkShowYQCSMsgFlag()
local flag=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWenDingCangQiong,localMsgSaveKey[msgWinType.eWDCQYQCS],nil)
if not WDCQController:checkInit38_1()then return end
local endTime=WDCQController.getGameEndTime()
local curTime=timeHelper.getServerShortTime()
if flag==nil then
return endTime>curTime
end
local beginTime=UIXianFaWenDaoControl:getSessionBeginTime()or 0
return beginTime>flag
end

function WDCQController.checkClearYQCSMsgFlag()
local flag=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWenDingCangQiong,localMsgSaveKey[msgWinType.eWDCQYQCS],nil)
if flag==nil then
return false
end
local beginTime=UIXianFaWenDaoControl:getSessionBeginTime()or 0

if beginTime>flag then
userActorArraySetting.remove(ACTOR_SETTING_TYPE.eWenDingCangQiong,localMsgSaveKey[msgWinType.eWDCQYQCS])
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eWenDingCangQiong)
end
end




function WDCQController.onNewDay()
WDCQController.checkClearYQCSMsgFlag()
end




function WDCQController.setMsgWinOpenFlag(msgType,val,default)
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eWenDingCangQiong,localMsgSaveKey[msgType],val,default)
end




function WDCQController.dealMsgTest(group,stage,rank)
local data=WDCQModel:getData()


data.groupStagelookUp[group]=stage

local acotrId=playerModel:getActorID()
local actorData=WDCQController.getTestActorData()
actorData.groupId=group
actorData.stageId=stage
data.actorRankLookup[tostring(acotrId)]={group,rank,actorData}
data.rankList[group][rank]=actorData
end
