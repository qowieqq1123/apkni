






local _MODULENAME="qqLobbyActModel"


def_table(_MODULENAME)
qqLobbyActModel.name=_MODULENAME
qqLobbyActModel.data={}

function qqLobbyActModel:onAppStart()

end


function qqLobbyActModel:onEnterState(isReconnect)

end


function qqLobbyActModel:onProtocolReq()

end


function qqLobbyActModel:onLeaveState(isReconnect)

self.data={}
end



