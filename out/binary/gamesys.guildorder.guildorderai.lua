







guildOrderAIState={
eClosed=0,
eReplay=1,
eCond=2,
eComplete=3,
}

local aiHandleLookup={
[GUILD_ORDER_TYPE.eAutoDuJie]='guildOrderAI_autoDuJie',
[GUILD_ORDER_TYPE.eQuicklyZhaoMu]='guildOrderAI_quicklyZhaoMu',
[GUILD_ORDER_TYPE.eAutoBuy]='guildOrderAI_autoBuy',
[GUILD_ORDER_TYPE.eAutoCleaning]='guildOrderAI_autoCleaning',
[GUILD_ORDER_TYPE.eAutoTreat]='guildOrderAI_autoTreat',
[GUILD_ORDER_TYPE.eAutoFightMonster]='guildOrderAI_autoFightMonster',
[GUILD_ORDER_TYPE.eAutoAttendClass]='guildOrderAI_autoClass',
[GUILD_ORDER_TYPE.eAutoFireFighting]='guildOrderAI_autoFireFighting',
[GUILD_ORDER_TYPE.eAutoCaoLing]='guildOrderAI_autoCaoLing',
[GUILD_ORDER_TYPE.eAutoBaiShan]='guildOrderAI_autoBaiShan',

}

local guildOrderAI={}

function guildOrderAI:__init(orderID)
self.orderID=orderID
self.coolDown=nil
self:onInit()
end

function guildOrderAI:onInit()

end

function guildOrderAI:getOrderID()
return self.orderID
end

function guildOrderAI:SetCoolDown(time)
local cur=gameUtilityModel.getServerShortTime()
self.coolDown=cur+time




end

function guildOrderAI:checkInCoolDown()
if self.coolDown then
local cur=gameUtilityModel.getServerShortTime()
return cur<self.coolDown
end
return false
end

function guildOrderAI:__delete()
self.orderID=nil
self.coolDown=nil
if self.listenner~=nil then
for notify_id,func in pairs(self.listenner)do
notifySystem:removelistener(notify_id,func)
end
self.listenner=nil
end

self:onDelete()
end

function guildOrderAI:onDelete()

end


function guildOrderAI:update()
self:onUpdate()
end

function guildOrderAI:onUpdate()

end

function guildOrderAI:listenNotify(notify_id,func)
if self.listenner==nil then
self.listenner={}
end
if self.listenner[notify_id]==nil then
self.listenner[notify_id]=func
notifySystem:listenNotify(notify_id,func)
else



end
end



local num=5
local pool={}
local fileLookup={}

function new_guildOrderAI(orderID)
local newT
if#pool>0 then
newT=table.remove(pool)
else
newT={}
local mT={
__index=guildOrderAI,
}
setmetatable(newT,mT)
end
local childname=aiHandleLookup[orderID]
if childname then
local child=fileLookup[orderID]
local filename=FMT.fmt('lua.gamesys.guildOrder.AI.{0}',childname)
if child==nil then
child=require(filename)
fileLookup[orderID]=child
end
if child==nil then



return
end
for k,v in pairs(child)do
newT[k]=v
end
end
newT:__init(orderID)
return newT
end

function release_guildOrderAI(aiObj)
if aiObj==nil then return end
aiObj:__delete()
local temp={}

for k,v in pairs(aiObj)do
temp[k]=true
end
for k,v in pairs(temp)do
aiObj[k]=nil
end
if#pool>=num then
return
end
table.insert(pool,aiObj)
end
