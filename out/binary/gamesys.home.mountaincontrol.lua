
mountainControl=gameState.addListener({})

mountainLoadState={
unloaded=0,
loading=1,
loaded=2,
reqUnlock=3,
}









local _map_data={
[mapIdType.zhufeng]={
onAfterLoadMap=function(mapId)
surfaceControl:hideScenery()
surfaceControl:showScenery()
zongmenSkinControl:init()
isometricMapSystem:loadMountain(mapId)
isometricMapSystem:loadSkyBuilding(mapId)
isometricMapSystem:resetMap(mapId)
isometricMapSystem:playWaitingBT()
end,
onBeforeLeaveHome=function(mapId)
isometricMapSystem:removeBuildingBehavior(mapId)
end,
isCanRemove=function()
return false
end
},
[mapIdType.lingshoudao]={
onAfterLoadMap=function(mapId)
isometricMapSystem:loadMountain(mapId)
isometricMapSystem:setNormalMap(mapId)

lingShouAIManager:init()

end,
checkOpen=function(mapId,isWarning)
if not systemModel.isOpen(SYSTEM_DEFINE.eLingShouFeng)then
if isWarning then
UIManager.error('灵兽峰未开启')
end
return false
end
return true
end,
isCanRemove=function()
return false
end
},
[mapIdType.xianzhan]={
onAfterLoadMap=function(mapId)
local area_list=cfgHelper.get2(cfg_monijysfconfig_get,mapId,'area_list')
for i,v in ipairs(area_list)do
isometricMapSystem:unlockArea(mapIdType.xianzhan,v)
end
end,
checkOpen=function(mapId,isWarning)
local list=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eXianZhan,true,true,isWarning)
if list==nil or#list<=0 then
return false
end
return true
end,
onBeforeDeleteMap=function(mapId)
xianzhanController:leaveSceneClearEntity()
end,
isCanRemove=function()
return true
end,
},
[mapIdType.xianmeng]={
onAfterLoadMap=function(mapId)
isometricMapSystem:loadMountain(mapId)
isometricMapSystem:setNormalMap(mapId)
local areas=cfgHelper.get2(cfg_monijysfconfig_get,mapIdType.xianmeng,'draw_surface')or{}
for k,v in pairs(areas)do
_MapManager.DrawByArea(mapIdType.xianmeng,v,TILE_TYPE.eSurfaceTile1,mapLayer.Ground1,conditionConfig.drawSurface)
end
xianmengController:loadMapAI()
end,
checkOpen=function(mapId,isWarning)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianMeng)then
local w_str=systemModel.getOpenTips(SYSTEM_DEFINE.eXianMeng)
UIManager.error(w_str)
return false
end
if not xianmengModel:hasXM()then
if isWarning then
local str=cfgHelper.getlang("haveNotXianMengTips")
UIManager.error(str)
end
return false
end

if xianmengModel:getMyXMDetialData()==nil then

xianmengController:reqXMDataDetail()
return false
end
return true
end,
onEnteredMap=function(mapId)
if xianmengController:doHeJuAutoBuild()then
return
end
if not xianmengModel:hasSelfHeJu()then
local checkId=cfgHelper.get2(cfg_guildbaseconfig_get,1,"hejubuildid")
isometricMapSystem:enterLayoutModel({model=layoutMode.eBuild,forceBuildId=checkId,forceBuildTips='点击绿色地块将本宗的鹤居放在仙盟内'})
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.XianMengFirstLuaFunc)
return
end

if xianmengModel:getTipsFlag_fenxiangziyuan()then
xianmengController:req_protocol_20_46()
end
end,
onBeforeDeleteMap=function(mapId)
xianmengController:clearMapEntitys()
end,
isCanRemove=function()
return true
end
},
[mapIdType.zhufeng_hy]={
onAfterLoadMap=function(mapId)
visitControl:loadAndSetMountain(mapId)
end,
onBeforeDeleteMap=function(mapId)
visitControl:removeBuildingBehavior(mapId)
visitControl:clearMap()
end,
onBeforeLeaveHome=function(mapId)
visitControl:removeBuildingBehavior(mapId)
end,
isCanRemove=function()
return true
end
},

