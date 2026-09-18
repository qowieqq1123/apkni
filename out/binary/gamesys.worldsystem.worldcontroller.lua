






local _MODULENAME="worldController"




gameState.addListener(def_table(_MODULENAME))
worldController.name=_MODULENAME


worldController.data={}
worldController.manager=nil

local _this=worldController


local onSceneState={}


function worldController:onAppStart()
worldPositionLibrary:onAppStart()
worldModel:onAppStart()
worldHUDModel:onAppStart()
worldSymbolModel:onAppStart()
worldUnitModel:onAppStart()







local sceneData={
enter=function(o,...)self:onIntoScene(...)end,
leave=function(o,...)self:onExitScene(...)end,
load=function(o,...)self:onLoadScene(...)end,
}
mainControl:regSceneTypo(eSceneType.eWorld,sceneData)

self._listenerPanelFunc=function()
self:listenNeedPanels()
end
notifySystem:listenNotify(notifyConfig.onUIManagerInit,self._listenerPanelFunc)
notifySystem:listenNotify(notifyConfig.endCloud,self.endCloud)
end


function worldController:onEnterState(isReconnet)
worldController:resumeCameraControl()
worldPositionLibrary:onEnterState(isReconnet)
worldModel:onEnterState()
worldHUDModel:onEnterState()
worldSymbolModel:onEnterState()
worldUnitModel:onEnterState()
timeEventController.addNormalTimerHandler(1,self.name,self)
end

function worldController:onPlayerCreate(...)

end


function worldController:onServerDataInitFinish()
worldPositionLibrary:onServerDataInitFinish()
worldModel:onServerDataInitFinish()
worldHUDModel:onServerDataInitFinish()
worldSymbolModel:onServerDataInitFinish()
worldUnitModel:onServerDataInitFinish()
end


function worldController:onLeaveState(isReconnet)

worldController:stopCameraControl()
worldPositionLibrary:onLeaveState(isReconnet)
worldModel:onLeaveState(isReconnet)
worldHUDModel:onLeaveState(isReconnet)
worldSymbolModel:onLeaveState(isReconnet)
worldUnitModel:onLeaveState(isReconnet)

if not isReconnet then
self:clearCheckPanel()
end
timeEventController.removeNormalTimerHandler(1,self.name)
worldPositionLibrary:checkSave()
end


function worldController:onLostConnection()
if self:isInWorld()then
self.manager:PauseMoveUpdate()
end
end

function worldController:onReConnection()
if self:isInWorld()then
self.manager:ResumeMoveUpdate()
self:resetLeftView()
self:resetRightView()
end
end

function worldController:onProtocolReq()

if self:isInWorld()then
if worldController:checkCameraState(eWorldCameraState.Normal)then
self:showPanel()


end
end
end

function worldController:onNormalUpdate(delay)
worldPositionLibrary:checkSave()
end









function worldController.onClickUnit(args)


if fullScreenUI.activeUI==nil or fullScreenUI.isActiveBaseFull()then
notifySystem:postNotify(notifyConfig.onClickObjectInWorld,args)
end
end

function worldController:clickUnit(unitKey)
local unitData=self:getUnit(unitKey)
if unitData then
self.onClickUnit(unitData.LuaData)
end
end

function worldController.rayHitEntity(screenPos)
if _this.manager then
return _this.manager:RayHitEntity(screenPos)
end
end

function worldController.onTipsRange(aspect,state)

if systemModel.isOpen(SYSTEM_DEFINE.eWorldMap)and not worldExperienceModel:checkScene()then
local bitArray=mathHelper.convertBitToArray(aspect,4)
local world=worldModel.world
if world then
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,world)
local nearWorlds=worldCfg.nearWorld
for i,v in ipairs(bitArray)do
local near=nearWorlds[i]
if near and v then
local check=worldBlockModel:checkWorldEnterLimit(near)
if check then
UIManager:callWindowFunc("UIWorldWin","onEdgeTips",i,state)
return
end
end
end
end
end
end

