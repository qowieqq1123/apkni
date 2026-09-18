




local createTimer
local createGridData={}
local round=0
local maxRound
local maparea


local hasFirstGrid=false
local borderAngle=90
local _camera_begin_pos,_swip_begin_pos,_swip_update_pos

local baseCfg=cfg_secretscenebaseconfig_get(1)

function MysteryController.req_4_80(fbId,roomId,mapIndex)
socketManager:send_4_80(fbId,roomId,mapIndex)
end

function MysteryController.recv_4_80(fbId,roomId,mapIndex,mapConf)
local mapData=jsonHelper.decode(mapConf)
if roomId==0 then
MysteryModel:saveMapConfig(fbId,mapIndex,mapData)


else
MysteryModel:saveRoomMapConfig(roomId,mapIndex,mapData)


end
notifySystem:postNotify(notifyConfig.on_mystery_config_load,fbId,roomId,mapIndex)
end


function MysteryController:initMap(fbID)
if not fbID then
fbID=MysteryModel:get_cur_fbid()
end
if not fbID then
loggerUtil.logErrFMT("副本id为空",fbID)
return
end

local cfg_fb=cfg_secretscenefubenconfig_get(fbID)


if cfg_fb.bgMusic then
AudioManager.playBgMusic(cfg_fb.bgMusic)
end



if cfg_fb.cloudGroup then
for i,v in ipairs(cfg_fb.cloudGroup)do
mysteryFogController.loadFogEffect(v,Vector3.New(0,0,0),HexMapLayer.Ground,false,Vector3.New(0,0,0),function(guid)
mysteryFogController.removeFogEffectId(guid)
end)
end
end

local grid_size=cfg_fb.gridsize
maxRound=grid_size[1]>grid_size[2]and grid_size[1]or grid_size[2]
maparea=cfg_fb.maparea[1]>cfg_fb.maparea[2]and cfg_fb.maparea[1]or cfg_fb.maparea[2]
maparea=maparea+10
_HexMapManager.SetGridSize(grid_size[1],grid_size[2],0)

borderAngle=cfg_fb.borderangle or 90

MysteryController:setCameraBorder(HexMapType.Main)


MysteryController:initFBStage(fbID,0)

if MysteryController.enterTimeOut then
MysteryController.enterTimeOut:cancel()
MysteryController.enterTimeOut=nil
end


if cfg_fb.fixedenveffect then
local edList={}
for i,v in ipairs(cfg_fb.fixedenveffect)do
table.insert(edList,v[1])
end
mysteryEnvironmentEffectController.setEnvironmentEffectByList(edList)
end


hasFirstGrid=false
MysteryModel.currentFBData.isMapInit=false
round=0
self:stopCreateTimer()


createGridData=table.deepCopy(MysteryModel:get_all_main_grid_data())

if not(createGridData and next(createGridData))then
return
end


sceneAudioController:playMysteryEnterMusic()

self.createMapInRound()

if not self.isClearMysteryCloud then
mysteryFogController:createMapFogEffect(0,0)
end




createTimer=timer.new()
createTimer:start(baseCfg.map_round_duration,self.createMapInRound,50)

end

function MysteryController:stopCreateTimer()
if createTimer then
createTimer:cancel()
createTimer=nil
end
end


function MysteryController.createMapInOneRound()
local birth_pos=MysteryModel:get_player_birth_pos()
local playerPos={x=birth_pos[1],y=birth_pos[2]}
local posList=mysteryPosHelper.get_round_pos_list(playerPos,round)

local grid
local cfg_surface=cfg_secretscentsurfaceconfig()
local config

for i,v in ipairs(posList)do
if createGridData[v.y]and createGridData[v.y][v.x]then
grid=createGridData[v.y][v.x]
config=cfg_surface[grid.surfaceId]
local pos=Vector3(v.x,v.y,0)
if config then



