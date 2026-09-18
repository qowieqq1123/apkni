











mysteryPortalController=mysteryEntityControllerBase.new(eMysteryEntityType.ePortal,mysteryEntityControllerBase)

local _HexMapManager=CS.HexagonMapManagerInterface
local CreateRole=_HexMapManager.CreateRole
local SetPosition=_HexMapManager.SetPosition
local Vector3ToVector3Int=_HexMapManager.Vector3ToVector3Int
local _Screen=UnityEngine.Screen



function mysteryPortalController:onAppStart()

end

function mysteryPortalController:onEnterState()
mysteryPortalModel:init_data()
notifySystem:listenNotify(notifyConfig.on_mystery_player_move_start,mysteryPortalController.on_mystery_player_move_start)
end

function mysteryPortalController:onLeaveState()
notifySystem:removelistener(notifyConfig.on_mystery_player_move_start,mysteryPortalController.on_mystery_player_move_start)
end


local existTimer={}



function mysteryPortalController.create_portal(id,x,y,roomId,guid,hideFlag,targetRoomID,disappearTime)
roomId=roomId or mysteryRoomModel:get_cur_roomID()
local portalId=id
local portalCfg=mysteryPortalModel.get_portal_config(portalId)
local portalPos=Vector3(x,y,0)
if not portalCfg then
error("无传送门配置",portalId)
end
local skipCreate=portalCfg.skipCreate
if skipCreate then
if skipCreate[1]==1 and roomId==0 then
return
end
if skipCreate[2]==1 and roomId==id then
return
end
end
local model=
{
id=portalCfg.model[1],
components={},
layer=SortingLayers.ITBuilding,
scale=portalCfg.model[2],
}
local data=
{
targetRoomID=targetRoomID,
showInFog=portalCfg.showInFog,
guid=guid,
}
local guid=mysteryPortalModel:create_entity(eMysteryEntityType.ePortal,portalId,portalPos,roomId,model,data,hideFlag)
if disappearTime and disappearTime>0 then
existTimer[guid]=disappearTime+1
end
return guid
end

function mysteryPortalController:create_entity(args)
return mysteryPortalController.create_portal(args.etId,args.x,args.y,args.roomId,args.guid,args.hideFlag,args.targetRoomID)
end

function mysteryPortalController:init_map_entity(playerRooomID,completeCB,createEffect)
playerRooomID=playerRooomID or mysteryRoomModel:get_cur_roomID()
local groundLayer=mysteryRoomModel:get_GroundLayer(playerRooomID)
local portal=mysteryPortalModel:get_portal_data(playerRooomID)

if portal then
for guid,v2 in pairs(portal)do
local _portal=mysteryPortalModel:get_entity_by_pos(Vector3(v2.x,v2.y,0),playerRooomID)
if not _portal then
if createEffect then
local guid=mysteryPortalController.create_portal(v2.transferDoorId,v2.x,v2.y,playerRooomID,guid,0,v2.roomId,v2.hhNum)
if guid then
mysteryEntityController.invokeFuncByMysteryEntityType(eMysteryEntityType.ePortal,"set_entity_visible",guid,false)
end
mysteryFogController:createEffect(5,Vector3(v2.x,v2.y,0),groundLayer,0.5,function()
if guid then
mysteryEntityController.invokeFuncByMysteryEntityType(eMysteryEntityType.ePortal,"set_entity_visible",guid,true)
end
end)
else
mysteryPortalController.create_portal(v2.transferDoorId,v2.x,v2.y,playerRooomID,guid,0,v2.roomId,v2.hhNum)
end

end
end
end
if completeCB then
completeCB()
end
end



function mysteryPortalController.update_portal()

if not mysteryPortalController.handle_meet()then

mysteryAIManager:update_queue()
end

end

function mysteryPortalController.on_mystery_player_move_start()

mysteryPortalController.disappear_update()
end

function mysteryPortalController.disappear_update()
local portal_list=mysteryPortalModel:get_entity_list()
for guid,v in pairs(portal_list)do
if existTimer[guid]then
existTimer[guid]=existTimer[v.guid]-1
if existTimer[guid]<=0 then
mysteryPortalModel:remove_entity(guid)
existTimer[guid]=nil
end
end
end
end


function mysteryPortalController.handle_meet()
local portal_list=mysteryPortalModel:get_entity_list()
local isMeet=false
for guid,v in pairs(portal_list)do

mysteryPortalModel:update_visible(guid)









if mysteryAIManager.meet_player(v,v.pos,mysteryPortalController.meet_result)then
if not isMeet then
isMeet=true
end
end

end
return isMeet
end

function mysteryPortalController.meet_result(originEntity,targetEntity)



local portal=originEntity

if not mysteryAIManager.is_on_round()then
local targetID=mysteryPortalModel:get_room_guid(portal.roomId,portal.data.guid)
if targetID then
if portal.data.guid==-1 then
mysteryRoomController.send_4_18(0,0,0,targetID)
else
mysteryRoomController.send_4_18(0,0,tonumber(tostring(portal.data.guid)),targetID)
end
end
end


if mysteryFightModel:get_after_queue_size()>0 then
mysteryFightModel:dequeue_after_callback()
end
end


function mysteryPortalController.transfer(x,y,roomID,preRoomID)
roomID=roomID==nil and 0 or roomID

local transferPos=Vector3(x,y,0)


local mapType=mysteryRoomModel:get_mapType_by_roomID(roomID)
local groundLayer=MysteryController.MapLayerLookUp[mapType].GroundLayer



local baseCfg=cfg_secretscenebaseconfig_get(1)
local cameraSpeed=baseCfg.camera_move_speed

mysteryPlayerModel:set_player_pos(transferPos)
local movedCB=function()

local srcPortal=mysteryPortalModel:get_entity_by_pos(mysteryPlayerModel:get_player_pos(),preRoomID)
if srcPortal then
mysteryPortalModel:update_visible(srcPortal.guid)
end

local dstPortal=mysteryPortalModel:get_entity_by_pos(transferPos,roomID)
if dstPortal then
mysteryPortalModel:update_visible(dstPortal.guid)
end
SetPosition(mysteryPlayerModel:get_player_guid(),transferPos,groundLayer)

MysteryController:setCameraBorder(mapType)

UIManager:invokeUIMethod("UIMysteryMiniWin","initPlayer")
UIManager:invokeUIMethod("UIMysteryMiniWin","focusPlayer")

mysteryFogController:updateFog(MysteryModel:get_cur_fbid(),transferPos)
mysteryCameraController:setCamaraFocusEntity(eMysteryEntityType.ePlayer,mysteryPlayerModel:get_player_guid(),nil,cameraSpeed[2])

end
_HexMapManager.SetCameraPosition(_HexMapManager.GetCellCenterWorld(transferPos,groundLayer),movedCB,false,0)


mysteryAIManager:update_queue()
end




function mysteryPortalController.send_4_25()

end





















