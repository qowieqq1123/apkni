







xjBattleEffectType={
eMonster=0,
eScene=1,
eRPMonster=2,
eClientBuild=3,
eZongMen=4,
eStation=5,
eScene2=6,
}

local battleEffectLookup={}

function xianjieController:clearAllBattleEffect()
if battleEffectLookup then
for battleType,lp in pairs(battleEffectLookup)do
for k,effectEntKey in pairs(lp)do
xianjieController:removeEntity(effectEntKey)
end
end
battleEffectLookup={}
end
end

function xianjieController:removeBatterEffect(battleType,guid_str)
local lp=battleEffectLookup[battleType]
if lp then
local effectEntKey=lp[guid_str]
if effectEntKey then
lp[guid_str]=nil
xianjieController:removeEntity(effectEntKey)
return true
end
end
return false
end

function xianjieController:removeBatterEffectEx(params)
local lp=battleEffectLookup[params[1]]
if lp then
local effectEntKey=lp[params[2]]
if effectEntKey then
if params[3]then
xianjieController:invokeEntityFunc(effectEntKey,'removeBattleTime',params[3])
else
lp[effectEntKey]=nil
xianjieController:removeEntity(effectEntKey)
end
end
end
end

function xianjieController:createEntityBatterEffect(infoguid,marchguid,stime,etime,teamEntityKey,sceneIdx,marchtype)
local guid_str=tostring(infoguid)
local entityData=xianjieModel:getEntityDataByGuid(infoguid,sceneIdx)
if entityData==nil or entityData:getEntityKey()==nil then
return
end
local targetDataID=entityData:getID()

local battleType=xjBattleEffectType.eMonster
local lp=battleEffectLookup[battleType]
if lp==nil then
lp={}
battleEffectLookup[battleType]=lp
end

local key_str=tostring(marchguid)

local effectEntKey=lp[guid_str]
if effectEntKey==nil then
local data={battleType=battleType,guid_str=guid_str,targetDataID=targetDataID,marchtype=marchtype}
effectEntKey=xianjieController:addEntity(XJ_ENTITY_TYPE.eBattleEffect,data,true)
lp[guid_str]=effectEntKey
end
local data_={targetDataID=targetDataID}
local teamData=xianjieModel:getMarchTeamDataEx(key_str)
data_.teamHandleID=teamData:getTeamHandleID()
data_.faceTo=true
data_.teamEntityKey=teamEntityKey
xianjieController:invokeEntityFunc(effectEntKey,'addBattleTime',key_str,stime,etime,data_)
return{battleType,guid_str,key_str}
end

function xianjieController:createMonsterBatterEffect(infoguid,marchguid,stime,etime,teamEntityKey)
local guid_str=tostring(infoguid)
local monsterData=xianjieModel:getMonsterDataEx(guid_str)
if monsterData==nil or monsterData:getEntityKey()==nil then
return
end
local targetDataID=monsterData:getID()

local battleType=xjBattleEffectType.eMonster
local lp=battleEffectLookup[battleType]
if lp==nil then
lp={}
battleEffectLookup[battleType]=lp
end

local key_str=tostring(marchguid)

local effectEntKey=lp[guid_str]
if effectEntKey==nil then
local data={battleType=battleType,guid_str=guid_str,targetDataID=targetDataID}
effectEntKey=xianjieController:addEntity(XJ_ENTITY_TYPE.eBattleEffect,data,true)
lp[guid_str]=effectEntKey
end
local data_={targetDataID=targetDataID}
local teamData=xianjieModel:getMarchTeamDataEx(key_str)
data_.teamHandleID=teamData:getTeamHandleID()
data_.faceTo=true
data_.teamEntityKey=teamEntityKey
xianjieController:invokeEntityFunc(effectEntKey,'addBattleTime',key_str,stime,etime,data_)
return{battleType,guid_str,key_str}
end

