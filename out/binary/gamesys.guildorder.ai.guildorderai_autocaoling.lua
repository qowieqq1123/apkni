
local guildOrderAI_autoCaoLing={name='autoCaoLing'}


function guildOrderAI_autoCaoLing:onInit()
self.coolDownTime=10
self.coolDownTime2=5
self.coolDownTime3=10
end


function guildOrderAI_autoCaoLing:onDelete()
self.coolDownTime=nil
self.coolDownTime2=nil
end

function guildOrderAI_autoCaoLing:checkCond()

if mainControl:isInScene(eSceneType.eZongmen)and zongmenControl:isMountid(mapIdType.zhufeng)then
return isometricMapSystem:IsInHome()
end
return false
end



function guildOrderAI_autoCaoLing:onUpdate()
if xianjieController:isPauseUpdateInXianJie()then return end

local eventType=emergenciesModel:getCurrentEventType()
if eventType~=emergenciesType.eYiMuCongSheng then
self:SetCoolDown(self.coolDownTime)
return guildOrderAIState.eCond
end

if not self:checkCond()then

self:SetCoolDown(self.coolDownTime3)
return guildOrderAIState.eCond
end


local _clObj=emergenciesControl:getAllCaoLing()

if not _clObj or not next(_clObj)then
isometricMapSystem:receiveAllSundries()
self:SetCoolDown(self.coolDownTime2)
return guildOrderAIState.eCond
else
for idx,ent in pairs(_clObj)do
emergenciesControl:onClickCaoLing(ent.obj)
end
end


local cur,max=emergenciesControl:getEventCount_YiMuCongSheng()
if cur==0 then
return guildOrderAIState.eComplete
end
end

return guildOrderAI_autoCaoLing