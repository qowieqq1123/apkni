local _lastWinParam=nil

function chuanSongZhenController:onEnterWorld(world)
local wCfg=cfgHelper.get1(cfg_worldblocktransportconfig_get,world)
for block,bCfg in pairs(wCfg)do
if worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)then
self:createEntity(world,block)
end
end
end

function chuanSongZhenController:onExitWorld(world)
local wCfg=cfgHelper.get1(cfg_worldblocktransportconfig_get,world)
for block,bCfg in pairs(wCfg)do
if worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)then
self:deleteEntity(world,block)
end
end
end

function chuanSongZhenController:createEntity(world,block)
local unitKey=chuanSongZhenModel:convertUnitKey(world,block)
local config=cfgHelper.get2(cfg_worldblocktransportconfig_get,world,block)
local position=worldPositionConfig:getPosition(world,config.pos)
local luaData={eWorldUnitTpye.CHUANSONGZHEN,world,block}
local isRepaired=chuanSongZhenModel:getFlagBit(world,block)
local model=isRepaired and config.model[2]or config.model[1]
local modelSetting=worldModel:getModelSettings(model,eWorldUnitTpye.CHUANSONGZHEN)
local hudSettings=worldModel:getHUDSetting(config.hud,eWorldUnitTpye.CHUANSONGZHEN)
worldController:pushUnit(unitKey,position,luaData,modelSetting,hudSettings,nil,true)
if isRepaired and config.effect then
worldController:playModelEffect(unitKey,config.effect,Vector3.zero,Vector3.one,nil,true)
end
end

function chuanSongZhenController:deleteEntity(world,block)
local unitKey=chuanSongZhenModel:convertUnitKey(world,block)
worldController:popUnit(unitKey)
end

function chuanSongZhenController:repairEntity(world,block)
local unitKey=chuanSongZhenModel:convertUnitKey(world,block)
local config=cfgHelper.get2(cfg_worldblocktransportconfig_get,world,block)
local modelSetting=worldModel:getModelSettings(config.model[2],eWorldUnitTpye.CHUANSONGZHEN)
worldController:changeUnitModel(unitKey,modelSetting)
if config.effect then
worldController:playModelEffect(unitKey,config.effect,Vector3.zero,Vector3.one,nil,true)
end
worldHUDModel:UpdateHUDByKey(unitKey)
end

function chuanSongZhenController:playEntityEffect(world,block,effect)
local unitKey=chuanSongZhenModel:convertUnitKey(world,block)
worldController:playModelEffect(unitKey,effect,Vector3.zero,Vector3.one,nil,true)
end

function chuanSongZhenController:refreshHUD(world,block)
local unitKey=chuanSongZhenModel:convertUnitKey(world,block)
worldHUDModel:onUpdateHUD(unitKey)
end

function chuanSongZhenController.onWorldBlockDataInited(reInit)
if initProControl.isDone()and worldController:isInWorld()then
chuanSongZhenController:onExitWorld(worldModel.world)
chuanSongZhenController:onEnterWorld(worldModel.world)
end
end

function chuanSongZhenController.onWorldBlockDataChanged(world,block,state)
if state==eWorldBlockState.OPEN then
local wCfg=cfgHelper.get1(cfg_worldblocktransportconfig_get,world)
if wCfg and wCfg[block]then
chuanSongZhenController:createEntity(world,block)
end
end
end

function chuanSongZhenController.onClickObjectInWorld(args)
if args and args[1]==eWorldUnitTpye.CHUANSONGZHEN then
local world=args[2]
local block=args[3]
local cPos=worldController:getCameraPosition()
local minZoom=worldController:getCameraZoomRange_Normal(world)[1]
local key=chuanSongZhenModel:convertUnitKey(world,block)
worldController:stopCameraControl()
worldController:lookAtUnit(key,minZoom,false,function()
worldController:resumeCameraControl()
_lastWinParam={
world=world,
block=block,
height=cPos.y,
}
if UIManager:isActive("UIChuanSongZhenBlockWin")then
UIManager:showWindow("UIChuanSongZhenBlockWin",_lastWinParam)
else
worldController:changeRightView("UIChuanSongZhenBlockWin",_lastWinParam)
end
end)
end
end

function chuanSongZhenController:resumePanel()
if not UIManager:isActive("UIChuanSongZhenBlockWin")and _lastWinParam then
worldController:changeRightView("UIChuanSongZhenBlockWin",_lastWinParam)
end
end