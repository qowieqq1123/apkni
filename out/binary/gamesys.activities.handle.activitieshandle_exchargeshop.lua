
activitiesHandle_exchargeshop=new_activitiesHandle('activitiesHandle_exchargeshop',activitiesHandle)

function activitiesHandle_exchargeshop:onInit()

end

function activitiesHandle_exchargeshop.onExchargeShopInit(args)
local subType=SUB_ACTIVITY_TYPE.eDuiHuanShangDian
local actId=args[1]
local subId=args[2]
local exp=args[3]
local len=args[4]
local list=args[5]
local flag=args[6]
activitiesHandle_exchargeshop:handleList(actId,subId,list,true)
local data={exp=exp,list=list,flag=flag}
local lastData=activitiesModel:getSubActInfoData(actId,subType,subId)
activitiesModel:setSubActInfoData(actId,subType,subId,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_exchargeshop.onExchargeShopBuy(actId,subId,idx,times,exp)
local subType=SUB_ACTIVITY_TYPE.eDuiHuanShangDian
local lastData=activitiesModel:getSubActInfoData(actId,subType,subId)
local model=activitiesModel:getSubActInfo(actId,subType,subId)
local lastshoplevel=model:getShopLevel()
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
lastData.exp=exp
local shoplevel=model:getShopLevel()
local changelv=shoplevel~=lastshoplevel
activitiesModel:setSubActInfoData(actId,subType,subId,lastData)
UIManager:callWindowFunc('UIExchargeShopPanel','onBuyGood',idx,changelv)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_exchargeshop.onNewDay(actId,subId)

local subType=SUB_ACTIVITY_TYPE.eDuiHuanShangDian
local lastData=activitiesModel:getSubActInfoData(actId,subType,subId)or{}
activitiesHandle_exchargeshop:handleList(actId,subId,lastData.list,false)
UIManager:callWindowFunc('UIExchargeShopPanel','freshInfo')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_exchargeshop.onExchargeShopRewards(actId,subId,flag)
local subType=SUB_ACTIVITY_TYPE.eDuiHuanShangDian
local lastData=activitiesModel:getSubActInfoData(actId,subType,subId)or{}
lastData.flag=flag
activitiesModel:setSubActInfoData(actId,subType,subId,lastData)
UIManager:callWindowFunc('UIExchargeShopPanel','onRewards')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_exchargeshop:handleList(actId,subId,list,init)
local subType=SUB_ACTIVITY_TYPE.eDuiHuanShangDian
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