function xianjieController:createRPMonsterBatterEffect(guid,stime,etime,teamEntityKey)
local guid_str=tostring(guid)
local marchData=xianjieModel:getResPointDataEx(guid_str)
if marchData==nil or marchData:getEntityKey()==nil then
return
end
local targetDataID=marchData:getID()

local battleType=xjBattleEffectType.eRPMonster
local lp=battleEffectLookup[battleType]
if lp==nil then
lp={}
battleEffectLookup[battleType]=lp
end

local key_str=guid_str

local effectEntKey=lp[guid_str]
if effectEntKey==nil then
local data={battleType=battleType,guid_str=guid_str,targetDataID=targetDataID}
effectEntKey=xianjieController:addEntity(XJ_ENTITY_TYPE.eBattleEffect,data,true)
lp[guid_str]=effectEntKey
end
local data_={targetDataID=targetDataID}
local teamData=xianjieModel:getResPointMarchEx(key_str)
data_.teamHandleID=teamData:getTeamHandleID()
data_.faceTo=true
data_.teamEntityKey=teamEntityKey
xianjieController:invokeEntityFunc(effectEntKey,'addBattleTime',key_str,stime,etime,data_)
return{battleType,guid_str,key_str}
end

function xianjieController:createClientBuildBattleEffect(buildId,marchguid,stime,etime,teamEntityKey,entityData)
if entityData==nil then return end
local targetDataID=entityData:getID()
local battleType=xjBattleEffectType.eClientBuild
local lp=battleEffectLookup[battleType]
if lp==nil then
lp={}
battleEffectLookup[battleType]=lp
end

local guid_str=tostring(buildId)
local key_str=tostring(marchguid)

local effectEntKey=lp[guid_str]
if effectEntKey==nil then
local data={battleType=battleType,guid_str=guid_str,targetDataID=targetDataID}

data.fightEffect={}
effectEntKey=xianjieController:addEntity(XJ_ENTITY_TYPE.eBattleEffect,data,true)
lp[guid_str]=effectEntKey
end
local data_={targetDataID=targetDataID}
local teamData=xianjieModel:getMarchTeamDataEx(key_str)
data_.teamHandleID=teamData:getTeamHandleID()
data_.teamEntityKey=teamEntityKey
xianjieController:invokeEntityFunc(effectEntKey,'addBattleTime',key_str,stime,etime,data_)
return{battleType,guid_str,key_str}
end

function xianjieController:createClientBuildBattleEffect_MoGong(buildId,marchguid,stime,etime,teamEntityKey)
local arenaData=xianjieModel:getMoGongDataByMoGongId(buildId)
if arenaData==nil then return end
local targetDataID=arenaData:getID()
local battleType=xjBattleEffectType.eClientBuild
local lp=battleEffectLookup[battleType]
if lp==nil then
lp={}
battleEffectLookup[battleType]=lp
end

local length=0
for i,v in pairs(lp)do
length=length+1
end

if length>=10 then
return
end

local guid_str=tostring(buildId)
local key_str=tostring(marchguid)

local effectEntKey=lp[guid_str]
if effectEntKey==nil then
local data={battleType=battleType,guid_str=guid_str,targetDataID=targetDataID}

data.fightEffect={}
effectEntKey=xianjieController:addEntity(XJ_ENTITY_TYPE.eBattleEffect,data,true)
lp[guid_str]=effectEntKey
end
local data_={targetDataID=targetDataID}
local teamData=xianjieModel:getMarchTeamDataEx(key_str)
data_.teamHandleID=teamData:getTeamHandleID()
data_.teamEntityKey=teamEntityKey
xianjieController:invokeEntityFunc(effectEntKey,'addBattleTime',key_str,stime,etime,data_)
return{battleType,guid_str,key_str}
end

function xianjieController:createZongMenBatterEffect(taractorid,marchguid,stime,etime,teamEntityKey)
local guid_str=tostring(taractorid)
local zmData=xianjieModel:getZongMenDataEx(guid_str)
if zmData==nil or zmData:getEntityKey()==nil then
return
end
local targetDataID=zmData:getID()

