





yunZhouBagModel=simple_class(baseBagModel)

yunZhouBagModel.bagType=BAG_TYPE.eYunZhou

function yunZhouBagModel:onAppStart()

end

function yunZhouBagModel:onEnterState()
self:init()
end

function yunZhouBagModel:onLeaveState()
self:init()
end
