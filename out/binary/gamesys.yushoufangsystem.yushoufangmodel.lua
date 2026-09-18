






local _MODULENAME="YuShouFangModel"


def_table(_MODULENAME)
YuShouFangModel.name=_MODULENAME
YuShouFangModel.data={}

function YuShouFangModel:onAppStart()

end


function YuShouFangModel:onEnterState(isReconnect)

end


function YuShouFangModel:onProtocolReq()

end


function YuShouFangModel:onLeaveState(isReconnect)

self.data={}
end



