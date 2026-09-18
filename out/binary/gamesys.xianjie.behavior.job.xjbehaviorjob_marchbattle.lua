









local xjBehaviorJob_marchBattle={}


function xjBehaviorJob_marchBattle:onInit()
self.marchguid=self.tree:getShareValue('marchguid')
local teamData=xianjieModel:getMarchTeamData(self.marchguid)
local teamHandle=teamData:getTeamHandle()

local state,time=teamHandle:getTeamState()
self.starTime=time[1]
self.endTime=time[2]
self.entKey=self.tree:getShareValue('teamEntityKey')
end


function xjBehaviorJob_marchBattle:onStart()

local teamData=xianjieModel:getMarchTeamData(self.marchguid)
local teamHandle=teamData:getTeamHandle()
if teamHandle:checkTargetInScene()then
if teamData.infoguid and teamData.marchtype~=xjServerMarchType.eMoZongAttack and teamData.marchtype~=xjServerMarchType.eMoJunFenShenAttack and teamData.marchtype~=xjServerMarchType.eZhenYanAttack then
local entityType=xianjieModel:getEntityTypeByGuid(teamData.infoguid,teamData.tarsceneidx)
if entityType==xjServerEnityType.eClientBuild then
if xianjieModel:isMoJiangBuild(teamData.infoguid)or xianjieModel:isMoJunBuild(teamData.infoguid)then
self.battleEffect=xianjieController:createEntityBatterEffect(teamData.infoguid,self.marchguid,self.starTime,self.endTime,self.entKey,teamData.tarsceneidx)
else
if xianjieModel:isMoGongAtk(teamData.infoguid)then

self.battleEffect=xianjieController:createClientBuildBattleEffect_MoGong(teamData.infoguid,self.marchguid,self.starTime,self.endTime,self.entKey)
else

if xianjieModel:isArenaAtk(teamData.infoguid)or xianjieModel:isMoJieGateAtk(teamData.infoguid)then
local entityData=xianjieModel:getEntityDataByGuid(teamData.infoguid,teamData.tarsceneidx)
if entityData then
self.battleEffect=xianjieController:createClientBuildBattleEffect(teamData.infoguid,self.marchguid,self.starTime,self.endTime,self.entKey,entityData)
end
end
end
end
elseif entityType==xjServerEnityType.eMoJingZhenJi_Normal then
local entityData=xianjieModel:getEntityDataByGuid(teamData.infoguid,teamData.tarsceneidx)
if entityData then
self.battleEffect=xianjieController:createClientBuildBattleEffect(teamData.infoguid,self.marchguid,self.starTime,self.endTime,self.entKey,entityData)
end
else
self.battleEffect=xianjieController:createMonsterBatterEffect(teamData.infoguid,self.marchguid,self.starTime,self.endTime,self.entKey)
end
elseif teamData.taractorid and teamData.marchtype==xjServerMarchType.eMJSLDebuffAdd then
self.battleEffect=xianjieController:createEntityBatterEffect(teamData.taractorid,self.marchguid,self.starTime,self.endTime,self.entKey,teamData.tarsceneidx,teamData.marchtype)
else
if teamData.marchtype==xjServerMarchType.eAttackRole then
if teamData.taractorid then
self.battleEffect=xianjieController:createZongMenBatterEffect(teamData.taractorid,self.marchguid,self.starTime,self.endTime,self.entKey)
end
elseif teamData.marchtype==xjServerMarchType.eStation then
local stationData=teamHandle:getAtkTargetData()
if stationData then

self.battleEffect=xianjieController:createStationBatterEffect(stationData.guid,self.marchguid,self.starTime,self.endTime,self.entKey)
else

self:clearTeamEntity()
self.battleEffect=xianjieController:createStationBuildEffect(teamHandle)
end
elseif teamData.marchtype==xjServerMarchType.eMoZongAttack or teamData.marchtype==xjServerMarchType.eMoJunFenShenAttack or teamData.marchtype==xjServerMarchType.eZhenYanAttack then
local actorid=teamData.actorid or teamData.taractorid
if actorid then
self.battleEffect=xianjieController:createZongMenBatterEffect(actorid,self.marchguid,self.starTime,self.endTime,self.entKey)
end
elseif teamData.marchtype==xjServerMarchType.eMoJingZhenJi_Origin then
local entityData=xianjieModel:findBenYuanZhenJiDataByBuildId(teamData.buildingId)
if entityData then
self.battleEffect=xianjieController:createClientBuildBattleEffect(teamData.buildingId,self.marchguid,self.starTime,self.endTime,self.entKey,entityData)
end
end
end
return true
end
return false
end

function xjBehaviorJob_marchBattle:tick(interval)
local time=gameUtilityModel.getServerShortTime2()
if time>=self.endTime then
return true
end
return false
end

function xjBehaviorJob_marchBattle:clearTeamEntity()
if self.entKey then
xianjieController:removeEntity(self.entKey)
self.tree:setShareValue('teamEntityKey',nil)
self.entKey=nil
end
end


function xjBehaviorJob_marchBattle:onDispose()
local battleEffect=self.battleEffect
if battleEffect then
self.battleEffect=nil
xianjieController:removeBatterEffectEx(battleEffect)
end
end

function xjBehaviorJob_marchBattle:onDelete()
self:clearTeamEntity()
end

return xjBehaviorJob_marchBattle