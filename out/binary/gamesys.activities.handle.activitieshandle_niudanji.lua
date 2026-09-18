







activitiesHandle_niudanji=new_activitiesHandle('activitiesHandle_niudanji',activitiesHandle)

function activitiesHandle_niudanji:onInit()

end

function activitiesHandle_niudanji:reqExchange(actId,subId,giftIdx,num)

local subType=SUB_ACTIVITY_TYPE.eNiuDanJi
local jstr=jsonHelper.encode({3,giftIdx,num})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_niudanji:reqFixNiuDanJi(actId,subId)

local subType=SUB_ACTIVITY_TYPE.eNiuDanJi
local jstr=jsonHelper.encode({2})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_niudanji.recv_249_220(args)
local subType=SUB_ACTIVITY_TYPE.eNiuDanJi
local actId=args[1]
local subId=args[2]
local great=args[3]
local len=args[4]
local array=args[5]
local free=args[6]
local fix_time=args[7]
local lib_idx=args[8]
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
if info:hasData()then
info.data.free=free
info.data.great=great
info.data.fix_time=fix_time
info.data.lib_idx=lib_idx
info.data.exchanges=exchanges
info.data.fullValue=fullValue
info.data.fullReddot=fullReddot
info.data.fix_flag=false
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
}
info:setData(data)
end
UIManager:invokeUIMethod("UISubAct_NiuDanJiWin","refreshView",actId,subType,subId)
UIManager:invokeUIMethod("UISubAct_NiuDanJiExchangeWin","refreshView",actId,subType,subId)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_niudanji.recv_249_221(actId,subId,great,free,lib_idx)
local subType=SUB_ACTIVITY_TYPE.eNiuDanJi
local infoData=activitiesModel:getSubActInfo(actId,subType,subId)
if infoData then
infoData.data.great=great
infoData.data.fix_time=0
infoData.data.lib_idx=lib_idx
infoData.data.free=free
if lib_idx>0 then
infoData.data.fix_flag=true
end
UIManager:invokeUIMethod("UISubAct_NiuDanJiWin","refreshView",actId,subType,subId)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end

function activitiesHandle_niudanji.recv_249_222(actId,subId,fix_time,great)
local subType=SUB_ACTIVITY_TYPE.eNiuDanJi
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
if fix_time>=#lib_cfg then
infoData.data.lib_idx=0
else
UIManager:invokeUIMethod("UISubAct_NiuDanJiWin","play_Animation",actId,subType,subId)
end
UIManager:invokeUIMethod("UISubAct_NiuDanJiWin","refreshView_OnlyNext",actId,subType,subId)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end

function activitiesHandle_niudanji.recv_249_223(actId,subId,idx,num)
local subType=SUB_ACTIVITY_TYPE.eNiuDanJi
local infoData=activitiesModel:getSubActInfo(actId,subType,subId)
if infoData then
infoData.data.exchanges[idx]=num
UIManager:invokeUIMethod("UISubAct_NiuDanJiExchangeWin","refreshView",actId,subType,subId)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end