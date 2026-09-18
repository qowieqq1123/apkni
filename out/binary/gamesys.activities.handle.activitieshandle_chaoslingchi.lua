







activitiesHandle_chaoslingchi=new_activitiesHandle('activitiesHandle_chaoslingchi',activitiesHandle)

function activitiesHandle_chaoslingchi:onInit()

end

function activitiesHandle_chaoslingchi:reqReward(actId,subId,rewardIdx)

local subType=SUB_ACTIVITY_TYPE.eLotteryact7
local jstr=jsonHelper.encode({4,rewardIdx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_chaoslingchi:reqExchange(actId,subId,giftIdx,num)

local subType=SUB_ACTIVITY_TYPE.eLotteryact7
local jstr=jsonHelper.encode({3,giftIdx,num})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_chaoslingchi:reqFixChaosLingChi(actId,subId)

local subType=SUB_ACTIVITY_TYPE.eLotteryact7
local jstr=jsonHelper.encode({2})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_chaoslingchi.recv_247_10(args)
local subType=SUB_ACTIVITY_TYPE.eLotteryact7
local actId=args[1]
local subId=args[2]
local great=args[3]
local len=args[4]
local array=args[5]
local free=args[6]
local fix_time=args[7]
local lib_idx=args[8]

local recordList=args[10]or{}
local recvIdx=args[11]
local total=args[12]
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end
local exchanges={}
for i=1,len do
local v=array[i]
exchanges[v.param_1]=v.param_2
end
local config=activitiesModel:getSubActivityConfig(subType,subId)
for i,v in ipairs(config.gift)do
if not exchanges[i]then
exchanges[i]=0
end
end
local fullValue=nil
local fullReddot=nil
for i,v in ipairs(config.gift)do
fullValue=fullValue and math.min(fullValue,v[3])or v[3]
fullReddot=fullReddot and math.max(fullReddot,v[3])or v[3]
end

local len=#recordList
if config.record_cnt>0 and len>config.record_cnt then
recordList=table.sub(recordList,len-config.record_cnt+1,len)
end
if info:hasData()then
info.data.free=free
info.data.great=great
info.data.fix_time=fix_time
info.data.lib_idx=lib_idx
info.data.exchanges=exchanges
info.data.fullValue=fullValue
info.data.fullReddot=fullReddot
info.data.fix_flag=false
info.data.recordList=recordList
info.data.recvIdx=recvIdx
info.data.total=total
else
local data={
free=free,
great=great,
fix_time=fix_time,
lib_idx=lib_idx,
exchanges=exchanges,
fullValue=fullValue,
fullReddot=fullReddot,
fix_flag=false,
recordList=recordList,
recvIdx=recvIdx,
total=total,
}
info:setData(data)
end
info:initSelfRecordList()
UIManager:invokeUIMethod("UISubAct_ChaosLingChiWin","refreshView",actId,subType,subId)
UIManager:invokeUIMethod("UISubAct_ChaosLingChiExchangeWin","refreshView",actId,subType,subId)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_chaoslingchi.recv_247_11(args)
local actId=args[1]
local subId=args[2]
local great=args[3]
local free=args[4]
local lib_idx=args[5]
local total=args[6]
local now_sec=args[7]
local subType=SUB_ACTIVITY_TYPE.eLotteryact7
local infoData=activitiesModel:getSubActInfo(actId,subType,subId)
if infoData then
infoData.data.great=great
infoData.data.fix_time=0
infoData.data.lib_idx=lib_idx
infoData.data.free=free
infoData.data.total=total
infoData.data.now_sec=now_sec

if lib_idx>0 then
infoData.data.fix_flag=true
end
UIManager:invokeUIMethod("UISubAct_ChaosLingChiWin","refreshView",actId,subType,subId)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end

function activitiesHandle_chaoslingchi.recv_247_12(args)
local actId=args[1]
local subId=args[2]
local fix_time=args[3]
local great=args[4]
local total=args[5]
local now_sec=args[6]
local subType=SUB_ACTIVITY_TYPE.eLotteryact7
local infoData=activitiesModel:getSubActInfo(actId,subType,subId)
if infoData then
local cfg=cfgHelper.get1(cfg_lotteryact6libconfig_get,infoData.data.lib_idx)
if not cfg then
loggerUtil.logErrFMT("扭蛋机抽奖修复进度模板未找到id：{0} 的配置",infoData.data.lib_idx)
return
end
local lib_cfg=cfg.lib_conf
infoData.data.fix_time=fix_time
infoData.data.great=great
infoData.data.fix_flag=false
infoData.data.total=total
infoData.data.now_sec=now_sec
if fix_time>=#lib_cfg then
infoData.data.lib_idx=0
else
UIManager:invokeUIMethod("UISubAct_ChaosLingChiWin","play_Animation",actId,subType,subId)
end
UIManager:invokeUIMethod("UISubAct_ChaosLingChiWin","refreshView_OnlyNext",actId,subType,subId)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end

function activitiesHandle_chaoslingchi.recv_247_13(actId,subId,idx,num)
local subType=SUB_ACTIVITY_TYPE.eLotteryact7
local infoData=activitiesModel:getSubActInfo(actId,subType,subId)
if infoData then
infoData.data.exchanges[idx]=num
UIManager:invokeUIMethod("UISubAct_ChaosLingChiExchangeWin","refreshView",actId,subType,subId)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end

function activitiesHandle_chaoslingchi.recv_247_14(actId,subId,len,recordList)
local subType=SUB_ACTIVITY_TYPE.eLotteryact7
local infoData=activitiesModel:getSubActInfo(actId,subType,subId)
if infoData then
infoData.data.recordList=infoData.data.recordList or{}
for i=1,len do
table.insert(infoData.data.recordList,recordList[i])
end
local config=activitiesModel:getSubActivityConfig(subType,subId)
local len=#infoData.data.recordList
if config.record_cnt>0 and len>config.record_cnt then
infoData.data.recordList=table.sub(infoData.data.recordList,len-config.record_cnt+1,len)
end
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end

function activitiesHandle_chaoslingchi.recv_247_15(actId,subId,recv_idx)
local subType=SUB_ACTIVITY_TYPE.eLotteryact7
local infoData=activitiesModel:getSubActInfo(actId,subType,subId)
if infoData then
infoData.data.recvIdx=recv_idx
UIManager:invokeUIMethod("UISubAct_ChaosLingChiWin","refreshView_OnlyNext",actId,subType,subId)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end