if MysteryController.is_offscreen_round()then
MysteryController:Paint(pos,config.groupid,grid.surfaceId,HexMapLayer.Ground,grid.height)
_HexMapManager.SetTileColor(pos,HexMapLayer.Ground,1,1,1,1)
else


MysteryController:Paint(pos,config.groupid,grid.surfaceId,HexMapLayer.Ground,grid.height)
_HexMapManager.SetTileColor(pos,HexMapLayer.Ground,1,1,1,1)
local animCB=function()
if playerPos and playerPos.x==v.x and playerPos.y==v.y then
mysteryFogController:createEffect(5,Vector3(playerPos.x,playerPos.y,0),HexMapLayer.Ground,0.5,function()
mysteryEntityController.invokeFuncByMysteryEntityType(eMysteryEntityType.ePlayer,"set_entity_visible",mysteryPlayerModel:get_player_guid(),true)
end)
end
local entity=mysteryEntityBase:get_entity_by_pos(pos,0)
if entity then
_HexMapManager.SetPosition(entity.guid,pos,grid.height)
end
end
timeEventController.delayDo(0.7,animCB)
_HexMapManager.RunSurfaceSpriteAnimator(pos,HexMapLayer.Ground,"CreateAnim",0,nil)
end
if not hasFirstGrid then
mysteryPlayerController.init_map_player()
mysteryEntityController.invokeFuncByMysteryEntityType(eMysteryEntityType.ePlayer,"set_entity_visible",mysteryPlayerModel:get_player_guid(),false)
MysteryController:Paint(pos,config.groupid,grid.surfaceId,HexMapLayer.Ground,grid.height)
hasFirstGrid=true
end
end

createGridData[v.y][v.x]=nil
if next(createGridData[v.y])==nil then
createGridData[v.y]=nil
end
end
end
if next(createGridData)~=nil then
for k,v in pairs(createGridData)do
if next(v)==nil then
createGridData[k]=nil
end
end
end

end

function MysteryController.createMapInRound()
MysteryController.createMapInOneRound()
if MysteryController.is_offscreen_round()then
for i=1,maparea do
MysteryController.createMapInOneRound()
if next(createGridData)==nil then
break
end
round=round+1
end
else

round=round+1
end
if next(createGridData)==nil then

createTimer:cancel()
createTimer=nil


MysteryController:afterCreateMap()


createTimer=timer.new()
createTimer:start(0.1,MysteryController.initUI,1)

MysteryModel.currentFBData.isMapInit=true
MysteryModel:set_map_create_flag(true)
end
end


function MysteryController.is_offscreen_round()
return round>5
end



function MysteryController.loadMapData(fbId,index)
local fbCfg=cfgHelper.get(cfg_secretscenefubenconfig_get,fbId)
local templateType=fbCfg.template[1]



local mapData=MysteryModel:getMapConfig(fbId,index)
if not mapData then
loggerUtil.debugErr("没有获取地图配置{0},{1}",fbId,index)
return
end

local map

map=mapData




if not map then
loggerUtil.logErrFMT("地图不存在:{0}",fbId)
return
end

return map
end

function MysteryController.loadRoomMapData(doorId,index)


local mapData=MysteryModel:getRoomMapConfig(doorId,index)
if not mapData then
loggerUtil.debugErr("没有获取地图配置{0},{1}",doorId,index)
return
end

return mapData
end

function MysteryModel:saveMapConfig(fbId,index,mapData)
self.mapConfig[fbId]=self.mapConfig[fbId]or{}
self.mapConfig[fbId][index]=mapData
end

function MysteryModel:getMapConfig(fbId,index)
if self.mapConfig[fbId]then
return self.mapConfig[fbId][index]
end
end

function MysteryModel:saveRoomMapConfig(doorId,index,mapData)
self.roomMapConfig[doorId]=self.roomMapConfig[doorId]or{}
self.roomMapConfig[doorId][index]=mapData
end
function MysteryModel:getRoomMapConfig(doorId,index)
if self.roomMapConfig[doorId]then
return self.roomMapConfig[doorId][index]
end
end
