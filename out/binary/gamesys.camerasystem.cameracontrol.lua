cameraControl={}

function cameraControl.getCameraType()
local inMijing=MysteryModel:is_in_mystery()
local inFight=fightModel:haveBattleShow()
if inFight then
return CAMERA_TYPE.eFight
elseif inMijing then
return CAMERA_TYPE.eMiJing
else
local sceneType=mainControl:getSceneType()
if sceneType==eSceneType.eZongmen then
return CAMERA_TYPE.eHome
elseif sceneType==eSceneType.eWorld then
return CAMERA_TYPE.eWorld
elseif sceneType==eSceneType.eAirGame then
return CAMERA_TYPE.eAirGame
elseif sceneType==eSceneType.eXianJie then
return CAMERA_TYPE.eXianJie
else
loggerUtil.debugErrFMT('没找到当前摄像机')
end
end
end


function cameraControl.getCameraTransformByType(cameraType)
if cameraType==CAMERA_TYPE.eFight then
return fightManager.getCameraTransform()
elseif cameraType==CAMERA_TYPE.eHome then
return _MapManager.GetCameraTransform()
elseif cameraType==CAMERA_TYPE.eWorld then
return worldController:getCameraTransform()
elseif cameraType==CAMERA_TYPE.eMiJing then
return mysteryCameraController.getBgCamera()
elseif cameraType==CAMERA_TYPE.eAirGame then
return airMapSystem:getCamera()
elseif cameraType==CAMERA_TYPE.eXianJie then
return xianjieController:getCameraTransform()
end
end

function cameraControl.getCameraTransform()
local cameraType=cameraControl.getCameraType()
if cameraType then
return cameraControl.getCameraTransformByType(cameraType),cameraType
end
end

function cameraControl.setCameraActive(active)
local camera=cameraControl.getCameraTransform()
if camera then
camera.gameObject:SetActive(active)
end
end


function cameraControl.isSpecialCamera()
local cameraType=cameraControl.getCameraType()
return cameraType==CAMERA_TYPE.eHome or
cameraType==CAMERA_TYPE.eWorld or
cameraType==CAMERA_TYPE.eXianJie
end




function cameraControl.setBeautifyTone(enableBeautify,vibarance,tint,contrast,brightness)
if api_Available_SetBeautifyTone()then
CS.GameInterface.SetBeautifyTone(enableBeautify,vibarance,tint,contrast,brightness)
end
end