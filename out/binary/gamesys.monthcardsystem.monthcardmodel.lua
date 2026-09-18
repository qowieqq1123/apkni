






local _MODULENAME="MonthCardModel"


def_table(_MODULENAME)
MonthCardModel.name=_MODULENAME
MonthCardModel.data={}

function MonthCardModel:onAppStart()

end


function MonthCardModel:onEnterState(isReconnect)

end


function MonthCardModel:onProtocolReq()

end


function MonthCardModel:onLeaveState(isReconnect)

self.data={}
end



