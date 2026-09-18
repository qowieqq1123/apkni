






local _MODULENAME="moGongZhengDuoActModel"


def_table(_MODULENAME)
moGongZhengDuoActModel.name=_MODULENAME
moGongZhengDuoActModel.data={}


MGZD_RANK_TYPE={
ePersonRank=1,
eXianMengRank=2,
eZhanYunRank=3,
}


function moGongZhengDuoActModel:onAppStart()

end


function moGongZhengDuoActModel:onEnterState(isReconnect)
self.pveSetting={}
end


function moGongZhengDuoActModel:onProtocolReq()

end


function moGongZhengDuoActModel:onLeaveState(isReconnect)

self.data={}
end




function moGongZhengDuoActModel:checkIsXJArenaActDoing()
if limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eMoGongZhengDuo)then
return true
end
return false
end


function moGongZhengDuoActModel:checkIsXJArenaActOpened()
if limitActivitiesModel:getActMark_done(LIMIT_ACT_TYPE.eMoGongZhengDuo)then
return true
end
return false
end


function moGongZhengDuoActModel:checkIsXJArenaActCanOpen()
if limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eMoGongZhengDuo)then
return true
end
return false
end


function moGongZhengDuoActModel:checkInActScene()
return moGongZhengDuoActModel:checkIsXJArenaActDoing()and(mainControl:isSceneType(eSceneType.eXianJie)and xianjienSceneType:isMoGongZhengDuo(xianjieModel:getScenceType()))
end



function moGongZhengDuoActModel:setArenaBuildList(len,list)

self.data.arenaBuildList_lookup={}
if len>0 then


for i,v in ipairs(list)do
local arenaId=v.buildId
v.xmGuidStr=tostring(v.xmGuid)
v.sceneidx=xianjienSceneIndexType.eMoGongZhengDuo
self.data.arenaBuildList_lookup[arenaId]=v
end
end
end


function moGongZhengDuoActModel:getArenaBuildList()
if not self.data then
return nil
end

return self.data.arenaBuildList_lookup
end


function moGongZhengDuoActModel:setArenaBuildDataByArenaId(arenaId,data)
if not self.data or not self.data.arenaBuildList_lookup then
return
end
if data then
data.xmGuidStr=tostring(data.xmGuid)
end
self.data.arenaBuildList_lookup[arenaId]=data
end



function moGongZhengDuoActModel:checkArenaBuildIsOpenByArenaId(arenaId)
if not self.data or not self.data.arenaBuildList_lookup then
return false
end

if self.data.arenaBuildList_lookup[arenaId]then
return true
end
return false
end


function moGongZhengDuoActModel:getArenaBuildData(arenaId)
if not self.data or not self.data.arenaBuildList_lookup then
return nil
end

return self.data.arenaBuildList_lookup[arenaId]
end


function moGongZhengDuoActModel:resetAllArenaOccupyData()
if not self.data or not self.data.arenaBuildList_lookup then
return
end
for arenaId,v in pairs(self.data.arenaBuildList_lookup)do
self:resetArenaOccupyDataByArenaId(arenaId)
end
end


function moGongZhengDuoActModel:resetArenaOccupyDataByArenaId(arenaId)
if not self.data or not self.data.arenaBuildList_lookup then
return
end
if self.data.arenaBuildList_lookup[arenaId]then
self.data.arenaBuildList_lookup[arenaId].occupyServerId=0
self.data.arenaBuildList_lookup[arenaId].occupyStartTime=0
self.data.arenaBuildList_lookup[arenaId].sceneidx=0
self.data.arenaBuildList_lookup[arenaId].len=0
self.data.arenaBuildList_lookup[arenaId].occupyHis=nil
self.data.arenaBuildList_lookup[arenaId].xmGuid=nil
self.data.arenaBuildList_lookup[arenaId].xmName=''
self.data.arenaBuildList_lookup[arenaId].xmGuidStr=''
end
end


function moGongZhengDuoActModel:setArenaLogList(arenaId,len,list)
if not self.data.arenaLogList then
self.data.arenaLogList={}
end

self.data.arenaLogList[arenaId]={}
if len>0 then
self.data.arenaLogList[arenaId]=list
end
end


function moGongZhengDuoActModel:getArenaLogList(arenaId)
if not self.data or not self.data.arenaLogList then
return nil
end

return self.data.arenaLogList[arenaId]
end


function moGongZhengDuoActModel:setArenaZhuJunList(arenaId,len,list)
if not self.data.arenaZhuJunList then
self.data.arenaZhuJunList={}
end

self.data.arenaZhuJunList[arenaId]={}
if len>0 then
self.data.arenaZhuJunList[arenaId]=list
end
end


function moGongZhengDuoActModel:getArenaZhuJunList(arenaId)
if not self.data or not self.data.arenaZhuJunList then
return nil
end

