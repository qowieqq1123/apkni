






UISceneActor={_playerLoaders={}}

local _actorScene=CS.UIActorScene
local _ShowScene=_actorScene.ShowScene
local _HideScene=_actorScene.HideScene
local _HideActor=_actorScene.HideModel
local _HideStage=_actorScene.HideStage
local _SetCameraAngleX=_actorScene.SetCameraAngleX
local _ChangeModel=_actorScene.ChangeModel
local _ChangeModelAndIdle=_actorScene.ChangeModelAndIdle
local _ChangeModelAndPlaySkill=_actorScene.ChangeModelAndPlaySkill
local _LoadWeapon=_actorScene.LoadWeapon
local _LoadAttachment=_actorScene.LoadAttachment
local _SetStage=_actorScene.SetStage
local _SetStageOffset=_actorScene.SetStageOffset
local _ShowStage=_actorScene.ShowStage
local _SetAnimation=_actorScene.SetAnimation
local _SetPose=_actorScene.SetPose
local _PlayActorEffect=_actorScene.PlayActorEffect
local _StopActorEffect=_actorScene.StopActorEffect
local _RemoveAllActorEffect=_actorScene.RemoveAllActorEffect
local _AddBuff=_actorScene.AddBuff
local _RemoveBuff=_actorScene.RemoveBuff
local _HideSceneAndDestoryModel=_actorScene.DestoryModelAndHide
local _UseSkill=_actorScene.UseSkill
local _UseSkillAlone=_actorScene.UseSkillAlone
local _SetRotate=_actorScene.SetRotate
local _HideByIndex=_actorScene.HideByIndex
local _GetBackGround=_actorScene.GetBackGroundObj
local _SetRotateSpeed=_actorScene.SetRotateSpeed
local _EnableRotation=_actorScene.EnableRotation
local _SetBackGroundOffset=_actorScene.SetBackGroundOffset
local _SetClipPlaneOffset=_actorScene.SetClipPlaneOffset
local _DestoryStage=_actorScene.DestoryStage
local _HideByLayer=_actorScene.HideByLayer
local _ChangeOther=_actorScene.ChangeOther
local _SetOther=_actorScene.SetOther
local _HideOther=_actorScene.HideOther
local _ClearOthers=_actorScene.ClearOthers
local _SetCameraFOV=_actorScene.SetCameraFOV
local _EnableHighEffectModel=_actorScene.EnableHighEffectModel
local _SetLineRenderer=_actorScene.SetLineRenderer
local _EnableLineRenderer=_actorScene.EnableLineRenderer
local _SetLineRendererByHP=_actorScene.SetLineRendererByHP
local _GetEffectPosByHP=_actorScene.GetEffectPosByHP
local _LoadStage=_actorScene.LoadStage
local _SetLightAndStageActive=_actorScene.SetLightAndStageActive
local _SnapUIActorPlayerToScreenPos=_actorScene.SnapUIActorPlayerToScreenPos
local _SetAllRootParam=_actorScene.SetAllRootParam
local _SetPostProcessEnable=_actorScene.EnablePostProcessingProfile
local _ShowEffect=_actorScene.ShowEffect
local _LoadParentNode=_actorScene.LoadParentNode
local _ResetAllRoot=_actorScene.ResetAllRoot
local _CS__ChangeModel=_ChangeModel
local _SetActorTableOffset=_actorScene.SetActorTableOffset
local _SetActorFBGOffset=_actorScene.SetActorFBGOffset
local _RemoveActorRootEffect=_actorScene.RemoveActorRootEffect
local _PauseHUD=_actorScene.PauseHUD
local _ResumeHUD=_actorScene.ResumeHUD

function _ChangeModel(...)

return _CS__ChangeModel(...)
end

local IsOpenCameraGrayAPI=nil

local actorPlayerType={
mainActorPlayer=0,
commonActorPlayer=1,
plotActorPlayer=255,
}
UISceneActor.ActorPlayerType=actorPlayerType



function UISceneActor:GetActorPara(modelID)
local cfg=cfg_charactermodelconfig_get(modelID)
if cfg~=nil and cfg.UIActorPara~=nil then
return cfg.UIActorPara
end

return{0,0,1,0,0}
end

function UISceneActor:GetActorParaSpecial(modelID)
local cfg=cfg_charactermodelconfig_get(modelID)
if cfg~=nil and cfg.UIActorPara1~=nil then
return cfg.UIActorPara1
end

return{0,0,1,0,0}
end

function UISceneActor:GetActorUIMirrorOffset(modelID)
local cfg=cfg_charactermodelconfig_get(modelID)
if cfg~=nil and cfg.UIMirrorOffset~=nil then
return cfg.UIMirrorOffset
end

return 0.1
end


function UISceneActor:GetActorGlowUIInfoByActor(modelID)
local cfg=cfg_characterinuidisplayconfig_get(modelID)
if cfg==nil or cfg.GLOWUIInfo==nil then
local str=cfg==nil and string.format("Not Find config At CharacterInUIDisplayConfig modelID-----> %s",modelID)
or string.format("Not Find GlowUIInfo At CharacterInUIDisplayConfig modelID-----> %s",modelID)
logErr(str)
return-1
end
return cfg.GLOWUIInfo or-1
end

function UISceneActor:SetGlowIndex(glowIndex)
_SetPostProcessEnable(glowIndex)
end


function UISceneActor:GetActorConfigByUISystem(modelID,sysIndex)
local cfg=cfg_characterinuidisplayconfig_get(modelID)
if cfg==nil then
logErr("Not Find config At CharacterInUIDisplayConfig modelID-----> ",modelID)
return{1,1,1,1,1,1}
end
if sysIndex==GameConfig.ActorDisplayToUISystem.CreateRoleUIInfo then
return cfg.CreateRoleUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.RoleUIInfo then
return cfg.RoleUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.RoleFacadeUIInfo then
return cfg.RoleFacadeUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.RoleSkillUIInfo then
return cfg.RoleSkillUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.AdvanceUIInfo then
return cfg.AdvanceUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.AwakenUIInfo then
return cfg.AwakenUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.RankUIInfo then
return cfg.RankUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.LookUIInfo then
return cfg.LookUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.ItemShowUIInfo then
return cfg.OpenSevenUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.TianShuUIInfo then
return cfg.TianShuUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.HaloShowUIInfo then
return cfg.HaloUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.ShenQiUIInfo then
return cfg.ShenQiUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.ShenQiUpUIInfo then
return cfg.ShenQiUpUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.YuanFenBaoXiaUIInfo then
return cfg.YuanFenBaoXiaUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.WedLeftUIInfo then
return cfg.WedLeftUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.WedRightUIInfo then
return cfg.WedRightUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.SpecialSkinUpStarUIInfo then
return cfg.SpecialSkinUpStarUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.LingYiUIInfo then
return cfg.AdvanceUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.FootMarkUIInfo then
return cfg.FootMarkUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.PetPicUIInfo then
return cfg.PetPicUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.BagUIInfo then
return cfg.BagUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.JinJieUpGradeTipUIInfo then
return cfg.JinJieUpGradeTipUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.JinJieOpenSysTipUIInfo then
return cfg.JinJieOpenSysTipUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.CallChongWuUIInfo then
return cfg.CallChongWuUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.XuanTongUIInfo then
return cfg.XuanTongUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.TQBOSSUIInfo then
return cfg.TQBOSSUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.XinMoBOSSUIInfo then
return cfg.XinMoBOSSUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.AdditionUIInfo then
return cfg.AdditionUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.SpectralUIInfo then
return cfg.SpectralUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.KingModelUIInfo then
return cfg.KingModelUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.OutShowSuitUIInfo then
return cfg.OutShowSuitUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.ShenPuFbUIInfo then
return cfg.ShenPuFbUIInfo
elseif sysIndex==GameConfig.ActorDisplayToUISystem.CCAwakeUIInfoMain then
return cfg.CCAwakeUIInfoMain
elseif sysIndex==GameConfig.ActorDisplayToUISystem.CCAwakeUIInfoPart then
return cfg.CCAwakeUIInfoPart
end

