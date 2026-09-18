








eMysteryEntityType=
{

ePlayer=0,
eSurface=1,
eTreasure=2,
eMonster=3,
eInteraction=4,
eObstacle=5,
ePortal=6,
eCurePoint=7,
eRelivePoint=8,
eChallengePoint=9,
eShop=10,
eLittleGamePoint=11,
eTriggerPoint=12,
eMoveTreasure=14,
eBoomMonster=15,

eWeirdBox=17,
eYaranzo=18,
eSelectGrid=19,

eBehaviorEnt=1001,
emysteryLingShou=2001,
}


eMysteryStaticEntityType=
{
eMysteryEntityType.eInteraction,
eMysteryEntityType.eTreasure,
eMysteryEntityType.eObstacle,
eMysteryEntityType.ePortal,
eMysteryEntityType.eCurePoint,
eMysteryEntityType.eRelivePoint,
eMysteryEntityType.eChallengePoint,
eMysteryEntityType.eShop,
eMysteryEntityType.eLittleGamePoint,
eMysteryEntityType.eYaranzo,
eMysteryEntityType.eZhenFaGrid,
}


eMysteryAIEntityType=
{
eMysteryEntityType.eBoomMonster,
eMysteryEntityType.eMonster,
eMysteryEntityType.eWeirdBox,
eMysteryEntityType.eMoveTreasure,

}


eMysteryMoveEntityType=
{
eMysteryEntityType.ePlayer,
eMysteryEntityType.eMonster,
eMysteryEntityType.eMoveTreasure,
eMysteryEntityType.eBoomMonster,
eMysteryEntityType.eWeirdBox,
}


eMysteryBoomEntityType=
{
eMysteryEntityType.ePlayer,
eMysteryEntityType.eMonster,
eMysteryEntityType.eBoomMonster,
}

eMysteryEntityHUDType=
{
appear=1,
playerNotFound=2,
}

mysteryEntityBase={}

mysteryEntityBase.colorGrids={}
mysteryEntityBase.colorGridsEntity={}

local _HexMapManager=CS.HexagonMapManagerInterface
local CreateRole=_HexMapManager.CreateRole
local RemoveTilemapObject=_HexMapManager.RemoveTilemapObject
local SetPosition=_HexMapManager.SetPosition
local Vector3ToVector3Int=_HexMapManager.Vector3ToVector3Int
local SetScale=_HexMapManager.SetScale

function mysteryEntityBase.new(entityType,class)
local _clone={}
if class then
for i,v in pairs(class)do
_clone[i]=v
end
_clone._base=class
end
local clone_mt={}
clone_mt.__index=mysteryEntityBase
setmetatable(_clone,clone_mt)
_clone.entityType=entityType
mysteryEntityController.register(_clone)
return _clone
end

function mysteryEntityBase:init_data()
self.colorGrids={}
self.colorGridsEntity={}
self.state={}
end


function mysteryEntityBase:isAiType(entityType)
for _,AIEntityType in pairs(eMysteryAIEntityType)do
if entityType==AIEntityType then
return true
end
end
return false
end

function mysteryEntityBase:isStaticType(entityType)
for _,eType in pairs(eMysteryStaticEntityType)do
if entityType==eType then
return true
end
end
return false
end

function mysteryEntityBase:isCanBoom(entityType)
for _,eType in pairs(eMysteryBoomEntityType)do
if entityType==eType then
return true
end
end
return false
end

function mysteryEntityBase:get_config(id)

end


function mysteryEntityBase:get_entity_ai_config(guid)
local AIType=self:get_entity(guid).data.ai_type
if AIType then
local monsterAICfg=cfgHelper.get(cfg_secretsceneaiconfig_get,AIType)
return monsterAICfg
end
end


function mysteryEntityBase:get_entity_per_steps(guid)
local AICfg=self:get_entity_ai_config(guid)
if AICfg then
return AICfg.steps
end
end


