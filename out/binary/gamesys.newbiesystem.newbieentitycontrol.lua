




newbieEntityControl=gameState.addListener({})
NEWBIE_ENTITY_SCENE_TYPE=
{
eHome=1,
eWorld=2,
eFight=3,
}

local _entityList={}
local _entityAction={}









local _bindFunc=
{
[NEW_BIE_ENTITY_LUA_FUNC_TYPE.eBuild]=function(...)
return newbieEntityControl.bindBuild(...)
end,

[NEW_BIE_ENTITY_LUA_FUNC_TYPE.eFightPrepare]=function(...)
return newbieEntityControl.bindFightPrepare(...)
end,

[NEW_BIE_ENTITY_LUA_FUNC_TYPE.eSundrise]=function(...)
return newbieEntityControl.bindSundrise(...)
end,

[NEW_BIE_ENTITY_LUA_FUNC_TYPE.eXiufuBuild]=function(...)
return newbieEntityControl.bindXiufuBuild(...)
end,

[NEW_BIE_ENTITY_LUA_FUNC_TYPE.eMysteryGround]=function(...)
return newbieEntityControl.bindMysteryGround(...)
end,
[NEW_BIE_ENTITY_LUA_FUNC_TYPE.eWorldEntityName]=function(...)
return newbieEntityControl.bindWorldEntityName(...)
end,

[NEW_BIE_ENTITY_LUA_FUNC_TYPE.eWorldEntity]=function(...)
return newbieEntityControl.bindWorldEntity(...)
end,

[NEW_BIE_ENTITY_LUA_FUNC_TYPE.eHomeEntityByPosition]=function(...)
return newbieEntityControl.bindHomeEntityByPos(...)
end,

[NEW_BIE_ENTITY_LUA_FUNC_TYPE.eAnyBuild]=function(...)
return newbieEntityControl.bindAnyBuild(...)
end,

[NEW_BIE_ENTITY_LUA_FUNC_TYPE.eZongMenVisitor]=function(...)
return newbieEntityControl.bingZongMenVistor(...)
end,

[NEW_BIE_ENTITY_LUA_FUNC_TYPE.eYunYouMerchant]=function(...)
return newbieEntityControl.bingYunYouMerchant(...)
end,

[NEW_BIE_ENTITY_LUA_FUNC_TYPE.eXGSZ]=function(...)
return newbieEntityControl.bingXGSZ(...)
end,

[NEW_BIE_ENTITY_LUA_FUNC_TYPE.eDanLing]=function(...)
return newbieEntityControl.bindDanLing(...)
end,

[NEW_BIE_ENTITY_LUA_FUNC_TYPE.eXianJiePos]=function(...)
return newbieEntityControl.bindXJpos(...)
end,
[NEW_BIE_ENTITY_LUA_FUNC_TYPE.eXianJieResPoint]=function(...)
return newbieEntityControl.bindXJResPoint(...)
end,
[NEW_BIE_ENTITY_LUA_FUNC_TYPE.eXianJieUnlockCloud]=function(...)
return newbieEntityControl.bindXJUnlockCloud(...)
end,
}


local _bindEntityLjType=
{
eHomeBaishanDizi=1,
}

local _bindEntityLjFunc=
{
[_bindEntityLjType.eHomeBaishanDizi]=function(guid)
return shanmenModel:getBsDiscipleguidByGuid(guid)
end
}



function newbieEntityControl:onAppStart()

end

function newbieEntityControl:onEnterState()
_entityList={}
_entityAction={}
end

function newbieEntityControl:onLeaveState()
_entityList={}
_entityAction={}
end



function newbieEntityControl.registerEntity(guid,entityInfo)
if guid==nil then
loggerUtil.logErrFMT('实体没有设置guid')
return
end
_entityList[guid]=entityInfo
end


function newbieEntityControl.unregisterEntity(guid)
if _entityList[guid]then
_entityList[guid]=nil
return true
end
return false
end

