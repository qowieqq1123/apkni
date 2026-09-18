





wagesMsgConfig={}

wagesTypeEnum={
eZhouKa=1,
eYueKa=2,
eXianZhi=3,
}












local wagesTypeConfig={
[wagesTypeEnum.eZhouKa]={
menuName="image_yuekawz_3",
winName="UIWeekInvestorDailyWin",
flagSpineId=5634,
receiveNotify=notifyConfig.onZhouKaReceive,
checkShow=function()
return rechargeModel:getWeekCardDailyReddot()
end,
receiveWages=function()
rechargeController:send_14_31(0)
end,
checkShowNpc=function()
return rechargeModel:checkIsHasWillExpireWeekCard()
end,
maskReceive=function()
rechargeController:send_14_31(0)
end
},
[wagesTypeEnum.eYueKa]={
menuName="image_yuekawz_1",
winName="UIMonthInvestorDailyWin",
flagSpineId=5634,
receiveNotify=notifyConfig.onYueKaReceive,
checkShow=function()
return rechargeModel:checkAllCardReddot()
end,
receiveWages=function()
rechargeController:reqMonthInvestorGetReward(0)
end,
checkShowNpc=function()
return rechargeModel:checkIsHasWillExpireMonthCard()
end,
maskReceive=function()
rechargeController:reqMonthInvestorGetReward(0)
end
},
[wagesTypeEnum.eXianZhi]={
menuName="image_yuekawz_2",
winName="UIXianJieFengLuWin",
flagSpineId=5635,
receiveNotify=notifyConfig.onXianZhiWagesReceive,
checkShow=function()

local state=false

if xianzhiModel:checkOpenXianZhi()then
state=xianzhiModel:checkCanReceiveDayXianFeng()
end





return state
end,
receiveWages=function()
xianzhiController:reqReceiveDayWages()
end,
checkShowNpc=function()
return false
end,
maskReceive=function()
xianzhiController:reqReceiveDayWages()
end
}
}

function wagesMsgConfig.getWagesInfoList()
local tempList={}

for index,wagesTypeInfo in ipairs(wagesTypeConfig)do
if wagesTypeInfo.checkShow and wagesTypeInfo.checkShow()then
tempList[#tempList+1]=wagesTypeInfo
end
end

return tempList
end

function wagesMsgConfig:doReceiveWages(typo)
if wagesTypeConfig[typo]then
wagesTypeConfig[typo].receiveWages()

UIManager:invokeUIMethod("UIWagesInfoWin","showCloseBtn")
end
end