function mysteryEntityBase:get_entity_patrol_point(guid)
local ent=self.entityList[guid]
if ent and ent.patrolPoint then
return Vector2(ent.patrolPoint[ent.patrolPointIdx][1],ent.patrolPoint[ent.patrolPointIdx][2])
end
end

function mysteryEntityBase:init_entity_patrol_point(guid)
local ent=self.entityList[guid]
if ent then
local aiConfig=self:get_entity_ai_config(guid)
if aiConfig then
local patrolPos=aiConfig.pos_patrol
if patrolPos then
ent.patrolPointTimes=0
ent.patrolPointIdx=1
ent.patrolPointTimesMax=patrolPos[1]
ent.patrolPoint=patrolPos[2]
end
end
end
end

function mysteryEntityBase:update_entity_patrol_point(guid)
local ent=self.entityList[guid]
if ent and ent.patrolPoint then
if ent.patrolPointIdx>=#ent.patrolPoint then
if ent.patrolPointTimesMax<=0 or ent.patrolPointTimes<ent.patrolPointTimesMax then
ent.patrolPointTimes=ent.patrolPointTimes+1
ent.patrolPointIdx=1
end
else
ent.patrolPointIdx=ent.patrolPointIdx+1
end
end
end

function mysteryEntityBase:compare_entity_patrol_point(guid)
local ent=self.entityList[guid]
if ent and ent.patrolPoint then
local curPoint=ent.patrolPoint[ent.patrolPointIdx]
local pos=ent.pos
return pos.x==curPoint[1]and pos.y==curPoint[2]
end
end

function mysteryEntityBase:get_start_color()
return Color.New(0,0,0,1)
end

function mysteryEntityBase:get_end_color(guid)
if self.entityList[guid]then
local colorRange=self.entityList[guid].data.colorRange
if colorRange then
return Color.StrToColor(tostring(colorRange[2]))
end
end
return Color.New(0,0,0,1)
end

function mysteryEntityBase:dealServerData(data)
local newData=data.etComm
newData.guid=newData.etGuid
newData.etType=data.etType
return newData
end


function mysteryEntityBase:create_entity(entityType,id,pos,roomId,model,data,isHide)
if not self.hideList then
self.hideList={}
end

if isHide and isHide==1 then
self:add_hide_entity(entityType,id,data.guid,roomId,pos)
return
end

local guid=CreateRole(model.id,model.components,model.layer,model.scale)
if not self.entityList then
self.entityList={}
end


local Layer=mysteryRoomModel:get_GroundLayer(roomId)
local ent={
entityType=entityType,
guid=guid,
id=id,
pos=pos,
roomId=roomId,
layer=Layer,
isRightward=false,
data=data,
model=model,
notUseRemoveBehavior=false,
}
self.entityList[guid]=ent

SetPosition(guid,pos,Layer)

local role=_HexMapManager.GetRole(guid)
local mysteryOffset=cfgHelper.get2(cfg_dbbodyconfig_get,model.id,'mysteryOffset')
if role then
role:ShowShadow(true)
if mysteryOffset then
if type(mysteryOffset[1])=='number'then
local offset=Vector3(mysteryOffset[1],mysteryOffset[2],0)
role:SetActorOffset(offset)
else
local ofType=data.huge and 2 or 1
local offsetT=mysteryOffset[ofType]
if not offsetT[1]then
offsetT=mysteryOffset[1]
end
local offset=Vector3(offsetT[1],offsetT[2],0)
role:SetActorOffset(offset)
end
end
local config=self:get_config(id)
if config then
local outLight=config.outLight
if outLight then
role:PlayEffect(outLight[1],Vector2(outLight[2]or 0,outLight[3]or 0),Vector3(outLight[4]or 0.02,outLight[5]or 0.02,outLight[6]or 0.02),true,true)
end
end

if model.isFlip~=nil then
role:SetFlipX(model.isFlip==1)
self.entityList[guid].isRightward=model.isFlip==1
end
end
self:update_visible(guid,nil,true)

