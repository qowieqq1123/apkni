





clothingBagModel=simple_class(baseBagModel)

clothingBagModel.bagType=BAG_TYPE.eClothing

function clothingBagModel:onAppStart()

end

function clothingBagModel:onEnterState()
self:init()
self.spitemids={}
end

function clothingBagModel:onLeaveState()
self:init()
self.spitemids={}
end


function clothingBagModel:onAddItem(data,isInit)
self._base.onAddItem(self,data,isInit)
local itemid=data.itemid
ClothingModel:updateCollectStar(itemid,data.star or 0)
end

function clothingBagModel:onChangeItem(data)
self._base.onChangeItem(self,data)
local itemid=data.itemid
ClothingModel:updateCollectStar(itemid,data.star or 0)
end


