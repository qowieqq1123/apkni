






UIMovieStage=simple_class()

local TYPE=type
local MovieStageScene=CS.MovieStageScene
local TableToObjectArray=CS.TableToObjectArray

function UIMovieStage:__init(vocationId,index,stageAsset)
self.currentScene=nil
self.stage=nil
self.bgAsset=nil
self.asset=stageAsset or"fakebattle/roledisplaystage.ab"
self.vocationId=vocationId or 0
self.index=index or 0

self:CreateScene()
end

function UIMovieStage:CreateScene()
if self.currentScene==nil then
self.currentScene=MovieStageScene.Create({x=0,y=0,z=0},{x=0,y=0,z=0})
end

self.currentScene:Load(self.bgAsset,self.asset,objectHelper.packFunc(self,self.OnSceneLoadFinish))
end

function UIMovieStage:OnSceneLoadFinish()
if nil==self.currentScene then return end

local scene=self.currentScene
local stage=scene:GetMovieAnimationStage()
local cfg=cfg_actorinitconfig()
local actorCfg=cfg and cfg[self.vocationId]or{}
local model=actorCfg and actorCfg.model or 0
local weapon=actorCfg and actorCfg.weapon or 0
local showSkillId=actorCfg and actorCfg.showSkillId or 0
local modelId=RoleAttributeData.GetAppearanceModelId(model,self.vocationId)
local weaponId=RoleAttributeData.GetAppearanceModelId(weapon,self.vocationId)
self.stage=stage
stage:CreateModel(self.index,"a",0,modelId,weaponId,0,nil)
self:SetActive(true)
self:SetInfo(self.index,modelId)
self:DelayUseSkill(self.index,showSkillId)

self:EnableActorSimpleTab(function()self:RandomPlayRoleAnimation(self.index)end)



















end

function UIMovieStage:DelayUseSkill(index,skillId)
local function CallBack()
if self.stage then
self.stage:UseSkill(index,0,skillId,false,Vector3.zero,nil,nil)
end

self:CloseTimer()
end

self.timer=timer.new()
self.timer:start(0.1,CallBack,1)
end

function UIMovieStage:ChangeModel(index,modelId)
if modelId and 0<modelId and self.stage then
self:SetInfo(index,modelId)
end
end

function UIMovieStage:ChangeWeapon(index,weaponId)
if weaponId and 0<weaponId and self.stage then
self.stage:ChangeWeapon(index,weaponId)
end
end

function UIMovieStage:SetInfo(index,modelId)
self.modelCnf=cfg_charactermodelconfig_get(modelId)
if not self.modelCnf or not self.stage or self.modelId==modelId then return end

self.modelId=modelId
local speed=self.modelCnf.UIModelHoldSpeed or 0
local scale=self.modelCnf.UIModelScale and self.modelCnf.UIModelScale or 1
local autoSpeed=self.modelCnf.UIModelRotateVel and self.modelCnf.UIModelRotateVel or 0
local isAuto=autoSpeed~=0 and true or false
local pos=self.modelCnf.UIModelPos and self.modelCnf.UIModelPos or{0,0,0}
local rotate=self.modelCnf.UIModelRotation

if speed~=0 then
self.stage:SetRotationSpeed(speed)
else
self:UnRotationTouch()
end

if"table"==TYPE(pos)then
self.stage:SetPostion(pos[1]or 0,pos[2]or 0,pos[3]or 0)
end

if"table"==TYPE(rotate)then
self.stage:SetRotation(rotate[1]or 0,rotate[2]or 0,rotate[3]or 0)
end

self.stage:ChangeModel(index,modelId)
self.stage:SetAutoRotaion(autoSpeed,isAuto)
end

function UIMovieStage:SetRotationSpeed(speed)
if self.stage then
self.stage:SetRotationSpeed(speed)
end
end

function UIMovieStage:SetActive(bool)
if self.currentScene then
self.currentScene:SetActive(bool)
end
end

function UIMovieStage:SetAnimation(index,animationId)
if self.stage then
self.stage:SetAnimation(index,animationId)
end
end

function UIMovieStage:GetMovieScene()
return self.currentScene
end


function UIMovieStage:GetMovieStage()
return self.stage
end

function UIMovieStage:EnableActorSimpleTab(simpleTabCallBack)
if self.stage then
if nil==self.stage.OnSimpleTap then
self.stage.OnSimpleTap=simpleTabCallBack
end
self.stage:EnableActorSimpleTab()
end
end

function UIMovieStage:DisbaleActorSimpleTab()
if self.stage then
self.stage:DisbaleActorSimpleTab()
end
end

function UIMovieStage:EnableActorDoubleTab(doubleTabCallBack)
if self.stage then
if nil==self.stage.OnDoubleTap then
self.stage.OnDoubleTap=doubleTabCallBack
end
self.stage:EnableActorDoubleTab()
end
end

function UIMovieStage:DisbaleActorDoubleTab()
if self.stage then
self.stage:DisbaleActorDoubleTab()
end
end

function UIMovieStage:EnableTouch(isUIModel)
if self.stage then
self.stage:EnableTouch(isUIModel)
end
end

function UIMovieStage:DisbaleTouch()
if self.stage then
self.stage:DisbaleTouch()
end
end

function UIMovieStage:RandomPlayRoleAnimation(index)
if self.stage then
local animId=UIActor:RandomActionId()
self.stage:SetAnimation(index,animId)
end
end

function UIMovieStage:CloseTimer()
if self.timer then
self.timer:cancel()
self.timer=nil
end
end

function UIMovieStage:KillScene()
if self.currentScene~=nil then
self.currentScene:KillSelf()
self.currentScene=nil
end
end

function UIMovieStage:KillStage()
if self.stage~=nil then
self.stage:KillSelf()
self.stage=nil
end
end

function UIMovieStage:DestroySelf()
self:DisbaleTouch()
self:CloseTimer()
self:KillScene()
end
