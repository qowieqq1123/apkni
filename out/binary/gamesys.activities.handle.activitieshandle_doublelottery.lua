







activitiesHandle_doubleLottery=new_activitiesHandle('activitiesHandle_doubleLottery',activitiesHandle)

function activitiesHandle_doubleLottery:onInit()

end

function activitiesHandle_doubleLottery.recv_249_143(args)
local subType=SUB_ACTIVITY_TYPE.eTianMoBaoXia
local actId=args[1]
local subId=args[2]
local freeResetTime=args[3]
local maxGotRewardIndex=args[4]
local maxFinishCount=args[5]
local len=args[6]
local boxDrawCountList=args[7]
local boxDrawCountList_lookup={}
if len>0 then
for i,v in ipairs(boxDrawCountList)do
local boxIndex=v.param_1
local count=v.param_2
local useFreeCount=v.param_3
boxDrawCountList_lookup[boxIndex]={
boxIndex=boxIndex,
drawCount=count,
useFreeCount=useFreeCount,
}
end
end

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end
if info:hasData()then
info.data.freeResetTime=freeResetTime
info.data.maxGotRewardIndex=maxGotRewardIndex
info.data.maxFinishCount=maxFinishCount
info.data.boxDrawCountList=boxDrawCountList_lookup
else
local data={
freeResetTime=freeResetTime,
maxGotRewardIndex=maxGotRewardIndex,
maxFinishCount=maxFinishCount,
boxDrawCountList=boxDrawCountList_lookup,
}
info:setData(data)
end
UIManager:invokeUIMethod("UISubAct_doubleLotteryWin","refresh")
UIManager:invokeUIMethod("UISubAct_doubleLottery_TargetWin","refresh",true)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_doubleLottery.recv_249_144(actId,subId,maxGotRewardIndex)
local subType=SUB_ACTIVITY_TYPE.eTianMoBaoXia
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end
if info:hasData()then
info.data.maxGotRewardIndex=maxGotRewardIndex
end
UIManager:invokeUIMethod("UISubAct_doubleLotteryWin","refresh")
UIManager:invokeUIMethod("UISubAct_doubleLottery_TargetWin","refresh",true)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end