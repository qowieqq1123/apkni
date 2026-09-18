







mysterySelectGridController=mysteryEntityControllerBase.new(eMysteryEntityType.eSelectGrid,mysteryEntityControllerBase)

local _HexMapManager=CS.HexagonMapManagerInterface

function mysterySelectGridController:onAppStart()
socketManager:register_receiver(4,71,mysterySelectGridController.recv_4_71)
end

function mysterySelectGridController.send_4_71(x,y,etGuid,index)
socketManager:send_4_71(x,y,etGuid,index)
end

function mysterySelectGridController.recv_4_71(x,y,etGuid,index)
mysterySelectGridModel:remove_entity_by_server_guid(etGuid)
mysteryEntityController.handle_meet()
end





function mysterySelectGridController.handle_meet()
local isMeet=false
local entity_list=mysterySelectGridModel:get_entity_list()
for guid,v in pairs(entity_list)do

mysterySelectGridModel:update_visible(guid)

if mysteryAIManager.meet_player(v,v.pos,mysterySelectGridController.meet_result)then
isMeet=true
end
end
return isMeet
end

function mysterySelectGridController.meet_result(originEntity,targetEntity)

mysterySkillController:set_hide_steps(0)

mysterySelectGridController.openSelectWin(originEntity)


if mysteryFightModel:get_after_queue_size()>0 then
mysteryFightModel:dequeue_after_callback()
end
end

function mysterySelectGridController.openSelectWin(entity)
local id=entity.id

local cfg=mysterySelectGridModel:get_config(id)

UIFullMysteryMainControl:showWindow(cfg.window,{entity=entity})
end