function newbieEntityControl.findRegisterEntity(guid)
return _entityList[guid]~=nil
end

function newbieEntityControl.registerEntityAction(guid,action)
_entityAction[guid]=action
end

function newbieEntityControl.invokeEntityAction()
for k,v in pairs(_entityAction)do
if v then
v()
end
end
_entityAction={}
end













function newbieEntityControl.bindEntity(entityType,...)
local func=_bindFunc[entityType]
if func==nil then return end
local entityInfo=_bindFunc[entityType](entityType,...)
if entityInfo then
newbieEntityControl.registerEntity(entityInfo.guid,entityInfo)
end
return entityInfo
end



function newbieEntityControl.bindEntityByLuaType(entityLuaType)




end


function newbieEntityControl.unbindEntity(guid)
if newbieEntityControl.unregisterEntity(guid)then
newbieControl.removeEntity(guid)
end
end

function newbieEntityControl.checkEntityLj(ljType,guid)
if ljType==nil or ljType<=0 then return true end
if _bindEntityLjFunc[ljType]then
return _bindEntityLjFunc[ljType](guid)
end
loggerUtil.logErrFMT('没有找到逻辑类型的处理方法：{0}',ljType)
end


function newbieEntityControl.bingZongMenVistor(entityType,sfId)
sfId=sfId or mapIdType.zhufeng
local visitor=zongmenVisitorModel:getEntity(sfId)
if visitor==nil then
newbieControl.log(FMT.fmt('没找到当前指引的宗门访客：{0},超时将中断',sfId))
return
end
local entityInfo={}
entityInfo.entityType=entityType
entityInfo.guid=visitor.entGuid
entityInfo.pos=_MapManager.GetObjectAreaC(entityInfo.guid)
entityInfo.camera=cameraControl.getCameraTransform(CAMERA_TYPE.eHome)
return entityInfo
end


function newbieEntityControl.bingYunYouMerchant(entityType)
local entity=yunyouMerchantController:getEntity()
if entity==nil then
newbieControl.log(FMT.fmt('没找到当前指引的云游商人, 超时将中断'))
return
end
local entityInfo={}
entityInfo.entityType=entityType
entityInfo.guid=visitor.entGuid
entityInfo.pos=_MapManager.GetObjectAreaC(entityInfo.guid)
entityInfo.camera=cameraControl.getCameraTransform(CAMERA_TYPE.eHome)
return entityInfo
end

function newbieEntityControl.bingXGSZ(entityType)
local entity=xiangongpingdingController:getEntityGUID()
if entity==nil then
newbieControl.log(FMT.fmt('没找到当前指引的仙宫使者, 超时将中断'))
return
end
local entityInfo={}
entityInfo.entityType=entityType
entityInfo.guid=entity
entityInfo.pos=_MapManager.GetObjectAreaC(entity)
entityInfo.camera=cameraControl.getCameraTransform(CAMERA_TYPE.eHome)
return entityInfo
end

function newbieEntityControl.bindDanLing(entityType)
local entityData=jctjDuJieXianDanModel:getEntity(mapIdType.zhufeng)
if entityData==nil then
newbieControl.log(FMT.fmt('没找到当前指引的丹灵, 超时将中断'))
return
end
local entity=entityData.entGuid
local entityInfo={}
entityInfo.entityType=entityType
entityInfo.guid=entity
entityInfo.pos=_MapManager.GetObjectAreaC(entity)
entityInfo.camera=cameraControl.getCameraTransform(CAMERA_TYPE.eHome)
return entityInfo
end

function newbieEntityControl.bindXJpos(entityType,pos_grid)

local entityInfo={}
entityInfo.entityType=entityType
entityInfo.entityId=string.format("xjpos_%d_%d",pos_grid[1],pos_grid[2])
local lookpos=xianjieController:worldGridPos2WorldPos4(pos_grid[1],pos_grid[2],0)

