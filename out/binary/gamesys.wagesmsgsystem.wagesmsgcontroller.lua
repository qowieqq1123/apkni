






local _MODULENAME="wagesMsgController"

gameState.addListener(def_table(_MODULENAME))
wagesMsgController.name=_MODULENAME
wagesMsgController.data={}

function wagesMsgController:onAppStart()

wagesMsgModel:onAppStart()

socketManager:register_receiver(37,47,self.recv_37_47)
end


function wagesMsgController:onEnterState(isReconnect)
wagesMsgModel:onEnterState()
end


function wagesMsgController:onProtocolReq()
wagesMsgModel:onProtocolReq()
end


function wagesMsgController:onLeaveState(isReconnect)
wagesMsgModel:onLeaveState(isReconnect)

self.data={}
end


function wagesMsgController:onLostConnection()

end


function wagesMsgController:onReConnection(isInitPro)

end

function wagesMsgController:onOpenView(isReconnect)
wagesMsgController:checkShowWages()
end

function wagesMsgController:checkShowWages()
if mainControl:isInScene(eSceneType.eZongmen)then
local list=wagesMsgConfig.getWagesInfoList()
if#list>0 then
msgWinControl:addMsgWin(msgWinType.eWages)
end
end
end

function wagesMsgController:reqQuickReceiveWages()
socketManager:send_37_47()
end

function wagesMsgController.recv_37_47()
if UIManager:isActive("UIWagesInfoWin")then
UIManager:closeWindow("UIWagesInfoWin")
end
end


