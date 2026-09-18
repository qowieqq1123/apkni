







local showlog=false

function guildOrderController:initAI()
self.aiList={}
self.aiLookup={}
self.aiIdx=nil
end

function guildOrderController:clearAI()
self.aiList=nil
self.aiLookup=nil
self.aiIdx=nil
end

function guildOrderController:checkInit()
return self.aiList~=nil
end

function guildOrderController:initAllAI()
guildOrderController:checkAddAI(GUILD_ORDER_TYPE.eAutoDuJie)
guildOrderController:checkAddAI(GUILD_ORDER_TYPE.eAutoCleaning)
guildOrderController:checkAddAI(GUILD_ORDER_TYPE.eAutoTreat)
guildOrderController:checkAddAI(GUILD_ORDER_TYPE.eAutoFightMonster)
guildOrderController:checkAddAI(GUILD_ORDER_TYPE.eAutoAttendClass)
guildOrderController:checkAddAI(GUILD_ORDER_TYPE.eAutoFireFighting)
guildOrderController:checkAddAI(GUILD_ORDER_TYPE.guildOrderAI_autoCaoLing)
guildOrderController:checkAddAI(GUILD_ORDER_TYPE.eAutoBaiShan)
end

function guildOrderController:checkAddAI_delay(orderID,delay,isFisrt)
if not guildOrderModel:checkOrderActive(orderID)then
return
end
local func=function()
local setup_,cfg_=guildOrderModel:getSetupData(orderID)
if setup_.isOpen then
guildOrderController:addAI(orderID,isFisrt)
local calss=self.aiLookup[orderID]
calss:onUpdate()
end
end
if delay~=nil and delay>0 then
timeEventController.delayDo(delay,func)
else
func()
end
end

function guildOrderController:checkAddAI(orderID,isFisrt)
if not guildOrderModel:checkOrderActive(orderID)then
return
end
local setup,cfg=guildOrderModel:getSetupData(orderID)
if setup.isOpen then
guildOrderController:addAI(orderID,isFisrt)
end
end

function guildOrderController:addAI(orderID,isFisrt)
if not guildOrderController:checkInit()then return end

if isFisrt==nil then isFisrt=false end
local oldNum=#self.aiList
local aiObj=self.aiLookup[orderID]
if aiObj==nil then
aiObj=new_guildOrderAI(orderID)
if isFisrt then
table.insert(self.aiList,1,aiObj)
else
table.insert(self.aiList,aiObj)
end
self.aiLookup[orderID]=aiObj
else

local f
for i,aiObj_ in ipairs(self.aiList)do
if aiObj_:getOrderID()==orderID then
f=i
break
end
end
if isFisrt and f~=1 then
table.remove(self.aiList,f)
table.insert(self.aiList,1,aiObj)
end
end






if oldNum<=0 then

timeEventController.addNormalTimerHandler(3,self.name,self)
end
end

function guildOrderController:removeAI(orderID)
local aiObj=self.aiLookup[orderID]
if aiObj then
for i,aiObj_ in ipairs(self.aiList)do
if aiObj_:getOrderID()==orderID then
table.remove(self.aiList,i)
break
end
end
self.aiLookup[orderID]=nil
release_guildOrderAI(aiObj)







local num=#self.aiList
if num<=0 then

timeEventController.removeNormalTimerHandler(3,self.name)
end
end
end

local _stateFunc=
{
[guildOrderAIState.eClosed]=function(self,aiObj)
local orderID=aiObj:getOrderID()
self.aiLookup[orderID]=nil
release_guildOrderAI(aiObj)






return true
end,
[guildOrderAIState.eComplete]=function(self,aiObj)
local orderID=aiObj:getOrderID()
self.aiLookup[orderID]=nil
release_guildOrderAI(aiObj)






return true
end,

















}

function guildOrderController:onNormalUpdate()
if self.aiList~=nil then
local c=#self.aiList
if self.aiIdx==nil then
self.aiIdx=c
else
self.aiIdx=self.aiIdx-1
if self.aiIdx<=0 or self.aiIdx>c then self.aiIdx=c end
end
local aiObj=self.aiList[self.aiIdx]
if not aiObj:checkInCoolDown()then
local state=aiObj:onUpdate()
if _stateFunc[state]then
if _stateFunc[state](self,aiObj)then
_remove(self.aiList,self.aiIdx)
end
end
end

local num=#self.aiList
if num<=0 then

timeEventController.removeNormalTimerHandler(3,self.name)
end
end
end

function guildOrderController:printAIInfo(str)


end
