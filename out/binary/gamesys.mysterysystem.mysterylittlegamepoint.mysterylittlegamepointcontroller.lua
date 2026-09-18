











mysteryLittleGamePointController=mysteryEntityControllerBase.new(eMysteryEntityType.eLittleGamePoint,mysteryEntityControllerBase)

local _HexMapManager=CS.HexagonMapManagerInterface



function mysteryLittleGamePointController:onAppStart()

end

function mysteryLittleGamePointController:onEnterState()
mysteryLittleGamePointModel:init_data()
end

function mysteryLittleGamePointController:onLeaveState()

end



function mysteryLittleGamePointController.create_littlegamepoint(id,x,y,roomId,hideFlag)
roomId=roomId or mysteryRoomModel:get_cur_roomID()
local cfg=mysteryLittleGamePointModel:get_config(id)
local pos=Vector3(x,y,0)

local modelCfg=cfg.shape


local model=
{
id=modelCfg[1],
components={},
layer=SortingLayers.ITBuilding,
scale=modelCfg[2],
}
local data={}
local guid=mysteryLittleGamePointModel:create_entity(eMysteryEntityType.eLittleGamePoint,id,pos,roomId,model,data,hideFlag)

end

function mysteryLittleGamePointController:create_entity(args)
return mysteryLittleGamePointController.create_littlegamepoint(args.etId,args.x,args.y,args.roomId,args.hideFlag)
end

function mysteryLittleGamePointController:init_map_entity(roomId,completeCB)
roomId=roomId or mysteryRoomModel:get_cur_roomID()
local entitys=mysteryRoomModel:get_room_entity_birth_pos_list(roomId,eMysteryEntityType.eLittleGamePoint)
if entitys then
for i,v in pairs(entitys)do
mysteryLittleGamePointController.create_littlegamepoint(v.etId,v.x,v.y,roomId,v.hideFlag)
end
end

local list={}
local num=5
local lIndex=0
local entitys=mysteryRoomModel:get_room_entity_birth_pos_list(roomId,eMysteryEntityType.eLittleGamePoint)
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
mysteryLittleGamePointController.create_littlegamepoint(v.etId,v.x,v.y,roomId,v.hideFlag)
end
else
createTimer:cancel()
if completeCB then
completeCB()
end
end
end,-1)
end





function mysteryLittleGamePointController.update_littlegamepoint()

if not mysteryLittleGamePointController.handle_meet()then

mysteryAIManager:update_queue()
end
end


function mysteryLittleGamePointController.handle_meet()
local isMeet=false
local entity_list=mysteryLittleGamePointModel:get_entity_list()
for guid,v in pairs(entity_list)do

mysteryLittleGamePointModel:update_visible(guid)









if mysteryAIManager.meet_player(v,v.pos,mysteryLittleGamePointController.meet_result)then
if not isMeet then
isMeet=true
end
break
end

end
return isMeet
end

function mysteryLittleGamePointController.meet_result(originEntity,targetEntity)



mysterySkillController:set_hide_steps(0)





if mysteryFightModel:get_after_queue_size()>0 then
mysteryFightModel:dequeue_after_callback()
end



end