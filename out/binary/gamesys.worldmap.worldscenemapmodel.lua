









worldSceneMapModel={}

eWorldSceneMapItemType={
ZongMeng=0,
MiJing=1,
Monster=2,
ResPoint=3,
Family=4,
}

local _default_select={
[eWorldSceneMapItemType.ZongMeng]=true,
[eWorldSceneMapItemType.MiJing]=true,
[eWorldSceneMapItemType.Monster]=false,
[eWorldSceneMapItemType.ResPoint]=false,
[eWorldSceneMapItemType.Family]=true,
}

local _search_handle={
[eWorldSceneMapItemType.ZongMeng]="getSceneZMData",
[eWorldSceneMapItemType.MiJing]="getSceneMJData",
[eWorldSceneMapItemType.Monster]="getSceneMonsterData",
[eWorldSceneMapItemType.ResPoint]="getSceneResPointData",
[eWorldSceneMapItemType.Family]="getSceneFamilyData",
}

local _item_name={
[eWorldSceneMapItemType.ZongMeng]="宗门",
[eWorldSceneMapItemType.MiJing]="秘境",
[eWorldSceneMapItemType.Monster]="怪物",
[eWorldSceneMapItemType.ResPoint]="资源点",
[eWorldSceneMapItemType.Family]="家族",
}

local _item_icon={
[eWorldSceneMapItemType.ZongMeng]="",
[eWorldSceneMapItemType.MiJing]="icon_sjbiaoshi_1",
[eWorldSceneMapItemType.Monster]="icon_sjbiaoshi_2",
[eWorldSceneMapItemType.ResPoint]="icon_sjbiaoshi_3",
[eWorldSceneMapItemType.Family]="icon_sjbiaoshia_1",
}

local _family_icon_order={
[0]="a",
[1]="b",
[2]="c",
}

local _respoint_icon_cfg={
[eWorldResPointUnitType.Monster]=cfg_worldresbattleconfig_get,
[eWorldResPointUnitType.Collection]=cfg_worldrescollectionconfig_get,
[eWorldResPointUnitType.Story]=cfg_worldresstoryconfig_get,
[eWorldResPointUnitType.Event]=cfg_worldreseventconfig_get,
[eWorldResPointUnitType.Mystery]=cfg_worldresmysteryconfig_get,
}

local _respoint_icon_weight={
[eWorldResPointUnitType.Monster]=4,
[eWorldResPointUnitType.Collection]=1,
[eWorldResPointUnitType.Story]=3,
[eWorldResPointUnitType.Event]=2,
[eWorldResPointUnitType.Mystery]=0,
}

local _map_item_icon={
[eWorldSceneMapItemType.MiJing]="getMysteryIcon",
[eWorldSceneMapItemType.Monster]="getMonsterIcon",
[eWorldSceneMapItemType.ResPoint]="getResPointIcon",
[eWorldSceneMapItemType.Family]="getFamilyIcon",
}

local _map_filters_key="worldSceneMapFilter"
local _map_filters_save=nil
local _map_categories_key="worldSceneMapCategorie"
local _map_categories_save=nil

function worldSceneMapModel:getFilterData()
if _map_filters_save==nil then





local temp=userActorSetting.get(_map_filters_key,_default_select)
_map_filters_save={}
for i,v in pairs(temp)do
_map_filters_save[tonumber(i)]=v
end
end
return _map_filters_save
end

function worldSceneMapModel:setFilterData(index,value)
_map_filters_save[index]=value
userActorSetting.set(_map_filters_key,_map_filters_save)
userActorSetting.flush()
end

function worldSceneMapModel:setFilterAllData(value)
for i,v in pairs(value)do
_map_filters_save[i]=v
end

userActorSetting.set(_map_filters_key,_map_filters_save)
userActorSetting.flush()
end

function worldSceneMapModel:getCategorieData()
if _map_categories_save==nil then
_map_categories_save=userActorSetting.get(_map_categories_key,1)
end
return _map_categories_save
end

function worldSceneMapModel:setCategorieData(value)
_map_categories_save=value
userActorSetting.flushVal(_map_categories_key,_map_categories_save)
end




function worldSceneMapModel:getItemName(eType)
return _item_name[eType]
end




function worldSceneMapModel:getItemIcon(eType)
return _item_icon[eType]
end

function worldSceneMapModel:getMapItemIcon(eType,...)
return self[_map_item_icon[eType]](self,...)
end





function worldSceneMapModel:getFamilyIcon(guid)
local pCnt=worldXiuZhenJiaZuModel:getFamilyScaleData(guid)
local data=worldXiuZhenJiaZuModel:getFamilyDataByGuid(guid)
local state=data.state
return FMT.fmt("icon_sjbiaoshi{0}_{1}",_family_icon_order[state],pCnt)
end

