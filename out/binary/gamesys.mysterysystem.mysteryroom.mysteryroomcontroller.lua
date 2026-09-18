







local _MODULENAME="mysteryRoomController"
gameState.addListener(def_table(_MODULENAME))
mysteryRoomController.name=_MODULENAME

local _HexMapManager=CS.HexagonMapManagerInterface
local SetPosition=_HexMapManager.SetPosition



function mysteryRoomController:onAppStart()

socketManager:register_receiver(4,18,mysteryRoomController.recv_4_18)
socketManager:register_receiver(4,68,mysteryRoomController.recv_4_68)
socketManager:register_receiver(4,70,mysteryRoomController.recv_4_70)

notifySystem:listenNotify(notifyConfig.on_mystery_config_load,self.onMysteryConfigLoad)
end

function mysteryRoomController:onEnterState()
mysteryRoomModel:init_data()
end

function mysteryRoomController:onLeaveState()

end



function mysteryRoomController:createRoom(roomID)
local mapType=mysteryRoomModel:get_mapType_by_roomID(roomID)
if not mapType then return end
local main_grid_data=mysteryRoomModel:get_room_grid_list_data(roomID)
local cfg_surface=cfg_secretscentsurfaceconfig()
local groundLayer=MysteryController.MapLayerLookUp[mapType].GroundLayer
local config
if main_grid_data then
for y,yv in pairs(main_grid_data)do
for x,v in pairs(yv)do
if cfg_surface[v.surfaceId]then
config=cfg_surface[v.surfaceId]
MysteryController:Paint(Vector3(x,y,0),config.groupid,v.surfaceId,groundLayer,v.height)
end
end
end
end
local mapData=mysteryRoomModel:get_room_grid_list_data(roomID)or{}

UIManager:invokeUIMethod("UIMysteryMiniWin","initMiniMap",mapData)

mysteryEntityController:initEntity(roomID)



end

function mysteryRoomController:clearRoom(roomID)
if roomID==0 then
return
end
mysteryRoomModel:clear_room_data(roomID)
for _,entityType in pairs(eMysteryEntityType)do
if entityType~=eMysteryEntityType.ePlayer then
mysteryEntityController.invokeFuncByMysteryEntityType(entityType,"clear_room_entity_list",roomID)
end
end

mysteryFogModel:clear_fog_data(roomID)
local mapType=mysteryRoomModel:get_mapType_by_roomID(roomID)
_HexMapManager.ClearMap(MysteryController.MapLayerLookUp[mapType].GroundLayer)
_HexMapManager.ClearMap(MysteryController.MapLayerLookUp[mapType].DataLayer)
end


function mysteryRoomController:enterRoom(roomID,x,y)
local oldRoomID=mysteryRoomModel:get_cur_roomID()

mysteryRoomModel.data.isInitRoom=true
UIManager:showWindow("UIFightPrepareLoading",{
startCallback=function()
local mapType=mysteryRoomModel:get_mapType_by_roomID(roomID)
MysteryModel:set_map_type(mapType)
MysteryController:initFBStage(nil,roomID)
self:clearRoom(oldRoomID)
mysteryRoomModel:set_cur_roomID(roomID)
self:createRoom(roomID)
mysteryFogController:removeMapFogEffect(oldRoomID)
mysteryFogController:createMapFogEffect(0,roomID)






local fogWhiteList=nil
local pconfig=mysteryPortalModel:get_config(roomID)
if pconfig then
fogWhiteList=pconfig.fogWhite
end

mysteryFogController:initFog(nil,true,fogWhiteList,Vector3.New(x,y,0))
MysteryController:setCameraBorder()
mysteryPortalController.transfer(x,y,roomID,oldRoomID)



UIManager:invokeUIMethod("UIMysteryWin","showTriggerItemPanel")
UIManager:callWindowFunc("UIMysteryWin","initSkillList")
UIManager:callWindowFunc("UIMysteryWin","refreshLayer")
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
local fbId=MysteryModel:get_cur_fbid()
mysteryRoomController.send_4_70(fbId,roomID)
end,
})



mysteryMonsterModel:refresh_all_hud()
end


