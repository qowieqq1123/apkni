

fightManager={}


local instance

local fightCamera

local fightStage={}
local fightStageAsset={}
local fightSceneEffect={}

local csuimgr=CS.CSGUIManager.Instance
local stopEffect=CS.GameInterface.StopEffect
local stagePostion=Vector3.zero

local stageIndex=1
local csEffect=nil

function fightManager.init()
instance=CS.FightUnit.FightManager.GetInstance()
fightCamera=instance.fightCamera
fightStage[1]=instance.fightStage
fightStage[2]=instance.fightSubStage
fightManager.activeStage(1)
stagePostion=instance.transform.position
csEffect=cameraScreenEffect(fightCamera.CameraTransorm)

if api_Available_SetAnimatorEventAction()then
fightCamera:SetAnimatorEventAction(
function(strType)

notifySystem:listenNotify(notifyConfig.fightCameraAnimatorEvent,strType)
end)
end
end

function fightManager.stagePositon()

end

function fightManager.clearStage(removeAllEntity)
fightManager.activeStage(1)
fightModel:closeAllStage()


instance:ClearStage(removeAllEntity)
fightStage[1].transform.localPosition=Vector3.zero
fightStage[2].transform.localPosition=Vector3.zero
fightStageAsset[1]=nil
fightStageAsset[2]=nil
end

function fightManager.getCameraTransform()
return fightCamera.CameraTransorm
end

function fightManager.addEntity(modelID,slots,pos,flipx,animID,scale,callback)
return instance:AddEntity(modelID,slots,pos,flipx,animID,scale,callback)
end

function fightManager.add3DEntity(modelID,pos,rot,scale,callBack)
return instance:Add3DEntity(modelID,pos,rot,scale,callBack)
end

function fightManager.removeEntity(guid)
instance:RemoveEntity(guid)
end

function fightManager.cleanEntity()
instance:CleanEntity()
end

function fightManager.registerEasyTouch(register,onEvent)
instance:RegisterTouch(register,onEvent)
end

function fightManager.setSelectMask(maskArray)
instance:SetSelectMask(maskArray)
end

function fightManager.setSelectEntity(guid)
instance:SetSelectEntity(guid)
end

function fightManager.focusEntity(index,targetOffset,aimOffset,targetMoveSpeed,targetEase,aimEase)
return instance:FocusHolePlace(index,targetOffset,aimOffset,targetMoveSpeed,targetEase,aimEase)
end

function fightManager.focus(targetPos,aimPos,targetMoveSpeed,targetEase,aimEase)
return instance:Focus(targetPos,aimPos,targetMoveSpeed,targetEase,aimEase)
end

function fightManager.preLoadEffect(effectIDList,soundIDList,loadCallback)
if api_Available_PreLoadEffect()then
instance:PreLoadEffect("[Pool]FightEffect",effectIDList,soundIDList,loadCallback,1)
else
if loadCallback then
loadCallback()
end
end
end

function fightManager.clearPreLoad()
if api_Available_CleanCache()then
instance:CleanCache()
end
end

function fightManager.playEffect(id,pos,isLeft,scale)

if not scale then
scale=Vector3.one
end
return instance:PlayEffect(id,pos,isLeft,scale)
end

function fightManager.playCameraEffect(id,pos,isLeft,scale)
if not scale then
scale=Vector3.one
end
return instance:PlayCameraEffect(id,pos,isLeft,scale)
end

function fightManager.playMoveEffect(id,param,srcPos,endPos,onFinish,scale)
if not scale then
scale=Vector3.one
end
instance:PlayMoveEffect(id,param,srcPos,endPos,onFinish,scale)
end


local initOffset=
{
[0]={Vector3.New(0,3,-3.8),Vector3.New(0,-0.6,0)},
[1]={Vector3.New(0,-1.3,-1.35),Vector3.New(0,0.3,2.5)},
[2]={Vector3.New(0,0,0),Vector3.New(0,0,0)},
[3]={Vector3.New(0,-1.3,-4.5),Vector3.New(0,0.3,2.5)},
}




function fightManager.setState(nStateID,index)

index=index or stageIndex
fightStage[index]:SetState(nStateID)
end

function fightManager.setScale(index,localScale)
index=index or stageIndex
fightStage[index].transform.localScale=localScale
end


function fightManager.loadStage(assetbundle,onFinish,index,fadeInTime,fadeOutTime)
index=index or stageIndex
if fightStageAsset[index]==assetbundle then
if onFinish then
onFinish()
end
return false
end
local fin=function()
fightStageAsset[index]=assetbundle
if onFinish then
onFinish()
end
end
fightStage[index]:Load(assetbundle,fadeInTime or 0,fadeOutTime or 0,fin)
return true
end

function fightManager.activeStage(index)
stageIndex=index
end

function fightManager.getActiveStageIndex()
return stageIndex
end

function fightManager.getStageTransform(index)
return fightStage[index].transform
end

function fightManager.rayHitEntity(screenPos)
return instance:RayHitEntity(screenPos)
end

local __TargetOffset=Vector3.New(0,9,-25)
local __AimOffset=Vector3.New(0,0,0)

function fightManager.resetCamera(enable,speed)
if not enable then
fightManager.disableScreenEffect()
end
fightCamera:InitCamera(__TargetOffset,__AimOffset)
fightManager.setCameraActive(enable or false,fightCameraMode.preSelect,speed)
fightManager.stageFadeToColor(0,Color.New(1,1,1,1))
fightManager.resetDotLight(0)
end

function fightManager.resetCameraEx(stageCfg)
local cameraPara=stageCfg.initCamera
if cameraPara then
fightManager.stageFadeToColor(0,Color.New(1,1,1,1))
fightManager.resetDotLight(0)