function worldSceneMapModel:getMysteryIcon(isNormal,id,id2)
if isNormal then
local cfg=cfgHelper.get1(cfg_secretscenefubenconfig_get,id)
return cfg.sceneIcon
else
local cfg=cfgHelper.get2(cfg_secretsceneziyuanfubenconfig_get,id,id2)
return cfg.sceneIcon
end
end

function worldSceneMapModel:getMonsterIcon(unitType,id)

if unitType==eWorldUnitTpye.MONSTER then

local cfg=cfgHelper.get1(cfg_worldmonstergroupconfig_get,id)
return cfg.sceneIcon
elseif unitType==eWorldUnitTpye.RESPOINT then
local cfg=cfgHelper.get1(cfg_worldresbattleconfig_get,id)
return cfg.sceneIcon,cfg.sceneIconScale
end
end

function worldSceneMapModel:getResPointIcon(rpType,rpId)

local cfg=cfgHelper.get1(_respoint_icon_cfg[rpType],rpId)
return cfg.sceneIcon,cfg.sceneIconScale
end

function worldSceneMapModel:changePosition(x,z,world,ResOffset,MapSize,WorldSize,WorldPos)
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,world or worldModel.world)
local mapCfg=cfgHelper.get1(cfg_worldscenemapconfig_get,worldCfg.sceneMap)

local resOffset=ResOffset or mapCfg.resOffset
local mapSize=MapSize or mapCfg.mapSize
local worldSize=WorldSize or mapCfg.worldSize
local worldPos=WorldPos or mapCfg.worldPos
local nx=(x+worldSize[1]/2-worldPos[1])/worldSize[1]*mapSize[1]-resOffset[1]
local nz=(z+worldSize[2]/2-worldPos[2])/worldSize[2]*mapSize[2]-resOffset[2]
return Vector2.New(nx,nz)
end

function worldSceneMapModel:rechangePosition(x,z,world)

local worldCfg=cfgHelper.get1(cfg_worldconfig_get,world or worldModel.world)
local mapCfg=cfgHelper.get1(cfg_worldscenemapconfig_get,worldCfg.sceneMap)

local resOffset=mapCfg.resOffset
local mapSize=mapCfg.mapSize
local worldSize=mapCfg.worldSize
local worldPos=mapCfg.worldPos
local nx=(x+resOffset[1])/mapSize[1]*worldSize[1]-(worldSize[1]/2-worldPos[1])
local nz=(z+resOffset[2])/mapSize[2]*worldSize[2]-(worldSize[2]/2-worldPos[2])
return Vector2.New(nx,nz)
end

function worldSceneMapModel:getMaskUVRect(world,offset,resSize,mapSize)
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,world or worldModel.world)
local mapCfg=cfgHelper.get1(cfg_worldscenemapconfig_get,worldCfg.sceneMap)
local Offset=offset or mapCfg.resOffset
local ResSize=resSize or mapCfg.resSize
local MapSize=mapSize or mapCfg.mapSize
return Vector4.New(
Offset[1]/MapSize[1],
Offset[2]/MapSize[2],
ResSize[1]/MapSize[1],
ResSize[2]/MapSize[2])
end

function worldSceneMapModel:screen2ui_position(x,z,world)
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,world or worldModel.world)
local mapCfg=cfgHelper.get1(cfg_worldscenemapconfig_get,worldCfg.sceneMap)
local localPos=UIManager:invokeUIMethod("UIWorldSceneWin","getMapLocalPosition",Vector2.New(x,z))
return Vector2.New(localPos.x+mapCfg.resSize[1]/2,localPos.y+mapCfg.resSize[2]/2)
end

function worldSceneMapModel:clampMoveRect(x,z,world)
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,world or worldModel.world)
local deltaZ=worldCfg.cameraPos[2]/math.tan(math.pi/180*worldCfg.cameraAngle[1])
local nx=Mathf.Clamp(x,worldCfg.cameraMove[1],worldCfg.cameraMove[2])
local nz=Mathf.Clamp(z,worldCfg.cameraMove[3]+deltaZ,worldCfg.cameraMove[4]+deltaZ)
return Vector2.New(nx,nz)
end




function worldSceneMapModel:getSceneMapUnitList(world)
local list={}
for i=eWorldSceneMapItemType.MiJing,eWorldSceneMapItemType.Family do
list=table.concatTableX(list,self[_search_handle[i]](self,world))
end
return list
end