return cfg.DefaultUIInfo
end

function UISceneActor:GetBackGroundOffsetByUISystem(sysIndex)
if sysIndex==2 then
return cfg_miscconfig_get("RoleUIInfoOffset")
elseif sysIndex==3 then
return cfg_miscconfig_get("RoleFacadeUIInfoOffset")
elseif sysIndex==5 then
return cfg_miscconfig_get("AdvanceUIInfoOffset")
elseif sysIndex==6 then
return cfg_miscconfig_get("AwakenUIInfoOffset")
end
return nil
end


function UISceneActor:GetActorHoldSpeed(modelID)
local cfg=cfg_characterinuidisplayconfig_get(modelID)
return cfg and cfg.UIModelHoldSpeed or 0
end


function UISceneActor.GetActorRotationUnlockTime(modelID)
local cfg=cfg_characterinuidisplayconfig_get(modelID)
return cfg and cfg.UIRotateUnlockTime or 0
end


function UISceneActor:GetActorCameraFOVConfig(modelID,sysIndex)
local cfg=cfg_characterinuidisplayconfig_get(modelID)
if cfg==nil then
return 30
end

local fov=nil
if sysIndex==2 then
fov=cfg.RoleUICameraFOV
elseif sysIndex==3 then
fov=cfg.RoleFacadeUICameraFOV
elseif sysIndex==6 then
fov=cfg.AwakenUICameraFOV
end

if fov==nil then
fov=40
end
return fov
end


































function UISceneActor:ShowPlayer(backgroundIndex,posID,animationID,systemIndex,idleID,fashionID)
local bodyId=CommonLogic.GetUIModelId(playerControl.player:get_modelid())
local weaponId=CommonLogic.GetUIModelId(playerControl.player:get_weapon())
local wingId=playerControl.player:get_wing()
local cloakId=playerControl.player:get_pifeng2()

local config=self:GetActorConfigByUISystem(bodyId,systemIndex or 0)
local cameraAngleX=config[4]or 0
self:SetCameraFOVByUISystem(bodyId,systemIndex)
self:ShowScene(2000)
self:SetBackGroundOffset(backgroundIndex,systemIndex)

self:ShowActorAndWing(0,bodyId,weaponId,wingId,posID,animationID,systemIndex,idleID)
self:ChangeCloak(0,cloakId)
self:SetRotateSpeed(0,self:GetActorHoldSpeed(bodyId))
end

function UISceneActor:ShowPlayerOffset(backgroundIndex,posID,animationID,enableRotation,xRotateAngle,offsetX,offsetY,offsetZ,systemIndex)
local bodyId=playerControl.player:get_modelid()
local weaponId=playerControl.player:get_weapon()
local wingId=playerControl.player:get_wing()
local cloakId=playerControl.player:get_pifeng2()

self:SetCameraFOVByUISystem(bodyId,systemIndex)
self:ShowScene(2000)
self:SetBackGroundOffset(backgroundIndex,systemIndex)
self:ShowActorAndWing(0,bodyId,weaponId,wingId,posID,animationID,systemIndex)
self:ChangeCloak(0,cloakId)
local speed=0
if enableRotation then
speed=self:GetActorHoldSpeed(bodyId)
end
self:SetRotateSpeed(0,speed)
end

function UISceneActor:ShowPlayerByStage(backgroundIndex,posID,animationID,stagePath,systemIndex)
local bodyId=playerControl.player:get_modelid()
local weaponId=playerControl.player:get_weapon()
local wingId=playerControl.player:get_wing()
local cloakId=playerControl.player:get_pifeng2()
local modelCfg=self:GetActorConfigByUISystem(bodyId,systemIndex or 0)
local FileIndex=self:GetActorGlowUIInfoByActor(bodyId)
self:SetCameraFOVByUISystem(bodyId,systemIndex)
self:ShowScene(backgroundIndex,2000)
self:SetBackGroundOffset(backgroundIndex,systemIndex)
stagePath=stagePath or''
self:ShowActorOffsetAndLoadStage(0,bodyId,weaponId,wingId,posID,animationID,modelCfg[1],modelCfg[2],modelCfg[3],0,stagePath,systemIndex)
self:ChangeCloak(0,cloakId)
_SetRotate(0,modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)
_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))
_SetPostProcessEnable(FileIndex)
self:SetRotateSpeed(0,self:GetActorHoldSpeed(bodyId))
end

function UISceneActor:ShowPlayerOffsetByStage(posID,animationID,offsetX,offsetY,offsetZ,yRotate,stagePath,systemIndex)
if playerControl.player==nil then return end
local bodyId=playerControl.player:get_modelid()
local weaponId=playerControl.player:get_weapon()
local wingId=playerControl.player:get_wing()

stagePath=stagePath or''
self:SetStageOffset(0,stagePath,Vector3(offsetX,offsetY,offsetZ))

local backgroundID=2000
local systemIndex=systemIndex or 0
local modelCfg=self:PrepareScene(6,backgroundID,bodyId,systemIndex)
local FileIndex=self:GetActorGlowUIInfoByActor(bodyId)

local player=self:getPlayer(0)


if self.currentSystemIndex~=systemIndex then
player:unload()
else


player:unloadModel()
end
self.currentSystemIndex=systemIndex

_HideActor(false)

player:setActorRootActive(true)

player:changeBody(bodyId)

player:loadWeapon(weaponId)

player:loadWing(wingId)



player:SetAnimation(animationID)

player:SetPose(posID)

player:snapToScreenPos(nil,3.4)

player:setRotate(0,yRotate,0)

player:setRotateSpeed(self:GetActorHoldSpeed(bodyId))

_SetAllRootParam(modelCfg[4]or 0,Vector3(offsetX or 0,offsetY or 0,offsetZ or 0))

_SetPostProcessEnable(FileIndex)

self:SetActorClipPlaneOffset(bodyId)
end


function UISceneActor:ShowPlayerScene(backgroundIndex,systemIndex,fashionID)
self:SetCameraIsGray(false)

local bodyId=playerControl.player:get_modelid()
local weaponId=playerControl.player:get_weapon()
local wingId=playerControl.player:get_wing()

local config=self:GetActorConfigByUISystem(bodyId,systemIndex or 0)
local cameraAngleX=config[4]or 0
self:ShowScene(2000)
self:SetBackGroundOffset(backgroundIndex,systemIndex)
self:LoadActorTable(0,true,systemIndex)
end





function UISceneActor:ShowNormalScene()
self:ShowScene(2000)
end


