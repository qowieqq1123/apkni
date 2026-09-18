

function lingshouController:onAppStart_kickout()
socketManager:register_receiver(19,107,self.do_protocol_19_107)
end

function lingshouController:reqKickOutLingShou(list)

socketManager:send_19_107(#list,list)
end

function lingshouController.do_protocol_19_107(len,list)
if len<=0 then return end
UIManager.info("放生成功")
UIShouLanControl:removeShouLanLsByLsGuidList(list)
notifySystem:postNotify(notifyConfig.onLingShouRemoveList,list)
end

