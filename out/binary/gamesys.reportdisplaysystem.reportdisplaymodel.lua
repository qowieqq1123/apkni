






local _MODULENAME="reportDisplayModel"


def_table(_MODULENAME)
reportDisplayModel.name=_MODULENAME
reportDisplayModel.data={}

function reportDisplayModel:onAppStart()

end


function reportDisplayModel:onEnterState(isReconnect)

end


function reportDisplayModel:onProtocolReq()

end


function reportDisplayModel:onLeaveState(isReconnect)

self.data={}
end