function UISceneActor:ShowScene(backgroundID)
local backgroundAssetBundleName="stage/m9stage/stage/m9_map305_c.ab"
local effectAssetBundleName=""
local onSceneReadyCallback=function(what)
if what==1 then
_SetLightAndStageActive(true);
end
end

if backgroundID~=0 or backgroundID~=nil then
local cfg=cfg_mubutableconfig_get(backgroundID)
if cfg~=nil and next(cfg)then
backgroundAssetBundleName=cfg.BackGroundABName or backgroundAssetBundleName
effectAssetBundleName=cfg.EffectABName or effectAssetBundleName
end
end

_LoadStage(backgroundAssetBundleName,effectAssetBundleName,onSceneReadyCallback)
end


function UISceneActor:ShowActor(index,modelId,weaponId,posID,animationID,systemIndex)
self:SetCameraIsGray(false)
local modelCfg=self:GetActorConfigByUISystem(modelId,systemIndex or 0)
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)
self:SetCameraFOVByUISystem(modelId,systemIndex)
_ChangeModel(index,modelId,weaponId,posID,animationID,0,0,0,0)
_SetRotate(index,modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)
self:snapUIActorPlayerToScreenPos(index,nil,3.4)
_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))
_SetPostProcessEnable(FileIndex)
self:SetRotateSpeed(index,self:GetActorHoldSpeed(modelId))

self:SetActorClipPlaneOffset(modelId)
end


function UISceneActor:ShowActorAndWing(index,modelId,weaponId,wingId,posID,animtiaonID,systemIndex,idleID,backgroundID)

local modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end
if modelconf.ShowID then
modelId=modelconf.ShowID
modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end
end
local backgroundID=backgroundID or 2000
local systemIndex=systemIndex or 0
local modelCfg=self:PrepareScene(6,backgroundID,modelId,systemIndex)
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)

local playerIndex=index or 0
local player=self:getPlayer(playerIndex)


if self.currentSystemIndex~=systemIndex then
player:unload()
else


player:unloadModel()
end
self.currentSystemIndex=systemIndex

idleID=idleID or modelCfg[8]or 0



_HideActor(false)

player:setActorRootActive(true)

player:changeBody(modelId)

player:loadWeapon(weaponId)

player:loadWing(wingId)



player:SetAnimation(animtiaonID)

player:SetPose(posID)

player:SetIdleID(idleID)

player:snapToScreenPos(nil,3.4)

player:setRotate(modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)

player:setRotateSpeed(self:GetActorHoldSpeed(modelId))

_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))

_SetPostProcessEnable(FileIndex)

self:SetActorClipPlaneOffset(modelId)
end


function UISceneActor:ShowActorAndLoadStageWithoutBG(index,modelId,weaponId,wingId,posID,animationID,backgroundID,systemIndex)
local modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end
if modelconf.ShowID then
modelId=modelconf.ShowID
modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end
end

local backgroundID=backgroundID or 2000
local modelCfg=self:PrepareScene(6,backgroundID,modelId,systemIndex or 0)
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)

local playerIndex=index
local player=self:getPlayer(index)


if self.currentSystemIndex~=systemIndex then
player:unload()
else


player:unloadModel()
end
self.currentSystemIndex=systemIndex


_HideActor(false)

player:setActorRootActive(true)

player:changeBody(modelId)

player:loadWeapon(weaponId)

player:loadWing(wingId)

player:loadTable(false,systemIndex)

player:runAnimator(animationID,posID)


player:snapToScreenPos(nil,3.4)

player:setRotate(modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)

player:setRotateSpeed(self:GetActorHoldSpeed(modelId))

_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))

_SetPostProcessEnable(FileIndex)
end


function UISceneActor:ShowActorOffsetAndLoadStage(index,modelId,weaponId,wingId,posID,animationID,backgroundID,systemIndex)
local modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end
if modelconf.ShowID then
modelId=modelconf.ShowID
modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end
end

local backgroundID=backgroundID or 2000
local modelCfg=self:PrepareScene(6,backgroundID,modelId,systemIndex or 0)
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)

local playerIndex=index
local player=self:getPlayer(index)


if self.currentSystemIndex~=systemIndex then
player:unload()
else


player:unloadModel()
end
self.currentSystemIndex=systemIndex


_HideActor(false)

player:setActorRootActive(true)

player:changeBody(modelId)

player:loadWeapon(weaponId)

player:loadWing(wingId)

local tableId=backgroundID or 2000
local tableID=RoleFashionData:GetOnFashion(GameConfigM9.ItemType.itFashion_Background);
player:loadTable(tableID>0,systemIndex)

player:runAnimator(animationID,posID)


player:snapToScreenPos(nil,3.4)

player:setRotate(modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)

player:setRotateSpeed(self:GetActorHoldSpeed(modelId))

_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))

_SetPostProcessEnable(FileIndex)
end


function UISceneActor:ShowMultiActorOffsetAndLoadStage(index,modelId,weaponId,wingId,posID,animationID,offsetX,offsetY,offsetZ,yRotation,stagePath,IsMultiModel)
self:SetCameraIsGray(false)
local modelCfg=self:GetActorConfigByUISystem(modelId,0)
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)
self:SetCameraFOVByUISystem(modelId,-1)
self:ResetAllRoot()

local flag=((IsMultiModel~=nil)and(IsMultiModel==true))
if flag then
_ChangeModel(index,modelId,weaponId,wingId,posID,animationID,offsetX,offsetY,offsetZ,yRotation,stagePath,IsMultiModel)
else
IsMultiModel=false
_ChangeModel(index,modelId,weaponId,wingId,posID,animationID,0,0,0,yRotation,stagePath,IsMultiModel)
end
_SetRotate(index,0,yRotation,0)
if flag then
_SetAllRootParam(0,Vector3(0,0,0))
else
_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))
end
_SetPostProcessEnable(FileIndex)
self:SetRotateSpeed(index,self:GetActorHoldSpeed(modelId))

self:SetActorClipPlaneOffset(modelId)
end


function UISceneActor:ShowActorRotateAndLoadStage(index,modelId,weaponId,wingId,posID,animationID,yRotate,stagePath,systemIndex,IsMultiModel)
self:SetCameraIsGray(false)
local IsMulti=IsMultiModel~=nil and IsMultiModel or false
local modelCfg=self:GetActorConfigByUISystem(modelId,systemIndex or 0)
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)
self:SetCameraFOVByUISystem(modelId,systemIndex)
_ChangeModel(index,modelId,weaponId,wingId,posID,animationID,modelCfg[1],modelCfg[2],modelCfg[3],yRotate,stagePath,IsMulti)
_SetRotate(index,0,yRotate,0)
_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))
_SetPostProcessEnable(FileIndex)
self:SetRotateSpeed(index,self:GetActorHoldSpeed(modelId))

self:SetActorClipPlaneOffset(modelId)
end


function UISceneActor:ShowActorScenePlayAnimation(backgroundIndex,modelId,weaponId,wingId,posID,animationID,systemIndex)
local modelCfg=self:GetActorConfigByUISystem(modelId,systemIndex or 0)
local xCameraRotate=modelCfg[4]or 0

self:SetCameraFOVByUISystem(modelId,systemIndex)
self:ShowScene(2000)
self:SetBackGroundOffset(backgroundIndex,systemIndex)
self:ShowActorAndWing(0,modelId,weaponId,wingId,posID,animationID,systemIndex)
self:SetRotateSpeed(0,self:GetActorHoldSpeed(modelId))
end


