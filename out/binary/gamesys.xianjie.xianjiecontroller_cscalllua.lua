







function xianjieController.callLuaFunc(funcname,...)
local func=xianjieController[funcname]
if func then
func(...)
end
end

function xianjieController.ON_MAP_LOAD_FINISH(ischange)
xianjieController:onIntoScene_finish(ischange)
end

function xianjieController.ON_CAMERA_ZOOM_MAX()
notifySystem:postNotify(notifyConfig.onXianJieCameraZoomMax)
end

function xianjieController.ON_CAMERA_ZOOM_MIN()
notifySystem:postNotify(notifyConfig.onXianJieCameraZoomMin)
end

function xianjieController.ON_CAMERA_MOVE_END()
notifySystem:postNotify(notifyConfig.onXianJieCameraMoveEnd)
end

function xianjieController.ON_CAMERA_FOLLOW_OUTSIZE()
xianjieModel:setCameraFollow(nil)
end

function xianjieController.ON_CAMERA_CHANGE_LOD(lodLevel)
xianjieController.curlodLevel=lodLevel
notifySystem:postNotify(notifyConfig.onXianJieChangeLOD,lodLevel)
end