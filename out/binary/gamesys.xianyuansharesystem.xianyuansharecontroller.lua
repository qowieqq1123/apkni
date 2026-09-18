






local _MODULENAME="xianyuanShareController"

gameState.addListener(def_table(_MODULENAME))
xianyuanShareController.name=_MODULENAME
xianyuanShareController.data={}

function xianyuanShareController:onAppStart()

xianyuanShareModel:onAppStart()

socketManager:register_receiver(15,51,self.recv_15_51)
socketManager:register_receiver(15,52,self.recv_15_52)
socketManager:register_receiver(15,53,self.recv_15_53)

notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
end


function xianyuanShareController:onEnterState(isReconnect)
xianyuanShareModel:onEnterState()
end


function xianyuanShareController:onProtocolReq()
xianyuanShareModel:onProtocolReq()
end


function xianyuanShareController:onLeaveState(isReconnect)
xianyuanShareModel:onLeaveState(isReconnect)

self.data={}
end


function xianyuanShareController:onLostConnection()

end


function xianyuanShareController:onReConnection(isInitPro)

end


function xianyuanShareController:reqXianYuanShareInit()
socketManager:send_15_51()
end

function xianyuanShareController:reqXianYuanShareDaily()
socketManager:send_15_52()
end

function xianyuanShareController:reqXianYuanShareWheel()
socketManager:send_15_53()
end

function xianyuanShareController.recv_15_51(sharesec,sharetimes,zpflag)
xianyuanShareModel:setData(sharesec,sharetimes,zpflag)
UIManager:invokeUIMethod("UIXianYuanShareWin","refreshView")
end

function xianyuanShareController.recv_15_52(sharesec,sharetimes)
xianyuanShareModel:updateTimes(sharesec,sharetimes)
UIManager:invokeUIMethod("UIXianYuanShareWin","refreshTimes")
UIManager:invokeUIMethod("UIXianYuanShareWin","refreshTips")
reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end

function xianyuanShareController.recv_15_53(zpflag)
local index=xianyuanShareModel:updateFlag(zpflag)
UIManager:invokeUIMethod("UIXianYuanShareWin","afterWheel",index)
reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end



function xianyuanShareController.onNewDay()
UIManager:invokeUIMethod("UIXianYuanShareWin","refreshReddot")
reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end

function xianyuanShareController:triggerReddotCancel()
if xianyuanShareModel:getReddot()then
xianyuanShareModel:cancelReddot()
UIManager:invokeUIMethod("UIXianYuanShareWin","refreshReddot")
reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end
end