function UISceneActor:ShowActorSceneOffset(backgroundIndex,modelId,weaponId,wingId,offsetX,offsetY,offsetZ,enableRotation,systemIndex)
local modelCfg=self:GetActorConfigByUISystem(modelId,systemIndex or 0)
local xCameraRotate=modelCfg[4]or 0

self:SetCameraFOVByUISystem(modelId,systemIndex)
self:ShowScene(2000)
self:SetBackGroundOffset(backgroundIndex,systemIndex)
self:ShowActorAndWing(0,modelId,weaponId,wingId,1,0,systemIndex)

local speed=0
if enableRotation then
speed=self:GetActorHoldSpeed(modelId)
end
self:SetRotateSpeed(0,speed)
end


function UISceneActor:ShowActorSceneAndLoadStage(backgroundIndex,index,modelId,weaponId,wingId,posID,animationID,stagePath,systemIndex,IsMultiModel)
self:SetCameraIsGray(false)

local modelCfg=self:GetActorConfigByUISystem(modelId,systemIndex or 0)
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)
local IsMulti=IsMultiModel~=nil and IsMultiModel or false
local animation=animationID==0 and modelCfg[8]
self:SetCameraFOVByUISystem(modelId,systemIndex)
self:ShowScene(2000)
self:SetBackGroundOffset(backgroundIndex,systemIndex)
_ChangeModel(index,modelId,weaponId,wingId,posID,animation or animationID,modelCfg[1],modelCfg[2],modelCfg[3],0,stagePath,IsMulti)
_SetRotate(index,modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)
self:snapUIActorPlayerToScreenPos(index,nil,3.4)
_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))
_SetPostProcessEnable(FileIndex)
self:SetRotateSpeed(index,self:GetActorHoldSpeed(modelId))

self:SetActorClipPlaneOffset(modelId)
end

function UISceneActor:ShowBaseActorScene(backgroundIndex,index,modelId,systemIndex)
self:SetCameraIsGray(false)

local modelCfg=self:GetActorConfigByUISystem(modelId,systemIndex or 0)
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)
self:SetCameraFOVByUISystem(modelId,systemIndex)
self:ShowScene(2000)
self:SetBackGroundOffset(backgroundIndex,systemIndex)
_ChangeModel(index,modelId,1,0,modelCfg[1],modelCfg[2],modelCfg[3],0)
_SetRotate(index,modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)
_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))
_SetPostProcessEnable(FileIndex)
self:SetRotateSpeed(index,self:GetActorHoldSpeed(modelId))

self:SetActorClipPlaneOffset(modelId)
end

function UISceneActor:ShowBaseActorSceneOffset(backgroundIndex,index,modelId,xRotateAngle,offsetX,offsetY,offsetZ,enableRotation,systemIndex)
self:SetCameraIsGray(false)

self:ShowScene(2000)
self:SetBackGroundOffset(backgroundIndex,systemIndex)
local modelCfg=self:GetActorConfigByUISystem(modelId,systemIndex or 0)
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)
self:SetCameraFOVByUISystem(modelId,systemIndex)
_ChangeModel(index,modelId,1,0,modelCfg[1],modelCfg[2],modelCfg[3],0)
_SetRotate(index,modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)
_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))
_SetPostProcessEnable(FileIndex)
local speed=0
if enableRotation then
speed=self:GetActorHoldSpeed(modelId)
end
self:SetRotateSpeed(index,speed)

self:SetActorClipPlaneOffset(modelId)
end


function UISceneActor:ShowActorOffset(index,modelId,weaponId,wingId,posID,animationID,offsetX,offsetY,offsetZ,yRotation)
self:SetCameraIsGray(false)
local modelCfg=self:GetActorConfigByUISystem(modelId,0)
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)
self:SetCameraFOVByUISystem(modelId,-1)
_ChangeModel(index,modelId,weaponId,wingId,posID,animationID,offsetX,offsetY,offsetZ,yRotation)
_SetRotate(index,0,yRotation,0)
_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))
_SetPostProcessEnable(FileIndex)
self:SetRotateSpeed(index,self:GetActorHoldSpeed(modelId))

self:SetActorClipPlaneOffset(modelId)
end

function UISceneActor:HideActor(isHide)
_HideActor(isHide)
end


function UISceneActor:ClearScene()
_HideScene()
end

function UISceneActor:HideStage()
_HideStage()
end


function UISceneActor:HideSceneAndDestoryModel(indexArray)
for _,index in ipairs(indexArray)do
self:clearPlayerLoader(index)
end
_HideSceneAndDestoryModel(indexArray)
end

function UISceneActor:clearPlayerLoader(index)
self._playerLoaders[index]=nil
end


function UISceneActor:DestoryStage(indexArray)
_DestoryStage(indexArray)
end


function UISceneActor:PauseHUD()
_PauseHUD()
end


function UISceneActor:ResumeHUD()
_ResumeHUD()
end





function UISceneActor:ShowActorInSkill(backgroundIndex,posID,animationID)
local bodyId=playerControl.player:get_modelid()
local weaponId=playerControl.player:get_weapon()
local wingId=playerControl.player:get_wing()

local cameraAngleX=self:GetActorConfigByUISystem(bodyId,4)[4]or 0
self:SetCameraFOVByUISystem(bodyId,4)
self:ShowScene(2000)
self:SetBackGroundOffset(backgroundIndex,4)
self:ShowActorAndWing(0,bodyId,weaponId,wingId,posID,animationID,4)
self:SetRotateSpeed(0,self:GetActorHoldSpeed(bodyId))
end


function UISceneActor:ShowActorInGoldBody(modelId,skillId,buffId,offset)
local bodyId=modelId
local weaponId=playerControl.player:get_weapon()
local wingId=playerControl.player:get_wing()

local backgroundIndex=0
local posID=0
local animationID=0

self:SetCameraFOVByUISystem(bodyId,4)
self:ShowScene(2000)
self:SetBackGroundOffset(backgroundIndex,4)
self:ShowActorAndWing(0,bodyId,weaponId,wingId,posID,animationID,4)
self:SetRotateSpeed(0,self:GetActorHoldSpeed(bodyId))
_SetAllRootParam(0,Vector3(offset.x or 0,offset.y or 0,offset.z or 0))
self:UseSkill(0,skillId)
self:AddBuff(buffId)
end


function UISceneActor:ShowActorInXinMo(backgroundIndex)
local bodyId=playerControl.player:get_modelid()
local weaponId=playerControl.player:get_weapon()
local wingId=playerControl.player:get_wing()
local modelCfg=self:GetActorConfigByUISystem(bodyId,0)
local FileIndex=self:GetActorGlowUIInfoByActor(bodyId)
local cameraAngleX=0
self:SetCameraFOVByUISystem(bodyId,4)
self:ShowScene(backgroundIndex,2000)
self:SetBackGroundOffset(backgroundIndex,4)
self:ShowActorAndWing(10,bodyId,weaponId,wingId,1,0,4)
_SetRotate(10,0,0,0)
_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))
_SetPostProcessEnable(FileIndex)
_SetShader(10,"Custom/Character/CH_Texture_Rim","000000FF","FF0000FF",700,true)


end


