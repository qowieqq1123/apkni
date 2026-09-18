






local _MODULENAME="XianGongController"

gameState.addListener(def_table(_MODULENAME))
XianGongController.name=_MODULENAME
XianGongController.data={}

function XianGongController:onAppStart()
XianGongModel:onAppStart()

socketManager:register_receiver(37,51,XianGongController.recv_37_51)
socketManager:register_receiver(37,52,XianGongController.recv_37_52)
socketManager:register_receiver(37,53,XianGongController.recv_37_53)
socketManager:register_receiver(37,54,XianGongController.recv_37_54)

end


function XianGongController:onEnterState(isReconnect)
XianGongModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onCommonShopData,self.onCommonShopDataReady)
notifySystem:listenNotify(notifyConfig.onCommonShopChange,self.onCommonShopChange)
end


function XianGongController:onProtocolReq()
funcShopController.send_23_1(eFuncShopType.eXianJieBaoKu)
funcShopController.send_23_1(eFuncShopType.eXianGongChaoGong)

XianGongModel:onProtocolReq()
end


function XianGongController:onLeaveState(isReconnect)
XianGongModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.onCommonShopData,self.onCommonShopDataReady)
notifySystem:removelistener(notifyConfig.onCommonShopChange,self.onCommonShopChange)

self.data={}
end


function XianGongController:onLostConnection()

end


function XianGongController:onReConnection(isInitPro)

end

function XianGongController.onCommonShopDataReady(shopType)
if shopType==eFuncShopType.eXianJieBaoKu then
XianGongModel:initShopItemList()
end
end

function XianGongController.onCommonShopChange(shopType,buyId,buyNum)
if shopType==eFuncShopType.eXianJieBaoKu then
UIManager:invokeUIMethod('UIXianGongBaoKuWin','refreshItemByID',buyId)
end
end




function XianGongController.reqReceiveTaskReward(len,list)
socketManager:send_37_53(len,list)
end



function XianGongController.reqReceiveStageReward(idx)
socketManager:send_37_54(idx)
end






function XianGongController.recv_37_51(len,list,stage,idx)
if len>0 then
XianGongModel:initTaskList(list)
end
XianGongModel:setStageVal(stage)
XianGongModel:setStageIdx(idx)
reddotControl.on_change_catch_type(CATCH_TYPE.eXianGongBangYu)
end




function XianGongController.recv_37_52(id,progress)
XianGongModel:updateTask(id,progress)
UIManager:invokeUIMethod("UIXianGongBangYuWin","receiveTaskItem",{{param_1=id}})
reddotControl.on_change_catch_type(CATCH_TYPE.eXianGongBangYu)
end




function XianGongController.recv_37_53(len,list)
if len>0 then
XianGongModel:receiveUpdateTask(list)
UIManager:invokeUIMethod("UIXianGongBangYuWin","receiveTaskItem",list)
UIManager:invokeUIMethod("UIXianGongBangYuWin","receiveTaskUpdateScore")
UIManager:invokeUIMethod("UIXianGongBangYuWin","receiveScoreItem")
end
reddotControl.on_change_catch_type(CATCH_TYPE.eXianGongBangYu)
end



function XianGongController.recv_37_54(idx)
XianGongModel:setStageIdx(idx)
UIManager:invokeUIMethod("UIXianGongBangYuWin","receiveScoreItem")
reddotControl.on_change_catch_type(CATCH_TYPE.eXianGongBangYu)
end


function XianGongController.getReddot()
return xianguanController.getReddot()or XianGongModel:checkXianGongBangYuReddot()or xianguanModel:getPublishWantedReddot()
end



