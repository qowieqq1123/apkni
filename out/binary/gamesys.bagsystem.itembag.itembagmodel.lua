





itemBagModel=simple_class(baseBagModel)

itemBagModel.bagType=BAG_TYPE.eItemBag

function itemBagModel:onAppStart()

end

function itemBagModel:onEnterState()
self:init()
end

function itemBagModel:onLeaveState()
self:init()
end




function itemBagModel:sortBagItems(items)
if items and#items>1 then
_sort(items,function(a,b)
local aUseFlag=self:canUseNow(a)and 1 or 0
local bUseFlag=self:canUseNow(b)and 1 or 0
local aConfig=itemsConfig.getConfig(a.itemid)
local bConfig=itemsConfig.getConfig(b.itemid)
if aUseFlag~=bUseFlag then
return aUseFlag>bUseFlag
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


function itemBagModel:canUseNow(item)
return true
end



function itemBagModel:checkReddot()

local reddot=false

for i,v in ipairs(self.bag_items)do
local itemConfig=itemsConfig.getConfig(v.itemid)
if itemConfig.hasReddot and itemConfig.hasReddot==1 then
reddot=true
break
end
if itemConfig.special_limit then
local itemguid=v.itemguid
local lerp=bagUseControl.getItemCDTime(itemguid)
if lerp<=0 then
reddot=true
break
end
end
end

return reddot
end

function itemBagModel:onAddItem(data,isInit)
gubaoLookup:setlianhuaitemDirty(data.itemid)
self._base.onAddItem(self,data,isInit)
end

function itemBagModel:onDeleteItem(data)
gubaoLookup:setlianhuaitemDirty(data.itemid)
self._base.onDeleteItem(self,data)
end

function itemBagModel:onChangeItem(data)
gubaoLookup:setlianhuaitemDirty(data.itemid)
self._base.onChangeItem(self,data)
end
