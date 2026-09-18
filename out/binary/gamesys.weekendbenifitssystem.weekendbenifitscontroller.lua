






local _MODULENAME="weekendBenifitsController"

gameState.addListener(def_table(_MODULENAME))
weekendBenifitsController.name=_MODULENAME
weekendBenifitsController.data={}

function weekendBenifitsController:onAppStart()

weekendBenifitsModel:onAppStart()



socketManager:register_receiver(248,83,self.recv_248_83)
socketManager:register_receiver(248,84,self.recv_248_84)


end


function weekendBenifitsController:onEnterState(isReconnect)
weekendBenifitsModel:onEnterState()
end


function weekendBenifitsController:onProtocolReq()
weekendBenifitsModel:onProtocolReq()
end


function weekendBenifitsController:onLeaveState(isReconnect)
weekendBenifitsModel:onLeaveState(isReconnect)

self.data={}
end


function weekendBenifitsController:onLostConnection()

end


function weekendBenifitsController:onReConnection(isInitPro)

end


function weekendBenifitsController.recv_248_83(reward_flag,login_flag,reward_idx)
weekendBenifitsModel:setServerData(reward_flag,login_flag,reward_idx)
UIManager:invokeUIMethod('UIWeekendWelfareWin','refreshPanel')
reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end

function weekendBenifitsController:send_248_84(reward_id)
socketManager:send_248_84(reward_id)
end

function weekendBenifitsController.recv_248_84(reward_id)
weekendBenifitsModel:setRewardIdxFlag(reward_id)
UIManager:invokeUIMethod('UIWeekendWelfareWin','refreshPanel')
reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end


