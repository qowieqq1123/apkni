






mysteryEntityControllerBase={}

local ResumeMove=_HexMapManager.ResumeMove
local PauseMove=_HexMapManager.PauseMove
local StopMove=_HexMapManager.StopMove
local SetPosition=_HexMapManager.SetPosition
local Vector3ToVector3Int=_HexMapManager.Vector3ToVector3Int
local _updateposList={}
local _updatecolorList={}
local _updatlayerList={}

function mysteryEntityControllerBase.new(entityType,class)
local _clone={}
if class then
for i,v in pairs(class)do
_clone[i]=v
end
_clone._base=class
end
local clone_mt={}
clone_mt.__index=mysteryEntityControllerBase
setmetatable(_clone,clone_mt)
_clone.entityType=entityType
mysteryEntityController.registerController(_clone)
if _clone.model==nil then
logErr('没有找到对应model')
end
gameState.addListener(_clone)
return _clone
end



function mysteryEntityControllerBase:create_entity(args)
local id=args.etId
local x=args.x
local y=args.y
local roomId=args.roomId
local status=args.status
local hideFlag=args.hideFlag
roomId=roomId or mysteryRoomModel:get_cur_roomID()
local config=mysteryEntityController.invokeFuncByMysteryEntityType(self.entityType,'get_config',id)
if not config then
logErr(FMT.fmt("没有该景观的配置{0}",id))
return
end
local pos=Vector3(x,y,0)

local modelCfg=nil