function worldSceneMapModel:getSceneZMData(world)
local list={}
local cfg=cfg_worldsceneryconfig()
for i,v in pairs(cfg)do
if v.func==0 and v.worldId==world then
table.insert(list,
{eWorldSceneMapItemType.ZongMeng,v.position[1],v.position[2],
worldModel:convertUnitKey({eWorldUnitTpye.SCENERY,i})})
break
end
end

return list
end




function worldSceneMapModel:getSceneMJData(world)
local list={}
local units=MysteryModel:get_all_mysteryFB_unit()
if units then
for i,v in pairs(units)do
local worldId=v[1]
local blockId=v[4]
if worldId==world and worldBlockModel:checkBlockState(worldId,blockId,worldBlockModel.BLOCKSTATE.OPEN)then
table.insert(list,{eWorldSceneMapItemType.MiJing,v[2],v[3],
worldModel:convertUnitKey({eWorldUnitTpye.MYSTERY,i}),{true,i}})
end
end
end

units=mysteryZiYuanFuBenModel:get_all_mysteryFB_unit()
if units then
for i,v in pairs(units)do
local worldId=v[1]
local blockId=v[4]
local infos=string.split(i,'-')
local tagId=tonumber(infos[1])
local mijiId=tonumber(infos[2])

if worldId==world and worldBlockModel:checkBlockState(worldId,blockId,worldBlockModel.BLOCKSTATE.OPEN)then
table.insert(list,{eWorldSceneMapItemType.MiJing,v[2],v[3],
worldModel:convertUnitKey({eWorldUnitTpye.RESMYSTERY,i}),{false,tagId,mijiId}})
end
end
end

return list
end




function worldSceneMapModel:getSceneMonsterData(world)
local list={}
local worldCfg=cfgHelper.get1(cfg_worldblockconfig_get,world)
for block,blockCfg in pairs(worldCfg)do
if worldBlockModel:checkBlockState(world,block,worldBlockModel.BLOCKSTATE.OPEN)then
local units=worldMonsterModel:getBlockMonsters(world,block)
for i,v in pairs(units)do
local data={
eWorldSceneMapItemType.Monster,
v.posData[1],
v.posData[2],
worldModel:convertUnitKey({eWorldUnitTpye.MONSTER,v.posId}),
{eWorldUnitTpye.MONSTER,v.worldMonsterId},
}
table.insert(list,data)
end
end
end

local guidList=worldResPointDataModel:findWorldGuidList(world)
for index,guid in ipairs(guidList)do
local v=worldResPointDataModel:getPointData(guid)
if v then
local block=v.block

local subData=v.datas
if worldResPointDataModel.isTempldateAllMonster(v.template)then
local first=nil
local iconData=nil
for j,w in pairs(subData)do

if w[1]==eWorldResPointUnitType.Monster then
first=j
elseif not first then
first=j
end

if not iconData then
iconData=w
elseif _respoint_icon_weight[iconData[1]]>_respoint_icon_weight[w[1]]then
iconData=w
end
end
local guid=v.guid
local posInfo=worldResPointDataModel:getSubPointPos(guid,first)

local data={
eWorldSceneMapItemType.Monster,
posInfo[1],
posInfo[2],
worldResPointBaseModel:convertUnitKey(guid,first),
{eWorldUnitTpye.RESPOINT,iconData[2]},
}
table.insert(list,data)
end
end
end

return list
end




function worldSceneMapModel:getSceneResPointData(world)
local list={}

local guidList=worldResPointDataModel:findWorldGuidList(world)
for index,guid in ipairs(guidList)do
local v=worldResPointDataModel:getPointData(guid)
if not worldResPointDataModel.isTempldateAllMonster(v.template)then
local block=v.block

local subData=v.datas

local first=nil
local iconData=nil
for j,w in pairs(subData)do

if v[1]==eWorldResPointUnitType.Monster then
first=j
elseif not first then
first=j
end

if not iconData then
iconData=w
elseif _respoint_icon_weight[iconData[1]]>_respoint_icon_weight[w[1]]then
iconData=w
end
end
local guid=v.guid
local posInfo=worldResPointDataModel:getSubPointPos(guid,first)
if posInfo then
local data={
eWorldSceneMapItemType.ResPoint,
posInfo[1],
posInfo[2],
worldResPointBaseModel:convertUnitKey(guid,first),
{iconData[1],iconData[2]},
}
table.insert(list,data)
end
end
end
return list
end




function worldSceneMapModel:getSceneFamilyData(world)
local list={}
local datas=worldXiuZhenJiaZuModel:getAllFamilyData(world)
for i,v in pairs(datas)do
local block=v.block
if worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)then
local data={
eWorldSceneMapItemType.Family,
v.x,
v.z,
worldXiuZhenJiaZuModel:convertKey(v.guid),
{v.guid},
}
table.insert(list,data)
end
end
return list
end