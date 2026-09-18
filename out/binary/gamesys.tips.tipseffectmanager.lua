tipsEffectManager={}

function tipsEffectManager.handleEquip(argstable)
local formType=argstable.formType
local itemguid=argstable.itemguid
local itemid=argstable.itemid
if equipsHelper.hasDianHuaCnt(itemguid)then
if argstable.effect==nil then
local effect={}
effect.bottom=10498
effect.top=10499
argstable.effect=effect
end
end
end