local battleType=xjBattleEffectType.eZongMen
local lp=battleEffectLookup[battleType]
if lp==nil then
lp={}
battleEffectLookup[battleType]=lp
end

local key_str=tostring(marchguid)

local effectEntKey=lp[guid_str]
if effectEntKey==nil then
local data={battleType=battleType,guid_str=guid_str,targetDataID=targetDataID}
data.fightEffect={}
effectEntKey=xianjieController:addEntity(XJ_ENTITY_TYPE.eBattleEffect,data,true)
lp[guid_str]=effectEntKey
end
local data_={targetDataID=targetDataID}
local teamData=xianjieModel:getMarchTeamDataEx(key_str)
data_.teamHandleID=teamData:getTeamHandleID()
data_.teamEntityKey=teamEntityKey
xianjieController:invokeEntityFunc(effectEntKey,'addBattleTime',key_str,stime,etime,data_)
return{battleType,guid_str,key_str}
end

function xianjieController:createStationBatterEffect(infoguid,marchguid,stime,etime,teamEntityKey)
local guid_str=tostring(infoguid)
local stationData=xianjieModel:getStationDataEx(guid_str)
if stationData==nil or stationData:getEntityKey()==nil then
return
end
local targetDataID=stationData:getID()

local battleType=xjBattleEffectType.eStation
local lp=battleEffectLookup[battleType]
if lp==nil then
lp={}
battleEffectLookup[battleType]=lp
end

local key_str=tostring(marchguid)

local effectEntKey=lp[guid_str]
if effectEntKey==nil then
local data={battleType=battleType,guid_str=guid_str,targetDataID=targetDataID}
effectEntKey=xianjieController:addEntity(XJ_ENTITY_TYPE.eBattleEffect,data,true)
lp[guid_str]=effectEntKey
end
local data_={targetDataID=targetDataID}
local teamData=xianjieModel:getMarchTeamDataEx(key_str)
data_.teamHandleID=teamData:getTeamHandleID()
data_.teamEntityKey=teamEntityKey
xianjieController:invokeEntityFunc(effectEntKey,'addBattleTime',key_str,stime,etime,data_)
return{battleType,guid_str,key_str}
end

function xianjieController:createStationBuildEffect(teamHandle)
local sceneidx,gridX_c,gridZ_c=teamHandle:getTargetPos()
local pos=xianjieController:worldGridPos2WorldPos4(gridX_c,gridZ_c,sceneidx)
local size=xianjieController:gridSize2WorldSize2(1,1)
return xianjieController:createNormalEffect2(6075,pos,size,nil,2.5,Vector3(0,0,0))
end







function xianjieController:createNormalEffect(effectId,position,startTime,endTime,scale,offset,sortingLayer,sortingOrder)
local data={effect=effectId,startTime=startTime,endTime=endTime,position=position,offset=offset,scale=scale,sortingLayer=sortingLayer,sortingOrder=sortingOrder}
local ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eSceneEffect,data,true)
local battleType=xjBattleEffectType.eScene
local lp=battleEffectLookup[battleType]
if lp==nil then
lp={}
battleEffectLookup[battleType]=lp
end
local guid_str=tostring(ent_key)
lp[guid_str]=ent_key
end







function xianjieController:createNormalEffect2(modelID,pos,size,lifeTime,scale,offset)
local data={modelID=modelID,pos=pos,size=size,lifeTime=lifeTime,offset=offset,scale=scale}
local ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eSceneEffect2,data,true)
local battleType=xjBattleEffectType.eScene2
local lp=battleEffectLookup[battleType]
if lp==nil then
lp={}
battleEffectLookup[battleType]=lp
end
local guid_str=tostring(ent_key)
lp[guid_str]=ent_key
return{battleType,guid_str}
end