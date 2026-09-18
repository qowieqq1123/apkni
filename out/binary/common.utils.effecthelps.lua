






effectHelps={}

function effectHelps.DrawCard(transform,gameObject,active,duration)
local tweener1=Lua.DOTweenProxyExtensions.DOScaleX(transform,0,duration/2)
tweener1:OnComplete(function()
gameObject:SetActive(active)
end)

local tweener2=Lua.DOTweenProxyExtensions.DOScaleX(transform,1,duration/2)
tweener2:SetDelay(duration/2)
tweener2:OnComplete(function()
Lua.DOTweenProxyExtensions.DOKill(transform)
end)
end

function effectHelps.CardAnimation(objs,time,callback)
for k,v in pairs(objs)do
local pos=v.transform.localPosition
local obj=v.transform

local func=function()
local t=Lua.DOTweenProxyExtensions.DOLocalMove(obj,pos,time/2)
t:OnComplete(function()
Lua.DOTweenProxyExtensions.DOKill(obj)
end)

if callback then
callback()
end
end

local tween=Lua.DOTweenProxyExtensions.DOLocalMove(obj,Vector3.zero,time/2)
tween:OnComplete(func)

local drawSpeed=time/math.random(2,7)
local card=obj:Find("Card_Normal").gameObject
effectHelps.DrawCard(obj,card,true,drawSpeed*2)
end
end
