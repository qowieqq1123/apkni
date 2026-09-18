

shophuocangBagModel=simple_class(baseBagModel)

shophuocangBagModel.bagType=BAG_TYPE.eShopHuoCang

function shophuocangBagModel:onAppStart()

end

function shophuocangBagModel:onEnterState()
self:init()
end

function shophuocangBagModel:onLeaveState()
self:init()
end

function shophuocangBagModel:sortBagItems(items)
if items and#items>1 then
table.sort(items,function(a,b)
local aConfig=itemsConfig.getConfig(a.itemid)
local bConfig=itemsConfig.getConfig(b.itemid)
return aConfig.color>bConfig.color
end)
end
end

