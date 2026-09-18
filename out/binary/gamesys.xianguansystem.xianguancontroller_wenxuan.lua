





function xianguanController:onAppStart_WenXuan()
socketManager:register_receiver(40,1,xianguanController.recv_40_1)
socketManager:register_receiver(40,2,xianguanController.recv_40_2)
socketManager:register_receiver(40,3,xianguanController.recv_40_3)
socketManager:register_receiver(40,4,xianguanController.recv_40_4)
socketManager:register_receiver(40,5,xianguanController.recv_40_5)
socketManager:register_receiver(40,6,xianguanController.recv_40_6)
socketManager:register_receiver(40,7,xianguanController.recv_40_7)
socketManager:register_receiver(40,8,xianguanController.recv_40_8)
socketManager:register_receiver(40,9,xianguanController.recv_40_9)
end

function xianguanController:onLeaveState_WenXuan()
xianguanModel:clearWenXuanData()
xianguanModel:clearData_WenXuan_BW()
end

function xianguanController:onNormalUpdate_WenXuan(lastTime)
local activityData=xianguanModel:getWenXuanActivityData()
if activityData and activityData.thisWeek then

local segmentData=activityData.segmentData
local nowTime=timeHelper.getServerShortTime()

if nowTime>=segmentData.endTime and(not xianguanController:isInMatchStage_enter_WenXuan_BW())then
local old=segmentData.status
xianguanModel:refreshWenXuanData(nowTime)
notifySystem:postNotify(notifyConfig.onXianGuanJingXuanSegmentChange,XianGuanCampaignType.eWenXuan,old)
notifySystem:postNotify(notifyConfig.onLimitActReddotChange,LIMIT_ACT_TYPE.eXianGuanWenXuan)
end

if lastTime<activityData.resultTime and nowTime>=activityData.resultTime then
xianguanModel:addMsgJingXuanResultType(XianGuanCampaignType.eWenXuan)
msgWinControl:addMsgWin(msgWinType.eXianGuanJingXuanResult,nil,{delay=self.delayJingXuanResultTime},true)
end
end
end




function xianguanController:req_send_40_2(officer_id,declaration_idx)
if ServerTransferModel:checkTransferServerState()then
UIManager.error("已申请转服，该功能无法使用")
return
end
socketManager:send_40_2(officer_id,declaration_idx)
end



function xianguanController:req_send_40_3(free_idx)
socketManager:send_40_3(free_idx)
end



function xianguanController:req_send_40_4(declaration_idx)
socketManager:send_40_4(declaration_idx)
end



function xianguanController:req_send_40_5(officer_id)
socketManager:send_40_5(officer_id)

xianguanModel:setGetWenXuanRecordTime(officer_id)
end




function xianguanController:req_send_40_6(channleIds)
socketManager:send_40_6(#channleIds,channleIds)
end


function xianguanController:req_send_40_7()
socketManager:send_40_7()
end






function xianguanController:req_send_40_8(actor_id,vote,free_num,item_num,args)
xianguanController.args_40_8=args
socketManager:send_40_8(actor_id,vote,free_num,item_num)
end


function xianguanController:req_send_40_9()
socketManager:send_40_9()
end












function xianguanController.recv_40_1(args)
xianguanModel:setWenXuanData(args)

notifySystem:postNotify(notifyConfig.onXianGuanJingXuanSegmentChange,XianGuanCampaignType.eWenXuan)
notifySystem:postNotify(notifyConfig.onLimitActReddotChange,LIMIT_ACT_TYPE.eXianGuanWenXuan)
reddotControl.on_change_catch_type(CATCH_TYPE.eXianGuanJingXuan)
end




function xianguanController.recv_40_2(officer_id,last_cooldown)
xianguanModel:setWenXuanOfficerId(officer_id,last_cooldown)

xianguanModel:setGetWenXuanRecordTime(officer_id,0)

UIManager:invokeUIMethod("UIXianGuanCampaignMainWin","refreshXGList")
UIManager:invokeUIMethod("UIXianGuanJobDetailsWin","refreshCampaign")
end



function xianguanController.recv_40_3(free_bits)
xianguanModel:setWenXuanFreeBits(free_bits)

UIManager:invokeUIMethod("UIXianGuanCampaignMainWin","refreshReward")
UIManager:invokeUIMethod("UIXianGuanCampaignRegisterWin","refreshReward")
notifySystem:postNotify(notifyConfig.onLimitActReddotChange,LIMIT_ACT_TYPE.eXianGuanWenXuan)
reddotControl.on_change_catch_type(CATCH_TYPE.eXianGuanJingXuan)

end



function xianguanController.recv_40_4(declaration_idx)
xianguanModel:setWenXuanDeclarationIdx(declaration_idx)

UIManager:invokeUIMethod("UIXianGuanCampaignRegisterWin","freshMyRegisterItem")
end





function xianguanController.recv_40_5(officer_id,record_len,electionRecordList)
xianguanModel:setWenXuanElectionRecordList(officer_id,record_len,electionRecordList)

UIManager:invokeUIMethod("UIXianGuanCampaignRegisterWin","refreshList",officer_id)
UIManager:invokeUIMethod("UIXianGuanCampaignRegisterWin","refreshSelfRank")
UIManager:invokeUIMethod("UIXianGuanWenXuanInspireWin","refreshPanel")
end


function xianguanController.recv_40_6(chat_sec)
xianguanModel:markWenXuanShareTime(chat_sec)
UIManager.info("分享成功")
UIManager:invokeUIMethod("UIXianGuanWenXuanShareInspireWin","refreshPublicShareShow")
end




function xianguanController.recv_40_7(len,settleList)


end






function xianguanController.recv_40_8(actor_id,vote,free_num,item_num)
local args=xianguanController.args_40_8
xianguanModel:setWenXuanVote(actor_id,vote,free_num,item_num,args)

UIManager.info("投票成功")

UIManager:invokeUIMethod("UIXianGuanCampaignRegisterWin","freshVoteRegisterItem",args.officerId,actor_id)
UIManager:invokeUIMethod("UIXianGuanWenXuanInspireWin","refreshView",actor_id,vote)
end



function xianguanController.recv_40_9(last_cooldown)
xianguanModel:setWenXuanDelOfficerId(last_cooldown)

UIManager:invokeUIMethod("UIXianGuanCampaignMainWin","refreshXGList")
UIManager:invokeUIMethod("UIXianGuanJobDetailsWin","refreshCampaign")
end
