







local _LuaHelper=CS.LuaHelper

activitiesHandle_shizhuangzhigou=new_activitiesHandle('activitiesHandle_shizhuangzhigou',activitiesHandle)









local showRewards
local battleRecv
local qiyudata




function activitiesHandle_shizhuangzhigou:onEnterState()
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
end

function activitiesHandle_shizhuangzhigou:onLeaveState()
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
end

function activitiesHandle_shizhuangzhigou:reqBuy(actId,subId,suitIdx,conf_idx)
local subType=SUB_ACTIVITY_TYPE.ebuyact9
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if data and data.list then
local buyRecord=data.list
local config=activitiesModel:getSubActivityConfig(subType,subId)
local buy_conf=config.recharge_conf[suitIdx]
local butCnt_conf=buy_conf[conf_idx]
local rechargeId=butCnt_conf[1]
local info={suitIdx,conf_idx}
local params=payControl.getActivityPayParams(actId,subType,subId,info)
payControl.reqPay(rechargeId,1,params)
end
end

function activitiesHandle_shizhuangzhigou:reqFreeGift(actId,subId)

local subType=SUB_ACTIVITY_TYPE.ebuyact9
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if data then
local gift_cnt=data.gift_cnt or 0
if gift_cnt<=0 then
local jstr=jsonHelper.encode({1})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end
end
end

function activitiesHandle_shizhuangzhigou.recv_249_254(...)





local args={...}
local subType=SUB_ACTIVITY_TYPE.ebuyact9
local actID=args[1]
local subID=args[2]

local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end

data.gift_cnt=args[3]
if args[4]>0 then
data.list=args[5]
end
activitiesModel:setSubActInfoData(actID,subType,subID,data)
UIManager:invokeUIMethod('UISubAct_shizhuangzhigouWin','refreshSelectPanel')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_shizhuangzhigou.onShowPrize(prizeType,prizelist,effectData)

end
