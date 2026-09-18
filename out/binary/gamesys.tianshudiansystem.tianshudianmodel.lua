






local _MODULENAME="tianShuDianModel"


def_table(_MODULENAME)
tianShuDianModel.name=_MODULENAME
tianShuDianModel.data={}

function tianShuDianModel:onAppStart()

end


function tianShuDianModel:onEnterState(isReconnect)

end


function tianShuDianModel:onProtocolReq()

end


function tianShuDianModel:onLeaveState(isReconnect)

self.data={}
end



