





mountBagProtocolControl=gameState.addListener({})



function mountBagProtocolControl:onAppStart()

end

function mountBagProtocolControl:onEnterState()
mountBagModel:onEnterState()
end

function mountBagProtocolControl:onLeaveState()
mountBagModel:onLeaveState()
end