function worldController.onOutRange(aspect)

if systemModel.isOpen(SYSTEM_DEFINE.eWorldMap)and not worldExperienceModel:checkScene()and worldController:checkCameraState(eWorldCameraState.Normal)then
local bitArray=mathHelper.convertBitToArray(aspect,4)
local world=worldModel.world
if world then
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,world)
local nearWorlds=worldCfg.nearWorld
for i,v in ipairs(bitArray)do
local near=nearWorlds[i]
if near and v then
local check=worldBlockModel:checkWorldEnterLimit(near)
if check then
worldController:enterWorld(near)
return
end
end
end
end
end
end




function worldController:getMainCityPoint(world,block)
local worldID=world or worldModel.world
if block and chuanSongZhenModel:getFlagBit(world,block)then
local cszCfg=cfgHelper.get2(cfg_worldblocktransportconfig_get,world,block)
if cszCfg then
return mathHelper.convertArrayToVector(cszCfg.taskPos)
end
end
local pos=cfgHelper.get2(cfg_worldconfig_get,worldID,"mainCityPos")
return mathHelper.convertArrayToVector(pos)
end



function worldController:getMainCityPosition(world,block)
local worldID=world or worldModel.world
if block and chuanSongZhenModel:getFlagBit(world,block)then
local cszCfg=cfgHelper.get2(cfg_worldblocktransportconfig_get,world,block)
if cszCfg then
local position=worldPositionConfig:getPosition(worldID,cszCfg.taskPos)
return position
end
end
local pos=cfgHelper.get2(cfg_worldconfig_get,worldID,"mainCityPos")
local position=worldPositionConfig:getPosition(worldID,pos)
return position
end

function worldController:lookAtCity(world,block,height)







local pos=self:getMainCityPoint(world,block)
worldController:lookAtPoint(pos,height)
end





function worldController:registerSceneState(state,order,callBack)
table.checkCreateSubTable(onSceneState,{state,order})
table.insert(onSceneState[state][order],callBack)
end



function worldController:doSceneState(state)
local list=onSceneState[state]
for i,v in pairsBySortKey(list)do
for j,w in ipairs(v)do
xpcall(w,function(err)
loggerUtil.logWarnFMT('state:{0}, order:{1}',state,i)
loggerUtil.logErrFMT(err)
end)
end
end
end

function worldController.onCameraBlockChange(sight,horizontal)

notifySystem:postNotify(notifyConfig.onWorldCameraBlockChanged,sight,horizontal)
end


function worldController:isInWorld()
return self.manager~=nil and worldModel.world~=nil
end


function worldController:getManager()
return self.manager
end

function worldController:enterStoryMode(closeTips)

self.isInStoryMode=true
worldController:stopCameraControl()
baseFullScreenUI:openMain(false)

UIManager:showWindow("UIWorldHUDWin")
worldHUDModel:beginInterruptModel()














if closeTips~=false then
UIManager.enableTopHourceTips(false)

UIManager.closeTopHourceLamp()
end




end

function worldController:leaveStoryMode()

if self.isInStoryMode then
self.isInStoryMode=false
worldController:resumeCameraControl()
UIManager.clearTipsFlag()
worldHUDModel:endInterruptModel()

baseFullScreenUI:openMain(true)
end





end

function worldController:checkNoticiateBlockOpen()
local cfg=cfgHelper.get2(cfg_worldglobalconfig_get,"noviciateBlock","value")
return worldBlockModel:checkBlockState(cfg[1],cfg[2],eWorldBlockState.OPEN)
end


function worldController:stopDynamicExpression()
worldTaskModel:quitWorldTask(worldModel.world)
worldLeaderController.onExitWorldSceneEvent()
worldSceneryController:stopMove()
end


function worldController:resumeDynamicExpression()
worldTaskModel:restartWorldTask(worldModel.world)
worldLeaderController.onEnterWorldSceneEvent()
worldSceneryController:resumeMove()
end