if type(config.shape[1])=='table'then
modelCfg=config.shape[status+1]
if not modelCfg then
modelCfg=config.shape[#config.shape]
end
else
modelCfg=config.shape
end

local model=
{
id=modelCfg[1],
components=modelCfg[3]or{},
layer=SortingLayers.ITBuilding,
scale=modelCfg[2],

isFlip=modelCfg.isFlip,
icon=modelCfg.icon,
iconScale=modelCfg.iconScale,
animID=modelCfg.animID
}
local data=
{

}
for key,value in pairs(args)do
data[key]=value
end

local guid=mysteryEntityController.invokeFuncByMysteryEntityType(self.entityType,"create_entity",self.entityType,id,pos,roomId,model,data,hideFlag)

return guid
end

function mysteryEntityControllerBase:init_map_entity(roomId,completeCB)
roomId=roomId or mysteryRoomModel:get_cur_roomID()

local list={}
local num=5
local lIndex=0
local entitys=mysteryRoomModel:get_room_entity_birth_pos_list(roomId,self.entityType)
if entitys then
for i,v in pairs(entitys)do
if num>=5 then
num=0
lIndex=lIndex+1
list[lIndex]={}
end
num=num+1
v.roomId=roomId
table.insert(list[lIndex],v)
end
end

lIndex=0
local createTimer=timer.new()
createTimer:start(0.01,function()
lIndex=lIndex+1
if list[lIndex]and next(list[lIndex])then
for i,v in ipairs(list[lIndex])do
self:create_entity(v)
end
else
createTimer:cancel()
if completeCB then
completeCB()
end
end
end,-1)
end



function mysteryEntityControllerBase:start_color_change()
if self.updateTimer then
return
end
self.updateTimer=timer.new()

self.startColor=mysteryEntityController.invokeFuncByMysteryEntityType(self.entityType,'get_start_color')

if not self.updateCB then
self.updateCB=function()
self:update_color_change()
end
end

self:update_color_change()
self.updateTimer:start(0,self.updateCB)
end

function mysteryEntityControllerBase:update_color_change()
local model=mysteryEntityController.getModelByEntityType(self.entityType)
if not model then
return
end
local entityList=model:get_entity_list()
if entityList==nil or next(entityList)==nil and self.updateTimer then
self.updateTimer:cancel()
self.updateTimer=nil
end
local delta=0.02
local color=nil
local newVal=nil
local lerpVal=nil
local entity=nil
local colorGrids=model:get_grid_color_list()
table.clear(_updateposList)
table.clear(_updatecolorList)
table.clear(_updatlayerList)
for guid,v in pairs(colorGrids)do
entity=model:get_entity(guid)
if entity then
local colorPosList=entity.data.colorPosList
if colorPosList then
local colorRange=entity.data.colorRange
if v>0 then
newVal=v+delta*(colorRange and colorRange[3]or 1)
if newVal>1 then
newVal=-0.01
end
else
newVal=v-delta*(colorRange and colorRange[3]or 1)
if newVal<-1 then
newVal=0.01
end
end

local endColor=model:get_end_color(guid)
lerpVal=newVal<0 and(1+newVal)or newVal
color=Color.Lerp(self.startColor,endColor,lerpVal)
local groundLayer=mysteryRoomModel:get_GroundLayer(entity.roomId)
for _,pos in pairs(colorPosList)do
local posGuid=MysteryModel:get_grid_have_entity(entity.roomId,pos)
if posGuid==guid or posGuid==nil then
table.insert(_updateposList,pos)
table.insert(_updatecolorList,color)
table.insert(_updatlayerList,groundLayer)
model:set_color_grid_entity(guid,newVal)
MysteryModel:add_grid_color_entity(entity.roomId,pos,guid)
end
end
end
end
end

if next(_updateposList)then
_HexMapManager.SetTileAddColorList(_updateposList,_updatecolorList,_updatlayerList)
end
end




function mysteryEntityControllerBase:move_entity(entity)


local simPath=MysteryModel:get_last_path(entity.guid)
if not simPath then
return
end

if mysteryPosHelper.is_invalid_path(#simPath)then
return
end

if not next(simPath)then
return
end


local completeCB=function(path)
self:move_complete_callback(entity,path)
end
local pointCB=function(pos,pathIndex,path)
self:move_point_callback(entity,pos,pathIndex,path)
mysteryEntityController.entityMove(entity.entityType,entity.guid,pos)
end
local beginCB=function(pos)
if mysteryPosHelper.is_same_pos(pos,entity.pos)then
return
end

UIManager:invokeUIMethod("UIMysteryMiniWin","moveItem",entity.guid,pos,0.02)
self:move_begin_callback(entity,pos)

local isUpdate=mysteryEntityController.invokeFuncByMysteryEntityType(self.entityType,'compare_entity_patrol_point',entity.guid)
if isUpdate then
mysteryEntityController.invokeFuncByMysteryEntityType(self.entityType,'update_entity_patrol_point',entity.guid)
end
end
local prepareCB=function(pos)
if mysteryPosHelper.is_same_pos(pos,entity.pos)then
return
end

self:move_prepare_callback(entity)
end

local roomID=entity.roomId
local mapType=mysteryRoomModel:get_mapType_by_roomID(roomID)
local groundLayer=MysteryController.MapLayerLookUp[mapType].GroundLayer


local monsterPerSteps=mysteryEntityController.invokeFuncByMysteryEntityType(self.entityType,'get_entity_per_steps',entity.guid)
self.sequence=self.sequence or{}
self.sequence[entity.guid]=MysteryController:playMoveToPath(entity.guid,simPath,monsterPerSteps,completeCB,pointCB,groundLayer,beginCB,prepareCB,self.sequence[entity.guid])

mysteryEntityController.invokeFuncByMysteryEntityType(self.entityType,'set_move_complete',entity.guid,false)



end


function mysteryEntityControllerBase:move_complete_callback(entity)

end


function mysteryEntityControllerBase:move_point_callback(entity,pos)

end


function mysteryEntityControllerBase:move_begin_callback(entity,pos)

end


function mysteryEntityControllerBase:move_prepare_callback(entity)

end


function mysteryEntityControllerBase:onRecvMove(...)

end


function mysteryEntityControllerBase:pause_move(entity)
PauseMove(entity.guid)
end


function mysteryEntityControllerBase:resume_move(entity)
ResumeMove(entity.guid)
end


function mysteryEntityControllerBase:stop_move(entity,path)
StopMove(entity.guid)

if self.sequence and self.sequence[entity.guid]then
self.sequence[entity.guid]:Kill()
self.sequence[entity.guid]=nil
end

local Layer=mysteryRoomModel:get_GroundLayer(entity.roomId)
SetPosition(entity.guid,entity.pos,Layer)
UIManager:invokeUIMethod("UIMysteryMiniWin","moveItem",entity.guid,entity.pos,0)

self:move_complete_callback(entity,path)
end





function mysteryEntityControllerBase:push_to_move(entity,steps,arrow)

local posList=mysteryPosHelper.getLinePosList(entity.pos,arrow,steps,false)

local path={}
local isDown=false
local roomID=entity.roomId
local downPos=nil
table.insert(path,entity.pos)
if next(posList)then
for i,pos in ipairs(posList)do
if MysteryModel:is_border(roomID,pos)then
isDown=true
downPos=pos
break
else
if mysteryPosHelper.isCanMove(pos)then
table.insert(path,pos)
else
break
end
end
end
else
if MysteryModel:is_border(roomID,entity.pos)then
isDown=true
downPos=entity.pos
end
end

if next(path)then

local completeCB=function(path)
self:push_complete_callback(entity,isDown,downPos,path)
end

local pointCB=function(pos,index)
self:push_point_callback(entity)
end
local beginCB=function(pos)
if mysteryPosHelper.is_same_pos(pos,entity.pos)then
return
end

UIManager:invokeUIMethod("UIMysteryMiniWin","moveItem",entity.guid,pos,0.02)
self:push_begin_callback(entity,pos)
end
local prepareCB=function(pos)
mysteryEntityController.invokeFuncByMysteryEntityType(self.entityType,'set_move_complete',entity.guid,false)
self:push_prepare_callback(entity)
end
local layer=mysteryRoomModel:get_GroundLayer(entity.roomId)
self.sequence=self.sequence or{}
if#path==1 and mysteryPosHelper.is_same_pos(path[1],entity.pos)and isDown then
self:push_complete_callback(entity,isDown,downPos,path)
else
self.sequence[entity.guid]=MysteryController:playMoveToPath(entity.guid,path,1,completeCB,pointCB,layer,beginCB,prepareCB,self.sequence[entity.guid])
end


end
end


function mysteryEntityControllerBase:push_complete_callback(entity,isDown,downPos,path)
if isDown then
mysteryEntityController.invokeFuncByMysteryEntityType(self.entityType,'setUseRemoveBehavior',entity.guid,true)
local role=_HexMapManager.GetRole(entity.guid)
local roleTrans=role:GetActorTransform()
mysteryEntityController.invokeFuncByMysteryEntityType(self.entityType,'play_animation',entity.guid,eAnimationID.jump1,MysteryModel:getMoveAnimSpeed())
mysteryAIManager:set_mystery_state(true)
local layer=mysteryRoomModel:get_GroundLayer(entity.roomId)
local worldPos=_HexMapManager.GetCellCenterWorld(downPos,layer)
Lua.DOTweenProxyExtensions.DOJump(roleTrans,worldPos+Vector3(0,-1,0),1,1,0.5)
local scaleTween=Lua.DOTweenProxyExtensions.DOScale(roleTrans,0,0.5)
if entity.hud then
entity.hud:recycleSelf()
end
scaleTween:OnComplete(function()
mysteryAIManager:set_mystery_state(false)
mysteryEntityController.send_4_50({entity})
end)
else
mysteryEntityController.invokeFuncByMysteryEntityType(self.entityType,'play_animation',entity.guid,eAnimationID.jump3,MysteryModel:getMoveAnimSpeed())
end


mysteryEntityController.invokeFuncByMysteryEntityType(self.entityType,'set_move_complete_path',entity.guid,path)

mysteryEntityController.invokeFuncByMysteryEntityType(self.entityType,'set_move_complete',entity.guid,true)
end


function mysteryEntityControllerBase:push_point_callback(entity,pos,index)

end


function mysteryEntityControllerBase:push_begin_callback(entity,pos)

mysteryEntityController.invokeFuncByMysteryEntityType(self.entityType,'play_animation',entity.guid,eAnimationID.jump2)

mysteryEntityController.invokeFuncByMysteryEntityType(self.entityType,'set_entity_pos',entity.guid,pos)
end


function mysteryEntityControllerBase:push_prepare_callback(entity)
mysteryEntityController.invokeFuncByMysteryEntityType(self.entityType,'play_animation',entity.guid,eAnimationID.jump1)
end



function mysteryEntityControllerBase:update_queue()

if not self.handle_meet()then

mysteryAIManager:update_queue()
end
end

function mysteryEntityControllerBase.handle_meet()
return false
end


function mysteryEntityControllerBase.set_entity_parent(entity,index)
local etType=entity.entityType
local model=mysteryEntityController.getModelByEntityType(etType)
if model then
local list=mysteryRoomModel:get_pos_entityList(entity.roomId,entity.pos)
if next(list)then
for i,other in pairs(list)do
if entity.guid~=other.guid then
if other.entityType==etType and other.data.parent==nil then
model:set_merge_entity_parent(entity,other)
return
end
end
end
end
model:set_merge_entity_parent(entity,nil)
end
end

function mysteryEntityControllerBase:set_all_entity_parent()
local model=mysteryEntityController.getModelByEntityType(self.entityType)
if model then
local roomId=mysteryRoomModel:get_cur_roomID()
local entityList=model:get_entity_list()
if next(entityList)then
for _,entity in pairs(entityList)do
if roomId==entity.roomId then
model:set_merge_entity_parent(entity,nil)
local list=mysteryRoomModel:get_pos_entityList(entity.roomId,entity.pos)
if next(list)then
for _,other in pairs(list)do
if entity.guid~=other.guid then
if other.entityType==entity.entityType and other.data.parent==nil then
model:set_merge_entity_parent(entity,other)
break
end
end
end
end
model:update_visible(entity.guid)
end
end
end
end
end

function mysteryEntityControllerBase:show_entity_count_hud()

local model=mysteryEntityController.getModelByEntityType(self.entityType)
if model then
if not self.countHUDList then
self.countHUDList={}
end
local entityList=model:get_entity_list()
for _,entity in pairs(entityList)do
local count=model:get_my_range_count(entity)or 0
if count>1 and entity.countHUD then
entity.countHUD:refreshCount(count)
self.countHUDList[entity.guid]=entity
else
if entity.countHUD then
entity.countHUD:refreshCount(0)
end
if self.countHUDList[entity.guid]then
self.countHUDList[entity.guid]=nil
end
end
end
end

end

function mysteryEntityControllerBase:clear_entity_count_hud()
self.countHUDList={}
end

function mysteryEntityControllerBase:inGrassBehavior(guid,pos,isInGrass)
if self.entityType~=eMysteryEntityType.eTriggerPoint then
local model=mysteryEntityController.getModelByEntityType(self.entityType)
if model then
local entity=model:get_entity(guid)
local config=model:get_config(entity.id)
if config.showInGrass then
return
end
local grass=mysteryTriggerPointModel:haveGrass(pos)
if grass then
if isInGrass==nil then
isInGrass=mysteryTriggerPointModel:isInGrassList(guid)
end


local oldAnimGrass=entity.animGrass
entity.animGrass=grass.guid
if oldAnimGrass then
mysteryTriggerPointController:clearGrassState(oldAnimGrass,guid)
end
mysteryTriggerPointModel:setEntGrass(grass.guid,guid,true)
mysteryTriggerPointModel:play_animation(grass.guid,2018)

if isInGrass then
model:fade_to_color(guid,Color.New(1,1,1,0.5),0.5,nil,0)
entity.inGrass=nil

else
model:fade_to_color(guid,Color.New(1,1,1,0),0.5,nil,0)
entity.inGrass=grass.guid
end

model:update_visible(guid,nil,nil,false)
if model.refresh_hud then
model:refresh_hud(guid)
end

else
model:fade_to_color(guid,Color.New(1,1,1,1),0.5,nil,0)

entity.inGrass=nil
model:update_visible(guid,nil,nil,false)
if model.refresh_hud then
model:refresh_hud(guid)
end

local oldGrass=entity.animGrass
entity.animGrass=nil
if oldGrass then
mysteryTriggerPointController:clearGrassState(oldGrass,guid)
end

end
end
end
end
