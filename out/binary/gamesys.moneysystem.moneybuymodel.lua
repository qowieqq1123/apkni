moneyBuyModel={}
moneyBuyModel.data={}


local moneyBuyMaxFunc={
[eMoneyType.mtXuKongLing]=function()
return xianmengModel:GetSkill_Effect(eXMMouLueEffectType.eZZSHAddXuKongLingBuyNum)
end,
}

function moneyBuyModel:onAppStart()
end

function moneyBuyModel:onEnterState()
end

function moneyBuyModel:onLeaveState()
self.data={}
self.least={}
end

function moneyBuyModel:getBuyMax(moneyId)
local cfg=itemsConfig.getConfig(moneyId)
local day=cfg.buy and cfg.buy[3]or 0
local func=moneyBuyMaxFunc[moneyId]
if func then
return day+func()
else
return day
end
end

function moneyBuyModel:setCount(moneyId,count)
self.data[moneyId]=count
end

function moneyBuyModel:setAllCount(list)
if not self.data then
self.data={}
end
if not self.least then
self.least={}
end
if list then
for i,v in ipairs(list)do
self:setCount(v.param_1,v.param_2)
self:setLeast(v.param_1,v.param_3)
end
end
end


function moneyBuyModel:getCount(moneyId)
return self.data[moneyId]or 0
end

function moneyBuyModel:setLeast(moneyId,least)
self.least[moneyId]=least
end

function moneyBuyModel:getLeast(moneyId)
return self.least[moneyId]or 0
end

function moneyBuyModel:getMax(moneyId)
local day=self:getBuyMax(moneyId)
local count=self:getCount(moneyId)
local least=self:getLeast(moneyId)
return math.max(day,count)+least
end

function moneyBuyModel:checkCount(moneyId)
local have=self:getCount(moneyId)
local max=self:getMax(moneyId)
return have<max
end