[mapIdType.zhufeng_design]={
onAfterLoadMap=function(mapId)
isometricMapSystem:loadAndSetDesignMountain(mapId)
isometricMapSystem:handleDesignCreateSundrise()
isometricMapSystem:showDesignObj(false)
end,
onBeforeDeleteMap=function(mapId)
isometricMapSystem:removeDesignSundrise()
isometricMapSystem:clearDesignMap()
end,
isCanRemove=function()
return true
end
},
[mapIdType.fort]={
onAfterLoadMap=function(mapId)
isometricMapSystem:loadMountain(mapId)
isometricMapSystem:setNormalMap(mapId)
local area_list=cfgHelper.get2(cfg_monijysfconfig_get,mapId,'area_list')
for i,v in ipairs(area_list)do
isometricMapSystem:unlockArea(mapIdType.fort,v)
end
local areas=cfgHelper.get2(cfg_monijysfconfig_get,mapIdType.fort,'draw_surface')or{}
for k,v in pairs(areas)do
_MapManager.DrawByArea(mapIdType.fort,v,TILE_TYPE.eSurfaceTile2,mapLayer.Ground1,conditionConfig.drawSurface)
end

isometricMapSystem:resetHUD(mapId)

ims_fort_ai:loadMapAI()

LittleWorldController.checkLittleWorldRepair(mapId)

notifySystem:postNotify(notifyConfig.enterXianJieFort)
end,
onBeforeDeleteMap=function(mapId)


visitControl:removeBuildingBehavior(mapId)
local buildingDatas=zongmenModel:getAllBuildingData(mapId)
for un_build_id,bdData in pairs(buildingDatas)do
hudControl:removeProgressData(un_build_id)
if bdData.entityId then
hudControl:clearHUDByEntityID(bdData.entityId)
_MapManager.RemoveTilemapObject(bdData.entityId)
end
isometricMapSystem:setBenefitBuffBuildingById(mapId,un_build_id,true)
buildingEffectControl:stopLoopEffect(mapId,un_build_id)
end

ims_fort_ai:onLeaveHome_ai(true)

notifySystem:postNotify(notifyConfig.leaveXianJieFort)
end,
isCanRemove=function()
return true
end,
greenChannel=function(mapId)
return zongmenModel:isMountainUnlock(mapId)
end,
onEnteredMap=function(mapId)
local haveBD=zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eJuTianYi,false)
if not haveBD then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.XianJieBaoLeiFirstLuaFunc)
end
end,
},
}

function mountainControl:onEnterState(isReconnect)
if isReconnect then
return
end
self.cameraPosRecord={}


self.loadRecord={}
self.removeCDData={}
end

function mountainControl:onLeaveState(isReconnect)
if isReconnect then
return
end
end

function mountainControl:onEnterHome()

timeEventController.addNormalTimerHandler(1,'mountainControl',self)
end

function mountainControl:onLeaveHome()
self.cameraPosRecord={}
self.removeCDData={}
zongmenModel:setMountainId(mapIdType.zhufeng)
timeEventController.removeNormalTimerHandler(1,'mountainControl')
end

function mountainControl:onNormalUpdate()
local currtime=gameUtilityModel.getServerShortTime()
for k,v in pairs(self.removeCDData)do
if currtime>=v then
self:removeMap(k)
break
end
end
end

function mountainControl:setLoadRecord(sfId,state)
self.loadRecord[sfId]=state
end

function mountainControl:getLoadRecord(sfId)
return self.loadRecord[sfId]or mountainLoadState.unloaded
end

function mountainControl:setCameraPos(id,pos)
self.cameraPosRecord[id]=pos
end

function mountainControl:getCameraPos(id)
return self.cameraPosRecord[id]
end











function mountainControl:finishEnterMountain(mapId)


zongmenModel:setMountainId(mapId)
end










function mountainControl:switchMountain(id)
local state=self:getLoadRecord(id)

if state~=mountainLoadState.loaded then
return false
end

local oldid=zongmenModel:getMountainId()
if id~=zongmenModel:getMountainId()then
local cameraPos=_MapManager.GetCameraPosition()
self:setCameraPos(oldid,cameraPos)
zongmenModel:setMountainId(id)

if not UIManager:isActive("UILayoutWin")then
baseFullScreenUI:openMain(true)
end
self:setRemoveTime(oldid)
notifySystem:postNotify(notifyConfig.onMountainChange,oldid,id)
end