return self.data.arenaZhuJunList[arenaId]
end


function moGongZhengDuoActModel:setArenaRewardGotFlag(flag)
self.data.arenaRewardGotFlag=flag
end


function moGongZhengDuoActModel:getArenaRewardGotFlag()
if not self.data then
return nil
end

return self.data.arenaRewardGotFlag
end


function moGongZhengDuoActModel:setArenaRewardWinShowFlag(flag)
self.data.arenaRewardWinShowFlag=flag
end


function moGongZhengDuoActModel:getArenaRewardWinShowFlag()
if not self.data then
return nil
end

return self.data.arenaRewardWinShowFlag
end

function moGongZhengDuoActModel:setActSceneEnterFlag(flag)
self.data.actSceneEnterFlag=flag
end

function moGongZhengDuoActModel:getActSceneEnterFlag()
if not self.data then
return nil
end

return self.data.actSceneEnterFlag
end

function moGongZhengDuoActModel:setActInSceneFlag(flag)

self.data.actInSceneFlag=flag
end

function moGongZhengDuoActModel:getActInSceneFlag()
if not self.data then
return nil
end

return self.data.actInSceneFlag
end

function moGongZhengDuoActModel:checkInSceneFlag()
if not self.data then
return nil
end

return self.data.actInSceneFlag==1

end


function moGongZhengDuoActModel:setLastExitTime(lastExitTime)
self.data.lastExitTime=lastExitTime
end

function moGongZhengDuoActModel:getLastExitTime()
return self.data.lastExitTime
end

function moGongZhengDuoActModel:getEnterIntervalRemainSec()
local lastExitTime=self:getLastExitTime()or 0
if lastExitTime<=0 then
return 0
end

local intervalTime=self:getBaseConfig('intervalTime')or 0
intervalTime=tonumber(intervalTime)or 0
if intervalTime<=0 then
return 0
end

local nowTime=timeHelper.getServerShortTime()or 0
local pass=nowTime-lastExitTime
local remain=intervalTime-pass
return remain
end



function moGongZhengDuoActModel:checkIsCanGetArenaReward()

local isOpen=moGongZhengDuoActModel:checkIsXJArenaActCanOpen()
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
local arenaList=moGongZhengDuoActModel:getArenaBuildList()or defaultT
local xmGuid=xianmengModel:getMyXMGuildID()
for arenaId,arenaData in pairs(arenaList)do
local oxmGuid=arenaData.xmGuid
local isSelfXM=mathHelper.compareInt64(xmGuid,oxmGuid)
if isSelfXM then
hasOccupyArena=true
break
end
end
if not hasOccupyArena then
return false
end

return true
end



function moGongZhengDuoActModel:checkArenaHasOccupy()
local openArenaList=moGongZhengDuoActModel:getArenaBuildList()or{}
local hasOccupy=false
for i,v in pairs(openArenaList)do

if v.occupyServerId and v.occupyServerId~=0 then
hasOccupy=true
break
end
end
return hasOccupy
end



function moGongZhengDuoActModel:setArenaRankList(rankType,len,list)
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


function moGongZhengDuoActModel:getArenaRankList(rankType)
if not self.data or not self.data.arenaRankList then
return nil
end
return self.data.arenaRankList[rankType]
end


function moGongZhengDuoActModel:initArenaRankRewardCfgLookupList(rankType,level)
if not self.data.arenaRankRewardCfgLookupList then
self.data.arenaRankRewardCfgLookupList={}
end

local levelCfg=cfg_xianyulevelcconfig()
local levelLen=#levelCfg

local lookup={}
local rewardCfg
if rankType==MGZD_RANK_TYPE.ePersonRank then
rewardCfg=cfgHelper.get(cfg_mogongzhengduobaseconfig_get,1,"rankRewards1")
elseif rankType==MGZD_RANK_TYPE.eXianMengRank then
rewardCfg=cfgHelper.get(cfg_mogongzhengduobaseconfig_get,1,"rankRewards3")
elseif rankType==MGZD_RANK_TYPE.eZhanYunRank then
rewardCfg=cfgHelper.get(cfg_mogongzhengduobaseconfig_get,1,"rankRewards2")
end



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

function moGongZhengDuoActModel:getArenaRankRewardCfgLookupListEx(rankType,level)
if not self.data or not self.data.arenaRankRewardCfgLookupList or not self.data.arenaRankRewardCfgLookupList[rankType]then
self:initArenaRankRewardCfgLookupList(rankType)
end
local lookup=self.data.arenaRankRewardCfgLookupList[rankType]

if level==nil or level<=0 then
return lookup
end

