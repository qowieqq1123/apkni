







activitiesHandle_xishizhenbao=new_activitiesHandle('activitiesHandle_xishizhenbao',activitiesHandle)

function activitiesHandle_xishizhenbao:onInit()

end

function activitiesHandle_xishizhenbao:reqFreeGift(actId,subId)

local subType=SUB_ACTIVITY_TYPE.eXiShiZhenBao
local jstr=jsonHelper.encode({1})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_xishizhenbao:reqBuy(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eXiShiZhenBao
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end
if info:checkCanBuy()then
local config=activitiesModel:getSubActivityConfig(subType,subId)
local params=payControl.getActivityPayParams(actId,subType,subId)
local rechargeId=config.recharge_id
payControl.reqPay(rechargeId,1,params)
else
UIManager.info("未达到购买条件")
end
end

function activitiesHandle_xishizhenbao.recv_247_17(args)
local actId,subId,buy_flag,free_flag,task_list_len,task_list=table.unpackEx(args)
local subType=SUB_ACTIVITY_TYPE.eXiShiZhenBao
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end
local task_num=0
if task_list_len>0 then
task_num=task_list[1].param_2
end
if info:hasData()then
info.data.buy_flag=buy_flag
info.data.free_flag=free_flag
info.data.task_num=task_num
else
local data={
buy_flag=buy_flag,
free_flag=free_flag,
task_num=task_num,
}
info:setData(data)
end
UIManager:invokeUIMethod("UISubAct_XiShiZhenBaoWin","onShow",{act_id=actId,sub_act_type=subType,sub_act_id=subId})
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_xishizhenbao.recv_247_18(actId,subId,task_list_len,task_list)
local subType=SUB_ACTIVITY_TYPE.eXiShiZhenBao
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end
local task_num=0
if task_list_len>0 then
task_num=task_list[1].param_2
end
if info:hasData()then
info.data.task_num=task_num
end
UIManager:invokeUIMethod("UISubAct_XiShiZhenBaoWin","onShow",{act_id=actId,sub_act_type=subType,sub_act_id=subId})
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end