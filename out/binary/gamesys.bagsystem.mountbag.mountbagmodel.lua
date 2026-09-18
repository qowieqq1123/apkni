





mountBagModel=simple_class(baseBagModel)

mountBagModel.bagType=BAG_TYPE.eMountBag

function mountBagModel:onAppStart()

end

function mountBagModel:onEnterState()
self:init()
end

function mountBagModel:onLeaveState()
self:init()
end

function mountBagModel:hasMountId(itemid)
if self.bag_itemID_lookup==nil then return false end
if self.bag_itemID_lookup[itemid]==nil then return false end
return next(self.bag_itemID_lookup[itemid])~=nil
end