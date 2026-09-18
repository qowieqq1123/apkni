







worldMapModel={}

worldInfoFiltterGroupType={
eAll=1,
eChallenge=2,
eNew=3,
eResource=4,
eOther=5,
}

worldInfoFiltterType={
eZongmen=1,
ePlayer=2,

eMJ=11,
eMonster=12,

eFamily=21,

eResCollect=31,
eResBox=32,
eResEvent=33,
eResNPC=34,
eResMonster=35,
eResDefenseBox=36,
eResHideBox=37,

eLiLian=51,
}

worldInfoFiltterChangeType={
eMJChange=1,
eMonsterChange=2,
eFamilyChange=3,
eResChange=4,
eLiLianChange=5,
}

local mapIndexLookup=nil
local mapBlockLookup=nil
local filtterTypeCfgLookup=nil
local saveKey='worldMapFiltter'

local worldInfoFiltterFunc={

[worldInfoFiltterType.eZongmen]={
change={},
getStateList=function()

local id=1
local cfg=cfgHelper.get1(cfg_worldsceneryconfig_get,id)
local position=cfg.position
local list={

{0,cfg.worldId,position[1],position[2]},
}
return list
end,
},

[worldInfoFiltterType.ePlayer]={
change={},
getStateList=function()

local position=worldController:getCameraPosition()
local list={

{0,worldModel.world,position.x,position.z},
}
return list
end,
},

[worldInfoFiltterType.eMJ]={
change={worldInfoFiltterChangeType.eMJChange},
getStateList=function()

local list={}
for world,worldCfg in pairs(cfg_worldblockconfig())do
for block,blockCfg in pairs(worldCfg)do
if worldBlockModel:checkBlockState(world,block,worldBlockModel.BLOCKSTATE.OPEN)then
local units=worldBlockModel:getBlockUnits_InStateAndType(world,block,worldBlockModel.BLOCKSTATE.OPEN,worldModel.UNITTYPE.MYSTERY)
for i,v in pairs(units)do
table.insert(list,{i,world,v.x,v.z})
end
end
end
end
return list
end,
},

[worldInfoFiltterType.eMonster]={
change={worldInfoFiltterChangeType.eMonsterChange},
getStateList=function()

local list={}
for world,worldCfg in pairs(cfg_worldblockconfig())do
for block,blockCfg in pairs(worldCfg)do
if worldBlockModel:checkBlockState(world,block,worldBlockModel.BLOCKSTATE.OPEN)then





local units=worldMonsterModel:getBlockMonsters(world,block)
for i,v in pairs(units)do
table.insert(list,{v.worldMonsterId,world,v.posData[1],v.posData[2]})
end
end
end
end
return list
end,
},

[worldInfoFiltterType.eFamily]={
change={worldInfoFiltterChangeType.eFamilyChange},
getStateList=function()

local list={}
for world,worldCfg in pairs(cfg_worldblockconfig())do
local datas=worldXiuZhenJiaZuModel:getAllFamilyData(world)
for i,v in pairs(datas)do

table.insert(list,{i,world,v.x,v.z})
end
end
return list
end,
},

[worldInfoFiltterType.eResCollect]={
change={worldInfoFiltterChangeType.eResChange},
getStateList=function()

return worldResPointDataModel:getMapList()
end,
},

[worldInfoFiltterType.eResBox]={
change={worldInfoFiltterChangeType.eResChange},
getStateList=function()

return worldResPointDataModel:getMapList()
end,
},

[worldInfoFiltterType.eResEvent]={
change={worldInfoFiltterChangeType.eResChange},
getStateList=function()

return worldResPointDataModel:getMapList()
end,
},

[worldInfoFiltterType.eResNPC]={
change={worldInfoFiltterChangeType.eResChange},
getStateList=function()

return worldResPointDataModel:getMapList()
end,
},

[worldInfoFiltterType.eResMonster]={
change={worldInfoFiltterChangeType.eResChange},
getStateList=function()

return worldResPointDataModel:getMapList()
end,
},

[worldInfoFiltterType.eResDefenseBox]={
change={worldInfoFiltterChangeType.eResChange},
getStateList=function()

return worldResPointDataModel:getMapList()
end,
},

[worldInfoFiltterType.eResHideBox]={
change={worldInfoFiltterChangeType.eResChange},
getStateList=function()

return worldResPointDataModel:getMapList()
end,
},

[worldInfoFiltterType.eLiLian]={
change={worldInfoFiltterChangeType.eLiLianChange},
getStateList=function()

local list={}
for world,worldCfg in pairs(cfg_worldblockconfig())do
for block,blockCfg in pairs(worldCfg)do
if worldBlockModel:checkBlockState(world,block,worldBlockModel.BLOCKSTATE.UNLOCK)then


end
end
end
return list
end,
},
}

