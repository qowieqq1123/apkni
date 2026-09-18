











mysteryInteractionController=mysteryEntityControllerBase.new(eMysteryEntityType.eInteraction,mysteryEntityControllerBase)

local _HexMapManager=CS.HexagonMapManagerInterface
local CreateRole=_HexMapManager.CreateRole
local SetPosition=_HexMapManager.SetPosition
local Vector3ToVector3Int=_HexMapManager.Vector3ToVector3Int


local existTimer={}
local interaction_queue=setmetatable({},{__index=queue})


function mysteryInteractionController:onAppStart()
socketManager:register_receiver(4,29,mysteryInteractionController.recv_4_29)
end

function mysteryInteractionController:onEnterState()
interaction_queue:clear()
mysteryInteractionModel:init_data()

notifySystem:listenNotify(notifyConfig.on_mystery_player_move_start,mysteryInteractionController.on_mystery_player_move_start)
end

function mysteryInteractionController:onLeaveState()

notifySystem:removelistener(notifyConfig.on_mystery_player_move_start,mysteryInteractionController.on_mystery_player_move_start)
end



function mysteryInteractionController.create_interaction(args)
local id=args.etId
local x=args.x
local y=args.y
local hideFlag=args.hideFlag
local disappearTime=args.stepNum
local roomId=args.roomId or mysteryRoomModel:get_cur_roomID()
local interactionId=id
local interactionCfg=mysteryInteractionModel.get_interaction_config(interactionId)

if not interactionCfg then
logErr(FMT.fmt("没有该互动物的配置{0} ({1},{2})",id,x,y))
return
end

local interactionPos=Vector3(x,y,0)

local model=
{
id=interactionCfg.model[1],
components={},
layer=SortingLayers.ITBuilding,
scale=interactionCfg.model[2],
isFlip=interactionCfg.model.isFlip,
}
local data=
{
showInFog=interactionCfg.showInFog,
}


for key,value in pairs(args)do
data[key]=value
end

local guid=mysteryInteractionModel:create_entity(eMysteryEntityType.eInteraction,interactionId,interactionPos,roomId,model,data,hideFlag)
if disappearTime and disappearTime>0 then
existTimer[guid]=disappearTime+1
end
return guid
end

function mysteryInteractionController:create_entity(args)
return mysteryInteractionController.create_interaction(args)
end

function mysteryInteractionController:init_map_entity(roomId,completeCB)
roomId=roomId or mysteryRoomModel:get_cur_roomID()

local list={}
local num=5
local lIndex=0
local entitys=mysteryRoomModel:get_room_entity_birth_pos_list(roomId,eMysteryEntityType.eInteraction)
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
mysteryInteractionController.create_interaction(v)
end
else
createTimer:cancel()
if completeCB then
completeCB()
end
end
end,-1)
end



function mysteryInteractionController.update_interaction()

if not mysteryInteractionController.handle_meet()then

mysteryAIManager:update_queue()
end
end

function mysteryInteractionController.on_mystery_player_move_start()

mysteryInteractionController.disappear_update()
end

function mysteryInteractionController.disappear_update()
local interaction_list=mysteryInteractionModel:get_entity_list()
for guid,v in pairs(interaction_list)do
if existTimer[guid]then
existTimer[guid]=existTimer[v.guid]-1
if existTimer[guid]<=0 then
mysteryInteractionModel:remove_entity(guid)
existTimer[guid]=nil
end
end
end
end


function mysteryInteractionController.handle_meet()
local isMeet=false
local interaction_list=mysteryInteractionModel:get_entity_list()
for guid,v in pairs(interaction_list)do

mysteryInteractionModel:update_visible(guid)







if mysteryAIManager.meet_player(v,v.pos,mysteryInteractionController.meet_result)then
isMeet=true
end

end
return isMeet
end

function mysteryInteractionController.meet_result(originEntity,targetEntity)
local interaction=originEntity
notifySystem:postNotify(notifyConfig.on_mystery_interaction_event,interaction)


mysterySkillController:set_hide_steps(0)





if mysteryFightModel:get_after_queue_size()>0 then
mysteryFightModel:dequeue_after_callback()
end
end





function mysteryInteractionController:mystery_created()
local roomId=mysteryRoomModel:get_cur_roomID()
local mapType=mysteryRoomModel:get_mapType_by_roomID(roomId)
local groundLayer=MysteryController.MapLayerLookUp[mapType].GroundLayer
if interaction_queue:size()>0 then

local value=interaction_queue:dequeue()
if value then
mysteryFogController:createEffect(5,Vector3(value.x,value.y,0),groundLayer,0.5,function()
mysteryInteractionController:create_entity({etId=value.hdwId,x=value.x,y=value.y,roomId=roomId,hideFlag=value.hideFlag})

end)
if interaction_queue:size()>0 then
self:mystery_created()
else
notifySystem:postNotify(notifyConfig.on_mystery_entity_create_complete,eMysteryEntityType.eInteraction)
end



end
end
end

function mysteryInteractionController.recv_4_29(len,interactionList)
if len>0 then

for i,data in ipairs(interactionList)do
interaction_queue:enqueue(data)
end
mysteryInteractionController:mystery_created()
end
end