function UISceneActor:ShowModelFatherInvisble(backgroundIndex,index,modelId,weaponId,wingId,posID,animationID,stagePath,systemIndex,isGray,tableObjectPath)
local modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end
if modelconf.ShowID then
modelId=modelconf.ShowID
end

modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end

self:SetCameraIsGray(isGray)

local modelCfg=self:GetActorConfigByUISystem(modelId,systemIndex or 0)
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)
local animation=animationID==0 and modelCfg[8]
self:SetCameraFOVByUISystem(modelId,systemIndex)
self:ShowScene(2000)
self:SetBackGroundOffset(backgroundIndex,systemIndex)
_ChangeModel(index,modelId,weaponId,wingId,posID,animation or animationID,modelCfg[1],modelCfg[2],modelCfg[3],0,stagePath,false)
_SetRotate(index,modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)
self:snapUIActorPlayerToScreenPos(index,nil)
_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))
_SetPostProcessEnable(FileIndex)
self:SetRotateSpeed(index,self:GetActorHoldSpeed(modelId))

self:SetActorClipPlaneOffset(modelId)

if modelconf.parentID then
UISceneActor:loadParentNode(index,modelconf.parentID,modelconf.parentHP)
end
end


function UISceneActor:ShowShenBingModel(backgroundIndex,index,modelId,enableRotation,systemIndex,isGray)
local modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end
if modelconf.ShowID then
modelId=modelconf.ShowID
modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end
end

local backgroundID=2000

self:SetCameraIsGray(isGray)
local modelCfg=self:GetActorConfigByUISystem(modelId,systemIndex or 0)or{}
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)
local animation=modelCfg[8]or 0
local posID=0
self:SetCameraFOVByUISystem(modelId,systemIndex)
self:ShowScene(backgroundID)
self:SetBackGroundOffset(backgroundIndex,systemIndex)

local playerIndex=index
local player=self:getPlayer(index)


if self.currentSystemIndex~=systemIndex then
player:unload()
else


player:unloadModel()
end
self.currentSystemIndex=systemIndex


_HideActor(false)

player:setActorRootActive(true)

player:changeBody(modelId)

player:loadTable(false,systemIndex)


if modelconf.parentID then
player:loadParentNode(modelconf.parentID,modelconf.parentHP)
else
player:loadParentNode(0,modelconf.parentHP)
end

player:runAnimator(animation,posID)




player:snapToScreenPos(nil,3.4)

player:setRotate(modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)

local speed=0
if enableRotation then
speed=self:GetActorHoldSpeed(modelId)
end
player:setRotateSpeed(speed)

_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))

_SetPostProcessEnable(FileIndex)
end



function UISceneActor:ShowNormalModel(backgroundIndex,index,modelId,enableRotation,systemIndex,isGray,uiSnap)
local modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end
if modelconf.ShowID then
modelId=modelconf.ShowID
modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end
end

local backgroundID=2000

self:SetCameraIsGray(isGray)
local modelCfg=self:GetActorConfigByUISystem(modelId,systemIndex or 0)or{}
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)
local animation=modelCfg[8]or 0
local posID=0
self:SetCameraFOVByUISystem(modelId,systemIndex)
self:ShowScene(backgroundID)
self:SetBackGroundOffset(backgroundIndex,systemIndex)

local playerIndex=index
local player=self:getPlayer(index)


if self.currentSystemIndex~=systemIndex then
player:unload()
else


player:unloadModel()
end
self.currentSystemIndex=systemIndex


_HideActor(false)

player:setActorRootActive(true)

player:changeBody(modelId)

player:loadTable(false,systemIndex)


if modelconf.parentID then
player:loadParentNode(modelconf.parentID,modelconf.parentHP)
else
player:loadParentNode(0,modelconf.parentHP)
end

player:runAnimator(animation,posID)




local snapIndex=uiSnap and uiSnap[1]or nil
local snapD=uiSnap and uiSnap[2]or 3.4
player:snapToScreenPos(snapIndex,snapD)

player:setRotate(modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)

local speed=0
if enableRotation then
speed=self:GetActorHoldSpeed(modelId)
end
player:setRotateSpeed(speed)

_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))

_SetPostProcessEnable(FileIndex)
end




function UISceneActor:ShowActorPlaySkill(modelId,weaponId,wingId,skillId,systemIndex)
self:SetCameraIsGray(false)

local modelCfg=self:GetActorConfigByUISystem(modelId,systemIndex or 0)
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)

self:ShowScene(2000)
local actorIndex=0
_ChangeModelAndPlaySkill(actorIndex,modelId,weaponId,wingId,modelCfg[1],modelCfg[2],modelCfg[3],0,skillId)
_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))
_SetPostProcessEnable(FileIndex)
_SetRotate(actorIndex,0,0,0)
self:SetRotateSpeed(actorIndex,self:GetActorHoldSpeed(modelId))

self:SetActorClipPlaneOffset(modelId)
end





function UISceneActor:CreateCreatorScene()
UISceneActor:ShowScene(2000)

end


function UISceneActor:ChangeModel(modelID,poseID,animationID,systemIndex,idleID,isGray)
isGray=isGray==nil and false or isGray
self:SetCameraIsGray(isGray)
local modelCfg=self:GetActorConfigByUISystem(modelID,systemIndex or 0)
local FileIndex=self:GetActorGlowUIInfoByActor(modelID)
idleID=idleID or modelCfg[8]or 0

_ChangeModelAndIdle(0,modelID,0,0,poseID,animationID,modelCfg[1],modelCfg[2],modelCfg[3],0,idleID)

_SetRotate(0,modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)

_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))
_SetPostProcessEnable(FileIndex)
self:SetRotateSpeed(0,self:GetActorHoldSpeed(modelID))

self:SetActorClipPlaneOffset(modelID)
end

function UISceneActor:LoadAttachment(partID,ID)
_LoadAttachment(0,partID,ID)
end

function UISceneActor:SetMainPlayerStage(vacation)
local stage=stageConfig:getStageByVocation(vacation)
if stage~=nil then
_SetStage(0,stage)
end
end

function UISceneActor:SetStage(stage)
_SetStage(0,stage)
end

function UISceneActor:SetStageOffset(index,stage,v3)
_SetStageOffset(index,stage,v3)
end

function UISceneActor:ShowStage(show,Index)
if Index==nil then
Index=0
end
_ShowStage(Index,show)
end

function UISceneActor:PlayBodyEffectOffset(hp,effectID,offset)
UISceneActor:PlayActorEffect(hp,effectID,offset[1],offset[2],offset[3])
end

function UISceneActor:PlayBodyEffectOffsetByIndex(index,hp,effectID,offset)
_PlayActorEffect(index,hp,effectID,offset[1],offset[2],offset[3])
end

function UISceneActor:PlayActorEffect(hp,id,offsetx,offsety,offsetz)
_PlayActorEffect(0,hp,id,offsetx or 0,offsety or 0,offsetz or 0)
end

function UISceneActor:StopActorEffect(hp)
_StopActorEffect(0,hp)
end

function UISceneActor:RemoveAllActorEffect()
_RemoveAllActorEffect(0)
end

function UISceneActor:RemoveAllActorEffectByIndex(index)
_RemoveAllActorEffect(index)
end

function UISceneActor:RemoveActorRootEffectByIndex(index)
_RemoveActorRootEffect(index)
end

function UISceneActor:AddBuff(buffID)
_AddBuff(0,buffID)
end

