






local _MODULENAME="xianJieArenaActModel"


def_table(_MODULENAME)
xianJieArenaActModel.name=_MODULENAME
xianJieArenaActModel.data={}

LTYW_Rank_Type={
ePersonRank=1,
eXianMengRank=2,
eZhanYunRank=3,
}

local _arenaSortIdListLookup={
[xjClientBuildType.flcbLeiTai6]=1,
[xjClientBuildType.flcbLeiTai2]=2,
[xjClientBuildType.flcbLeiTai8]=3,
[xjClientBuildType.flcbLeiTai3]=4,
[xjClientBuildType.flcbLeiTai5]=5,
[xjClientBuildType.flcbLeiTai1]=6,
[xjClientBuildType.flcbLeiTai7]=7,
[xjClientBuildType.flcbLeiTai4]=8,
}


function xianJieArenaActModel:onAppStart()

end


function xianJieArenaActModel:onEnterState(isReconnect)

end


function xianJieArenaActModel:onProtocolReq()

end


function xianJieArenaActModel:onLeaveState(isReconnect)

self.data={}
end



function xianJieArenaActModel:checkIsXJArenaActDoing()
if limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eLeiTaiYanWu)then
return true
end
return false
end


function xianJieArenaActModel:checkIsXJArenaActOpened()
if limitActivitiesModel:getActMark_done(LIMIT_ACT_TYPE.eLeiTaiYanWu)then
return true
end
return false
end


function xianJieArenaActModel:checkIsXJArenaActCanOpen()
if limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eLeiTaiYanWu)then
return true
end
return false
end


function xianJieArenaActModel:checkIsXJArenaActCanOpen_ignoreCustomCdn()
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eLeiTaiYanWu)
if actInfo then
return actInfo:checkCondition(nil,true)
end
return false
end


function xianJieArenaActModel:setArenaBuildList(len,list)

self.data.arenaBuildList_lookup={}
if len>0 then

for i,v in ipairs(list)do
local arenaId=v.buildId
self.data.arenaBuildList_lookup[arenaId]=v
end
end
end


function xianJieArenaActModel:getArenaBuildList()
if not self.data then
return nil
end

return self.data.arenaBuildList_lookup
end


function xianJieArenaActModel:setArenaBuildDataByArenaId(arenaId,data)
if not self.data or not self.data.arenaBuildList_lookup then
return
end

self.data.arenaBuildList_lookup[arenaId]=data
end



function xianJieArenaActModel:checkArenaBuildIsOpenByArenaId(arenaId)
if not self.data or not self.data.arenaBuildList_lookup then
return false
end

if self.data.arenaBuildList_lookup[arenaId]then
return true
end
return false
end


function xianJieArenaActModel:getArenaBuildData(arenaId)
if not self.data or not self.data.arenaBuildList_lookup then
return nil
end

return self.data.arenaBuildList_lookup[arenaId]
end


function xianJieArenaActModel:resetAllArenaOccupyData()
if not self.data or not self.data.arenaBuildList_lookup then
return
end
for arenaId,v in pairs(self.data.arenaBuildList_lookup)do
self:resetArenaOccupyDataByArenaId(arenaId)
end
end


function xianJieArenaActModel:resetArenaOccupyDataByArenaId(arenaId)
if not self.data or not self.data.arenaBuildList_lookup then
return
end
if self.data.arenaBuildList_lookup[arenaId]then
self.data.arenaBuildList_lookup[arenaId].occupyServerId=0
self.data.arenaBuildList_lookup[arenaId].occupyStartTime=0
self.data.arenaBuildList_lookup[arenaId].sceneidx=0
self.data.arenaBuildList_lookup[arenaId].len=0
self.data.arenaBuildList_lookup[arenaId].occupyHis=nil
end
end


function xianJieArenaActModel:setArenaLogList(arenaId,len,list)
if not self.data.arenaLogList then
self.data.arenaLogList={}
end

self.data.arenaLogList[arenaId]={}
if len>0 then
self.data.arenaLogList[arenaId]=list
end
end


function xianJieArenaActModel:getArenaLogList(arenaId)
if not self.data or not self.data.arenaLogList then
return nil
end

return self.data.arenaLogList[arenaId]
end


