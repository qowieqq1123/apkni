






local _MODULENAME="changeManagerCheckController"

gameState.addListener(def_table(_MODULENAME))
changeManagerCheckController.name=_MODULENAME
changeManagerCheckController.data={}

function changeManagerCheckController:onAppStart()

changeManagerCheckModel:onAppStart()













end


function changeManagerCheckController:onEnterState(isReconnect)
changeManagerCheckModel:onEnterState()
end


function changeManagerCheckController:onProtocolReq()
changeManagerCheckModel:onProtocolReq()
end


function changeManagerCheckController:onLeaveState(isReconnect)
changeManagerCheckModel:onLeaveState(isReconnect)

self.data={}
end


function changeManagerCheckController:onLostConnection()

end


function changeManagerCheckController:onReConnection(isInitPro)

end


























































































