if self.data.rankRewardLevelExLookUpList==nil then
self.data.rankRewardLevelExLookUpList={}
end
if self.data.rankRewardLevelExLookUpList[rankType]==nil then
self.data.rankRewardLevelExLookUpList[rankType]={}
end
if self.data.rankRewardLevelExLookUpList[rankType][level]==nil then
self.data.rankRewardLevelExLookUpList[rankType][level]={}
else
return self.data.rankRewardLevelExLookUpList[rankType][level]
end


local levelLookup=self.data.rankRewardLevelExLookUpList[rankType][level]

local levelRewardCfg=defaultT

if rankType==MGZD_RANK_TYPE.ePersonRank then
levelRewardCfg=cfgHelper.get(cfg_mogongduanweirewardconfig_get,level,"rankRewards1")
elseif rankType==MGZD_RANK_TYPE.eXianMengRank then
levelRewardCfg=cfgHelper.get(cfg_mogongduanweirewardconfig_get,level,"rankRewards3")
elseif rankType==MGZD_RANK_TYPE.eZhanYunRank then
levelRewardCfg=cfgHelper.get(cfg_mogongduanweirewardconfig_get,level,"rankRewards2")
end

local len=#levelRewardCfg
if len>0 then
for i=1,#levelRewardCfg do
local startIndex=levelRewardCfg[i][1]
local endIndex=levelRewardCfg[i][2]
local levelRewards=levelRewardCfg[i][3]

for j=startIndex,endIndex do
local reward=lookup[j]
levelLookup[j]=table.concatTable(levelRewards,reward)
end
end
end

return levelLookup
end




function moGongZhengDuoActModel:getArenaRankReward(rankType,rankNum,level)
local lookup=self:getArenaRankRewardCfgLookupListEx(rankType,level)or{}

return lookup[rankNum]
end


function moGongZhengDuoActModel:getArenaRankSettlementTime()














local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eMoGongZhengDuo)
if actInfo then return 0 end
return actInfo.end_time_l
end


function moGongZhengDuoActModel:setArenaSelfRankValue(rankType,value)
if not self.data.arenaSelfRankValueList then
self.data.arenaSelfRankValueList={}
end

self.data.arenaSelfRankValueList[rankType]=value
end


function moGongZhengDuoActModel:getArenaSelfRankValue(rankType)
if not self.data or not self.data.arenaSelfRankValueList then
return nil
end
return self.data.arenaSelfRankValueList[rankType]
end



