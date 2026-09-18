





fabaoBagModel=simple_class(baseBagModel)

fabaoBagModel.bagType=BAG_TYPE.eFabaoBag

function fabaoBagModel:onAppStart()

end

function fabaoBagModel:onEnterState()
self:init()
end

function fabaoBagModel:onLeaveState()
self:init()
end



function fabaoBagModel:onAddItem(data,isInit)
self._base.onAddItem(self,data,isInit)
pushGiftTwoManager:onFabaoChange(isInit)
pushGiftThreeManager:onFabaoChange(isInit)

end


function fabaoBagModel:sortBagItems(items)
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


function fabaoBagModel:handleItem(item)
fabaoHelper.handleItem(item)
end



function fabaoBagModel:canUseNow(item)

end