function worldMapModel:getFiltterList(filtterTypelist,showDefault)
if showDefault==nil then showDefault=true end
local temp={}
local lookup={}
if filtterTypelist~=nil then
for i,v in ipairs(filtterTypelist)do
lookup[v]=true
end
else
for k,v in pairs(worldInfoFiltterGroupType)do
if v~=worldInfoFiltterGroupType.eAll then
local group=cfgHelper.get1(cfg_worldinfofiltterconfig_get,v)
for k2,v2 in pairs(group)do
lookup[k2]=true
end
end
end
end
if showDefault then
local defualtGroup=cfgHelper.get1(cfg_worldinfofiltterconfig_get,worldInfoFiltterGroupType.eAll)
for k,v in pairs(defualtGroup)do
lookup[k]=true
end
end


for k,v in pairs(lookup)do
local statelist=worldMapModel:getFiltterListEx(k)
if statelist~=nil and#statelist>0 then
temp[k]=statelist
end
end

local list={}
for filtterType,filtterlist in pairs(temp)do
for k,v in pairs(filtterlist)do
local worldid=v[2]
if list[worldid]==nil then list[worldid]={}end
local cfg=worldMapModel:getFiltterTypeCfg(filtterType)
table.insert(list[worldid],{filtterType,v,cfg.sortWeight or 0})
end
end
for k,v in pairs(list)do
table.sort(v,function(a,b)
return a[3]>b[3]
end)
end
return list
end

function worldMapModel:getFiltterListEx(filtterType)
local check=worldInfoFiltterFunc[filtterType]



if check then
return check.getStateList()
end
return nil
end

function worldMapModel:initData()
mapIndexLookup={}
local cfgs=cfg_worldconfig()
for k,v in pairs(cfgs)do
mapIndexLookup[v.mapIndex]=v
end

mapBlockLookup={}
local cfgs2=cfg_worldblockconfig()
for k,v in pairs(cfgs2)do
local worldid=k
if mapBlockLookup[worldid]==nil then mapBlockLookup[worldid]={}end
for k2,v2 in pairs(v)do
table.insert(mapBlockLookup[worldid],v2)
end
end
for k,v in pairs(mapBlockLookup)do
table.sort(v,function(a,b)
return a.blockId<b.blockId
end)
end

filtterTypeCfgLookup={}
local cfgs3=cfg_worldinfofiltterconfig()
for k,v in pairs(cfgs3)do
if k~='const_def'then
for k2,v2 in pairs(v)do
filtterTypeCfgLookup[v2.filtterType]=v2
end
end
end
end

function worldMapModel:clearData()
mapIndexLookup=nil
mapBlockLookup=nil
filtterTypeCfgLookup=nil
end

function worldMapModel:getMapConfigByIndex(worldIndex)
if mapIndexLookup then
return mapIndexLookup[worldIndex]
end
return nil
end

function worldMapModel:getMapIndexByWorldID(worldid)
if mapIndexLookup then
for i,v in ipairs(mapIndexLookup)do
if v.id==worldid then
return i
end
end
end
return nil
end

function worldMapModel:getBlockListByWorldID(worldid)
if mapBlockLookup then
return mapBlockLookup[worldid]
end
return nil
end

function worldMapModel:getBlockConfigByIndex(worldid,blockIndex)
if mapBlockLookup then
return mapBlockLookup[worldid][blockIndex]
end
return nil
end

function worldMapModel:getFiltterTypeCfg(filtterType)
return filtterTypeCfgLookup[filtterType]
end

function worldMapModel:checkBlockOpen(worldid,blockid)
return not worldBlockModel:checkBlockState(worldid,blockid,worldBlockModel.BLOCKSTATE.CLOSE)
end

function worldMapModel:canBlockOpen(worldid,blockid)
return not worldMapModel:checkBlockOpen(worldid,blockid)and worldMapModel:canBlockOpenEx(worldid,blockid)
end

function worldMapModel:canBlockOpenEx(worldid,blockid)
return worldBlockModel:isShowFogEffect(worldid,blockid)
end

function worldMapModel:map2ScreenPos(worldid,pos)
local mapScaleParams=cfgHelper.get2(cfg_worldconfig_get,worldid,'mapScaleParams')
local p={}
p.x=pos.x*mapScaleParams[1]+mapScaleParams[3]
p.y=pos.y*mapScaleParams[2]+mapScaleParams[4]
return p
end

function worldMapModel:saveMapfiltter(list)
userActorSetting.flushVal(saveKey,list,{})
end

function worldMapModel:getMapfiltter()
return userActorSetting.get(saveKey,{})
end

function worldMapModel:getMapfiltterlist()
local savedata=worldMapModel:getMapfiltter()
return worldMapModel:getMapfiltterlistEx(savedata)
end

function worldMapModel:getMapfiltterlistEx(savedata)
local list={}
for k,v in pairs(savedata)do
if v==true then
table.insert(list,tonumber(k))
end
end
return list
end

function worldMapModel:getWorldFiltterList(worldId,filtterTypelist,showDefault)
local list=worldMapModel:getFiltterList(filtterTypelist,showDefault)
for i,v in pairs(list)do
local subList={}
for j,w in ipairs(v)do
if w[2]==worldId then
table.insert(subList,w)
end
end
list[i]=subList
end
return list
end
