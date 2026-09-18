local _cameraEffectHandle={
[4]=function()
local cameraTF=worldController.manager:GetCamera()
local year=gameUtilityModel:getGameYear()
local temp=math.floor(year/10)%2
local childCount=cameraTF.childCount
for i=1,childCount do
local index=i-1
local cameraEffect=cameraTF:GetChild(i-1)
cameraEffect.gameObject:SetActive(temp==index)
end
end,
}

function worldController:onCameraEffectHandle(world)
local handle=_cameraEffectHandle[world]
if handle then
handle()
end
end