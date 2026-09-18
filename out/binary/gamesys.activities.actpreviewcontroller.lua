











local _MODULENAME="actPreviewController"
gameState.addListener(def_table(_MODULENAME))
actPreviewController.name=_MODULENAME

function actPreviewController:onAppStart()
socketManager:register_receiver(254,68,actPreviewController.do_protocol_254_68)
socketManager:register_receiver(254,69,actPreviewController.do_protocol_254_69)
end

function actPreviewController:onEnterState(isReconnet)
end

function actPreviewController:onLeaveState(isReconnet)
actPreviewModel:clearData()
end

function actPreviewController:onPlayerCreate(...)

end

function actPreviewController:onProtocolReq(isReconnet)

end

function actPreviewController:onLostConnection()

end

function actPreviewController:onOpenView(isReconnect)
if not isReconnect then
if mainControl:isInScene(eSceneType.eZongmen)then
local list=actPreviewModel:getPreviewSortList()
if list and#list>0 then
msgWinControl:addMsgWin(msgWinType.eActPreview,{})
end
end
end
end




function actPreviewController:send_254_68()
socketManager:send_254_68()
end


function actPreviewController:send_254_69(id)

socketManager:send_254_69(id)
end






function actPreviewController.do_protocol_254_68(len,list)





actPreviewModel:initData(list)
end


function actPreviewController.do_protocol_254_69(id,sec)


actPreviewModel:setRewardTime(id,sec)
UIManager:invokeUIMethod('UIActPreviewWin','recv_reward',id)
end

