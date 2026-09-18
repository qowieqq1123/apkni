

maomaoBagModel=simple_class(baseBagModel)

maomaoBagModel.bagType=BAG_TYPE.eMaoMaoBag

function maomaoBagModel:onAppStart()

end

function maomaoBagModel:onEnterState()
self:init()
end

function maomaoBagModel:onLeaveState()
self:init()
end