mysteryRoomModel:set_pos_entity(ent.roomId,pos,ent)


if model.icon then
ent.iconHud=MysteryController.addUIHUD(eMysteryHUDType.eModel,{attachEntity=ent,layer=HexMapLayer.Ground,icon=model.icon,scale=model.iconScale})
end

local config=self:get_config(id)
if data.blood and config.showMJHPBar then
MysteryController.addUIHUD(eMysteryHUDType.eBloodDur,{etType=entityType,guid=guid})
end

if model.animID then
role:RunAnimator(model.animID,1)
end

local etTypeConfig=cfgHelper.get(cfg_ssentitytypeconfig_get,entityType)
if etTypeConfig then


if etTypeConfig.useTree then
local entitylua=entity()
entitylua:_setEntObj(role)
self.entityList[guid].entitylua=entitylua
if not self.useTree then
self.useTree=true
self:startUpdateTimer()
end
end


if etTypeConfig.hideInSamePos then
mysteryEntityControllerBase.set_entity_parent(ent)
local hudWin=UIManager:findActiveWindow('UIMysteryHUDWin')
if hudWin then
hudWin:addUIHUD(eMysteryHUDType.eSamePosCount,{entity=ent,count=0})
end
end

if etTypeConfig.removeBehavior then
ent.removeBehavior=etTypeConfig.removeBehavior
end
end

if entityType~=eMysteryEntityType.ePlayer then
local playerPos=mysteryPlayerModel:get_player_pos()
if playerPos then
local distance=mysteryPosHelper.get_pos_distance(pos,playerPos)
local config=self:get_config(id)
if config then
local playAnimRound=config.playAnimRound
if playAnimRound then
for i,v in ipairs(playAnimRound)do
if distance<=v[1]then
local last=self:get_last_animation(ent.guid)
if last~=v[2]then
self:play_animation(ent.guid,v[2])
end
break
end
end
end
end
end
end


self:init_entity_patrol_point(guid)

return guid
end

function mysteryEntityBase:set_status(guid,state)
if self.entityList[guid]then
self.entityList[guid].data.status=state
end
end


function mysteryEntityBase:get_status(guid)
if self.entityList[guid]then
return self.entityList[guid].data.status
end
end

function mysteryEntityBase:get_role_entity(guid)
return _HexMapManager.GetRole(guid)
end

function mysteryEntityBase:play_animation(guid,state,speed)
local role=self:get_role_entity(guid)
if role then
role:RunAnimator(state,speed or 1)
end
if self.entityList[guid]then
self.entityList[guid].lastAnim=state
end
end

function mysteryEntityBase:setExpression(guid,id)
local role=self:get_role_entity(guid)
if role then
local haveFace=true
if self.entityList[guid]and self.entityList[guid].model then
local modelId=self.entityList[guid].model.id
local hasFace=spineHelper.enableChangeFace(modelId)
if not hasFace then
haveFace=false
end
end
if haveFace then
if id>0 then
local cfg=cfgHelper.get1(cfg_discipleexpressionimageconfig_get,id)
if cfg~=nil then
role:ChangeSlotDisplay("face","face",cfg.out_side)
end
else
role:ChangeSlotDisplay("face","face",0)
end
end
end
end

function mysteryEntityBase:get_last_animation(guid)
if self.entityList[guid]then
return self.entityList[guid].lastAnim
end
end

function mysteryEntityBase:get_world_position(guid)
local role=self:get_role_entity(guid)
if role then
return role.transform.position
end
end

function mysteryEntityBase:get_hud_position(guid,isOffset)
local role=self:get_role_entity(guid)
if role then
local position=role.transform.position
if isOffset then
local offset=role:GetHudOffset()
offset.x=0
return position+offset
else
return position
end

end
return Vector3.zero
end

function mysteryEntityBase:get_entity_by_id(id)
if not id then return end
if self.entityList==nil then return end
if next(self.entityList)then
for guid,v in pairs(self.entityList)do
if v.id==id then
return v
end
end
end
end

