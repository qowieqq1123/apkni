






local _MODULENAME="ChangeActModel"


def_table(_MODULENAME)
ChangeActModel.name=_MODULENAME
ChangeActModel.data={}

function ChangeActModel:onAppStart()

end


function ChangeActModel:onEnterState(isReconnect)

end


function ChangeActModel:onProtocolReq()

end


function ChangeActModel:onLeaveState(isReconnect)

self.data={}
end


