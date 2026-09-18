





daobingBagModel=simple_class(baseBagModel)

daobingBagModel.bagType=BAG_TYPE.eDaoBingBag

function daobingBagModel:onAppStart()

end

function daobingBagModel:onEnterState()
self:init()
self.spitemids={}
end

function daobingBagModel:onLeaveState()
self:init()
self.spitemids={}
end


function daobingBagModel:onAddItem(data,isInit)
self._base.onAddItem(self,data,isInit)
local itemid=data.itemid
if self.spitemids[itemid]==nil and itemsConfig.isDaoBingMaterials(itemid)then
self.spitemids[itemid]=true
end
daobingModel:addBagItem(data,isInit)
pushGiftTwoManager:onDaoBingChange(isInit)
pushGiftThreeManager:onDaoBingChange(isInit)
end

function daobingBagModel:onDeleteItem(equip)
local itemid=equip.itemid
local itemguid=equip.itemguid
self._base.onDeleteItem(self,equip)
if self.spitemids[itemid]==true and itemsConfig.isDaoBingMaterials(itemid)then
self.spitemids[itemid]=nil
end
daobingModel:changeBagItem(itemid,itemguid)
end

function daobingBagModel:onChangeItem(data)
self._base.onChangeItem(self,data)
daobingModel:changeBagItem(data.itemid,data.itemguid)
end

function daobingBagModel:getSuiPianitemids()
return self.spitemids
end

