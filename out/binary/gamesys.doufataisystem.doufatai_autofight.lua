




local fightNum=0

function douFaTaiController:startAutoFight(orderID)

if douFaTaiModel:checkIsTruce()then
douFaTaiController:showAutoError(orderID,"斗法台处于休战中")
return
end

fightNum=0

local setupData=xiaoZhuShouModel:getSetupData(orderID)
local times=0

local dftItemFight=setupData[xzsDataKey.dftItemFight]
if dftItemFight==1 then
times=setupData[xzsDataKey.dftItemFightNum]or 0
if times and tostring(times)=='userdata: NULL'or type(times)=='userdata'then
times=0
end
local useItemTimes=setupData[xzsDataKey.dftItemFightUseNum]or 0
if useItemTimes and(tostring(useItemTimes)=='userdata: NULL'or type(useItemTimes)=='userdata')then
useItemTimes=0
end
if useItemTimes>0 then
local useItemTime=setupData[xzsDataKey.dftItemFightUseTime]
if useItemTime then
useItemTime=tonumber(useItemTime)
local isday=timeHelper.isOutFiveStamp2(timeHelper.convertLongStamp(useItemTime))

if not isday then
times=times-useItemTimes
else
setupData[xzsDataKey.dftItemFightUseNum]=0
end
end
end
end

self.isUseItem=false

local freenum=douFaTaiModel:get_doufatai_freenum()
if freenum<=0 then
if times<=0 then
douFaTaiController:showAutoError(orderID,"当天挑战次数已用完")
return
else
local config=douFaTaiModel:getDouFaTaiBasicConfig()
local cost=config.challenge_item[1]
local itemid=cost[1]
local needItem=cost[2]
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if haveItem<needItem then
douFaTaiController:showAutoError(orderID,FMT.fmt("{0}不足",itemsConfig.getItemName(itemid)))
return
end
self.isUseItem=true
end


end


if times>0 then
setupData[xzsDataKey.dftItemFightUseTime]=tostring(timeHelper.getServerShortTime())
xiaoZhuShouModel:flushSetupData()
end

self.autoTimes=times
self.isStartAutoFight=true

douFaTaiController:req_select_actor()
xiaoZhuShouOrderFunc.dft_autoFight(orderID)
end

function douFaTaiController:showAutoError(orderID,errorLog)
local detailCfg=cfg_xiaozhushoudetailconfig_get(XIAOZHUSHUDETAIL_ENUM.xzs_sub_dft)
local args={
orderID=orderID,
state=-1,
title=detailCfg.name,
icon=detailCfg.icon,
error=errorLog,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_ss,args)
end

function douFaTaiController:updateAutoFight(orderID,result)

if self.isUseItem then
self.autoTimes=(self.autoTimes or 0)-1
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local dftItemFight=setupData[xzsDataKey.dftItemFight]
local useNum=setupData[xzsDataKey.dftItemFightUseNum]or 0
if dftItemFight then
if useNum and tostring(useNum)=='userdata: NULL'then
useNum=0
end
setupData[xzsDataKey.dftItemFightUseNum]=useNum+1
xiaoZhuShouModel:flushSetupData()
end
end

if result~=fightResultType.Victory then
douFaTaiController:onFinishAutoFight(true)
return
end

fightNum=fightNum+1

local freenum=douFaTaiModel:get_doufatai_freenum()

if freenum<=0 then
local config=douFaTaiModel:getDouFaTaiBasicConfig()
local cost=config.challenge_item[1]
local itemid=cost[1]
local needItem=cost[2]
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if haveItem<needItem then
self:onFinishAutoFight()
self.isStartAutoFight=nil
return
end

if self.autoTimes<=0 then
self:onFinishAutoFight()
self.isStartAutoFight=nil
return
end
self.isUseItem=true
end
xiaoZhuShouOrderFunc.dft_autoFight(orderID)
end

function douFaTaiController:onFinishAutoFight(isLose)
if isLose then
local str=fightNum>0 and string.format("斗法台已完成挑战%s次，剩余自动挑战失败",fightNum)or"斗法台自动挑战失败，已停止自动挑战"
xiaoZhuShouModel:addReportData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_dft,str)
end
xiaoZhuShouController:setIdleState()
end
