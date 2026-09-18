








gubaoBagModel=simple_class(baseBagModel)

gubaoBagModel.bagType=BAG_TYPE.eGubaoBag

function gubaoBagModel:onAppStart()

end

function gubaoBagModel:onEnterState()
self:init()
end

function gubaoBagModel:onLeaveState()
self:init()
end

function gubaoBagModel:onAddItem(data,isInit)
gubaoLookup:setGoodsSortList3Dirty()
self._base.onAddItem(self,data,isInit)
end

function gubaoBagModel:onDeleteItem(equip)
gubaoLookup:setGoodsSortList3Dirty()
self._base.onDeleteItem(self,equip)
end

function gubaoBagModel:onChangeItem(data)
gubaoLookup:setGoodsSortList3Dirty()
self._base.onChangeItem(self,data)
end