reddotControl.on_zongmen_mountain_changed()

local cfg=cfgHelper.get1(cfg_monijysfconfig_get,id)
local defOS=cfg.def_orthographic_size
if webGLHelper:isRunMiniGame()then
defOS=cfg.def_orthographic_size_webgl
end
isometricMapSystem:changeCameraOrthoSize(defOS[1],defOS[2],defOS[3])

local pos=self:getCameraPos(id)
if not pos then
if webGLHelper:isRunWebGL()then
pos=cfg.def_camera_pos_webgl
else
pos=cfg.def_camera_pos
end
local cp=_MapManager.ToVector3Int(pos[1],pos[2],pos[3])
pos=_MapManager.GetCellCenterWorld(id,cp,mapLayer.Data)
end
isometricMapSystem:moveCameraToPosition(pos)

UILayoutControl:setLayoutPage(BUILD_TAB_TYPE.eProduction)

return true
end

function mountainControl:loadMap(mapId,callback)
local state=self:getLoadRecord(mapId)
if state~=mountainLoadState.unloaded then
return false
end

self:setLoadRecord(mapId,mountainLoadState.loading)
local addMapCall=function()
local cfgs=cfgHelper.get1(cfg_mnjyloadsceneconfig_get,mapId)
for i,v in ipairs(cfgs)do
_MapManager.AddTileMap(mapId,v.name,SortingLayers[v.slayer],mapLayer[v.mlayer],tilemapRenderMode[v.mode],v.tid,v.olayer)
end
local data=_map_data[mapId]
xpcall(function()
data.onAfterLoadMap(mapId)
end,function(err)
logErr('loadMap err:',err)
end)
self:setLoadRecord(mapId,mountainLoadState.loaded)
callback()
end

local jsonStr=nil
if api_Available_AddMapEx()and webGLHelper:isRunMiniGame()then
local mapCfg=cfgHelper.get(cfg_mountainsceneconfig_get,mapId)
if mapCfg~=nil and mapCfg.abName_wx~=nil and mapCfg.assetName_wx~=nil then
local jsonData={}
jsonData.abName=mapCfg.abName_wx
jsonData.assetName=mapCfg.assetName_wx
jsonStr=jsonHelper.encode(jsonData)
end
end

if jsonStr~=nil and api_Available_AddMapEx()then
_MapManager.AddMapEx(mapId,jsonStr,addMapCall,true)
else
_MapManager.AddMap(mapId,addMapCall)
end

loadControl.postProgress()

return true
end

function mountainControl:isLoaded(mapId)
local state=self:getLoadRecord(mapId)
return state==mountainLoadState.loaded
end

function mountainControl:isOpen(mapId,warning)

local data=_map_data[mapId]
if data.greenChannel and data.greenChannel(mapId)then
return true
end

local cfg=cfgHelper.get1(cfg_monijysfconfig_get,mapId)
local cndlist=cfg.unlock_condition
if cndlist then
local zmLevel=zongmenModel:getLevel()
for i,v in ipairs(cndlist)do
if v.type==1 then
if zmLevel<v.param then
if warning then
UIManager.error(FMT.fmt('宗门等级不足{0}级',v.param))
end
return false
end
elseif v.type==2 then
if not taskModel:checkTaskFinish(v.param)then
if warning then
local taskname=taskModel:getTaskConfig(v.param).name
UIManager.error(FMT.fmt('完成{0}任务开启',taskname))
end
return false
end
elseif v.type==3 then
if not seasonController:checkSeasonStageOpen(0,v.param)or not seasonController:checkSeasonStageEnded(0,v.param)then
if warning then
local handleName=seasonModel:getHandleConfig(0,"name")
local stageName=seasonModel:getStageConfigEx(0,v.param,"name")
UIManager.error(FMT.fmt('完成{0}·{1}章节开启',handleName,stageName))
end
return false
end
elseif v.type==4 then
if not seasonController:checkSeasonStageOpen(0,v.param)or not seasonController:checkSeasonStageBegined(0,v.param)then
if warning then
local handleName=seasonModel:getHandleConfig(0,"name")
local stageName=seasonModel:getStageConfigEx(0,v.param,"name")
UIManager.error(FMT.fmt('开启{0}·{1}章节开启',handleName,stageName))
end
return false
else
local stageCfg=seasonModel:getStageConfigEx(0,v.param)
if stageCfg.storyMountain and seasonModel:readOpenAnimRecord(0,v.param)~=2 then
if warning then
local handleName=seasonModel:getHandleConfig(0,"name")
local stageName=seasonModel:getStageConfigEx(0,v.param,"name")
UIManager.error(FMT.fmt('开启{0}·{1}章节开启',handleName,stageName))
end
return false
end
end
end
end
end


