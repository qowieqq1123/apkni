









local guildOrderAI_autoCleaning={name='autoCleaning'}


function guildOrderAI_autoCleaning:onInit()
self.coolDownTime=20
self.coolDownTime2=5
self.excuteAINum=2
self.mapLookup={}
end


function guildOrderAI_autoCleaning:onDelete()
self.coolDownTime=nil
self.coolDownTime2=nil
self.excuteAINum=nil
self.mapLookup=nil
end

function guildOrderAI_autoCleaning:checkCond()

if mainControl:isInScene(eSceneType.eZongmen)and(zongmenControl:isMountid(mapIdType.zhufeng)or zongmenControl:isMountid(mapIdType.lingshoudao))then
return isometricMapSystem:IsInHome()
end
return false
end


function guildOrderAI_autoCleaning:onUpdate()
if xianjieController:isPauseUpdateInXianJie()then return end
local orderID=self.orderID
local setup,cfg=guildOrderModel:getSetupData(orderID)
if not setup.isOpen then
return guildOrderAIState.eClosed
end
if not self:checkCond()then

self:SetCoolDown(self.coolDownTime)
return guildOrderAIState.eCond
end



self.mapLookup[mapIdType.zhufeng]=true
local isLoadLSF=mountainControl:isLoaded(mapIdType.lingshoudao)
self.mapLookup[mapIdType.lingshoudao]=isLoadLSF
local list=isometricMapSystem:findMapLookupUnlockSundriesBySType(self.mapLookup,sundriseType.eStillSundrise)
if#list>0 then
local num=0
local cTime=self.coolDownTime
for i,data in ipairs(list)do
local flag=isometricMapSystem:startClearSundriesAI(data,1,false)
if flag==2 then

break
elseif flag==nil then
num=num+1
end
if num>=self.excuteAINum then
cTime=self.coolDownTime2
break
end
end
self:SetCoolDown(cTime)
return guildOrderAIState.eReplay
else
return guildOrderAIState.eComplete
end
end

return guildOrderAI_autoCleaning