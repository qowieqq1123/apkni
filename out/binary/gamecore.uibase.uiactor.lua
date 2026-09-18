









UIActor=simple_class()


function UIActor:__init(modelId,stageAsset)
self.asset=stageAsset or"stage/roledisplaystage.ab"
self.modelId=-1
if modelId then
self:CreateModel(modelId)
end
end

function UIActor:CreateModel(modelId)
if not self.roleDisplay then
self.roleDisplay=CS.UIActor.Create(self.asset,modelId,0,0)

end
end

function UIActor:ChangeModel(modelId)
if self.modelId==modelId then return end

self.modelId=modelId
self.modelCnf=cfg_charactermodelconfig_get(modelId)

if not self.modelCnf then return end
self:CreateModel(modelId)

local speed=self.modelCnf.UIModelHoldSpeed or 0
if speed~=0 then
self.roleDisplay:SetRotationSpeed(speed)
else
self.roleDisplay:DisableRotation()
end
local scale=self.modelCnf.UIModelScale and self.modelCnf.UIModelScale or 1
self.roleDisplay:ChangeModel(modelId)

local autoSpeed=self.modelCnf.UIModelRotateVel and self.modelCnf.UIModelRotateVel or 0
local isAuto=autoSpeed~=0 and true or false
local pos=self.modelCnf.UIModelPos and self.modelCnf.UIModelPos or{0,0,0}
local rotate=self.modelCnf.UIModelRotation and self.modelCnf.UIModelRotation or{0,0,0}
local clipPlaneOffset=self.modelCnf.UIMirrorOffset and self.modelCnf.UIMirrorOffset or 0

self.roleDisplay:SetClipPlaneOffset(clipPlaneOffset)
self.roleDisplay:SetPostion(pos[1],pos[2],pos[3])
self.roleDisplay:SetRotation(rotate[1],rotate[2],rotate[3])
self.roleDisplay:SetAutoRotaion(autoSpeed,isAuto)

local size=self.modelCnf.UICameraSize
if"number"==type(size)and 0<size then
self:SetUICameraSizeByName(size,"Main Camera")

end
end

function UIActor:LoadWeapon(weaponId)
if weaponId and 0<weaponId and self.roleDisplay then
self.roleDisplay:LoadWeapon(weaponId)
end
end

function UIActor:LoadWing(wingId)
if wingId and 0<wingId then
self:LoadAttachment(UIActor.BodyParts.HP_WING,wingId)
end
end

function UIActor:LoadAttachment(bodyParts,attachmentId)
if attachmentId and 0<attachmentId and self.roleDisplay then
self.roleDisplay:LoadAttachment(bodyParts,attachmentId)
end
end

function UIActor:UseSkill(skillId)
if 0<skillId and self.roleDisplay then
self.roleDisplay:UseSkill(0,skillId)
end
end

function UIActor:EnableActorSimpleTab(simpleTabCallBack)
if self.roleDisplay then
if nil==self.roleDisplay.OnSimpleTap then
self.roleDisplay.OnSimpleTap=simpleTabCallBack
end
self.roleDisplay:EnableActorSimpleTab()
end
end

function UIActor:DisbaleActorSimpleTab()
if self.roleDisplay then
self.roleDisplay:DisbaleActorSimpleTab()
end
end

function UIActor:EnableActorDoubleTab(doubleTabCallBack)
if self.roleDisplay then
if nil==self.roleDisplay.OnDoubleTap then
self.roleDisplay.OnDoubleTap=doubleTabCallBack
end
self.roleDisplay:EnableActorDoubleTab()
end
end

function UIActor:DisbaleActorDoubleTab()
if self.roleDisplay then
self.roleDisplay:DisbaleActorDoubleTab()
end
end

function UIActor:SetOnSimpleTap(simpleTabCallBack)
if self.roleDisplay then
self.roleDisplay.OnSimpleTap=simpleTabCallBack
end
end

function UIActor:SetOnDoubleTap(doubleTabCallBack)
if self.roleDisplay then
self.roleDisplay.OnDoubleTap=doubleTabCallBack
end
end

function UIActor:SetUICameraSizeByName(size,pathName)
if self.roleDisplay then

end
end

function UIActor:SetUICameraSizeByTag(size,tagStr)
if self.roleDisplay then
self.roleDisplay:SetUICameraSizeByTag(size,tagStr)
end
end

function UIActor:SetAnimation(animationId)
if self.roleDisplay then
self.roleDisplay:SetAnimation(animationId)
end
end

function UIActor:WaitAnimationEnd(isWait)
if self.roleDisplay then
self.roleDisplay:WaitAnimationEnd(isWait)
end
end

function UIActor:SetActive(bool)
if self.roleDisplay then
self.roleDisplay.gameObject:SetActive(bool)
end
end

function UIActor:IsActiveSelf()
if self.roleDisplay then
return self.roleDisplay.gameObject.activeSelf
end
end

function UIActor:GetActor()
return self.roleDisplay
end













function UIActor:DestroySelf()
if self.roleDisplay then
self.roleDisplay:DisableRotation()
self:CloseActionTimer()
self.roleDisplay:DestroySelf()
self.roleDisplay=nil
end
end

function UIActor:HideModel(isShow)

end




function UIActor:ResetTimeValue()
self._currentTime=self:GetPlayActionTime()
end


function UIActor:OpenInitPlayAction()
self:RandomPlayRoleAnimation()
self:ResetTimeValue()
end


function UIActor:OpenClickPlayAction(callback)
local CallBack=function()
self:RandomPlayRoleAnimation()
self:ResetTimeValue()

if"function"==type(callback)then
callback()
end
end

self:EnableActorSimpleTab(CallBack)
end


function UIActor:OpenPlayActionTimer(callback)
if nil==self.timer then
local function CallBack()
if 0>=self._currentTime then
self:RandomPlayRoleAnimation()
self:ResetTimeValue()
else
self._currentTime=self._currentTime-1
end

if"function"==type(callback)then
callback()
end
end

self:ResetTimeValue()
self._timer=timer.new()
self._timer:start(1,CallBack)
end
end

function UIActor:CloseActionTimer()
if self._timer then
self._timer:cancel()
self._timer=nil
end
end

function UIActor:RandomPlayRoleAnimation()
if self.roleDisplay then
local animId=self:RandomActionId()
self:SetAnimation(animId)
end
end

function UIActor:GetPlayActionTime()
local misCfg=cfg_miscconfig()
return misCfg and misCfg.play_idel_time or UIActor.ActionDelayTime
end

function UIActor:RandomActionId()
local list=UIActor.ActionId
if 0<#list then
local randomNum=(math.random(os.time()))%(#list)
randomNum=(0==randomNum)and#list or randomNum
return list[randomNum]
end

return 0
end


function UIActor:SetShader(ShaderName)
if self.roleDisplay then
self.roleDisplay:AddShaderName(ShaderName);
end
end





UIActor.BodyParts={
BODY=0,
HP_FACE=1,
HP_HAIR=2,
HP_HAT=3,
HP_LH=4,
HP_RH=5,
HP_WING=6,
COMMON=7,
UNKNOWN=8,
MAX=8,
}


UIActor.ActionId={9000,9001}


UIActor.ActionDelayTime=10
