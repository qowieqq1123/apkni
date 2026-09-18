





equipBagModel=simple_class(baseBagModel)

equipBagModel.bagType=BAG_TYPE.eEquipBag

function equipBagModel:onAppStart()

end

function equipBagModel:onEnterState()
self:init()
end

function equipBagModel:onLeaveState()
self:init()
end



function equipBagModel:sortBagItems(items)
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


function equipBagModel:canUseNow(equip)

end

function equipBagModel:onAddItem(data,isInit)
self._base.onAddItem(self,data,isInit)
bagEquipControl:onAddEquip(data,isInit)
end

function equipBagModel:deleteItem(guidStr)
local equip=self:getItemByStr(guidStr)
self._base.deleteItem(self,guidStr)
bagEquipControl:onDelEquip(equip)
end

function equipBagModel:deleleItemlist(len,strlookup)
self._base.deleleItemlist(self,len,strlookup)
bagEquipControl:onDelEquipList(len,strlookup)
end
