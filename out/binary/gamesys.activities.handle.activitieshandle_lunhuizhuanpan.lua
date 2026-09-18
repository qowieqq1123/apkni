







activitiesHandle_lunhuizhuanpan=new_activitiesHandle('activitiesHandle_lunhuizhuanpan',activitiesHandle)

function activitiesHandle_lunhuizhuanpan:onInit()

end

function activitiesHandle_lunhuizhuanpan:reqReceiveStageReward(actId,subId)

local subType=SUB_ACTIVITY_TYPE.eLunHuiZhuanPan
local jstr=jsonHelper.encode({3})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_lunhuizhuanpan:reqChangeRewardLib(actId,subId,select_idx)

local subType=SUB_ACTIVITY_TYPE.eLunHuiZhuanPan
local jstr=jsonHelper.encode({1,select_idx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_lunhuizhuanpan.recv_247_49(args)
local subType=SUB_ACTIVITY_TYPE.eLunHuiZhuanPan
local actId=args[1]
local subId=args[2]
local stage_reward_idx=args[3]
local total_luck_cnt=args[4]
local daily_luck_cnt=args[5]
local select_idx=args[6]
local luck_list_len=args[7]
local luck_list=args[8]
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end
local luck_lookup={}
local round_luck_cnt=0
if luck_list_len>0 then
for i,v in ipairs(luck_list)do
luck_lookup[v.param_1]=v.param_2
round_luck_cnt=round_luck_cnt+v.param_2
end
end
local data={
stage_reward_idx=stage_reward_idx,
total_luck_cnt=total_luck_cnt,
daily_luck_cnt=daily_luck_cnt,
select_idx=select_idx,
luck_lookup=luck_lookup,
round_luck_cnt=round_luck_cnt,
}
info:setData(data)
info:initRewardLib()
UIManager:invokeUIMethod("UISubAct_lunhuizhuanpanWin","onShow")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_lunhuizhuanpan.recv_247_50(actId,subId,select_idx)
local subType=SUB_ACTIVITY_TYPE.eLunHuiZhuanPan
local infoData=activitiesModel:getSubActInfo(actId,subType,subId)
if infoData then
infoData.data.select_idx=select_idx
UIManager:invokeUIMethod("UISubAct_lunhuizhuanpanWin","changeRewardLibRefresh")
UIManager:invokeUIMethod("UISubAct_lunhuizhuanpanSelectWin","changeRewardLibRefresh")
end
end

function activitiesHandle_lunhuizhuanpan.recv_247_51(actId,subId,stage_reward_idx)
local subType=SUB_ACTIVITY_TYPE.eLunHuiZhuanPan
local infoData=activitiesModel:getSubActInfo(actId,subType,subId)
if infoData then
infoData.data.stage_reward_idx=stage_reward_idx
UIManager:invokeUIMethod("UISubAct_lunhuizhuanpanWin","refreshTargetRewardPanel")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end

function activitiesHandle_lunhuizhuanpan.recv_247_52(args)
local actId=args[1]
local subId=args[2]
local luck_type=args[3]
local luck_cnt=args[4]
local big_rw_cnt=args[5]
local rw_idx_len=args[6]
local rw_idx=args[7]
local subType=SUB_ACTIVITY_TYPE.eLunHuiZhuanPan
local infoData=activitiesModel:getSubActInfo(actId,subType,subId)
if infoData and infoData.data then
infoData.data.total_luck_cnt=infoData.data.total_luck_cnt+luck_cnt
if luck_type==1 then
infoData.data.daily_luck_cnt=infoData.data.daily_luck_cnt+luck_cnt
end
local old_luck_lookup
if big_rw_cnt>0 then
old_luck_lookup=table.deepCopy(infoData.data.luck_lookup)
infoData.data.luck_lookup={}
infoData.data.round_luck_cnt=0
elseif rw_idx_len>0 then
local luck_lookup=infoData.data.luck_lookup
for _,idx in ipairs(rw_idx)do
luck_lookup[idx]=(luck_lookup[idx]or 0)+1
end
infoData.data.round_luck_cnt=infoData.data.round_luck_cnt+luck_cnt
end
UIManager:invokeUIMethod("UISubAct_lunhuizhuanpanWin","rec_lottery",big_rw_cnt,rw_idx,luck_cnt,old_luck_lookup,luck_type)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end