function mysteryEntityBase:get_entity_by_screen_pos(screenPos,roomId)
roomId=roomId or mysteryRoomModel:get_cur_roomID()
local layer=mysteryRoomModel:get_GroundLayer(roomId)
local point=MysteryController:screenToMapPos(screenPos,layer)
if not point then
return
end
local pos=_HexMapManager.Vector3IntToVector3(point)
return self:get_all_entity_list_by_pos(pos,roomId)
end


function mysteryEntityBase:get_entity_by_pos(pos,roomId)
if not self.entityList then
return
end
roomId=roomId or mysteryRoomModel:get_cur_roomID()
for guid,v in pairs(self.entityList)do
if mysteryPosHelper.is_same_pos(v.pos,pos,v.roomId,roomId)then
return v
end
end
end


function mysteryEntityBase:get_all_entity_list_by_pos(pos,roomId)
if not self.entityList then
return
end
local posEntityList={}
roomId=roomId or mysteryRoomModel:get_cur_roomID()
for guid,v in pairs(self.entityList)do
if v.data.huge then
if mysteryPosHelper.check_in_round(pos,v.pos,v.data.range,roomId,v.roomId)then
table.insert(posEntityList,v)
end
else
if mysteryPosHelper.is_same_pos(v.pos,pos,v.roomId,roomId)then
table.insert(posEntityList,v)
end
end

end
return posEntityList
end


function mysteryEntityBase:get_all_entity_list_by_posList(posList,roomId)
if not self.entityList then
return
end
local posEntityList={}
roomId=roomId or mysteryRoomModel:get_cur_roomID()
for guid,v in pairs(self.entityList)do
for _,pos in ipairs(posList)do
if mysteryPosHelper.is_same_pos(v.pos,pos,v.roomId,roomId)then
table.insert(posEntityList,v)
end
end
end
return posEntityList
end

function mysteryEntityBase:get_entity_by_pos_id(pos,roomId,id)
if not self.entityList then
return
end
roomId=roomId or mysteryRoomModel:get_cur_roomID()
for guid,v in pairs(self.entityList)do
if mysteryPosHelper.is_same_pos(v.pos,pos,v.roomId,roomId)and v.id==id then
return v
end
end
end


function mysteryEntityBase:get_all_entity_list_by_pos_id(pos,roomId,id)
if not self.entityList then
return
end
local posEntityList={}
roomId=roomId or mysteryRoomModel:get_cur_roomID()
for guid,v in pairs(self.entityList)do
if mysteryPosHelper.is_same_pos(v.pos,pos,v.roomId,roomId)and v.id==id then
table.insert(posEntityList,v)
end
end
return posEntityList
end


function mysteryEntityBase:set_entity_forward(guid,pos)
if not(self.entityList and self.entityList[guid])then
return
end
local isRightward=mysteryPosHelper.is_rightward(self.entityList[guid].pos,pos)
self.entityList[guid].isRightward=isRightward
local entity=_HexMapManager.GetRole(guid)
if entity then
entity:SetFlipX(isRightward)
end
end

function mysteryEntityBase:get_entity_forward_e(ent)
if not(ent)then
return false
end
return ent.isRightward
end

function mysteryEntityBase:get_entity_forward(guid)
if not(self.entityList and self.entityList[guid])then
return false
end
return self.entityList[guid].isRightward
end

function mysteryEntityBase:set_entity_pos(guid,pos)
if not(self.entityList and self.entityList[guid])then
return
end
local entity=self.entityList[guid]
mysteryRoomModel:remove_pos_entity(entity.roomId,pos,guid)
entity.pos=pos
self.entityList[guid]=entity
mysteryRoomModel:set_pos_entity(entity.roomId,pos,entity)
end

function mysteryEntityBase:get_entity_pos(guid)
if not(self.entityList and self.entityList[guid])then
return
end
return self.entityList[guid].pos
end

