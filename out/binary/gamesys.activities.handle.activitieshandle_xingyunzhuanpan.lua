







activitiesHandle_xingyunzhuanpan=new_activitiesHandle('activitiesHandle_xingyunzhuanpan',activitiesHandle)

function activitiesHandle_xingyunzhuanpan:onInit()

end

function activitiesHandle_xingyunzhuanpan:onEnterState()
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
end

function activitiesHandle_xingyunzhuanpan:onLeaveState()
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
end


function activitiesHandle_xingyunzhuanpan.recv_247_90(...)
local args={...}
local subType=SUB_ACTIVITY_TYPE.eLotteryact13
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.total_luck_cnt=args[3]or 0
data.free_sec=args[4]or 0
data.stage_reward_idx=args[5]or 0

activitiesModel:setSubActInfoData(actID,subType,subid,data)



UIManager:invokeUIMethod("UISubAct_XYZPWin","severRefresh",actID,subType,subid)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end



function activitiesHandle_xingyunzhuanpan.onShowPrize(prizeType,prizelist,effectData)


if prizeType==ePrizeType.eXingYunZhuanPan then

local activityData=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eLotteryact13)
if activityData then
UIManager:invokeUIMethod("UISubAct_XYZPWin","rec_DoAnim",prizelist,effectData)

end
end
end


function activitiesHandle_xingyunzhuanpan:reqChoujiang(actId,subId,type)
local subType=SUB_ACTIVITY_TYPE.eLotteryact13
local jstr=jsonHelper.encode({1,type})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_xingyunzhuanpan:reqReceiveReward(actId,subId,select_idx)
local subType=SUB_ACTIVITY_TYPE.eLotteryact13
local jstr=jsonHelper.encode({2,select_idx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end
