





vocEquipBagProtocolControl=gameState.addListener({})



function vocEquipBagProtocolControl:onAppStart()

end

function vocEquipBagProtocolControl:onEnterState()
vocEquipBagModel:onEnterState()
end

function vocEquipBagProtocolControl:onLeaveState()
vocEquipBagModel:onLeaveState()
end

