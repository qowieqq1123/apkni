

xianbaoBagModel=simple_class(baseBagModel)

xianbaoBagModel.bagType=BAG_TYPE.eXianBao

function xianbaoBagModel:onAppStart()

end

function xianbaoBagModel:onEnterState()
self:init()
end

function xianbaoBagModel:onLeaveState()
self:init()
end