function mysteryEntityBase:change_body(guid,bodyID,slots,scale)
local entity=_HexMapManager.GetRole(guid)
if entity then
if not self.entityList[guid]then
self.entityList[guid].bodyID=bodyID
end
entity:ChangeBody(bodyID,slots,false,scale)
end
end


function mysteryEntityBase:set_entity_room(guid,roomId)
if not(self.entityList and self.entityList[guid])then
return
end
self.entityList[guid].roomId=roomId
end

function mysteryEntityBase:get_entity_room(guid)
if not(self.entityList and self.entityList[guid])then
return
end
return self.entityList[guid].roomId
end


function mysteryEntityBase:setUseRemoveBehavior(guid,notUse)
local entity=self.entityList[guid]
if entity then
entity.notUseRemoveBehavior=notUse
end
end

function mysteryEntityBase:remove_entity(guid,clear)
if not(self.entityList and self.entityList[guid])then
return
end

local entity=self.entityList[guid]
local roomId=entity.roomId
local pos=entity.pos
local eType=entity.entityType
local id=entity.id
local colorPosList=entity.data.colorPosList

local config=self:get_config(id)
local removeBehavior=entity.removeBehavior
if not entity.notUseRemoveBehavior then
if config and config.removeBehavior then
removeBehavior=config.removeBehavior
end
else
removeBehavior=nil
end

if entity.data.parent and entity.data.parent.data.child then
entity.data.parent.data.child[guid]=nil
end
if entity.data.child then
for childGuid,v in pairs(entity.data.child)do
entity.data.child[childGuid].data.parent=nil
self:update_visible(childGuid)
end
end

if entity.hud then
entity.hud:recycleSelf()
end

if entity.countHUD then
entity.countHUD:recycleSelf()
end

if entity.data.inFogFlag then
MysteryController.removeUIHUD(entity.data.inFogFlag)
end

self:set_color_grid_entity(guid,nil)

mysteryRoomModel:remove_pos_entity(roomId,pos,guid)

local inGrass=entity.inGrass
if inGrass then
mysteryTriggerPointController:clearGrassState(inGrass,guid)
end

if removeBehavior and not clear then
entity.data.isRemoving=true
self:runBehavior(guid,removeBehavior,function()
RemoveTilemapObject(guid)
self:clear_color_grid_pos_list(guid,roomId,entity.data.colorPosList)
self.entityList[guid]=nil
MysteryModel:set_move_complete_entity(guid,nil)
notifySystem:postNotify(notifyConfig.on_mystery_remove_entity,guid,roomId,pos,eType,id,true)
end)
else
RemoveTilemapObject(guid)
self.entityList[guid]=nil
MysteryModel:set_move_complete_entity(guid,nil)
notifySystem:postNotify(notifyConfig.on_mystery_remove_entity,guid,roomId,pos,eType,id,true)
end


self:clear_color_grid_pos_list(guid,roomId,colorPosList)

end

function mysteryEntityBase:clear_room_entity_list(roomId)
if not self.entityList then
return
end
for guid,v in pairs(self.entityList)do
if v.roomId==roomId then
self:remove_entity(guid)
end
end

end

function mysteryEntityBase:clear_entity_list()
if not self.entityList then
return
end
for guid,v in pairs(self.entityList)do
self:remove_entity(guid,true)
end


self.hideList={}
end

function mysteryEntityBase:get_entity_list()
return self.entityList or{}
end

function mysteryEntityBase:get_room_entity_list(roomId)
if not self.entityList then
return
end
local entityList={}
for guid,v in pairs(self.entityList)do
if v.roomId==roomId then
table.insert(entityList,v)
end
end
return entityList
end

function mysteryEntityBase:get_entity_list_by_type(entityType)
local entityList={}
if not self.entityList then
return entityList
end
for guid,v in pairs(self.entityList)do
if v.entityType==entityType then
entityList[guid]=v
end
end
return entityList
end


