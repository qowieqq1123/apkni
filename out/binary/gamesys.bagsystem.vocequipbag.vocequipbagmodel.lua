





vocEquipBagModel=simple_class(baseBagModel)

vocEquipBagModel.bagType=BAG_TYPE.eVocEquip

function vocEquipBagModel:onAppStart()

end

function vocEquipBagModel:onEnterState()
self:init()
end

function vocEquipBagModel:onLeaveState()
self:init()
end



function vocEquipBagModel:sortBagItems(items)
if items and#items>1 then
local sortTag={}
for i,v in ipairs(items)do
local config=itemsConfig.getConfig(v.itemid)
sortTag[v.guidStr]=config.stage*1000000+
config.color*10000+v.itemid/100+i
end

_sort(items,function(a,b)
return sortTag[a.guidStr]<sortTag[b.guidStr]
end)
end
end


function vocEquipBagModel:canUseNow(equip)

end