function UISceneActor:AddBuffByIndex(index,buffID)
_AddBuff(index,buffID)
end

function UISceneActor:RemoveBuff()
_RemoveBuff(0)
end

function UISceneActor:RemoveBuffByIndex(index)
_RemoveBuff(index)
end

function UISceneActor:SetPoseID(index,poseID)
_SetPose(index,poseID)
end

function UISceneActor:SetAnimationID(animationID)
_SetAnimation(0,animationID)
end

function UISceneActor:SetAnimationByID(index,animationID)
_SetAnimation(index,animationID)
end

function UISceneActor:ChangeWeapon(weaponId)
_LoadWeapon(0,weaponId)
end

function UISceneActor:ChangeMount(index,mountId)
local player=self:getPlayer(index)
player:loadMount(mountId)
end


function UISceneActor:UseSkill(index,skillId)
_UseSkill(index,skillId)
end

function UISceneActor:UseSkillAlone(index,skillId)
_UseSkillAlone(index,skillId)
end

function UISceneActor:HideByIndex(index,isShow)
_HideByIndex(index,isShow)
end

function UISceneActor:GetBackGround(index)
return _GetBackGround(index)
end

function UISceneActor:SetRotateSpeed(index,speed)
_SetRotateSpeed(index,speed)
end


function UISceneActor:SetRotate(index,rotationX,rotationY,rotationZ)
_SetRotate(0,rotationX or 0,rotationY or 0,rotationZ or 0)
end


function UISceneActor:EnableRotation(index,enable)
_EnableRotation(index,enable)
end

function UISceneActor:SetBackGroundOffset(backgroundIndex,systemIndex)
local offset=self:GetBackGroundOffsetByUISystem(systemIndex or 0)
if offset then

_SetBackGroundOffset(backgroundIndex,offset[1],offset[2],offset[3])
end
end

function UISceneActor:SetActorClipPlaneOffset(modelId)
local cfg=cfg_charactermodelconfig_get(modelId)
if not cfg or not cfg.UIMirrorOffset then
return
end
_SetClipPlaneOffset(cfg.UIMirrorOffset)
end



function UISceneActor:ClearUIActorRes(Index)
_actorScene.ClearUIActorRes(Index)
end

function UISceneActor:ShowUIActor(Index,IsShow)
_actorScene.UIActorShow(Index,IsShow)
end

function UISceneActor.HideByLayer(Index,isShow)
_HideByLayer(Index,isShow)
end

function UISceneActor:ChangeOther(index,abName,pos,rotation)
_ChangeOther(index,abName,pos,rotation)
end

function UISceneActor:SetOther(index,abName,pos,rotation)
_SetOther(index,abName,pos,rotation)
end

function UISceneActor:HideOther(index,isShow)
_HideOther(index,isShow)
end

function UISceneActor:ClearOther()
_ClearOthers()
end

function UISceneActor:SetCameraFOV(fov)
_SetCameraFOV(fov)
end

function UISceneActor:SetCameraFOVByUISystem(modelId,sysIndex)
local fov=self:GetActorCameraFOVConfig(modelId,sysIndex)
_SetCameraFOV(fov)
end

function UISceneActor:EnableHighEffectModel(enable)
_EnableHighEffectModel(enable)
end

function UISceneActor:SetLineRenderer(positions)
_SetLineRenderer(positions)
end

function UISceneActor:EnableLineRenderer(isShow)
_EnableLineRenderer(false)
end

function UISceneActor:SetLineRendererByHP(index,hps)
_SetLineRendererByHP(index,hps)
end

function UISceneActor:GetEffectPosByHP(index,hp)
return _GetEffectPosByHP(index,hp)
end


function UISceneActor:GetIsOpenCameraGrayAPI()
if IsOpenCameraGrayAPI==nil then
IsOpenCameraGrayAPI=true
end
end


function UISceneActor:SetCameraIsGray(isGray)
self:GetIsOpenCameraGrayAPI()
if IsOpenCameraGrayAPI then
_actorScene.SetCameraIsGray(isGray)
end
end


function UISceneActor:SetCameraGrayColor(color)
self:SetCameraMaterialValue("_grayColor",color)
end


function UISceneActor:SetCameraGrayLerpValue(value)
self:SetCameraMaterialValue("_grayAmount",value)
end


function UISceneActor:SetCameraMaterialValue(key,value)
self:GetIsOpenCameraGrayAPI()
if IsOpenCameraGrayAPI then
_actorScene.SetCameraMaterialValue(key,value)
end
end

function UISceneActor:ChangeCloak(index,id)
_LoadAttachment(index,3,id)
end



function UISceneActor:LoadActorTable(index,isshowstage,systemIndex,backGroundID)
if isshowstage==nil then isshowstage=false end
local tableOffsetCfg={0,-1.04,3.7,0,0,0,0}
local bundlename="stage/m9stage/table/m9_map305_c_yuanpan_01.ab"
local InfoTableGroupID=backGroundID or RoleFashionData:GetOnFashion(GameConfigM9.ItemType.itFashion_Background)or 0
local FashionID=0
local JobVocation=playerControl.player~=nil and playerControl.player:get_vocation()or 1
local tableID=0


if InfoTableGroupID<=0 then _actorScene.LoadActorTable(index,bundlename,false)return end

FashionID=RoleAttributeData.GetAppearanceModelId(InfoTableGroupID,JobVocation)
local cfg=cfg_backgroundconfig_get(FashionID)
if cfg~=nil and next(cfg)then
tableID=cfg.tableID or 2000
bundlename=cfg.tableAB
end
tableOffsetCfg=self:GetActorConfigByUISystem(tableID,systemIndex or 0)

_actorScene.LoadActorTable(index,bundlename,isshowstage)
self:SetTableOffset(index,tableOffsetCfg[1],tableOffsetCfg[2],tableOffsetCfg[3],tableOffsetCfg[5],tableOffsetCfg[6],tableOffsetCfg[7])


if isshowstage~=false and InfoTableGroupID>0 then
self:LoadActorFBG(index,systemIndex,backGroundID)
end
end

function UISceneActor:SetTableOffset(index,offsetX,offsetY,offsetZ,rotationX,rotationY,rotationZ)
local V3=Vector3(offsetX or 0,offsetY or 0,offsetZ or 0)
_SetActorTableOffset(index,V3,rotationX or 0,rotationY or 0,rotationZ or 0)
end
















function UISceneActor:LoadActorFBG(index,systemIndex,backGroundID)
local FBGOffsetCfg={0,-1.04,3.7,0,0,0,0}
local bundlename=""
local InfoTableGroupID=backGroundID or RoleFashionData:GetOnFashion(GameConfigM9.ItemType.itFashion_Background)or 0
local FashionID=0
local JobVocation=playerControl.player~=nil and playerControl.player:get_vocation()or 1
local backgroundID=0

if InfoTableGroupID>0 then
FashionID=RoleAttributeData.GetAppearanceModelId(InfoTableGroupID,JobVocation)
local cfg=cfg_backgroundconfig_get(FashionID)
if cfg~=nil and next(cfg)then
backgroundID=cfg.backgroundID or 2000
bundlename=cfg.backgroundAB
end
FBGOffsetCfg=self:GetActorConfigByUISystem(backgroundID,systemIndex or 0)
end