if next(cameraPara)then
fightManager.initCamera(Vector3.New(cameraPara[1][1],cameraPara[1][2],cameraPara[1][3]),
Vector3.New(cameraPara[2][1],cameraPara[2][2],cameraPara[2][3]),
Vector3.New(cameraPara[3][1],cameraPara[3][2],cameraPara[3][3]),
Vector3.New(cameraPara[4][1],cameraPara[4][2],cameraPara[4][3]),
cameraPara[5])
end
else
fightManager.resetCamera()
fightManager.setCameraActive(true,fightCameraMode.fight)
end
end

function fightManager.initCamera(target,aim,targetMove,aimMove,speed)
fightCamera:InitCamera(target+__TargetOffset-targetMove,aim+__AimOffset-aimMove)
fightCamera:SetCameraActive(true,targetMove,aimMove,speed)
end

function fightManager.setCameraActive(enable,mode,speed)
if enable then
fightManager.getCameraTransform().gameObject:SetActive(true)
end
fightCamera:SetCameraActive(enable,initOffset[mode][1],initOffset[mode][2],speed or-1)
end

function fightManager.setCamera(enable,targetOffset,aimOffset)
fightCamera:SetCameraActive(enable,targetOffset,aimOffset)
end

function fightManager.shakePosition(duration,strength,vibrato,randomness,fadeOut)
fightCamera:ShakePosition(duration,strength,vibrato,randomness,fadeOut)
end

function fightManager.shakeRotation(duration,strength,vibrato,randomness,fadeOut)
fightCamera:ShaderRotation(duration,strength,vibrato,randomness,fadeOut)
end

function fightManager.genImpulse(typo,velocity,am,fre,rand,attack,sustain,decay)
fightCamera:GenImpulse(typo,velocity,am,fre,rand,attack,sustain,decay)
end

function fightManager.setVirtualCameraDamping(weight)
fightCamera:SetVirtualcameraDamping(weight)
end

function fightManager.getScreenPos(worldPos)
return fightCamera:GetScreenPos(worldPos)
end

function fightManager.stageToUIPos(stagePos)
return stagePos


end


function fightManager.setDotLight(duration,pos,srcRadiu,dstRadiu,srcColor,dstColor,srcMaskColor,dstMaskColor)
fightStage[stageIndex]:SetDotLight(duration,pos,pos,srcRadiu,dstRadiu,srcColor,dstColor,srcMaskColor,dstMaskColor)
end

function fightManager.setStageMask(duration,pos,srcRadiu,dstRadiu,srcColor,dstColor)
fightStage[stageIndex]:SetBlackMask(duration,pos,pos,srcRadiu,dstRadiu,srcColor,dstColor)
end

function fightManager.resetDotLight(duration)
fightStage[stageIndex]:Reset(duration)
end

function fightManager.stageFadeToColor(duration,color)
fightStage[stageIndex]:FadeToSceneColor(duration,color)
end

function fightManager.playSceneEffect(stageCfg)
fightManager.clearSceneEffect()
local effect=stageCfg.sceneEffect
if effect then
for i,v in ipairs(effect)do
local handle=fightManager.playEffect(v,fightModel.getWorldCenter()+fBTHelper.posOffset,true,Vector3.one)
fightSceneEffect[handle]=handle
end
end
effect=stageCfg.cameraEffect
if effect then
for i,v in ipairs(effect)do
local handle=fightManager.playCameraEffect(v,Vector3.zero,true,Vector3.one)
fightSceneEffect[handle]=handle
end
end
end

function fightManager.clearSceneEffect()
if next(fightSceneEffect)then
for handle,v in pairs(fightSceneEffect)do
stopEffect(handle)
end
fightSceneEffect={}
end
end

function fightManager.getScreenEffect()
return csEffect
end

function fightManager.disableScreenEffect()
csEffect:disableAllEffect()
end

function fightManager.initCameraEffect(stageCfg)
local effect=stageCfg.screenEffect
if effect then
local func=csEffect.setEffectFunc[effect[1]]
if func then
func(csEffect,effect[2])
end
else
fightManager.disableScreenEffect()
end
end





function fightManager.genDynamicAltlas(abNames,onGenFinish)
if api_Available_ReleaseDynamicAltlas()then
instance:ReleaseDynamicAltlas()
instance:GenDynamicAltlas(abNames,onGenFinish)
end
end

function fightManager.releaseDynamicAtlas()
if api_Available_ReleaseDynamicAltlas()then
instance:ReleaseDynamicAltlas()
end
end


function fightManager.setEntityTroops(guid,spritesABName,num,enterTypo,enterPos)
if api_Available_SetEntityTroops()then
instance:SetEntityTroops(guid,spritesABName,num,enterTypo or 0,enterPos or Vector3.zero)
end
end


function fightManager.setJunZhengLiveProgress(guid,liveRemainPercentity)
if api_Available_SetJunZhengLiveProgress()then
instance:SetJunZhengLiveProgress(guid,liveRemainPercentity)
end
end

function fightManager.enableAdjustAspect(enable)
CS.AppDataModel.SetOption("option.FightUnit.FightCamera.EnableAdjustAspect",enable)
if deviceHelper.getAPILevel()>=48 then
CS.AppDataModel.SetOption("option.CameraAdaptation.EnableAdaptation",enable)
end
end


function fightManager.setCameraFOV(fov)
if api_Available_SetCameraFOV()then
fightCamera:SetCameraFOV(fov)
end
end


function fightManager.setCameraAnimation(nStateID,tBreak)
if api_Available_SetAnimation()then
fightCamera:SetAnimation(nStateID,tBreak)
end
end


function fightManager.getJunZhenSize(guid)
if api_Available_GetJunZhengSize()then
local w,h
return instance:GetJunZhengSize(guid,w,h)
end
return 1,1
end
