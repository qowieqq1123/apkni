
fubaoBagModel=simple_class(baseBagModel)

fubaoBagModel.bagType=BAG_TYPE.eFubaoBag

function fubaoBagModel:onAppStart()

end

function fubaoBagModel:onEnterState()
self:init()
end

function fubaoBagModel:onLeaveState()
self:init()
end




function fubaoBagModel:sortBagItems(items)
if items and#items>1 then
table.sort(items,function(a,b)
local aConfig=itemsConfig.getConfig(a.itemid)
local bConfig=itemsConfig.getConfig(b.itemid)
if aConfig.stage~=bConfig.stage then
return aConfig.stage>bConfig.stage
elseif aConfig.color~=bConfig.color then
return aConfig.color>bConfig.color
elseif a.itemid~=b.itemid then
return a.itemid<b.itemid
elseif a.itemflag and b.itemflag and a.itemflag~=b.itemflag then
return a.itemflag<b.itemflag
else
return false
end
end)
end
end



function fubaoBagModel:canUseNow(item)

end