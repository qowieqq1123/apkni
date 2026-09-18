









local guildOrderAI_autoFightMonster={name='autoFightMonster'}


function guildOrderAI_autoFightMonster:onInit()
self.coolDownTime=5
self.coolDownTime2=1
self.excuteAINum=1
end


function guildOrderAI_autoFightMonster:onDelete()
self.coolDownTime=nil
self.coolDownTime2=nil
self.excuteAINum=nil
end

function guildOrderAI_autoFightMonster:checkCond()

if mainControl:isInScene(eSceneType.eZongmen)and zongmenControl:isMountid(mapIdType.zhufeng)then
return isometricMapSystem:IsInHome()
end
return false
end


function guildOrderAI_autoFightMonster:onUpdate()
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
isometricMapSystem:checkDZClearMonsterAI()
local eventMonDatas=emergenciesControl:getEventMonsterDatas()
local stillEnemyList=isometricMapSystem:findUnlockSundriesBySType(mapIdType.zhufeng,sundriseType.eStillEnemy)
local list={}
for k,v in ipairs(stillEnemyList)do
if v.auto_clear==1 then
table.insert(list,v)
end
end
if eventMonDatas and next(eventMonDatas)then
local num=0
local cTime=self.coolDownTime
for stId,data in pairs(eventMonDatas)do
local flag=isometricMapSystem:startClearMonsterAI(data)
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
elseif#list>0 then
local num=0
local cTime=self.coolDownTime
for i,data in ipairs(list)do
local flag=isometricMapSystem:startClearMonsterAI(data)
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

return guildOrderAI_autoFightMonster