_actorScene.LoadFashionBG(index,bundlename)
self:SetFBGOffset(index,FBGOffsetCfg[1],FBGOffsetCfg[2],FBGOffsetCfg[3],FBGOffsetCfg[5],FBGOffsetCfg[6],FBGOffsetCfg[7])
end


function UISceneActor:SetFBGOffset(index,offsetX,offsetY,offsetZ,rotationX,rotationY,rotationZ)
local V3=Vector3(offsetX or 0,offsetY or 0,offsetZ or 0)
_SetActorFBGOffset(index,V3,rotationX or 0,rotationY or 0,rotationZ or 0)
end

function UISceneActor:snapUIActorPlayerToScreenPos(index,nodeindex,distance)
nodeindex=nodeindex or 1
distance=distance or 3.4
_SnapUIActorPlayerToScreenPos(index,nodeindex,distance)
end

function UISceneActor:SetAllRootParam(xModelRotate,ModelPosX,ModelPosY,ModelPosZ)
_SetAllRootParam(xModelRotate or 0,Vector3(ModelPosX or 0,ModelPosY or 0,ModelPosZ or 0))
end

function UISceneActor:loadParentNode(index,parentID,parentHP)
_LoadParentNode(index,parentID,parentHP)
end

function UISceneActor:ResetAllRoot()
_ResetAllRoot()
end


function UISceneActor:PrepareScene(backgroundIndex,backgroundID,modelId,systemIndex)
local modelCfg=self:GetActorConfigByUISystem(modelId,systemIndex)
self:SetCameraIsGray(false)
self:SetCameraFOVByUISystem(modelId,systemIndex)
self:SetBackGroundOffset(backgroundIndex,systemIndex)
self:ShowScene(backgroundID)
self:SetActorClipPlaneOffset(modelId)
return modelCfg
end


function UISceneActor:ShowActorScenePlaySkill(backgroundIndex,modelId,weaponId,wingId,skillId,systemIndex)

local backgroundID=2000
local systemIndex=systemIndex or 0
local modelCfg=self:PrepareScene(backgroundIndex,backgroundID,modelId,systemIndex)
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)

local playerIndex=0
local player=self:getPlayer(playerIndex)


if self.currentSystemIndex~=systemIndex then
player:unload()
else


player:unloadModel()
end
self.currentSystemIndex=systemIndex


_HideActor(false)

player:setActorRootActive(true)

player:changeBody(modelId)

player:loadWeapon(weaponId)

player:loadWing(wingId)

player:useSkill(0,skillId)

local tableID=RoleFashionData:GetOnFashion(GameConfigM9.ItemType.itFashion_Background);
player:loadTable(tableID>0,systemIndex)

player:snapToScreenPos(nil,3.4)

player:setRotate(modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)

player:setRotateSpeed(self:GetActorHoldSpeed(modelId))

_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))

_SetPostProcessEnable(FileIndex)
end


function UISceneActor:ShowActorPlaySkllWithoutBG(backgroundIndex,modelId,weaponId,wingId,skillId,systemIndex)

local backgroundID=2000
local systemIndex=systemIndex or 0
local modelCfg=self:PrepareScene(backgroundIndex,backgroundID,modelId,systemIndex)
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)

local playerIndex=0
local player=self:getPlayer(playerIndex)


if self.currentSystemIndex~=systemIndex then
player:unload()
else


player:unloadModel()
end
self.currentSystemIndex=systemIndex


_HideActor(false)

player:setActorRootActive(true)

player:changeBody(modelId)

player:loadWeapon(weaponId)

player:loadWing(wingId)

player:useSkill(0,skillId)

player:loadTable(false,systemIndex)

player:snapToScreenPos(nil,3.4)

player:setRotate(modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)

player:setRotateSpeed(self:GetActorHoldSpeed(modelId))

_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))

_SetPostProcessEnable(FileIndex)
end


function UISceneActor:ShowAdvanceModel(backgroundIndex,index,modelId,weaponId,wingId,posID,animationID,stagePath,systemIndex,isGray,tableObjectPath,backGroundID)
local modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end
if modelconf.ShowID then
modelId=modelconf.ShowID
modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end
end

local backgroundID=backGroundID or 2000

self:SetCameraIsGray(isGray)
local modelCfg=self:GetActorConfigByUISystem(modelId,systemIndex or 0)or{}
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)
local animation=animationID==0 and modelCfg[8]or 0
self:SetCameraFOVByUISystem(modelId,systemIndex)
self:ShowScene(backgroundID)
self:SetBackGroundOffset(backgroundIndex,systemIndex)

local playerIndex=index
local player=self:getPlayer(index)


if self.currentSystemIndex~=systemIndex then
player:unload()
else


player:unloadModel()
end
self.currentSystemIndex=systemIndex


_HideActor(false)

player:setActorRootActive(true)

player:changeBody(modelId)

player:loadWeapon(weaponId)

player:loadWing(wingId)

player:loadTable(false,systemIndex)


if modelconf.parentID then
player:loadParentNode(modelconf.parentID,modelconf.parentHP)
else
player:loadParentNode(0,modelconf.parentHP)
end

player:runAnimator(animationID,posID)




player:snapToScreenPos(nil,3.4)

player:setRotate(modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)

player:setRotateSpeed(self:GetActorHoldSpeed(modelId))

_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))

_SetPostProcessEnable(FileIndex)












end


function UISceneActor:ShowTianMoActor(modelId,weaponId,wingId,animationID,offsetX,offsetY,offsetZ)
local modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end
if modelconf.ShowID then
modelId=modelconf.ShowID
modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end
end

local backgroundID=2000
local backgroundIndex=6
local index=1
local systemIndex=0
local posID=1

self:SetCameraIsGray(false)
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)
self:SetCameraFOVByUISystem(modelId,systemIndex)
self:ShowScene(backgroundID)
self:SetBackGroundOffset(backgroundIndex,systemIndex)


local player=self:getPlayer(index)


if self.currentSystemIndex~=systemIndex then
player:unload()
else


player:unloadModel()
end
self.currentSystemIndex=systemIndex


_HideActor(false)

player:setActorRootActive(true)

player:changeBody(modelId)

player:loadWeapon(weaponId)

player:loadWing(wingId)

player:loadTable(false,systemIndex)


if modelconf.parentID then
player:loadParentNode(modelconf.parentID,modelconf.parentHP)
else
player:loadParentNode(0,modelconf.parentHP)
end

player:runAnimator(animationID,posID)

player:snapToScreenPos(nil,3.4)

player:setRotate(0,180,0)

player:setRotateSpeed(self:GetActorHoldSpeed(modelId))

_SetAllRootParam(0,Vector3(offsetX or 0,offsetY or 0,offsetZ or 0))

_SetPostProcessEnable(FileIndex)
end




function UISceneActor:ShowTransferActor(backgroundIndex,index,modelId,weaponId,wingId,posID,animationID,systemIndex)

local backgroundID=2000
local systemIndex=systemIndex or 0
local modelCfg=self:PrepareScene(backgroundIndex,backgroundID,modelId,systemIndex)
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)

local playerIndex=index
local player=self:getPlayer(playerIndex)


if self.currentSystemIndex~=systemIndex then
player:unload()
else


player:unloadModel()
end
self.currentSystemIndex=systemIndex


_HideActor(false)

player:setActorRootActive(true)

player:changeBody(modelId)

player:loadWeapon(weaponId)

player:loadWing(wingId)

