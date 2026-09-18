
local guildOrderAI_autoClass={name='autoClass'}


function guildOrderAI_autoClass:onInit()
self.coolDownTime=20
self.coolDownTime2=5
end


function guildOrderAI_autoClass:onDelete()
self.coolDownTime=nil
self.coolDownTime2=nil
end


function guildOrderAI_autoClass:onUpdate()
if xianjieController:isPauseUpdateInXianJie()then return end
local bdData=UISchoolModel:getSchoolBDData()
if not bdData then
self:SetCoolDown(60)
return guildOrderAIState.eCond
end

local remain=UISchoolModel:get_study_remainNum()
if remain<=0 then
return guildOrderAIState.eComplete
end

local win=UIManager:findActiveWindow('UISchoolMainWin')
if win then
self:SetCoolDown(self.coolDownTime2)
return guildOrderAIState.eCond
end

win=UIManager:findActiveWindow('UIGuildOrderWin')
if win then
self:SetCoolDown(self.coolDownTime2)
return guildOrderAIState.eCond
end

local setup=guildOrderModel:getSetupData(GUILD_ORDER_TYPE.eAutoAttendClass)
local selectId=setup.selectId
local cost=cfgHelper.get2(cfg_collegecourseconfig_get,selectId,'useItem')
local moneyType=cost[1]
local needValue=cost[2]*remain
local enough=moneyModel.checkEnoughMoney(moneyType,needValue)

if not enough then
self:SetCoolDown(self.coolDownTime)
return guildOrderAIState.eCond
end

local diziList=UISchoolModel:getClassSelectDzDataListByClassType(selectId)
local ret=UISchoolController:autoHandleClass(selectId,remain,diziList)
if ret then
self:SetCoolDown(self.coolDownTime2)
return guildOrderAIState.eReplay
else
self:SetCoolDown(self.coolDownTime)
return guildOrderAIState.eCond
end
end

return guildOrderAI_autoClass