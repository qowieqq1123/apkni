






local _MODULENAME="ZongHuiController"

gameState.addListener(def_table(_MODULENAME))
ZongHuiController.name=_MODULENAME
ZongHuiController.data={}

function ZongHuiController:onAppStart()
ZongHuiModel:onAppStart()

socketManager:register_receiver(254,130,self.recv_254_130)
socketManager:register_receiver(254,131,self.recv_254_131)
socketManager:register_receiver(254,132,self.recv_254_132)

end


function ZongHuiController:onEnterState(isReconnect)
ZongHuiModel:onEnterState()
end


function ZongHuiController:onProtocolReq()
ZongHuiModel:onProtocolReq()
end


function ZongHuiController:onLeaveState(isReconnect)
ZongHuiModel:onLeaveState(isReconnect)

self.data={}
end


function ZongHuiController:onLostConnection()

end


function ZongHuiController:onReConnection(isInitPro)

end


function ZongHuiController:send_254_132(len,set_list)
socketManager:send_254_132(len,set_list)
end



function ZongHuiController.recv_254_130(badge_list_len,badge_list)
ZongHuiModel:setBadgeList(badge_list_len,badge_list)
end

function ZongHuiController.recv_254_131(badge_list_len,badge_list)
ZongHuiModel:freshBadgeList(badge_list_len,badge_list)
end

function ZongHuiController.recv_254_132(len,set_list)
ZongHuiModel:setBadgeHide(len,set_list)

UIManager:invokeUIMethod("UIPlayerInfoWin","onfreshList")
end


function ZongHuiController:checkZongHuiSystem()
return false
end



function ZongHuiController:OpenZongHuiWin()
if ZongHuiController:checkZongHuiSystem()then
UIManager:showWindow("UIZongHuiWin")
end
end