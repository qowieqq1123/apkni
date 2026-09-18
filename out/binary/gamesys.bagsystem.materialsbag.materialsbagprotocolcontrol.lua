





materialsBagProtocolControl=gameState.addListener({})



function materialsBagProtocolControl:onAppStart()

end

function materialsBagProtocolControl:onEnterState()
materialsBagModel:onEnterState()
end

function materialsBagProtocolControl:onLeaveState()
materialsBagModel:onLeaveState()
end