local data=_map_data[mapId]
if data.checkOpen then
return data.checkOpen(mapId,warning)
end
return true
end

function mountainControl:setRemoveTime(mapId,bRemove)
if bRemove then
self.removeCDData[mapId]=nil
return
end

local data=_map_data[mapId]
if data.isCanRemove and not data.isCanRemove()then
return
end

local rtime=cfgHelper.get2(cfg_monijysfconfig_get,mapId,'remove_time')
local currtime=gameUtilityModel.getServerShortTime()
self.removeCDData[mapId]=currtime+rtime
end

function mountainControl:removeMap(mapId)
self:setRemoveTime(mapId,true)
local data=_map_data[mapId]
if data.onBeforeDeleteMap then
data.onBeforeDeleteMap(mapId)
end
_MapManager.RemoveMap(mapId)
self:setLoadRecord(mapId,mountainLoadState.unloaded)
end

function mountainControl:clearAllMap()
for k,v in pairs(self.loadRecord)do
if v==mountainLoadState.loaded then
local data=_map_data[k]
if data.onBeforeLeaveHome then
data.onBeforeLeaveHome(k)
end
end
end
if _MapManager~=nil then
_MapManager.ClearMap()
end
self.loadRecord={}
end

function mountainControl:mapUnlockComplete(mapId)
self:setLoadRecord(mapId,mountainLoadState.unloaded)

local config=cfgHelper.get1(cfg_monijysfconfig_get,mapId)
if config.unlock_enter then
if mainControl:isSceneType(eSceneType.eZongmen)then
self:loadAndswitchMap(mapId,self.enterMapCallback[mapId])
else
mainControl:enterHome({mapId},self.enterMapCallback[mapId])
end
end
end

function mountainControl:invokeEnterMapCallback(mapId)
if self.enterMapCallback[mapId]then
self.enterMapCallback[mapId](mapId)
local data=_map_data[mapId]
if data.onEnteredMap then
data.onEnteredMap(mapId)
end
self.enterMapCallback[mapId]=nil
end
end

function mountainControl:isInMounts(mounts)
if mounts==nil then return false end
for i,v in ipairs(mounts)do
if zongmenControl:isMountid(v)then
return true
end
end
return false
end

function mountainControl:loadAndswitchMapEx(mapId,showLoading,callback)

if not webGLHelper:isRunWebGL()then
if downAssetManager:needDownLoadZongMenMap(mapId,true)then
return false
end
end
local startCallback=function()
local func
if showLoading then
func=function(mId)
if callback then
callback(mId)
end
isometricMapSystem:markEnterSceneAnim({eSceneType.eZongmen,mapId})
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
else
func=callback
end
mountainControl:loadAndswitchMap(mapId,func)
end

if showLoading then
UIFullDouFaTaiControl:showWindow("UIFightPrepareLoading",{
startCallback=startCallback
})
else
startCallback()
end
return true
end

function mountainControl:loadAndswitchMap(mapId,callback)
local state=self:getLoadRecord(mapId)

if state==mountainLoadState.reqUnlock then
return false
end

if not self.enterMapCallback then
self.enterMapCallback={}
end
self.enterMapCallback[mapId]=callback

self:setRemoveTime(mapId,true)

if not zongmenModel:isMountainUnlock(mapId)then
zongmenControl:reqUnlockMountain(mapId,0,{})
self:setLoadRecord(mapId,mountainLoadState.reqUnlock)
return false
end

if state==mountainLoadState.unloaded then
self:loadMap(mapId,function()
mountainControl:switchMountain(mapId)
self:invokeEnterMapCallback(mapId)
loadingControl:openSceneCloud()
end)
return true
elseif state==mountainLoadState.loaded then
mountainControl:switchMountain(mapId)
self:invokeEnterMapCallback(mapId)
loadingControl:openSceneCloud()
return true
end
return true
end