function mysteryEntityBase:get_entity(guid)
if not self.entityList then
return
end
return self.entityList[guid]
end


function mysteryEntityBase:get_entity_by_server_guid(guid)
if not self.entityList then
return
end
local sguid=tostring(guid)
for cguid,v in pairs(self.entityList)do
if tostring(v.data.guid)==sguid then
return self.entityList[cguid]
end
end
end

function mysteryEntityBase:remove_entity_by_server_guid(guid)
local ent=self:get_entity_by_server_guid(guid)
if ent then
self:remove_entity(ent.guid)
end
end

function mysteryEntityBase:get_entity_all(guid)
local entity=nil
for i,v in pairs(eMysteryEntityType)do
if v~=eMysteryEntityType.eSurface then
entity=mysteryEntityController.invokeFuncByMysteryEntityType(v,"get_entity",guid)
if entity then
return entity
end
end
end
end

function mysteryEntityBase:get_entity_random()
if not self.entityList or next(self.entityList)==nil then
return
end
local list={}
local n=0
for _,v in pairs(self.entityList)do
if v.isVisible then
list[n+1]=v
n=n+1
end
end
math.randomseed(timeHelper.getServerShortTime())
return list[math.random(1,n)]
end

function mysteryEntityBase:set_entity_visible(guid,isVisible)
local size
if isVisible then
size=Vector3(1,1,1)
else
size=Vector3(0,0,0)
end
if guid then
SetScale(guid,size)
end
end

function mysteryEntityBase:fade_to_color(guid,color,duration,complete,delay)
local roleEntity=self:get_role_entity(guid)
if roleEntity then
roleEntity:FadeToColor(color,duration,complete,delay)
end
end


function mysteryEntityBase:update_visible(guid,visible,isCreate,isNotify)
if not(self.entityList and self.entityList[guid])then
return
end

local entity=self.entityList[guid]
if not entity then
return
end

local thisRoom=mysteryRoomModel:get_cur_roomID()
if thisRoom~=entity.roomId then
return
end

isNotify=isNotify==nil and true or isNotify
local isVisible

local layer=mysteryRoomModel:get_GroundLayer(entity.roomId)

if visible~=nil then
isVisible=visible
else

local fogData=mysteryFogModel:get_fog_data(entity.roomId,entity.pos.x,entity.pos.y)
isVisible=entity.isVisible

if not entity.data.parent then
if entity.data.showInFog then
isVisible=true
else
isVisible=fogData and not entity.inGrass
end
else
isVisible=false
end

if not fogData then
local config=self:get_config(entity.id)
if config then
if config.mysteryInFogFlag then
local effect=config.mysteryInFogFlag
if not entity.data.inFogFlag then
entity.data.inFogFlag=MysteryController.addUIHUD(eMysteryHUDType.eModel,{pos=entity.pos,layer=layer,sortLayer="UIWindow",sortOrder=100,effectArgs={effectId=effect}})

end

end
end
else
if entity.data.inFogFlag then
MysteryController.removeUIHUD(entity.data.inFogFlag)
end
end
end

if entity.isVisible==isVisible then
return
end

self.entityList[guid].isVisible=isVisible
self:set_entity_visible(guid,isVisible)

if isNotify then

if isVisible then
notifySystem:postNotify(notifyConfig.on_mystery_create_entity,guid,entity.pos,entity.entityType,entity.id,isCreate)
else
notifySystem:postNotify(notifyConfig.on_mystery_remove_entity,guid,entity.roomId,entity.pos,entity.entityType,entity.id,false)
end
end
end

function mysteryEntityBase:get_entity_visible(guid)
if not(self.entityList and self.entityList[guid])then
return
end
return self.entityList[guid].isVisible
end


function mysteryEntityBase:set_state(guid,state)
self.state=self.state or{}
self.state[guid]=state
end

function mysteryEntityBase:get_state(guid)
self.state=self.state or{}
if not self.state[guid]then
self.state[guid]=eMysteryMonsterState.eIdle
end
return self.state[guid]
end




