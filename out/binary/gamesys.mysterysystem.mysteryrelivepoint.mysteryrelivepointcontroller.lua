











mysteryRelivePointController=mysteryEntityControllerBase.new(eMysteryEntityType.eRelivePoint,mysteryEntityControllerBase)

local _HexMapManager=CS.HexagonMapManagerInterface



function mysteryRelivePointController:onAppStart()
socketManager:register_receiver(4,38,mysteryRelivePointController.recv_4_38)
end

function mysteryRelivePointController:onEnterState()
mysteryRelivePointModel:init_data()
end

function mysteryRelivePointController:onLeaveState()

end



function mysteryRelivePointController.create_relivepoint(args)
local id=args.etId
local x=args.x
local y=args.y
local hideFlag=args.hideFlag
local roomId=args.roomId or mysteryRoomModel:get_cur_roomID()
local cfg=mysteryRelivePointModel:get_config(id)
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

for key,value in pairs(args)do
data[key]=value
end
local guid=mysteryRelivePointModel:create_entity(eMysteryEntityType.eRelivePoint,id,pos,roomId,model,data,hideFlag)

end

function mysteryRelivePointController:create_entity(args)
return mysteryRelivePointController.create_relivepoint(args)
end

function mysteryRelivePointController:init_map_entity(roomId,completeCB)
roomId=roomId or mysteryRoomModel:get_cur_roomID()

local list={}
local num=5
local lIndex=0
local entitys=mysteryRoomModel:get_room_entity_birth_pos_list(roomId,eMysteryEntityType.eRelivePoint)
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
mysteryRelivePointController.create_relivepoint(v)
end
else
createTimer:cancel()
if completeCB then
completeCB()
end
end
end,-1)
end





function mysteryRelivePointController.update_relive()

if not mysteryRelivePointController.handle_meet()then

mysteryAIManager:update_queue()
end
end


function mysteryRelivePointController.handle_meet()
local isMeet=false
local entity_list=mysteryRelivePointModel:get_entity_list()
for guid,v in pairs(entity_list)do

mysteryRelivePointModel:update_visible(guid)







if mysteryAIManager.meet_player(v,v.pos,mysteryRelivePointController.meet_result)then
isMeet=true
end

end
return isMeet
end

function mysteryRelivePointController.meet_result(originEntity,targetEntity)

local okcallback=function()
if not MysteryModel:check_dead()then
UIManager.info("暂无阵亡弟子")


mysteryAIManager:update_queue()
else

mysterySkillController:set_hide_steps(0)
socketManager:send_4_38()
end





end

local cancelback=function()

mysteryAIManager:update_queue()




end

if not mysteryRelivePointController.comfirmDialog then
local showdata=
{
type='UIDialouge',
title='提示',
content="是否随机复活一名阵亡弟子？",
oktext='确定',
canceltext='取消',
allowclickBG='false',

okcallback=okcallback,
cancelcallback=cancelback,
}
mysteryRelivePointController.comfirmDialog=UIDialogManager.newDialog(showdata)
mysteryRelivePointController.comfirmDialog.deleteSelf=function(...)
mysteryRelivePointController.comfirmDialog=nil
end
mysteryRelivePointController.comfirmDialog:show()

end

end

function mysteryRelivePointController.recv_4_38()





mysteryAIManager:update_queue()

local pos=mysteryPlayerModel:get_player_pos()
local roomId=mysteryRoomModel:get_cur_roomID()
local entity=mysteryRelivePointModel:get_entity_by_pos(pos,roomId)
if not entity then
return
end

mysteryRelivePointModel:remove_entity(entity.guid)

end