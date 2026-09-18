






local _MODULENAME="XingYuModel"


def_table(_MODULENAME)
XingYuModel.name=_MODULENAME
XingYuModel.data={}



function XingYuModel:onAppStart()

end


function XingYuModel:onEnterState(isReconnect)
self.lookUpData={}


































end


function XingYuModel:onProtocolReq()

end


function XingYuModel:onLeaveState(isReconnect)

self.initFlag=false
end






function XingYuModel:getXingYuBaseConfig()
return cfg_xingyubaseconfig_get(1)
end

function XingYuModel:getXingYuConfig(xyId)
return cfg_xingyuconfig_get(xyId)
end

function XingYuModel:getXingYuHuanJingConfig(envId)
return cfg_xingyuenvconfig_get(envId)
end







function XingYuModel:setInitFlag(flag)
self.initFlag=flag
end


function XingYuModel:refreshlookUpData_xingyuData_teamList(xyId,teamList)
if not self.lookUpData._xingyuDataLookUp then
self.lookUpData._xingyuDataLookUp={}
end
if not self.lookUpData._xingyuDataLookUp[xyId]then
self.lookUpData._xingyuDataLookUp[xyId]={}
end
self.lookUpData._xingyuDataLookUp[xyId]._teamList=teamList

local teamGuidList={}
local teamPosGuidList={}
local teamFightList={}
local teamJiYuanList={}
local teamGuidListLen=0
local hasRw=false
if teamList then
for i,xingyuTeam in ipairs(teamList)do
if xingyuTeam.len>0 then
local teamIndex=xingyuTeam.index
local guidTemp={}
local posguidTemp={0,0,0,0,0}
for pos,guid in ipairs(xingyuTeam.dzList)do
if not mathHelper.compareInt64(guid,Int64_0)then
table.insert(guidTemp,guid)
end
posguidTemp[pos]=guid
end
if#guidTemp>0 then
teamGuidListLen=teamGuidListLen+1
teamGuidList[teamIndex]=guidTemp
end
teamPosGuidList[teamIndex]=posguidTemp
teamFightList[teamIndex]=mathHelper.int64_to_number(xingyuTeam.fightVal)
teamJiYuanList[teamIndex]=xingyuTeam.jyzTeam
end
if not hasRw and xingyuTeam.len2>0 then
hasRw=true
end
end
end
self.lookUpData._xingyuDataLookUp[xyId]._teamGuidList=teamGuidList
self.lookUpData._xingyuDataLookUp[xyId]._teamGuidListLen=teamGuidListLen
self.lookUpData._xingyuDataLookUp[xyId]._teamPosGuidList=teamPosGuidList
self.lookUpData._xingyuDataLookUp[xyId]._teamFightList=teamFightList
self.lookUpData._xingyuDataLookUp[xyId]._teamJiYuanList=teamJiYuanList

self.lookUpData._xingyuDataLookUp[xyId]._hasRw=hasRw
end