function moGongZhengDuoActModel:getSelfXMArenaJiJieDataList()
local list={}
local allTeamsList=xianjieModel:getJiJieSimpleDataListByJJType(xjJjJieBaseType.eMoJie)or{}
for i,v in ipairs(allTeamsList)do
local infoguid=v.guid
local isArena=xianjieModel:checkClientBdIsMoGongByGuid(infoguid)
if isArena then
list[#list+1]=v
end
end

return list
end



function moGongZhengDuoActModel:setAllArenaMassDataList(len,list,len2,list2)
self.data.allArenaMassData={}
if len>0 then
for index,data in ipairs(list)do
local guid=mathHelper.int64_to_number(data.guid)
if self.data.allArenaMassData[guid]==nil then
self.data.allArenaMassData[guid]={}
end
table.insert(self.data.allArenaMassData[guid],data)
end
end
if len2>0 then
for index,data in ipairs(list2)do
local guid=data.cb_type
if self.data.allArenaMassData[guid]==nil then
self.data.allArenaMassData[guid]={}
end
data.guid=mathHelper.number_to_int64(guid)
table.insert(self.data.allArenaMassData[guid],data)
end
end
end


function moGongZhengDuoActModel:getAllArenaMassDataList()
if self.data==nil or self.data.allArenaMassData==nil then
return nil
end

return self.data.allArenaMassData
end

function moGongZhengDuoActModel:getBuildMassDataListByBuildID(buildID)
if self.data==nil or self.data.allArenaMassData==nil then
return nil
end

return self.data.allArenaMassData[buildID]
end




function moGongZhengDuoActModel:setArenaZhuJunDzList(massActorid,massGuid,len,dzList)
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


function moGongZhengDuoActModel:getArenaZhuJunDzList(massActorid,massGuid)
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



function moGongZhengDuoActModel:setArenaInfoWinSelectMenuIndex(index)
self.data.infoWinSelectMenuIndex=index
end


function moGongZhengDuoActModel:getArenaInfoWinSelectMenuIndex()
if not self.data then
return nil
end

return self.data.infoWinSelectMenuIndex
end

function moGongZhengDuoActModel:setBuffBuildInfoWinSelectMenuIndex(index)
self.data.buffBuildinfoWinSelectMenuIndex=index
end


function moGongZhengDuoActModel:getBuffBuildInfoWinSelectMenuIndex()
if not self.data then
return nil
end

return self.data.buffBuildinfoWinSelectMenuIndex
end


function moGongZhengDuoActModel:setLastSelectArenaId(arenaId)
self.data.lastSelectArenaId=arenaId
end


function moGongZhengDuoActModel:getLastSelectArenaId()
if not self.data then
return nil
end

return self.data.lastSelectArenaId
end



function moGongZhengDuoActModel:checkArenaHasSelfJJOrZJTeam(arenaId)

local teamDataList=xianjieModel:getOnlyWaiPaiTeamData()
for _,v in ipairs(teamDataList)do
local teamData=v.teamData
local occupytype=v.occupytype

if occupytype==xjWaiPiaBaseType.eJiJIe or occupytype==xjWaiPiaBaseType.eMarckTeam then

local guid
if occupytype==xjWaiPiaBaseType.eMarckTeam then
guid=teamData.infoguid
elseif occupytype==xjWaiPiaBaseType.eJiJIe then
local paramList=teamData.data.paramList
if paramList and next(paramList)then
guid=paramList[3]
end
end
if guid then
local sceneidx=teamData.tarsceneidx
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
elseif occupytype==xjWaiPiaBaseType.eMoGong then
local arenaId_64=teamData.data.paramList[1]
local targetArenaId=mathHelper.int64_to_number(arenaId_64)
if targetArenaId==arenaId then
local initiatorActorId=teamData.data.paramList[2]
if initiatorActorId and playerModel:checkActorId(initiatorActorId)then
return true
end
end
elseif occupytype==xjWaiPiaBaseType.eMoGong_ZHG then
local arenaId_64=teamData.data.paramList[1]
local targetArenaId=mathHelper.int64_to_number(arenaId_64)
if targetArenaId==arenaId then
local initiatorActorId=teamData.data.paramList[2]
if initiatorActorId and playerModel:checkActorId(initiatorActorId)then
return true
end
end
elseif occupytype==xjWaiPiaBaseType.eMoGong_HLT then
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



function moGongZhengDuoActModel:getBaseConfig(key)
return cfgHelper.get2(cfg_mogongzhengduobaseconfig_get,1,key)
end


function moGongZhengDuoActModel:setMoveZongMenCD(lastMoveTime)
self.data.lastMoveTime=lastMoveTime
local curTime=timeHelper.getServerShortTime()
local moveCD=self:getBaseConfig('moveCD')
local leftTime=curTime-self.data.lastMoveTime
if leftTime<moveCD then
timeEventController.delayDo(leftTime,function()

notifySystem:postNotify(notifyConfig.onMoGongZhengDuoFreeMoveZMCDReset)
end)
end
UIManager:invokeUIMethod('UIXianJieMainWin','refreshLimitMoveZMBtn')
end

function moGongZhengDuoActModel:getMoveZongMenLastTime()
return self.data.lastMoveTime
end

function moGongZhengDuoActModel:checkUseMoGongFreeMoveZongMen()
if self.data.lastMoveTime==nil then return false end

local curTime=timeHelper.getServerShortTime()
local moveCD=self:getBaseConfig('moveCD')
local left=curTime-self.data.lastMoveTime
return left>=moveCD
end



function moGongZhengDuoActModel:getPvESetting()
return self.pveSetting
end

function moGongZhengDuoActModel:setPvESetting(setting)
if setting==nil then return end
self.pveSetting[1]=setting[1]
self.pveSetting[2]=setting[2]
end

function moGongZhengDuoActModel:checkPvETeamBySetting(teamData)
local teamSelect=self.pveSetting[1]
if teamSelect then
local isMy=teamData:isMyXMTeam()
if isMy then
if moGongZhengDuoActModel:checkInMyWaiPai(teamData.guid)then
return teamSelect[1]~=false
else
return teamSelect[2]~=false
end
else
return teamSelect[3]~=false
end
end
return true
end

function moGongZhengDuoActModel:checkPvPTeamBySetting(teamData)
local teamSelect=self.pveSetting[1]
if teamSelect then
local isMy=teamData:isMyXMTeam()
if isMy then
return teamSelect[2]~=false
else
return teamSelect[3]~=false
end
end
return true
end


function moGongZhengDuoActModel:getActLeftState()
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eMoGongZhengDuo)
if actInfo==nil then return end

local readyTime=self:getBaseConfig('readyTime')
local nowTime=timeHelper.getServerShortTime()
if nowTime>actInfo.start_time+readyTime then
return 2
else
return 1
end
end

function moGongZhengDuoActModel:checkInReadyTime()
local state=self:getActLeftState()or 0
return state==1
end


function moGongZhengDuoActModel:setServerUpdated(flag)
self.data.serverUpdated=flag
end

function moGongZhengDuoActModel:checkServerUpdated()
if self.data==nil or self.data.serverUpdated==nil then return false end

return self.data.serverUpdated==1
end