function mysteryRoomController:enterMain(x,y)
local oldRoomID=mysteryRoomModel:get_cur_roomID()
UIManager:showWindow("UIFightPrepareLoading",{
startCallback=function()

self:clearRoom(oldRoomID)
mysteryRoomModel:set_cur_roomID(0)
MysteryController:initFBStage(nil,0)
MysteryModel:set_map_type(HexMapType.Main)
local mainMapData=MysteryModel:get_all_main_grid_data()or{}
UIManager:invokeUIMethod("UIMysteryMiniWin","initMiniMap",mainMapData)
UIManager:invokeUIMethod("UIMysteryMiniWin","initRoomMapItem",0)

MysteryController:setCameraBorder()
mysteryPortalController.transfer(x,y,0,oldRoomID)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
UIManager:callWindowFunc("UIMysteryWin","initSkillList")
UIManager:callWindowFunc("UIMysteryWin","refreshLayer")
mysteryRoomModel.data.isInitRoom=nil
mysteryFightController.fightComplete()
end,
})
mysteryFogController:removeMapFogEffect(oldRoomID)
mysteryFogController:createMapFogEffect(0,0)

mysteryMonsterModel:refresh_all_hud()
end










function mysteryRoomController.send_4_18(x,y,portalGUID,roomID,xyFlag)









mysteryRoomModel.data.isInitRoom=true
socketManager:send_4_18(xyFlag or 0,x,y,portalGUID,roomID)
end


function mysteryRoomController.recv_4_18(args)
local roomID,x,y,mapIndex,gridLen,gridList=args[1],args[2],args[3],args[4],args[5],args[6]

local preRoomId,preDoorId=args[7],args[8]

local etListLen,etList=args[9],args[10]

if roomID==0 then
mysteryRoomController:enterMain(x,y)
else
if MysteryModel:getRoomMapConfig(roomID,mapIndex)then
mysteryRoomModel:set_room_grid_data(roomID,gridList,mapIndex,preRoomId)
if etListLen>0 then
mysteryRoomModel:set_room_ent_birth_data(roomID,etList)
end
mysteryRoomController:enterRoom(roomID,x,y)
else
mysteryRoomModel:set_temp_grid_data(roomID,x,y,preRoomId,gridList,etList)
MysteryController.req_4_80(MysteryModel:get_cur_fbid(),roomID,mapIndex)
end








end
end

function mysteryRoomController.onMysteryConfigLoad(fbId,roomId,mapIndex)
if fbId==MysteryModel:get_cur_fbid()and roomId>0 then
local tempData=mysteryRoomModel:get_temp_grid_data(roomId)
mysteryRoomModel:set_room_grid_data(roomId,tempData[4],mapIndex,tempData[3])
if tempData[5]then
mysteryRoomModel:set_room_ent_birth_data(roomId,tempData[5])
end
mysteryRoomController:enterRoom(roomId,tempData[1],tempData[2])
end
end


function mysteryRoomController.recv_4_68(roomID,len,gridList)

for i,v in ipairs(gridList)do
local layer=mysteryRoomModel:get_GroundLayer(roomID)
local gridData=mysteryRoomModel:get_grid_pos_data(roomID,v.param_1,v.param_2)
gridData.surfaceId=v.param_3
mysteryRoomModel:set_grid_pos_data(roomID,v.param_1,v.param_2,gridData)
local surfaceCfg=cfgHelper.get(cfg_secretscentsurfaceconfig_get,v.param_3)
local gridPos=Vector3(v.param_1,v.param_2,0)

timeEventController.delayDo(0.2,function()
MysteryController:Paint(gridPos,surfaceCfg.groupid,v.param_3,layer,gridData.height)
_HexMapManager.RunSurfaceSpriteAnimator(gridPos,layer,"CreateAnim",0,nil)
mysteryAIManager:set_mystery_state(true,false,0.5)
end)
end

end

function mysteryRoomController.send_4_70(fbId,roomId)
socketManager:send_4_70(fbId,roomId)
end


function mysteryRoomController.recv_4_70(fbId,roomId)
mysteryRoomModel.data.isInitRoom=nil

mysteryFightController.fightComplete()

timeEventController.delayDo(0.5,function()
local portal=mysteryRoomModel:get_pos_entityType(roomId,mysteryPlayerModel:get_player_pos(),eMysteryEntityType.ePortal)
if not portal then
mysteryEntityController.handle_meet()
end
end)
end

