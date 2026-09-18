






local _MODULENAME="MiniGameModel"


def_table(_MODULENAME)
MiniGameModel.name=_MODULENAME
MiniGameModel.data={}

function MiniGameModel:onAppStart()

end


function MiniGameModel:onEnterState(isReconnect)

end


function MiniGameModel:onProtocolReq()

end


function MiniGameModel:onLeaveState(isReconnect)

self.data={}
end



