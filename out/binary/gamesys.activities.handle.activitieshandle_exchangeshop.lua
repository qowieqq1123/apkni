







activitiesHandle_exchangeshop=new_activitiesHandle('activitiesHandle_exchangeshop',activitiesHandle)

function activitiesHandle_exchangeshop:onInit()

end

function activitiesHandle_exchangeshop:onEnterState()
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
end

function activitiesHandle_exchangeshop:onLeaveState()
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
end


function activitiesHandle_exchangeshop.on_money_changed(moneyType)
local sub_actcfg=cfgHelper.get1(cfg_exchangeshop2config_get,1)
local costId=sub_actcfg.money
local subType=SUB_ACTIVITY_TYPE.eDuiHuanShangDian2

if costId and costId==moneyType then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end

function activitiesHandle_exchangeshop.recv_247_1(actId,subId,len,array)
local actId=actId
local subId=subId
local subType=SUB_ACTIVITY_TYPE.eDuiHuanShangDian2
local infoData=activitiesModel:getSubActInfoData(actId,subType,subId)
if infoData==nil then return end
activitiesHandle_exchangeshop:handleList(actId,subId,array,true)
infoData.len=len
infoData.list=array
activitiesModel:setSubActInfoData(actId,subType,subId,infoData)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_exchangeshop.recv_247_2(actId,subId,idx,times)
local subType=SUB_ACTIVITY_TYPE.eDuiHuanShangDian2
local lastData=activitiesModel:getSubActInfoData(actId,subType,subId)
local stamp=timeHelper.getServerShortTime()
local info={param_1=idx,param_2=times,param_3=stamp}
local list=lastData.list or{}
for i,v in ipairs(list)do
if v.param_1==idx then
table.remove(list,i)
break
end
end
list[#list+1]=info
lastData.list=list

activitiesModel:setSubActInfoData(actId,subType,subId,lastData)
UIManager:invokeUIMethod('UIExchangeShopWin','onBuyGood',idx)
UIManager:invokeUIMethod('UISubAct_YHDBExchangeShopWin','onBuyGood',idx)
UIManager:invokeUIMethod('UIXYBGShopWin','onBuyGood',idx)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_exchangeshop.onNewDay(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eDuiHuanShangDian2
local lastData=activitiesModel:getSubActInfoData(actId,subType,subId)or{}

activitiesHandle_exchangeshop:handleList(actId,subId,lastData.list,false)






reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

UIManager:invokeUIMethod('UIExchangeShopWin','freshGirds')
UIManager:invokeUIMethod('UIXYBGShopWin','freshGirds')
UIManager:invokeUIMethod('UIXYBGShopWin','setRemainingTimeTimer')
UIManager:invokeUIMethod('UIXYBGShopWin','refreshRewardBtn')
end

function activitiesHandle_exchangeshop:handleList(actId,subId,list,init)
local subType=SUB_ACTIVITY_TYPE.eDuiHuanShangDian2
local config=activitiesModel:getSubActivityConfig(subType,subId)
local good=config.good
local isDayReset=function(idx)
return good[idx][7]~=0
end
if list then
for i,v in ipairs(list)do

if isDayReset(v.param_1)then
if not init then
v.param_2=0
v.param_3=timeHelper.getServerShortTime()
else
if not timeHelper.isTodayStamp(timeHelper.convertLongStamp(v.param_3))then
v.param_2=0
v.param_3=timeHelper.getServerShortTime()
end
end
end
end
end
end

function activitiesHandle_exchangeshop:setReceiveState(isCanReward,time)
local list={}
list.time=time
list.isReceive=isCanReward

userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianYunBaoGe,'isReceive',list)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianYunBaoGe)
end

function activitiesHandle_exchangeshop:getReceiveState()
local list=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianYunBaoGe,'isReceive',{})
local isCanReward=list.isReceive
local time=list.time or 0
if isCanReward==nil then isCanReward=true end

return isCanReward,time
end

function activitiesHandle_exchangeshop:isHaveReddot(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eDuiHuanShangDian2

local config=activitiesModel:getSubActivityConfig(subType,subId)
local giftId=config.giftId or nil

if giftId then
local data={actId,subType,subId}
local state=FreeGiftController.GetFreeGift(giftId,data)
return state
end










return false
end