function mysteryEntityBase:flash(guid,pos,sendServer)
if sendServer==nil then
sendServer=true
end

local entity=self:get_entity(guid)

if sendServer then

mysteryEntityController:upload_move_pos(entity,pos)
end

self:set_entity_pos(entity.guid,pos)

local Layer=mysteryRoomModel:get_GroundLayer(entity.roomId)
SetPosition(guid,pos,Layer)
self:update_color_grid_pos_list(entity)
if sendServer then
self:set_move_complete(entity.guid,true)
end

if entity and entity.iconHud then
local hudPos=self:get_hud_position(guid)
MysteryController.refreshUIHUD(entity.iconHud,"refreshPosition",hudPos)
end
end


function mysteryEntityBase:set_move_complete(guid,is_move_complete)
local ent=self:get_entity(guid)
if not ent then
logErr("找不到实体")
MysteryModel:set_moving_entity(guid,nil)
return
end
ent.data.move_complete=is_move_complete

if is_move_complete then
MysteryModel:set_move_complete_entity(guid,ent)
end

mysteryEntityController.mysteryEntityMove(guid,not is_move_complete)
end


function mysteryEntityBase:is_move_complete(guid)
return self:get_entity(guid).data.move_complete
end


function mysteryEntityBase:has_monster_move()
for i,v in pairs(self:get_entity_list())do
if not v.data.move_complete then
return true
end
end
return false
end


function mysteryEntityBase:set_move_complete_path(guid,path)
local ent=self:get_entity(guid)
if not ent then
logErr("找不到实体")
return
end
ent.data.moveCompletePath=path
end



function mysteryEntityBase:add_hide_entity(entityType,id,serverGuid,roomId,pos)
if not self.hideList then
self.hideList={}
end
if not serverGuid then
return
end
local layer=mysteryRoomModel:get_GroundLayer(roomId)
local effectHUD=MysteryController.addUIHUD(eMysteryHUDType.eModel,{pos=pos,layer=layer,sortLayer="UIWindow",sortOrder=100,effectArgs={effectId=20020}})

self.hideList[serverGuid]={
entityType=entityType,
id=id,
guid=serverGuid,
roomId=roomId,
pos=pos,
effectHUD=effectHUD,
}


end


function mysteryEntityBase:remove_hide_entity(serverGuid)
if not self.hideList then
return
end
local hidden=self.hideList[serverGuid]
if hidden then
local effectHUD=hidden.effectHUD
if effectHUD then
MysteryController.removeUIHUD(effectHUD)
end
end
self.hideList[serverGuid]=nil
end

function mysteryEntityBase:get_hide_list()
return self.hideList or{}
end

function mysteryEntityBase:get_hidden_entity_by_pos(roomId,pos)
if not self.hideList then
return
end
for i,v in pairs(self.hideList)do
if v.roomId==roomId and v.pos.x==pos.x and v.pos.y==pos.y then
return v
end
end
end




function mysteryEntityBase:set_trigger_tip_record(guid,triggerId,flag)
if self.entityList[guid]then
if not self.entityList[guid].trigger_record then
self.entityList[guid].trigger_record={}
end
self.entityList[guid].trigger_record[triggerId]=flag
end
end

function mysteryEntityBase:is_trigger_tip_record(guid,triggerId)
if self.entityList[guid]and self.entityList[guid].trigger_record then
return self.entityList[guid].trigger_record[triggerId]
end
end



function mysteryEntityBase:set_color_grid_entity(guid,lerpVal)
self.colorGrids[guid]=lerpVal
end

function mysteryEntityBase:get_grid_color(guid)
return self.colorGrids[guid]
end

function mysteryEntityBase:get_grid_color_list()
return self.colorGrids
end

