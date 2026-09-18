






local _MODULENAME="prosperityController"

gameState.addListener(def_table(_MODULENAME))
prosperityController.name=_MODULENAME
prosperityController.data={}

function prosperityController:onAppStart()

prosperityModel:onAppStart()
prosperityController:onAppStart_Event()






socketManager:register_receiver(6,104,self.recv_6_104)




end


function prosperityController:onEnterState(isReconnect)
prosperityModel:onEnterState()

notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)





end


function prosperityController:onProtocolReq()
prosperityModel:onProtocolReq()
prosperityController:onProtocolReq_Event()
end


function prosperityController:onLeaveState(isReconnect)
prosperityModel:onLeaveState(isReconnect)

notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)

prosperityController:onLeaveState_Event()


self.data={}
end


function prosperityController:onLostConnection()

end


function prosperityController:onReConnection(isInitPro)
if systemModel.isOpen(SYSTEM_DEFINE.eProsperity)then
prosperityModel:initData()
if isInitPro then
prosperityController:onEnterState_Event()
end
end
end



function prosperityController:send_6_105()
socketManager:send_6_105()
end


function prosperityController.recv_6_104(level_idx)
prosperityModel:setLevelRewardIdx(level_idx)

notifySystem:postNotify(notifyConfig.onProsperityLevelChange)
taskController.fanrongduChange()
end




function prosperityController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
if systemModel.isOpen(SYSTEM_DEFINE.eProsperity)then
prosperityModel:initData()
prosperityController:onEnterState_Event()
end
elseif etype==homeEvent.eLeaveHome then

end
end

function prosperityController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eProsperity then
if isometricMapSystem:IsInHome()then
prosperityModel:initData()
prosperityController:onEnterState_Event()
end
end
end