entityInfo.guid=tonumber(string.format("%d%d",pos_grid[1],pos_grid[2]))
entityInfo.pos=lookpos
return entityInfo
end

function newbieEntityControl.bindXJResPoint(entityType,scrType,...)
local rpData=xianjieModel:excuteResPointResourceHandle(scrType,"findAData",nil,...)
if rpData==nil then
newbieControl.log(FMT.fmt('没找到当前指引的仙界资源点, 超时将中断'))
return
end

local entityInfo={}
entityInfo.entityType=entityType
entityInfo.entityId=rpData.rpGuid
entityInfo.guid=rpData:getEntityKey()
entityInfo.pos=rpData:getWorldPos_1()
return entityInfo
end


function newbieEntityControl.bindXJUnlockCloud(entityType,cloudid)
local cloudData=xianjieModel:getCloudData(cloudid)
if not cloudData then
newbieControl.log(FMT.fmt('没找到当前指引的仙界云雾, 超时将中断'))
return
end
local cloudEntData=cloudData.CloudUnLockData
if cloudEntData then
local entityInfo={}
local pos=cloudEntData:getWorldPos()
entityInfo.pos=pos
local ent_key=cloudData.CloudUnLockData.ent_key
if not ent_key then
newbieControl.log(FMT.fmt('没找到当前指引的仙界云雾实体id, 超时将中断'))
return
end
local Entity=xianjieController:getEntity(ent_key)
entityInfo.entityId=ent_key
entityInfo.guid=ent_key
entityInfo.entityType=entityType
return entityInfo
end
end


function newbieEntityControl.bindBuild(entityType,entityId,offset,sfId)
sfId=sfId or mapIdType.zhufeng
local buildInfoList=zongmenModel:getBuildingDataByBdId(sfId,entityId)or{}
local buildInfo=buildInfoList[1]
if buildInfo==nil then
newbieControl.log(FMT.fmt('没找到当前指引的建筑：{0},超时将中断',entityId))
return
end
local guid=buildInfo.entityId
if guid==nil then return end
local entityInfo={}
entityInfo.entityType=entityType
entityInfo.entityId=entityId
entityInfo.guid=guid
entityInfo.pos=_MapManager.GetObjectAreaC(guid)
entityInfo.camera=cameraControl.getCameraTransform(CAMERA_TYPE.eHome)
if offset then
local screenpos=_MapManager.WorldToScreenPoint(entityInfo.pos)
screenpos=Vector3(screenpos.x+offset[1],screenpos.y+offset[2],screenpos.z)
entityInfo.pos=_MapManager.ScreenToWorldPoint(screenpos)
end
return entityInfo
end


function newbieEntityControl.bindXiufuBuild(entityType,entityId,offset)
local sfId=mapIdType.zhufeng
local build=isometricMapSystem:getAnyRepairData(entityId)
if build==nil then
newbieControl.log(FMT.fmt('场景内没找到待修复建筑id:{0},超时将中断',entityId))
return
end
local guid=build.guid
if guid==nil then return end
local entityInfo={}
entityInfo.entityType=entityType
entityInfo.entityId=entityId
entityInfo.guid=guid
entityInfo.pos=_MapManager.GetObjectAreaC(guid)
entityInfo.camera=cameraControl.getCameraTransform(CAMERA_TYPE.eHome)
if offset then
local screenpos=_MapManager.WorldToScreenPoint(entityInfo.pos)
screenpos=Vector3(screenpos.x+offset[1],screenpos.y+offset[2],screenpos.z)
entityInfo.pos=_MapManager.ScreenToWorldPoint(screenpos)
end
return entityInfo
end