function xianJieArenaActModel:setArenaZhuJunList(arenaId,len,list)
if not self.data.arenaZhuJunList then
self.data.arenaZhuJunList={}
end

self.data.arenaZhuJunList[arenaId]={}
if len>0 then
self.data.arenaZhuJunList[arenaId]=list
end
end


function xianJieArenaActModel:getArenaZhuJunList(arenaId)
if not self.data or not self.data.arenaZhuJunList then
return nil
end

return self.data.arenaZhuJunList[arenaId]
end


function xianJieArenaActModel:setArenaRewardGotFlag(flag)
self.data.arenaRewardGotFlag=flag
end


function xianJieArenaActModel:getArenaRewardGotFlag()
if not self.data then
return nil
end

return self.data.arenaRewardGotFlag
end


function xianJieArenaActModel:setArenaRewardWinShowFlag(flag)
self.data.arenaRewardWinShowFlag=flag
end


function xianJieArenaActModel:getArenaRewardWinShowFlag()
if not self.data then
return nil
end

return self.data.arenaRewardWinShowFlag
end


function xianJieArenaActModel:checkIsCanGetArenaReward()

local isOpen=xianJieArenaActModel:checkIsXJArenaActCanOpen_ignoreCustomCdn()
if not isOpen then
return false
end


local gotFlag=self:getArenaRewardGotFlag()
local isGot=gotFlag==1
if isGot then
return false
end


local isOpenAct=self:checkIsXJArenaActDoing()
if isOpenAct then
return false
end


local hasOccupyArena=false
local arenaList=xianJieArenaActModel:getArenaBuildList()or{}
for arenaId,arenaData in pairs(arenaList)do
local cross_sid=loginModel:getCrossServerId()
local occupyServerId=arenaData.occupyServerId
local isSelfXianYu=occupyServerId==cross_sid
if isSelfXianYu then
hasOccupyArena=true
break
end
end
if not hasOccupyArena then
return false
end

return true
end











































function xianJieArenaActModel:checkArenaHasOccupy()
local openArenaList=xianJieArenaActModel:getArenaBuildList()or{}
local hasOccupy=false
for i,v in pairs(openArenaList)do

if v.occupyServerId and v.occupyServerId~=0 then
hasOccupy=true
break
end
end
return hasOccupy
end



function xianJieArenaActModel:setArenaHasCompensationFlag(flag)
self.data.arenaHasCompensationFlag=flag
end


function xianJieArenaActModel:getArenaHasCompensationFlag()
if not self.data then
return nil
end

return self.data.arenaHasCompensationFlag
end


function xianJieArenaActModel:setArenaGotCompensationFlag(flag)
self.data.arenaGotCompensationFlag=flag
end


function xianJieArenaActModel:getArenaGotCompensationFlag()
if not self.data then
return nil
end

return self.data.arenaGotCompensationFlag
end


function xianJieArenaActModel:checkArenaHasCompensation()
local isOpen=false
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eLeiTaiYanWu)
if actInfo then
isOpen=actInfo:checkCondition(nil,true)
end

if not isOpen then
return false
end
local hasFlag=xianJieArenaActModel:getArenaHasCompensationFlag()
local gotFlag=xianJieArenaActModel:getArenaGotCompensationFlag()

if hasFlag==1 and gotFlag~=1 then
return true
end

return false
end



function xianJieArenaActModel:setArenaRankList(rankType,len,list)
if not self.data.arenaRankList then
self.data.arenaRankList={}
end

if not self.data.arenaRankList[rankType]then
self.data.arenaRankList[rankType]={}
end

if len>0 then
self.data.arenaRankList[rankType]=list
end
end


function xianJieArenaActModel:getArenaRankList(rankType)
if not self.data or not self.data.arenaRankList then
return nil
end
return self.data.arenaRankList[rankType]
end


function xianJieArenaActModel:initArenaRankRewardCfgLookupList(rankType)
if not self.data.arenaRankRewardCfgLookupList then
self.data.arenaRankRewardCfgLookupList={}
end

