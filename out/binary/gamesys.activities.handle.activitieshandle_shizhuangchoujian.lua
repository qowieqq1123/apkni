







local _LuaHelper=CS.LuaHelper

activitiesHandle_shizhuangchoujian=new_activitiesHandle('activitiesHandle_shizhuangchoujian',activitiesHandle)









local showRewards
local battleRecv
local qiyudata




function activitiesHandle_shizhuangchoujian:onEnterState()

notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
end

function activitiesHandle_shizhuangchoujian:onLeaveState()
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
end

function activitiesHandle_shizhuangchoujian:get_showRewards()
return showRewards
end

function activitiesHandle_shizhuangchoujian.recv_249_121(...)







local args={...}
args=args[1]

local subType=SUB_ACTIVITY_TYPE.eDressLottery
local actID=args[1]
local subID=args[2]

local data=activitiesModel:getSubActInfoData(actID,subType,subID)

if data==nil then return end

data.use_free_times=args[3]
data.free_sec=args[4]
data.history_use_times=args[5]
data.specialPrize={}
data.idx=args[6]

activitiesModel:setSubActInfoData(actID,subType,subID,data)


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_shizhuangchoujian.recv_249_126(...)
local args={...}
local subType=SUB_ACTIVITY_TYPE.eDressLottery
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)

if data==nil then return end
data.idx=args[3]
activitiesModel:setSubActInfoData(actID,subType,subID,data)
UIManager:invokeUIMethod('UISubAct_shizhuanchoujianWin','rec_selectUp')
end


function activitiesHandle_shizhuangchoujian.onShowPrize(prizeType,prizelist,effectData)

if prizeType==ePrizeType.eShiZhuanJianLi then




if effectData and prizelist then
local subType=SUB_ACTIVITY_TYPE.eDressLottery
local actID=effectData.actid
local subID=effectData.act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end

data.use_free_times=effectData.use_free_times
data.history_use_times=effectData.history_use_times
data.specialPrize={}
data.specialPrize=prizelist

activitiesModel:setSubActInfoData(actID,subType,subID,data)

UIManager:invokeUIMethod('UISubAct_shizhuanchoujianWin','checkSuitReward')
UIManager:invokeUIMethod('UISubAct_shizhuanchoujianWin','handelShowBuySuccess')
UIManager:invokeUIMethod('UISubAct_shizhuanchoujianWin','refreshCostBtn')
UIManager:invokeUIMethod('UISubAct_shizhuanchoujianWin','baodinum')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
else
UIManager.error('抽奖失败')
end

end
end


function activitiesHandle_shizhuangchoujian.checkreddot(actid,act2id)
local mydata=activitiesModel:getSubActInfoData(actid,SUB_ACTIVITY_TYPE.eDressLottery,act2id)
if mydata then
local cfg=cfg_lotteryact3config_get(act2id)
local free_times=cfg.free_times or 0
local use_free_times=mydata.use_free_times or 0
local hasfree=free_times-use_free_times
local costid=cfg.cost_items[1]
local costnum=cfg.cost_items[2]
local tenbuy=cfg.lottery_list[2]
local haveItem
if moneyConfig.isMoney(costid)then
haveItem=moneyModel.getMoney(costid)
else
haveItem=bagControl.invokeFuncByItemId(costid,'getItemCountByItemID',costid)
end


if hasfree>0 then

return true
else
local needCost=costnum*tenbuy
if haveItem>=needCost then

return true
else

return false
end
end
end
end

