











mysteryObstacleController=mysteryEntityControllerBase.new(eMysteryEntityType.eObstacle,mysteryEntityControllerBase)

local _HexMapManager=CS.HexagonMapManagerInterface



function mysteryObstacleController:onAppStart()
socketManager:register_receiver(4,30,mysteryObstacleController.recv_4_30)

end

function mysteryObstacleController:onEnterState()
notifySystem:listenNotify(notifyConfig.on_mystery_create_entity,self.createEntityCb)
notifySystem:listenNotify(notifyConfig.on_mystery_remove_entity,self.removeEntityCb)
notifySystem:listenNotify(notifyConfig.touchUp,self.onTouchUp)
mysteryObstacleModel:init_data()
end

function mysteryObstacleController:onLeaveState()
notifySystem:removelistener(notifyConfig.on_mystery_create_entity,self.createEntityCb)
notifySystem:removelistener(notifyConfig.on_mystery_remove_entity,self.removeEntityCb)
notifySystem:removelistener(notifyConfig.touchUp,self.onTouchUp)
end



function mysteryObstacleController.create_obstacle(args)
local id=args.etId
local x=args.x
local y=args.y
local roomId=args.roomId
local hideFlag=args.hideFlag
roomId=roomId or mysteryRoomModel:get_cur_roomID()
local obstacleId=id
local obstacleCfg=mysteryObstacleModel.get_obstacle_config(obstacleId)
if not obstacleCfg then
logErr(FMT.fmt("没有该景观的配置{0}",id))
return
end
local obstaclePos=Vector3(x,y,0)

local model=
{
id=obstacleCfg.model[1],
components={},
layer=SortingLayers.ITDecoration4,
scale=obstacleCfg.model[2],
}
local data=
{

}
for key,value in pairs(args)do
data[key]=value
end

local guid=mysteryObstacleModel:create_entity(eMysteryEntityType.eObstacle,obstacleId,obstaclePos,roomId,model,data,hideFlag)

local obstacleCfg=mysteryObstacleModel.get_obstacle_config(obstacleId)
if obstacleCfg.collider then
local entity=mysteryObstacleModel:get_entity(guid)
if entity then
entity.data.obstacle=true
end
mysteryObstacleModel:add_obstacle_pos(guid,obstacleId,obstaclePos,roomId)
end
if obstacleCfg.showlingshou then
MysteryLingshouModel:CreateLingShou(obstaclePos)
end

return guid
end

function mysteryObstacleController:create_entity(args)
return mysteryObstacleController.create_obstacle(args)
end

function mysteryObstacleController:init_map_entity(roomId,completeCB)
roomId=roomId or mysteryRoomModel:get_cur_roomID()

local list={}
local num=5
local lIndex=0
local entitys=mysteryRoomModel:get_room_entity_birth_pos_list(roomId,eMysteryEntityType.eObstacle)
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
mysteryObstacleController:create_entity(v)
end
else
createTimer:cancel()
if completeCB then
completeCB()
end
end
end,-1)
end



function mysteryObstacleController.recv_4_30(x,y)
local pos=Vector3(x,y,0)
local roomId=mysteryRoomModel:get_cur_roomID()
local obstacle=mysteryObstacleModel:get_entity_by_pos(pos,roomId)
if not obstacle then
return
end

mysteryObstacleModel:remove_entity(obstacle.guid)
if MysteryEventModel:get_current_result_flag()==MysteryEventResult.EventResultType.removeObstacle then
local result_group=MysteryEventModel:get_result_select()
if result_group then
notifySystem:postNotify(notifyConfig.on_mystery_event_result_finish_c,result_group[2])
end
end
end

function mysteryObstacleController.createEntityCb(guid,pos,entityType,obstacleId)
if entityType==eMysteryEntityType.eObstacle then
local obstacleCfg=mysteryObstacleModel.get_obstacle_config(obstacleId)
if obstacleCfg.collider then
local entity=mysteryObstacleModel:get_entity(guid)
if entity then
entity.data.obstacle=true
end
mysteryObstacleModel:add_obstacle_pos(guid,obstacleId,pos,entity.roomId)
end
end
end


function mysteryObstacleController.removeEntityCb(guid,roomId,pos,eType,id,isDestory)
if eType==eMysteryEntityType.eObstacle and isDestory then
local oldObstacle=mysteryObstacleModel:is_obstacle_pos(roomId,pos)
mysteryObstacleModel:remove_obstacle_pos(roomId,guid,pos)
local newObstacle=mysteryObstacleModel:is_obstacle_pos(roomId,pos)
if oldObstacle~=newObstacle then
mysteryObstacleModel:erase_obstacle(roomId,pos)

UIManager:invokeUIMethod("UIMysteryMiniWin","paintGround",pos,1)
end
end
end


function mysteryObstacleController.onTouchUp(fingerIndex,touchCount,screenPoint,guid)
if not MysteryModel:is_enter_Mystery()then
return
end
if fingerIndex~=0 then
return
end
local roomID=mysteryRoomModel:get_cur_roomID()
local groundLayer=mysteryRoomModel:get_GroundLayer(roomID)

local point=MysteryController:screenToMapPos(screenPoint,groundLayer)
if not point then
return
end
local pos=_HexMapManager.Vector3IntToVector3(point)
if mysteryObstacleModel:is_obstacle_pos(roomID,pos)and not MysteryController.isDrag()then
UIManager.error("无法前往")
end
end