function XingYuModel:refreshlookUpData_xingyuData_fazeList(xyId,fazeList)
if not self.lookUpData._xingyuDataLookUp then
self.lookUpData._xingyuDataLookUp={}
end
if not self.lookUpData._xingyuDataLookUp[xyId]then
self.lookUpData._xingyuDataLookUp[xyId]={}
end
local envId=XingYuModel:getXingYuData_envId(xyId)
local hjCfg=envId and XingYuModel:getXingYuHuanJingConfig(envId)or nil
local _fazeList={}
if hjCfg and hjCfg.fzList then
for i,v in ipairs(hjCfg.fzList)do
_fazeList[#_fazeList+1]={id=v[1],level=v[2]}
end
end
if fazeList then
for i,v in ipairs(fazeList)do
_fazeList[#_fazeList+1]={id=v.param_1,level=v.param_2}
end
end

self.lookUpData._xingyuDataLookUp[xyId]._fazeList=_fazeList
end


function XingYuModel:refreshlookUpData_xingyuDataLookUp(data)

if not data then
self.lookUpData._xingyuIdList=nil
self.lookUpData._xingyuDataLookUp=nil
return
end
local xingyuIdList={}
local xingyuDataLookUp=self.lookUpData._xingyuDataLookUp or{}
for i,v in ipairs(data)do
local xingyuItem=v
local xingyuId=xingyuItem.xingyuId
local teamList=xingyuItem.teamList
local envId=xingyuItem.envId
table.insert(xingyuIdList,xingyuId)
if not xingyuDataLookUp[xingyuId]then
xingyuDataLookUp[xingyuId]={}
end
local xingyuData=xingyuDataLookUp[xingyuId]
xingyuData._envId=envId
xingyuData._teamList=teamList
xingyuData._rwFlag=xingyuItem.rwFlag


local teamGuidList={}
local teamPosGuidList={}
local teamFightList={}
local teamJiYuanList={}
local teamGuidListLen=0
local hasRw=false
if teamList then
for _,xingyuTeam in ipairs(teamList)do
if xingyuTeam.len>0 then
local teamIndex=xingyuTeam.index
local guidTemp={}
local posguidTemp={0,0,0,0,0}
for pos,guid in ipairs(xingyuTeam.dzList)do
if not mathHelper.compareInt64(guid,Int64_0)then
table.insert(guidTemp,guid)
end
posguidTemp[pos]=guid
end
if#guidTemp>0 then
teamGuidListLen=teamGuidListLen+1
teamGuidList[teamIndex]=guidTemp
end
teamPosGuidList[teamIndex]=posguidTemp
teamFightList[teamIndex]=mathHelper.int64_to_number(xingyuTeam.fightVal)
teamJiYuanList[teamIndex]=xingyuTeam.jyzTeam
end
if not hasRw and xingyuTeam.len2>0 then
hasRw=true
end
end
end
local zdzrwidList={}
if xingyuItem.len2>0 then
for i,v in ipairs(xingyuItem.zdzrwidList)do
zdzrwidList[v.param_1]=v.param_2
end
else
logErr("后端没有下发争夺战奖励列表")
end
xingyuData._zdzrwidList=zdzrwidList
xingyuData._teamGuidList=teamGuidList
xingyuData._teamFightList=teamFightList
xingyuData._teamJiYuanList=teamJiYuanList
xingyuData._teamGuidListLen=teamGuidListLen
xingyuData._teamPosGuidList=teamPosGuidList
xingyuData._hzTeamCnt=xingyuItem.hzTeamNum
xingyuData._zdzTeamCnt=xingyuItem.zdzTeamNum
xingyuData._hasRw=hasRw
xingyuData._hzSumRound=XingYuController.getRound(xingyuData._hzTeamCnt,32)
xingyuData._zdzSumRound=XingYuController.getRound(xingyuData._zdzTeamCnt)
end

table.sort(xingyuIdList,function(a,b)
local acfg=XingYuModel:getXingYuConfig(a)
local bcfg=XingYuModel:getXingYuConfig(b)
return acfg.color>bcfg.color
end)
self.lookUpData._xingyuIdList=xingyuIdList
self.lookUpData._xingyuDataLookUp=xingyuDataLookUp
end

function XingYuModel:refreshlookUpData_lastXingyuDataLookUp(data)
if not data then
self.lookUpData._lastxingyuIdList=nil
self.lookUpData._lastXingyuDataLookUp=nil
return
end
local xingyuIdList={}
local xingyuDataLookUp=self.lookUpData._lastXingyuDataLookUp or{}
for i,v in ipairs(data)do
local xingyuItem=v
local xingyuId=xingyuItem.xingyuId
local teamList=xingyuItem.teamList
local envId=xingyuItem.envId
table.insert(xingyuIdList,xingyuId)
if not xingyuDataLookUp[xingyuId]then
xingyuDataLookUp[xingyuId]={}
end
local xingyuData=xingyuDataLookUp[xingyuId]
xingyuData._envId=envId
xingyuData._teamList=teamList
xingyuData._rwFlag=xingyuItem.rwFlag

local teamGuidList={}
local teamPosGuidList={}
local teamFightList={}
local teamJiYuanList={}
local teamGuidListLen=0
local hasRw
if teamList then
for _,xingyuTeam in ipairs(teamList)do
if xingyuTeam.len>0 then
local teamIndex=xingyuTeam.index
local guidTemp={}
local posguidTemp={0,0,0,0,0}
for pos,guid in ipairs(xingyuTeam.dzList)do
if not mathHelper.compareInt64(guid,Int64_0)then
table.insert(guidTemp,guid)
end
posguidTemp[pos]=guid
end
if#guidTemp>0 then
teamGuidListLen=teamGuidListLen+1
teamGuidList[teamIndex]=guidTemp
end
teamPosGuidList[teamIndex]=posguidTemp
teamFightList[teamIndex]=mathHelper.int64_to_number(xingyuTeam.fightVal)
teamJiYuanList[teamIndex]=xingyuTeam.jyzTeam
end
if not hasRw and xingyuTeam.len2>0 then
hasRw=true
end
end
end

local zdzrwidList={}
if xingyuItem.len2>0 then
for i,v in ipairs(xingyuItem.zdzrwidList)do
zdzrwidList[v.param_1]=v.param_2
end
else
logErr("后端没有下发争夺战奖励列表")
end
xingyuData._zdzrwidList=zdzrwidList

xingyuData._hasRw=hasRw
xingyuData._teamGuidList=teamGuidList
xingyuData._teamFightList=teamFightList
xingyuData._teamJiYuanList=teamJiYuanList
xingyuData._teamGuidListLen=teamGuidListLen
xingyuData._teamPosGuidList=teamPosGuidList
xingyuData._hzTeamCnt=xingyuItem.hzTeamNum
xingyuData._zdzTeamCnt=xingyuItem.zdzTeamNum
xingyuData._hzSumRound=XingYuController.getRound(xingyuData._hzTeamCnt,32)
xingyuData._zdzSumRound=XingYuController.getRound(xingyuData._zdzTeamCnt)
end

table.sort(xingyuIdList,function(a,b)
local acfg=XingYuModel:getXingYuConfig(a)
local bcfg=XingYuModel:getXingYuConfig(b)
return acfg.color>bcfg.color
end)
self.lookUpData._lastxingyuIdList=xingyuIdList
self.lookUpData._lastXingyuDataLookUp=xingyuDataLookUp
end

function XingYuModel:refreshlookUpData_xingyuData_teamRewardList(xingyuId,len,rwList)
local xingyuDataLookUp=self.lookUpData._xingyuDataLookUp or{}
if not xingyuDataLookUp[xingyuId]then
xingyuDataLookUp[xingyuId]={}
end
local xingyuData=xingyuDataLookUp[xingyuId]

xingyuData._teamRewardList={}

local teamRewardList=xingyuData._teamRewardList
if len>0 then
for i,xingyuReward in ipairs(rwList)do
local teamIndex=xingyuReward.index
XingYuModel:refreshXingyuRewardAllRewardList(xingyuId,xingyuReward)
teamRewardList[teamIndex]=xingyuReward
end
end

self.lookUpData._xingyuDataLookUp=xingyuDataLookUp
end

function XingYuModel:refreshlookUpData_xingyuData_LogList(xingyuId,zsLogList,xyLogList)
local xingyuDataLookUp=self.lookUpData._xingyuDataLookUp or{}
if not xingyuDataLookUp[xingyuId]then
xingyuDataLookUp[xingyuId]={}
end
local xingyuData=xingyuDataLookUp[xingyuId]

xingyuData._zsLogList={}
xingyuData._xyLogList={}

if zsLogList then
for i,xingyuLog in ipairs(zsLogList)do
local zsLogtemp={}
zsLogtemp.logType=xingyuLog.logType
zsLogtemp.args=jsonHelper.decode(xingyuLog.jsonStr)
local evnid=zsLogtemp.args[1]
local evncfg=cfg_xingyueventconfig_get(evnid)
if evncfg and evncfg.few==1 then
zsLogtemp.logType=LOGTYPE.eFewReward
end
zsLogtemp.logTime=xingyuLog.logTime
table.insert(xingyuData._zsLogList,zsLogtemp)
end
end
table.sort(xingyuData._zsLogList,function(a,b)
return a.logTime>b.logTime
end)

if xyLogList then
for i,xingyuLog in ipairs(xyLogList)do
local xyLogtemp={}
xyLogtemp.logType=xingyuLog.logType
xyLogtemp.args=jsonHelper.decode(xingyuLog.jsonStr)
xyLogtemp.logTime=xingyuLog.logTime
local inserFlag=true
if xyLogtemp.logType==LOGTYPE.eTanSuoBigReward then
local tsRId=xyLogtemp.args[3]
local tsRCfg=cfg_xingyutansuorewardconfig_get(tsRId)
if not tsRCfg or not tsRCfg.zxItemId or not tsRCfg.zxDesc then
inserFlag=false
end
end

if inserFlag then
table.insert(xingyuData._xyLogList,xyLogtemp)
end

end
end
table.sort(xingyuData._xyLogList,function(a,b)
return a.logTime>b.logTime
end)

self.lookUpData._xingyuDataLookUp=xingyuDataLookUp
end

function XingYuModel:refreshlookUpData_xingyuData_hzTeamCnt(xingyuId,teamNum)
local xingyuDataLookUp=self.lookUpData._xingyuDataLookUp or{}
if not xingyuDataLookUp[xingyuId]then
xingyuDataLookUp[xingyuId]={}
end
local xingyuData=xingyuDataLookUp[xingyuId]
xingyuData._hzTeamCnt=teamNum
xingyuData._hzSumRound=XingYuController.getRound(xingyuData._hzTeamCnt,32)
self.lookUpData._xingyuDataLookUp=xingyuDataLookUp
end

function XingYuModel:refreshlookUpData_xingyuData_zdzList(xingyuId,zdzList)
local xingyuDataLookUp=self.lookUpData._xingyuDataLookUp or{}
if not xingyuDataLookUp[xingyuId]then
xingyuDataLookUp[xingyuId]={}
end
local xingyuData=xingyuDataLookUp[xingyuId]
local _zdzList={}

local allcnt=0
for _,xingyuZhengDuoZhan in ipairs(zdzList or{})do
local sequence=xingyuZhengDuoZhan.sequence
if not _zdzList[sequence]then
_zdzList[sequence]={}
end
local sequenceList=_zdzList[sequence]
local len=xingyuZhengDuoZhan.len
if len>0 then
local dzList=xingyuZhengDuoZhan.dzList
for i,xingyuZDZItem in ipairs(dzList)do
local sequenceTemp={}
sequenceTemp[1]={}
sequenceTemp[1].name=xingyuZDZItem.aName
sequenceTemp[1].iconInfo=xingyuZDZItem.aIcon
sequenceTemp[1].serverId=xingyuZDZItem.aServerId
sequenceTemp[1].teamIndex=xingyuZDZItem.aTeamIndex
sequenceTemp[1].actorId=xingyuZDZItem.aActorId
sequenceTemp[1].noActorId=mathHelper.compareInt64(xingyuZDZItem.aActorId,Int64_0)
sequenceTemp[1].winFlag=xingyuZDZItem.winner==1
sequenceTemp[2]={}
sequenceTemp[2].name=xingyuZDZItem.bName
sequenceTemp[2].iconInfo=xingyuZDZItem.bIcon
sequenceTemp[2].serverId=xingyuZDZItem.bServerId
sequenceTemp[2].teamIndex=xingyuZDZItem.bTeamIndex
sequenceTemp[2].actorId=xingyuZDZItem.bActorId
sequenceTemp[2].noActorId=mathHelper.compareInt64(xingyuZDZItem.bActorId,Int64_0)
sequenceTemp[2].winFlag=xingyuZDZItem.winner==2
sequenceTemp.fightLogId=xingyuZDZItem.fightLogId
sequenceTemp.winner=xingyuZDZItem.winner
if sequence==1 then
if not sequenceTemp[1].noActorId then
allcnt=allcnt+1
end
if not sequenceTemp[2].noActorId then
allcnt=allcnt+1
end
end
sequenceList[i]=sequenceTemp
end
end
end
xingyuData._zdzTeamCnt=allcnt
xingyuData._zdzSumRound=XingYuController.getRound(xingyuData._zdzTeamCnt)
xingyuData._zdzList=_zdzList
self.lookUpData._xingyuDataLookUp=xingyuDataLookUp
end


function XingYuModel:refreshlookUpData_xingyuData_hzRivalList(xingyuId,teamIndex,hzFightTemp)
local xingyuDataLookUp=self.lookUpData._xingyuDataLookUp or{}
if not xingyuDataLookUp[xingyuId]then
xingyuDataLookUp[xingyuId]={}
end
local xingyuData=xingyuDataLookUp[xingyuId]
local _hzRivalList=xingyuData._hzRivalList or{}
_hzRivalList[teamIndex]=hzFightTemp
xingyuData._hzRivalList=_hzRivalList
self.lookUpData._xingyuDataLookUp=xingyuDataLookUp
end

function XingYuModel:refreshlookUpData_xingyuData_zdzRivalList(xingyuId,teamIndex,zdzFightTemp)
local xingyuDataLookUp=self.lookUpData._xingyuDataLookUp or{}
if not xingyuDataLookUp[xingyuId]then
xingyuDataLookUp[xingyuId]={}
end
local xingyuData=xingyuDataLookUp[xingyuId]
local _zdzRivalList=xingyuData._zdzRivalList or{}
_zdzRivalList[teamIndex]=zdzFightTemp
xingyuData._zdzRivalList=_zdzRivalList
self.lookUpData._xingyuDataLookUp=xingyuDataLookUp
end

function XingYuModel:refreshlookUpData_xingyuData_rwFlag(xingyuId,rwFlag)
local xingyuDataLookUp=self.lookUpData._xingyuDataLookUp or{}
if not xingyuDataLookUp[xingyuId]then
xingyuDataLookUp[xingyuId]={}
end
local xingyuData=xingyuDataLookUp[xingyuId]
xingyuData._rwFlag=rwFlag
self.lookUpData._xingyuDataLookUp=xingyuDataLookUp
end

function XingYuModel:refreshlookUpData_lastxingyuData_rwFlag(xingyuId,rwFlag)
local xingyuDataLookUp=self.lookUpData._lastXingyuDataLookUp or{}
if not xingyuDataLookUp[xingyuId]then
xingyuDataLookUp[xingyuId]={}
end
local xingyuData=xingyuDataLookUp[xingyuId]
xingyuData._rwFlag=rwFlag
self.lookUpData._lastXingyuDataLookUp=xingyuDataLookUp
end

function XingYuModel:refreshlookUpData_lastEnterTimeList(xingyuId,lastTime)
local lastEnterTimeList=self.lookUpData._lastEnterTimeList or{}
lastEnterTimeList[xingyuId]=lastTime
self.lookUpData._lastEnterTimeList=lastEnterTimeList
end

function XingYuModel:refreshlookUpData_xingyuData_zdzrwidList(xingyuId,zdzrwidList)
local xingyuDataLookUp=self.lookUpData._xingyuDataLookUp or{}
if not xingyuDataLookUp[xingyuId]then
xingyuDataLookUp[xingyuId]={}
end
local xingyuData=xingyuDataLookUp[xingyuId]
local _zdzrwidList={}
if zdzrwidList then
for i,v in ipairs(zdzrwidList)do
_zdzrwidList[v.param_1]=v.param_2
end
else
logErr("后端没有下发争夺战奖励列表")
end
xingyuData._zdzrwidList=_zdzrwidList
self.lookUpData._xingyuDataLookUp=xingyuDataLookUp
end






function XingYuModel:getInitFlag()
return self.initFlag
end

function XingYuModel:getCurRecvFlag()

end

function XingYuModel:getXingYuIdList()
return self.lookUpData._xingyuIdList
end

function XingYuModel:getLastXingYuIdList()
return self.lookUpData._lastxingyuIdList
end

function XingYuModel:getXingYuDataLookUp()
return self.lookUpData._xingyuDataLookUp
end

function XingYuModel:getLastXingYuDataLookUp()
return self.lookUpData._lastXingyuDataLookUp
end

function XingYuModel:getXingYuData(xyId)
if self.lookUpData._xingyuDataLookUp then
return self.lookUpData._xingyuDataLookUp[xyId]
end
end

function XingYuModel:getLastXingYuData(xyId)
if self.lookUpData._lastXingyuDataLookUp then
return self.lookUpData._lastXingyuDataLookUp[xyId]
end
end

function XingYuModel:getLastEnterTime(xyId)
if self.lookUpData._lastEnterTimeList then
return self.lookUpData._lastEnterTimeList[xyId]
end
end

function XingYuModel:getXingYuData_teamList(xyId)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
return xyData._teamList
end
end

function XingYuModel:getXingYuData_teamListDzId(xyId,discipleguid)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
local teamList=xyData._teamList
for i,xingyuTeam in ipairs(teamList)do
local dzidList=xingyuTeam.dzidList or defaultT
for _,v in ipairs(dzidList)do
if mathHelper.compareInt64(discipleguid,v.param_1)then
return v.param_2
end
end
end
end
end

function XingYuModel:getLastXingYuData_teamList(xyId)
local xyData=XingYuModel:getLastXingYuData(xyId)
if xyData then
return xyData._teamList
end
end

function XingYuModel:getXingYuData_teamGuidList(xyId)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
return xyData._teamGuidList
end
end

function XingYuModel:getLastXingYuData_teamGuidList(xyId)
local xyData=XingYuModel:getLastXingYuData(xyId)
if xyData then
return xyData._teamGuidList
end
end

function XingYuModel:getXingYuData_teamGuidListLen(xyId)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
return xyData._teamGuidListLen
end
end

function XingYuModel:getXingYuData_teamPosGuidList(xyId)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
return xyData._teamPosGuidList
end
end

function XingYuModel:getXingYuData_teamFightList(xyId)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
return xyData._teamFightList
end
end

function XingYuModel:getXingYuData_teamJiYuanList(xyId)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
return xyData._teamJiYuanList
end
end


function XingYuModel:getXingYuData_fazeList(xyId)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
return xyData._fazeList
end
end

function XingYuModel:getXingYuData_envId(xyId)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
return xyData._envId
end
end

function XingYuModel:getXingYuData_hzTeamCnt(xyId)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
return xyData._hzTeamCnt
end
end

function XingYuModel:getXingYuData_zdzTeamCnt(xyId)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
return xyData._zdzTeamCnt
end
end

function XingYuModel:getLastXingYuData_hzTeamCnt(xyId)
local xyData=XingYuModel:getLastXingYuData(xyId)
if xyData then
return xyData._hzTeamCnt
end
end

function XingYuModel:getLastXingYuData_zdzTeamCnt(xyId)
local xyData=XingYuModel:getLastXingYuData(xyId)
if xyData then
return xyData._zdzTeamCnt
end
end

function XingYuModel:getXingYuData_hzSumRound(xyId)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
return xyData._hzSumRound
end
end

function XingYuModel:getXingYuData_zdzSumRound(xyId)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
return xyData._zdzSumRound
end
end

function XingYuModel:getXingYuData_teamRewardList(xyId)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
return xyData._teamRewardList
end
end

function XingYuModel:getXingYuData_teamReward(xyId,teamIndex)
local list=XingYuModel:getXingYuData_teamRewardList(xyId)
if list then
return list[teamIndex]
end
end

function XingYuModel:getXingYuData_zsLogList(xyId)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
return xyData._zsLogList
end
end

function XingYuModel:getXingYuData_xyLogList(xyId)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
return xyData._xyLogList
end
end

function XingYuModel:getXingYuData_zdzList(xyId)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
return xyData._zdzList
end
end


function XingYuModel:getXingYuData_zdzSequenceList(xyId,sequence)
local zdzList=XingYuModel:getXingYuData_zdzList(xyId)
if zdzList then
return zdzList[sequence]
end
end

function XingYuModel:getXingYuData_hzRivalList(xyId)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
return xyData._hzRivalList
end
end

function XingYuModel:getXingYuData_hzFightTemp(xyId,teamIndex)
local hzRivalList=XingYuModel:getXingYuData_hzRivalList(xyId)
if hzRivalList then
return hzRivalList[teamIndex]
end
end

function XingYuModel:getXingYuData_zdzRivalList(xyId)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
return xyData._zdzRivalList
end
end

function XingYuModel:getXingYuData_zdzrwidList(xyId)
local xyData=XingYuModel:getXingYuData(xyId)
if xyData then
return xyData._zdzrwidList
end
end

function XingYuModel:getXingYuData_zdzFightTemp(xyId,teamIndex)
local zdzRivalList=XingYuModel:getXingYuData_zdzRivalList(xyId)
if zdzRivalList then
return zdzRivalList[teamIndex]
end
end


function XingYuModel:getXingYuData_zdzRoundRwId(xyId,round)
local _zdzrwidList=XingYuModel:getXingYuData_zdzrwidList(xyId)
if _zdzrwidList then
return _zdzrwidList[round]
end
end





function XingYuModel:refreshXingyuRewardAllRewardList(xyId,xingyuReward)

local level=JiuYuZhengFengModel:getData_rank_level()or 0
local lookUp={}

local tsrwList=xingyuReward.tsrwList

if tsrwList then
local teamIndex=xingyuReward.index
local addValue=XingYuController.getXingYuTeamAdd_TeamIndex(xyId,teamIndex)
for _,rwId in ipairs(tsrwList)do
local items=cfgHelper.get(cfg_xingyutansuorewardconfig_get,rwId,"items")
for __,itemCfg in ipairs(items)do
if lookUp[itemCfg[1]]then
lookUp[itemCfg[1]]=lookUp[itemCfg[1]]+itemCfg[2]
else
lookUp[itemCfg[1]]=itemCfg[2]
end
end

local items2=cfgHelper.get(cfg_xingyutansuorewardconfig_get,rwId,"items2")
for __,itemCfg in ipairs(items2)do
local num=math.ceil(itemCfg[2]*(1+addValue))
if lookUp[itemCfg[1]]then
lookUp[itemCfg[1]]=lookUp[itemCfg[1]]+num
else
lookUp[itemCfg[1]]=num
end
end
end
end


local evtList=xingyuReward.evtList
if evtList then
for _,envId in ipairs(evtList)do
local result=cfgHelper.get(cfg_xingyueventconfig_get,envId,"result")
if result and result[1]==1 then
for __,itemCfg in ipairs(result[2])do
if lookUp[itemCfg[1]]then
lookUp[itemCfg[1]]=lookUp[itemCfg[1]]+itemCfg[2]
else
lookUp[itemCfg[1]]=itemCfg[2]
end
end
end
end
end





local hzqwin=xingyuReward.hzqwin
local hzqfail=xingyuReward.hzqfail


if hzqwin~=0 or hzqfail~=0 then
local sumRound=XingYuModel:getXingYuData_hzSumRound(xyId)
sumRound=sumRound<=0 and 1 or sumRound
local xyCfg=XingYuModel:getXingYuConfig(xyId)
local color=xyCfg.color
local colorCfg=cfgHelper.get(cfg_xingyuhunzhanrewardconfig_get,color)
if hzqwin~=0 then
for r=1,hzqwin do
local realLun=sumRound-r+1
local rwList=colorCfg[realLun].winRewards
for ___,itemCfg in ipairs(rwList)do
if lookUp[itemCfg[1]]then
lookUp[itemCfg[1]]=lookUp[itemCfg[1]]+itemCfg[2]
else
lookUp[itemCfg[1]]=itemCfg[2]
end
end
if level>0 then
local dwRwList=colorCfg[realLun].dwRewards[level]
if dwRwList then
local dwWinRWList=dwRwList[1]
for ___,itemCfg in ipairs(dwWinRWList)do
if lookUp[itemCfg[1]]then
lookUp[itemCfg[1]]=lookUp[itemCfg[1]]+itemCfg[2]
else
lookUp[itemCfg[1]]=itemCfg[2]
end
end
end
end
end
end
if hzqfail~=0 then
local realLun=sumRound-hzqfail+1
local rwList=colorCfg[realLun].lostRewards
for ___,itemCfg in ipairs(rwList)do
if lookUp[itemCfg[1]]then
lookUp[itemCfg[1]]=lookUp[itemCfg[1]]+itemCfg[2]
else
lookUp[itemCfg[1]]=itemCfg[2]
end
end

if level>0 then
local dwRwList=colorCfg[realLun].dwRewards[level]
if dwRwList then
local dwLoseRWList=dwRwList[2]
for ___,itemCfg in ipairs(dwLoseRWList)do
if lookUp[itemCfg[1]]then
lookUp[itemCfg[1]]=lookUp[itemCfg[1]]+itemCfg[2]
else
lookUp[itemCfg[1]]=itemCfg[2]
end
end
end
end
end
end



local zdzwin=xingyuReward.zdzwin
local zdzfail=xingyuReward.zdzfail


if zdzwin~=0 or zdzfail~=0 then
local sumRound=XingYuModel:getXingYuData_zdzSumRound(xyId)
sumRound=sumRound<=0 and 1 or sumRound
local xyCfg=XingYuModel:getXingYuConfig(xyId)
local color=xyCfg.color
local colorCfg=cfgHelper.get(cfg_xingyuzhengduozhanrewardconfig_get,color)

if zdzwin~=0 then
for r=1,zdzwin do

local rwList=XingYuController.getZDRoundRwList(xyId,r,true,level)
for ___,itemCfg in ipairs(rwList)do
if lookUp[itemCfg[1]]then
lookUp[itemCfg[1]]=lookUp[itemCfg[1]]+itemCfg[2]
else
lookUp[itemCfg[1]]=itemCfg[2]
end
end
end
end
if zdzfail~=0 then

local rwList=XingYuController.getZDRoundRwList(xyId,zdzfail,false,level)
for ___,itemCfg in ipairs(rwList)do
if lookUp[itemCfg[1]]then
lookUp[itemCfg[1]]=lookUp[itemCfg[1]]+itemCfg[2]
else
lookUp[itemCfg[1]]=itemCfg[2]
end
end
end
end


local list={}
for itemId,num in pairs(lookUp)do
local color=itemsConfig.getItemColor(itemId)
table.insert(list,{itemId,num,color})
end
table.sort(list,function(a,b)
return a[3]>b[3]
end)
xingyuReward.allRewardList=list
end



