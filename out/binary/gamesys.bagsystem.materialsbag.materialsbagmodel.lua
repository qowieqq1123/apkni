





materialsBagModel=simple_class(baseBagModel)

materialsBagModel.bagType=BAG_TYPE.eMaterialsBag

function materialsBagModel:onAppStart()

end

function materialsBagModel:onEnterState()
self:init()
end

function materialsBagModel:onLeaveState()
self:init()
end



function materialsBagModel:sortBagItems(items)
if items and#items>1 then
table.sort(items,function(a,b)
local aConfig=itemsConfig.getConfig(a.itemid)
local bConfig=itemsConfig.getConfig(b.itemid)
if aConfig.stage and bConfig.stage and aConfig.stage~=bConfig.stage then
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



function materialsBagModel:canUseNow(item)

end