local lookup={}
local rewardCfg_pf
if rankType==LTYW_Rank_Type.ePersonRank then
rewardCfg_pf=cfgHelper.get(cfg_leitaiyanwubaseconfig_get,1,"rankRewards1")
elseif rankType==LTYW_Rank_Type.eXianMengRank then
rewardCfg_pf=cfgHelper.get(cfg_leitaiyanwubaseconfig_get,1,"rankRewards3")
elseif rankType==LTYW_Rank_Type.eZhanYunRank then
rewardCfg_pf=cfgHelper.get(cfg_leitaiyanwubaseconfig_get,1,"rankRewards2")
end
local rewardCfg=pfwindowsModel:getVersionAndPfCfg_severPf(rewardCfg_pf)

for i=1,#rewardCfg do
local startIndex=rewardCfg[i][1]
local endIndex=rewardCfg[i][2]
local rewards=rewardCfg[i][3]

for j=startIndex,endIndex do
lookup[j]=rewards
end
end
self.data.arenaRankRewardCfgLookupList[rankType]=lookup
end


function xianJieArenaActModel:getArenaRankRewardCfgLookupList(rankType)
if not self.data or not self.data.arenaRankRewardCfgLookupList or not self.data.arenaRankRewardCfgLookupList[rankType]then
self:initArenaRankRewardCfgLookupList(rankType)
end

return self.data.arenaRankRewardCfgLookupList[rankType]
end


function xianJieArenaActModel:getArenaRankReward(rankType,rankNum)
local lookup=self:getArenaRankRewardCfgLookupList(rankType)or{}

return lookup[rankNum]
end


function xianJieArenaActModel:getArenaRankSettlementTime()
local cfg=cfgHelper.get(cfg_leitaiyanwubaseconfig_get,1)
local rankSettlementCfg=cfg.rankSettlement
local weekDay=rankSettlementCfg[1]
local hour=rankSettlementCfg[2]
local min=rankSettlementCfg[3]
local sec=rankSettlementCfg[4]
local thisWeekSettlementTime=timeHelper.getWeakDateStamp(0,weekDay,hour,min,sec)
local nowTime=timeHelper.getServerLongTime()
if nowTime<=thisWeekSettlementTime then
return thisWeekSettlementTime
else
local nextWeekSettlementTime=timeHelper.getWeakDateStamp(1,weekDay,hour,min,sec)
return nextWeekSettlementTime
end
end


function xianJieArenaActModel:setArenaSelfRankValue(rankType,value)
if not self.data.arenaSelfRankValueList then
self.data.arenaSelfRankValueList={}
end

self.data.arenaSelfRankValueList[rankType]=value
end


function xianJieArenaActModel:getArenaSelfRankValue(rankType)
if not self.data or not self.data.arenaSelfRankValueList then
return nil
end
return self.data.arenaSelfRankValueList[rankType]
end



