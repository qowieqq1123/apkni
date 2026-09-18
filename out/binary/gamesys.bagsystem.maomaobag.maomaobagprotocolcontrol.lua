
maomaoBagProtocolControl=gameState.addListener({})



function maomaoBagProtocolControl:onAppStart()

end

function maomaoBagProtocolControl:onEnterState()
maomaoBagModel:onEnterState()
end

function maomaoBagProtocolControl:onLeaveState()
maomaoBagModel:onLeaveState()
end

