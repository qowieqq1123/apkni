






local _MODULENAME="shouhundingController"

gameState.addListener(def_table(_MODULENAME))
shouhundingController.name=_MODULENAME
shouhundingController.data={}

function shouhundingController:onAppStart()
shouhundingModel:onAppStart()
end


function shouhundingController:onEnterState(isReconnect)
shouhundingModel:onEnterState()
end


function shouhundingController:onProtocolReq()
shouhundingModel:onProtocolReq()
end


function shouhundingController:onLeaveState(isReconnect)
shouhundingModel:onLeaveState(isReconnect)

self.data={}
end


function shouhundingController:onLostConnection()

end


function shouhundingController:onReConnection(isInitPro)

end



function shouhundingController:send_37_121()
socketManager:send_37_121()
end



function shouhundingController:getReddot()
return self:isOpen()and self:checkMoneyEnough()
end

function shouhundingController:checkMoneyEnough()
local cur=shouhundingModel:getDataValue()
local max=shouhundingModel:getDataMax()
return cur>=max
end

function shouhundingController:isOpen()
local sysid=shouhundingModel:getSysID()
return systemModel.isOpen(sysid)
end