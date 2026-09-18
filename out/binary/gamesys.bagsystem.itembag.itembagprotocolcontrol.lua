





itemBagProtocolControl=gameState.addListener({})



function itemBagProtocolControl:onAppStart()

end

function itemBagProtocolControl:onEnterState()
itemBagModel:onEnterState()
end

function itemBagProtocolControl:onLeaveState()
itemBagModel:onLeaveState()
end