function mysteryEntityBase:update_color_grid_pos_list(entity)
self:clear_color_grid_pos_list(entity.guid,entity.roomId,entity.data.colorPosList)
local range=entity.data.colorRange and entity.data.colorRange[1]or 0
local colorPosList=mysteryPosHelper.get_all_round_pos_list(entity.pos,range)
entity.data.colorPosList=colorPosList

self:set_color_grid_entity(entity.guid,0)
end

function mysteryEntityBase:clear_color_grid_pos_list(guid,roomId,colorPosList)
if colorPosList then
for i,pos in ipairs(colorPosList)do


MysteryModel:remove_grid_color_entity(roomId,pos)

local groundLayer=mysteryRoomModel:get_GroundLayer(roomId)
_HexMapManager.SetTileAddColor(pos,Color.New(0,0,0,1),groundLayer)

end

end
end




function mysteryEntityBase:runBehavior(guid,btName,_onBahaviroEvent)
if self.entityList[guid]==nil then
return
end
local entityData=self.entityList[guid]

if not self.useTree then
self.useTree=true
self:startUpdateTimer()
end
if not entityData.entitylua then
local entitylua=entity()
entitylua:_setEntObj(_HexMapManager.GetRole(guid))
entityData.entitylua=entitylua
end
local ent=entityData.entitylua
if ent then
ent.isRunBehavior=false
ent.fBTree:stop()

if self.entityList[guid]==nil then
return
end
self.entityList[guid].isRunBehavior=true

self.entityList[guid].onBahaviroEvent=_onBahaviroEvent
local onEventListen=function(eventTypo,args)
if self.entityList[guid]~=nil then
self.entityList[guid].isRunBehavior=false
local onBahaviroEvent=self.entityList[guid].onBahaviroEvent
if onBahaviroEvent~=nil then
onBahaviroEvent(eventTypo,args)
end
if self.entityList[guid]~=nil then
self.entityList[guid].onBahaviroEvent=nil
end
end
end
ent:runBehavior(btName,nil,onEventListen)
end
end


function mysteryEntityBase:stopBehavior(guid)
if not(self.entityList and self.entityList[guid])then
return
end
local entityData=self.entityList[guid]
self.entityList[guid].isRunBehavior=false
if entityData.entitylua then
local ent=entityData.entitylua
ent.isRunBehavior=false
ent.fBTree:stop()
end
end

function mysteryEntityBase:startUpdateTimer()
if self.useTree and self.updateTimer==nil then
local updateFunc=function()
local deltaTime=Time.deltaTime
if MysteryModel:is_in_mystery()then
self:update(deltaTime)
end
end
self.updateTimer=timer.new()
self.updateTimer:start(0,updateFunc)
end
end

function mysteryEntityBase:update(deltaTime)
if self.useTree then
local entitylua=nil
for i,ent in pairs(self.entityList)do
entitylua=ent.entitylua
if entitylua then
entitylua:update(deltaTime)
end
end
end
end

function mysteryEntityBase:isRunBehavior(guid)
if not(self.entityList)then
return false
end
local entity=self.entityList[guid]
if not entity then
return false
end
return entity.isRunBehavior
end




function mysteryEntityBase:get_my_range_count(entity)
local count=1

if entity.data.child then
for i,v in pairs(entity.data.child)do
count=count+1
end
end
return count
end



function mysteryEntityBase:set_merge_entity_parent(myEntity,parentEntity)
if myEntity.data.parent then
myEntity.data.parent.data.child[myEntity.guid]=nil
end
if parentEntity then
if parentEntity.data.parent~=myEntity then
myEntity.data.parent=parentEntity
if not parentEntity.data.child then
parentEntity.data.child={}
end
parentEntity.data.child[myEntity.guid]=myEntity
end
else
myEntity.data.parent=nil
end
end

function mysteryEntityBase:get_merge_entity_parent(myEntity)
return myEntity.data.parent
end


function mysteryEntityBase:isInGrass(entity)
if entity and mysteryTriggerPointModel:haveGrass(entity.pos)then
return true
end
return false
end