function newbieEntityControl.bindAnyBuild(entityType,entityId,offset,sfId)
sfId=sfId or mapIdType.zhufeng
local buildInfo=zongmenModel:findBuildingDataByID(sfId,entityId)
local repairBuild=isometricMapSystem:getRepairDataByID(sfId,entityId)
if buildInfo==nil and repairBuild~=nil then
buildInfo=repairBuild.bdData
end
if buildInfo==nil then
newbieControl.log(FMT.fmt('没找到当前指引的建筑：{0},超时将中断',entityId))
return
end
local guid=buildInfo.entityId
if guid==nil then return end
local entityInfo={}
entityInfo.entityType=entityType
entityInfo.entityId=entityId
entityInfo.guid=guid
entityInfo.pos=_MapManager.GetObjectAreaC(guid)
entityInfo.camera=cameraControl.getCameraTransform(CAMERA_TYPE.eHome)
if offset then
local screenpos=_MapManager.WorldToScreenPoint(entityInfo.pos)
screenpos=Vector3(screenpos.x+offset[1],screenpos.y+offset[2],screenpos.z)
entityInfo.pos=_MapManager.ScreenToWorldPoint(screenpos)
end
return entityInfo
end


function newbieEntityControl.bindFightPrepare(entityType,entityId)
local entityInfo={}
entityInfo.entityType=entityType
entityInfo.entityId=entityId
local posList=string.split(entityId,"_")

entityInfo.curPosIndex=tonumber(posList[1])
entityInfo.targetPosIndex=tonumber(posList[2])
local curEntity=UIManager:invokeUIMethod("UIFightPrepareWin","getEntity",entityInfo.curPosIndex)
entityInfo.entity=curEntity
if not curEntity then
return
end
entityInfo.guid=entityInfo.entity.guid
return entityInfo
end

function newbieEntityControl.bindSundrise(entityType,entityId)
if not mainControl:isInScene(eSceneType.eZongmen)then return end
local entityInfo={}
entityInfo.entityType=entityType
entityInfo.entityId=entityId
local mapid=entityId[1]
local id=entityId[2]
local sundrise=isometricMapSystem:findUnlockSundriesByID(mapid,id)
entityInfo.sundrise=sundrise
entityInfo.guid=sundrise.guid
if sundrise.guid==nil then return end
local pos=_MapManager.GetObjectAreaC(sundrise.guid)
entityInfo.pos=pos
return entityInfo
end


function newbieEntityControl.bindMysteryGround(entityType,entityId)
if not MysteryModel:get_cur_fbid()then
return
end
local entityInfo={}
entityInfo.entityType=entityType
entityInfo.entityId=entityId
local posList=string.split(entityId,"_")
local roomId=mysteryRoomModel:get_cur_roomID()
entityInfo.pos=Vector3.New(tonumber(posList[1]),tonumber(posList[2]),0)
local GUID=mysteryObstacleController:create_entity({etId=10000,x=entityInfo.pos.x,y=entityInfo.pos.y,roomId=roomId})
if not GUID or GUID==-1 then
return
end
entityInfo.entity=mysteryObstacleModel:get_role_entity(GUID)

local layer=mysteryRoomModel:get_GroundLayer(roomId)
local worldPos=CS.HexagonMapManagerInterface.GetCellCenterWorld(entityInfo.pos,layer)
entityInfo.worldPos=worldPos
entityInfo.guid=GUID
mysteryAIManager:set_mystery_state(true)
return entityInfo
end


function newbieEntityControl.bindWorldEntityName(entityType,entityId)
if not mainControl:isInScene(eSceneType.eWorld)or not worldController:isInWorld()then return end
local entityInfo={}
entityInfo.entityType=entityType
entityInfo.entityId=entityId
local entity=worldController:getUnitModelEntity(entityId)
if entity==nil then return end
entityInfo.guid=entity.GUID
entityInfo.camera=cameraControl.getCameraTransform(CAMERA_TYPE.eWorld)
return entityInfo
end


