
local guildOrderAI_autoFireFighting={name='autoFireFighting'}


function guildOrderAI_autoFireFighting:onInit()
self.coolDownTime=10
self.coolDownTime2=5
end


function guildOrderAI_autoFireFighting:onDelete()
self.coolDownTime=nil
self.coolDownTime2=nil
end

function guildOrderAI_autoFireFighting:checkCond()

if mainControl:isInScene(eSceneType.eZongmen)and zongmenControl:isMountid(mapIdType.zhufeng)then
return isometricMapSystem:IsInHome()
end
return false
end


function guildOrderAI_autoFireFighting:onUpdate()
if xianjieController:isPauseUpdateInXianJie()then return end
local fireData=emergenciesControl:getFireData()
local eventType=emergenciesModel:getCurrentEventType()
if not fireData or eventType~=emergenciesType.eBuildingOnFire then
self:SetCoolDown(self.coolDownTime)
return guildOrderAIState.eCond
end

if not self:checkCond()then

self:SetCoolDown(self.coolDownTime)
return guildOrderAIState.eCond
end


local fireCount=0
local max=0
local extinguishingCount=0
for entityId,v in pairs(fireData)do
if v.isOnFile then
fireCount=fireCount+1
if not v.extinguishingCount then
local bdData=zongmenModel:findBuildingByEntityId(entityId)
if bdData then
emergenciesControl:toExtinguishing(bdData)
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end
end

if v.extinguishing then
extinguishingCount=extinguishingCount+1
end

max=max+1
end

if fireCount==0 then
return guildOrderAIState.eComplete
end

end

return guildOrderAI_autoFireFighting