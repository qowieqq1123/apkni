






local _MODULENAME="wagesMsgModel"


def_table(_MODULENAME)
wagesMsgModel.name=_MODULENAME
wagesMsgModel.data={}

function wagesMsgModel:onAppStart()

end


function wagesMsgModel:onEnterState(isReconnect)

end


function wagesMsgModel:onProtocolReq()

end


function wagesMsgModel:onLeaveState(isReconnect)

self.data={}
end



