





function xianmengController:onAppStart_DonationStatistics()
socketManager:register_receiver(20,148,xianmengController.do_protocol_20_148)
end

function xianmengController:onEnterState_DonationStatistics(isReconnect)
xianmengModel:onEnterState_DonationStatistics(isReconnect)
end

function xianmengController:onLeaveState_DonationStatistics(isReconnet)

end

function xianmengController:req_XianMeng_DonationStatistics()
socketManager.send_20_148()
end

function xianmengController.do_protocol_20_148(len,jxList)
xianmengModel:set_DonationStatistics_Log_List(len,jxList)
end