function newbieEntityControl.bindWorldEntity(entityType,worldId,entityTypo,entityPos)
if not mainControl:isInScene(eSceneType.eWorld)or not worldController:isInWorld()then return end
local entityInfo={}
entityInfo.entityType=entityType
local world=worldId
local typo=entityTypo
local pos=entityPos
local worldpos=worldPositionConfig:getPosition(world,pos)
local x=worldpos.x
local y=worldpos.y
local z=worldpos.z
local data=worldController:findUnit(function(data)
local pos1=data.Position
local unitType=data.LuaData[1]
if unitType==typo and
math.floor(pos1.x)==math.floor(x)and
math.floor(pos1.y)==math.floor(y)and
math.floor(pos1.z)==math.floor(z)then
return true
end
return false
end)
if data==nil then return end
local entity=data.Model:GetModelEntity()
if entity==nil then return end
entityInfo.guid=entity.GUID
entityInfo.entityId=data.Key
entityInfo.camera=cameraControl.getCameraTransform(CAMERA_TYPE.eWorld)
return entityInfo
end


function newbieEntityControl.bindHomeEntityByPos(entityType,typo,posStr,ljType,jtPosStr,sfId)
if not mainControl:isInScene(eSceneType.eZongmen)then return end
local entityInfo={}
entityInfo.entityType=entityType
entityInfo.entityId=posStr
local posList=string.split(posStr,"_")
local pos=_MapManager.ToVector3Int(tonumber(posList[1]),tonumber(posList[2]),0)
sfId=sfId or mapIdType.zhufeng
local worldpos=_MapManager.GetCellCenterWorld(sfId,pos,mapLayer.Data)
local guidList=_MapManager.GetObjectByPos(pos,typo)

if guidList==nil or guidList.Count<=0 then return end
local guid
if ljType then
for i=0,guidList.Count-1 do
if newbieEntityControl.checkEntityLj(ljType,guidList[i])then
guid=guidList[i]
break
end
end
end
guid=guid or guidList[0]

if guid==nil then return end
entityInfo.guid=guid
entityInfo.pos=worldpos
if jtPosStr then
local jtpos=string.split(jtPosStr,"_")
local pos=_MapManager.ToVector3Int(tonumber(jtpos[1]),tonumber(jtpos[2]),0)
entityInfo.pos=_MapManager.GetCellCenterWorld(sfId,pos,mapLayer.Data)
end
entityInfo.camera=cameraControl.getCameraTransform(CAMERA_TYPE.eHome)
return entityInfo
end


function newbieEntityControl.tryClickEntity(screenPos)
local guid
if MysteryModel:get_cur_fbid()then
local entityList=mysteryObstacleModel:get_entity_by_screen_pos(screenPos)
if entityList then
for i=1,#entityList do
local entityInfo=entityList[i]
if newbieEntityControl.findRegisterEntity(entityInfo.guid)then
guid=entityInfo.guid
break
end
end
end
elseif xianjieModel:isInitScene()then
local guidList=xianjieController:getEntitysByScreenPoint(screenPos)
if guidList then
for i,v in ipairs(guidList)do
if newbieEntityControl.findRegisterEntity(v)then
guid=v
break
end
end
end
else
local guidList=isometricMapSystem:rayHitEntity(screenPos)
if guidList==nil or guidList.Count<=0 then
guidList=worldController.rayHitEntity(screenPos)
end
if guidList==nil or guidList.Count<=0 then
guidList=fightManager.rayHitEntity(screenPos)
end
if guidList then
local len=guidList.Count
for i=0,len-1 do
if newbieEntityControl.findRegisterEntity(guidList[i])then
guid=guidList[i]
break
end
end
end
end

if guid and guid>0 then
newbieControl.onRayHitEntity(guid)
end
end


