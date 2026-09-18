






local _MODULENAME="WenXinGuanController"

gameState.addListener(def_table(_MODULENAME))
WenXinGuanController.name=_MODULENAME
WenXinGuanController.data={}

function WenXinGuanController:onAppStart()

WenXinGuanModel:onAppStart()


socketManager:register_receiver(34,130,WenXinGuanController.recv_34_130)
socketManager:register_receiver(34,131,WenXinGuanController.recv_34_131)
socketManager:register_receiver(34,132,WenXinGuanController.recv_34_132)
socketManager:register_receiver(2,46,WenXinGuanController.recv_2_46)

















end


function WenXinGuanController:onEnterState(isReconnect)
WenXinGuanModel:onEnterState()
end


function WenXinGuanController:onProtocolReq()
WenXinGuanModel:onProtocolReq()
end


function WenXinGuanController:onLeaveState(isReconnect)
WenXinGuanModel:onLeaveState(isReconnect)

self.data={}
end


function WenXinGuanController:onLostConnection()

end


function WenXinGuanController:onReConnection(isInitPro)

end


















function WenXinGuanController.recv_34_130(argtable)
WenXinGuanModel:initWXGDatas(argtable)
reddotControl.on_change_catch_type(CATCH_TYPE.eDisciple)
notifySystem:postNotify(notifyConfig.onWenXinGuanNumChange,nil)
notifySystem:postNotify(notifyConfig.onJctjProgressChange)
end




function WenXinGuanController.recv_34_131(dzGuid,tmId)
WenXinGuanModel:setDzTmId(dzGuid,tmId)
WenXinGuanController.send_34_132()
end




function WenXinGuanController.recv_34_132(choice,finishNum,accNum)
WenXinGuanModel:setDzChoice(choice,finishNum)
WenXinGuanModel:addDzXMZAuto(choice)
WenXinGuanModel:setAccuCount(accNum)
notifySystem:postNotify(notifyConfig.onWenXinGuanNumChange,nil)
end




function WenXinGuanController.recv_2_46(guid,xmz)
WenXinGuanModel:setDzXMZChange(guid,xmz)
end

function WenXinGuanController:send_34_131(guid)
socketManager:send_34_131(guid)
end

function WenXinGuanController:send_34_132()
socketManager:send_34_132()
end