function xianJieArenaActModel:getSelfXMArenaJiJieDataList()
local list={}
local allTeamsList=xianjieModel:getJiJieSimpleDataListByJJType(xjJjJieBaseType.eWar)or{}
for i,v in ipairs(allTeamsList)do
local infoguid=v.guid
local isArena=xianjieModel:checkClientBdIsArenaByGuid(infoguid)
if isArena then
list[#list+1]=v
end
end

return list
end



function xianJieArenaActModel:setAllArenaMassDataList(len,list)
self.data.allArenaMassData={}
if len>0 then
self.data.allArenaMassData=list
end
end


function xianJieArenaActModel:getAllArenaMassDataList()
if not self.data then
return nil
end

return self.data.allArenaMassData
end




function xianJieArenaActModel:setArenaZhuJunDzList(massActorid,massGuid,len,dzList)
if not self.data.arenaZhuJunDzList then
self.data.arenaZhuJunDzList={}
end

local actorIdStr=tostring(massActorid)
local guidStr=tostring(massGuid)
if not self.data.arenaZhuJunDzList[actorIdStr]then
self.data.arenaZhuJunDzList[actorIdStr]={}
end

self.data.arenaZhuJunDzList[actorIdStr][guidStr]=dzList
end


function xianJieArenaActModel:getArenaZhuJunDzList(massActorid,massGuid)
if not self.data or not self.data.arenaZhuJunDzList then
return nil
end

local actorIdStr=tostring(massActorid)
local guidStr=tostring(massGuid)
if not self.data.arenaZhuJunDzList[actorIdStr]then
return nil
end

return self.data.arenaZhuJunDzList[actorIdStr][guidStr]
end



function xianJieArenaActModel:setArenaInfoWinSelectMenuIndex(index)
self.data.infoWinSelectMenuIndex=index
end


function xianJieArenaActModel:getArenaInfoWinSelectMenuIndex()
if not self.data then
return nil
end

return self.data.infoWinSelectMenuIndex
end


function xianJieArenaActModel:setLastSelectArenaId(arenaId)
self.data.lastSelectArenaId=arenaId
end


function xianJieArenaActModel:getLastSelectArenaId()
if not self.data then
return nil
end

return self.data.lastSelectArenaId
end



















function xianJieArenaActModel:checkArenaHasSelfJJOrZJTeam(arenaId)

local teamDataList=xianjieModel:getOnlyWaiPaiTeamData()
for _,v in ipairs(teamDataList)do
local teamData=v.teamData
local occupytype=v.occupytype
if occupytype==xjWaiPiaBaseType.eJiJIe or occupytype==xjWaiPiaBaseType.eMarckTeam then

local guid
local sceneidx
if occupytype==xjWaiPiaBaseType.eMarckTeam then
guid=teamData.infoguid
sceneidx=teamData.tarsceneidx
elseif occupytype==xjWaiPiaBaseType.eJiJIe then
local paramList=teamData.data.paramList
if paramList and next(paramList)then
guid=paramList[3]
sceneidx=teamData.data.sceneidx
end
end
if guid then
local entityType=xianjieModel:getEntityTypeByGuid(guid,sceneidx)
if entityType and entityType==xjServerEnityType.eClientBuild then
local targetArenaId=mathHelper.int64_to_number(guid)
if targetArenaId==arenaId then

local actorId
if occupytype==xjWaiPiaBaseType.eMarckTeam then
actorId=teamData.actorid
elseif occupytype==xjWaiPiaBaseType.eJiJIe then
local paramList=teamData.data.paramList
if paramList and next(paramList)then
actorId=paramList[2]
end
end
if actorId and playerModel:checkActorId(actorId)then
return true
end
end
end
end
elseif occupytype==xjWaiPiaBaseType.eArena then
local arenaId_64=teamData.data.paramList[1]
local targetArenaId=mathHelper.int64_to_number(arenaId_64)
if targetArenaId==arenaId then
local initiatorActorId=teamData.data.paramList[2]
if initiatorActorId and playerModel:checkActorId(initiatorActorId)then
return true
end
end
end
end
end

function xianJieArenaActModel:getArenaBuildServerOccupyCount(cross_sid)
local count=0
local arenaList=xianJieArenaActModel:getArenaBuildList()
if arenaList then
for arenaId,arenaData in pairs(arenaList)do
local occupyServerId=arenaData.occupyServerId
if occupyServerId==cross_sid then
count=count+1
end
end
end

return count
end


function xianJieArenaActModel:getArenaBuildServerOverLimitOccupyList()
local lookup={}
local countLookup={}
local maxOccupyCount_cfg=cfgHelper.get(cfg_leitaiyanwubaseconfig_get,1,"occupyMax")
local maxOccupyCount=pfwindowsModel:getVersionAndPfCfg_severPf(maxOccupyCount_cfg)

local arenaList=xianJieArenaActModel:getArenaBuildList()
local allArenaIndexList={
[1]=xjClientBuildType.flcbLeiTai6,
[2]=xjClientBuildType.flcbLeiTai2,
[3]=xjClientBuildType.flcbLeiTai8,
[4]=xjClientBuildType.flcbLeiTai3,
[5]=xjClientBuildType.flcbLeiTai5,
[6]=xjClientBuildType.flcbLeiTai1,
[7]=xjClientBuildType.flcbLeiTai7,
[8]=xjClientBuildType.flcbLeiTai4,
}
for sortId,arenaId in ipairs(allArenaIndexList)do
local arenaData=arenaList and arenaList[arenaId]or nil
if arenaData then
local occupyServerId=arenaData.occupyServerId
if not countLookup[occupyServerId]then
countLookup[occupyServerId]=0
end
countLookup[occupyServerId]=countLookup[occupyServerId]+1
if countLookup[occupyServerId]>=maxOccupyCount then
if not lookup[occupyServerId]then
lookup[occupyServerId]=sortId
end
end
end
end
return lookup
end

function xianJieArenaActModel:getArenaBuildSortId(arenaId)
local sortId=_arenaSortIdListLookup[arenaId]
return sortId
end