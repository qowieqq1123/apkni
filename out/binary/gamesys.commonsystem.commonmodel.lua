






local _MODULENAME="CommonModel"


def_table(_MODULENAME)
CommonModel.name=_MODULENAME
CommonModel.data={}

function CommonModel:onAppStart()

end


function CommonModel:onEnterState(isReconnect)

end


function CommonModel:onProtocolReq()

end


function CommonModel:onLeaveState(isReconnect)

self.data={}
end