function newbieEntityControl.clickEntity(entityInfo,invokeClick)
if invokeClick==nil then invokeClick=true end
if entityInfo==nil then return end
local entityType=entityInfo.entityType
local guid=entityInfo.guid
if invokeClick and _entityAction[guid]then
local action=_entityAction[guid]
action()
_entityAction[guid]=nil
return
end
newbieControl.log(FMT.fmt('点击实体 类型{0} 实体entityid：{1}',entityType,entityInfo.entityId))
if entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eBuild or
entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eXiufuBuild or
entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eHomeEntityByPosition or
entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eAnyBuild or
entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eZongMenVisitor or
entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eYunYouMerchant or
entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eXGSZ then
if invokeClick then
isometricMapSystem:onTouchUp(nil,entityInfo.guid)
end
elseif entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eFightPrepare then
if invokeClick then
UIManager:invokeUIMethod("UIFightPrepareWin","exchangeRoleItemWithEntity",entityInfo.curPosIndex,entityInfo.targetPosIndex)
end
elseif entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eSundrise then
if invokeClick then
UIManager:showWindow('UIChallengeWin',entityInfo.sundrise)
end
elseif entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eMysteryGround then
mysteryAIManager:set_mystery_state(false)
if invokeClick then
MysteryController.onMapClick(entityInfo.pos)
end
mysteryObstacleModel:remove_entity(entityInfo.guid)
elseif entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eWorldEntityName or
entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eWorldEntity then
if invokeClick then
worldController:clickUnit(entityInfo.entityId)
end
elseif entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eXianJieResPoint then
if invokeClick then
xianjieController:onClickResPoint(entityInfo.entityId)
end
elseif entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eXianJieUnlockCloud then
if invokeClick then
local Entity=xianjieController:getEntity(entityInfo.entityId)
if Entity then
Entity:onMyClick()
end
end
end
newbieEntityControl.unbindEntity(entityInfo.guid)
end


function newbieEntityControl.moveToEntity(entityInfo,callback)
if entityInfo==nil then return end

local entityType=entityInfo.entityType
if entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eBuild or
entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eXiufuBuild or
entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eHomeEntityByPosition or
entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eAnyBuild or
entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eXGSZ then
isometricMapSystem:moveCameraToPosition(entityInfo.pos,true,callback)
elseif entityInfo.entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eFightPrepare then
if callback then callback()end
elseif entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eSundrise then
isometricMapSystem:moveCameraToPosition(entityInfo.pos,true,callback)
elseif entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eXiufuBuild then
isometricMapSystem:moveCameraToPosition(entityInfo.pos,true,-callback)
elseif entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eMysteryGround then
mysteryCameraController:setCamaraPositionMove(entityInfo.worldPos,0.6,nil,nil,callback)
elseif entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eWorldEntityName or
entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eWorldEntity then
worldController:lookAtUnit(entityInfo.entityId,nil,false,callback)
elseif entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eXianJiePos or entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eXianJieResPoint or entityType==NEW_BIE_ENTITY_LUA_FUNC_TYPE.eXianJieUnlockCloud then
local func=function()
xianjieController:lookAtPosition(entityInfo.pos,nil,nil,callback)
end
local sceneType=xianjienSceneType.eXianJie
if xianjieController:isSceneOpen(sceneType)then
if(not mainControl:isSceneType(eSceneType.eXianJie)or xianjieModel:getScenceType()~=sceneType)then

xianjieController:jumpXianJie(sceneType,nil,func)
else
func()
end
end
else
if callback then callback()end
end
end


function newbieEntityControl.moveToPosition(typo,posCfg,duration,callback,ease)
local pos=Vector3.New(posCfg[1],posCfg[2],posCfg[3])
if typo==NEWBIE_POSITIPN_TYPE.eZongmen then
isometricMapSystem:moveCameraToPosition(pos,true,callback,duration,ease)
elseif typo==NEWBIE_POSITIPN_TYPE.eMystery then
mysteryCameraController:setCamaraPositionMove(pos,duration,ease,nil,callback)
elseif typo==NEWBIE_POSITIPN_TYPE.eWorld then
worldController:moveCameraPosition(pos,duration,callback,ease)
end
end












