






local _MODULENAME="YuShouFangController"

gameState.addListener(def_table(_MODULENAME))
YuShouFangController.name=_MODULENAME
YuShouFangController.data={}

function YuShouFangController:onAppStart()

YuShouFangModel:onAppStart()

end


function YuShouFangController:onEnterState(isReconnect)
YuShouFangModel:onEnterState()
end


function YuShouFangController:onProtocolReq()
YuShouFangModel:onProtocolReq()
end


function YuShouFangController:onLeaveState(isReconnect)
YuShouFangModel:onLeaveState(isReconnect)

self.data={}
end


function YuShouFangController:onLostConnection()

end


function YuShouFangController:onReConnection(isInitPro)

end