player:loadTable(false,systemIndex)

player:snapToScreenPos(nil,3.4)

player:setRotate(modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)

player:setRotateSpeed(self:GetActorHoldSpeed(modelId))

player:runAnimator(animationID,posID)

_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))

_SetPostProcessEnable(FileIndex)
end


function UISceneActor:ShowAwakeActor(index,modelId,weaponId,shenwengId,posID,animationID,systemIndex,wingId)
local systemIndex=systemIndex or 0
local modelCfg=self:GetActorConfigByUISystem(modelId,systemIndex)
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)
self:SetCameraIsGray(false)
self:SetCameraFOVByUISystem(modelId,systemIndex)
self:SetActorClipPlaneOffset(modelId)


local playerIndex=index
local player=self:getPlayer(playerIndex)


if self.currentSystemIndex~=systemIndex then
player:unload()
else


player:unloadModel()
end
self.currentSystemIndex=systemIndex


_HideActor(false)

player:setActorRootActive(true)

player:changeBody(modelId)

player:loadWeapon(weaponId)

player:loadWing(wingId)

player:loadAttachment(UIActorPlayerLoader.BodyParts.HP_Back,shenwengId)

player:snapToScreenPos(nil,3.4)

player:setRotate(modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)

player:setRotateSpeed(self:GetActorHoldSpeed(modelId))

player:runAnimator(animationID,posID)

_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))

_SetPostProcessEnable(FileIndex)
end


function UISceneActor:ShowOutShowSuitPlayerModel(backgroundIndex,index,modelId,weaponId,wingId,mountId,faBaoID,posID,animationID,systemIndex,backgroundID,uiArgs)
local modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end
if modelconf.ShowID then
modelId=modelconf.ShowID
modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end
end

backgroundID=backgroundID or 2000

local modelCfg=self:PrepareScene(backgroundIndex,backgroundID,modelId,systemIndex)





local playerIndex=index
local player=self:getPlayer(index)


if self.currentSystemIndex~=systemIndex then
player:unload()
else


player:unloadModel()
end
self.currentSystemIndex=systemIndex


_HideActor(false)

player:setActorRootActive(true)

player:changeBody(modelId)

player:loadWeapon(weaponId)

player:loadWing(wingId)

player:loadMount(mountId)

player:loadFaBao(faBaoID)


player:loadTable(false,systemIndex)


if modelconf.parentID then
player:loadParentNode(modelconf.parentID,modelconf.parentHP)
else
player:loadParentNode(0,modelconf.parentHP)
end

animationID=animationID==0 and modelCfg[8]or 0
player:runAnimator(animationID,posID)

player:setRotateSpeed(self:GetActorHoldSpeed(modelId))

local snapIndex=uiArgs and uiArgs[8]
local snapD=uiArgs and uiArgs[9]or 3.4
if uiArgs then
modelCfg=uiArgs
end

player:snapToScreenPos(snapIndex,snapD)

player:setRotate(modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)

_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))

local FileIndex=uiArgs and uiArgs[10]or self:GetActorGlowUIInfoByActor(modelId)
_SetPostProcessEnable(FileIndex)
end


function UISceneActor:ShowOutShowSuitJingLingModel(backgroundIndex,index,modelId,weaponId,wingId,linZhuID,posID,animationID,systemIndex,backgroundID,uiArgs)
local modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end
if modelconf.ShowID then
modelId=modelconf.ShowID
modelconf=cfg_charactermodelconfig_get(modelId)
if not modelconf then
logErr('unable to find modelconf with modelID',modelId)
return
end
end

backgroundID=backgroundID or 2000
local modelCfg=backgroundIndex and self:PrepareScene(backgroundIndex,backgroundID,modelId,systemIndex)or self:GetActorConfigByUISystem(modelId,systemIndex)
modelCfg=modelCfg or{}




local playerIndex=index
local player=self:getPlayer(index)


if self.currentSystemIndex~=systemIndex then
player:unload()
else


player:unloadModel()
end
self.currentSystemIndex=systemIndex


_HideActor(false)

player:setActorRootActive(true)

player:changeBody(modelId)

player:loadWeapon(weaponId)

player:loadWing(wingId)

player:LoadLinZhu(linZhuID)


player:loadTable(false,systemIndex)


if modelconf.parentID then
player:loadParentNode(modelconf.parentID,modelconf.parentHP)
else
player:loadParentNode(0,modelconf.parentHP)
end

animationID=animationID==0 and modelCfg[8]or 0
player:runAnimator(animationID,posID)

player:setRotateSpeed(self:GetActorHoldSpeed(modelId))

local snapIndex=uiArgs and uiArgs[8]
local snapD=uiArgs and uiArgs[9]or 3.4
if uiArgs then
modelCfg=uiArgs
end




player:snapToScreenPos(snapIndex,snapD)

player:setRotate(modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)

_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))

local FileIndex=uiArgs and uiArgs[10]or self:GetActorGlowUIInfoByActor(modelId)
_SetPostProcessEnable(FileIndex)
end


function UISceneActor:ShowCCAwakeMainModel(backgroundIndex,index,modelId,weaponId,wingId,faBaoID,systemIndex,backgroundID,uiSnap)

local backgroundID=backgroundID or 2000
local systemIndex=systemIndex or 0
local modelCfg=self:PrepareScene(backgroundIndex,backgroundID,modelId,systemIndex)
local FileIndex=self:GetActorGlowUIInfoByActor(modelId)

local playerIndex=index
local player=self:getPlayer(playerIndex)


if self.currentSystemIndex~=systemIndex then
player:unload()
else


player:unloadModel()
end
self.currentSystemIndex=systemIndex


_HideActor(false)

player:setActorRootActive(true)

player:changeBody(modelId)

player:loadWeapon(weaponId)

player:loadWing(wingId)

player:loadFaBao(faBaoID)

player:loadTable(false,systemIndex)

local snapIndex=uiSnap and uiSnap[1]
local snapD=uiSnap and uiSnap[2]or 3.4

player:snapToScreenPos(snapIndex,snapD)

player:setRotate(modelCfg[5]or 0,modelCfg[6]or 0,modelCfg[7]or 0)

player:setRotateSpeed(self:GetActorHoldSpeed(modelId))



_SetAllRootParam(modelCfg[4]or 0,Vector3(modelCfg[1]or 0,modelCfg[2]or 0,modelCfg[3]or 0))

_SetPostProcessEnable(FileIndex)
end


function UISceneActor:getPlayer(index,isLoader)

local playerLoader=self._playerLoaders[index]
if playerLoader then
return playerLoader
end


if isLoader then
_actorScene.CreateUIActorPlayer(index,true)
playerLoader=UIActorPlayerLoader.New(index)
else
_actorScene.CreateUIActorPlayer(index,false)
playerLoader=UIActorPlayerProxy.New(index)
end
self._playerLoaders[index]=playerLoader
return playerLoader
end

















function UISceneActor:GetModelInsideShowID(modelID)
local modelconf=cfg_charactermodelconfig_get(modelID)
if not modelconf then
logErr('unable to find modelconf with modelID',modelID)
return modelID
end

if modelconf.ShowID then
modelID=modelconf.ShowID
modelconf=cfg_charactermodelconfig_get(modelID)
if not modelconf then
logErr('unable to find modelconf with modelID',modelID)
end
end

return modelID
end
