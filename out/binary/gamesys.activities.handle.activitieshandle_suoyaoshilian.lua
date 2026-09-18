







activitiesHandle_suoyaoshilian=new_activitiesHandle('activitiesHandle_suoyaoshilian',activitiesHandle)

function activitiesHandle_suoyaoshilian:onInit()

end


function activitiesHandle_suoyaoshilian.recv_249_24(args)
local subType=SUB_ACTIVITY_TYPE.eSuoYaoShiLian
local actId=args[1]
local subId=args[2]
local shilianMyLen=args[3]
local shilianMy=args[4]
local shilianFullLen=args[5]
local shilianFull=args[6]
local qiansanListLen=args[7]
local qiansanList=args[8]

local shilianInfo_self={}
local shilianInfo_full={}
local top3RankList={}
if shilianMyLen and shilianMyLen>0 then
for i,infoIndex in ipairs(shilianMy)do
shilianInfo_self[infoIndex]=true
end
end

if shilianFullLen and shilianFullLen>0 then
for i,info in ipairs(shilianFull)do
local floor=info.param_1
local clearCount=info.param_2
local gotMaxTargetCount=info.param_3 or 0

local fullInfo={
floor=floor,
clearCount=clearCount,
gotMaxTargetCount=gotMaxTargetCount
}
shilianInfo_full[floor]=fullInfo
end
end

if qiansanListLen and qiansanListLen>0 then
for i,info in ipairs(qiansanList)do
local rank=info.rank
top3RankList[rank]=info
end
end











local data=activitiesModel:getSubActInfoData(actId,subType,subId)
data.shilianInfo_self_len=shilianMyLen
data.shilianInfo_self=shilianInfo_self
data.shilianInfo_full_len=shilianFullLen
data.shilianInfo_full=shilianInfo_full
data.top3RankListLen=qiansanListLen
data.top3RankList=top3RankList

data.shilianFullReddot=nil
data.isInitData=true

activitiesModel:setSubActInfoData(actId,subType,subId,data)

if not data.isInitConfig then

local model=activitiesModel:getSubActInfo(actId,subType,subId)
model:initConfigList_sort()
end


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

UIManager:invokeUIMethod('UISubAct_suoyaoshilianWin','refresh')
UIManager:invokeUIMethod('UISubAct_suoyaoshilian_rewardWin','refresh')

end


function activitiesHandle_suoyaoshilian.recv_249_25(actId,subId,layer,passNum)
local subType=SUB_ACTIVITY_TYPE.eSuoYaoShiLian
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if not data or not data.isInitData then

return
end

if not data.shilianInfo_full then
data.shilianInfo_full={}
end


if data.shilianInfo_full[layer]then
data.shilianInfo_full[layer].clearCount=passNum
else
data.shilianInfo_full[layer]={
floor=layer,
clearCount=passNum,
gotMaxTargetCount=0,
}
end
activitiesModel:setSubActInfoData(actId,subType,subId,data)


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)


UIManager:invokeUIMethod('UISubAct_suoyaoshilianWin','refresh')
local win=UIManager:findActiveWindow('UISubAct_suoyaoshilian_rewardWin')
if win then



UIManager:invokeUIMethod('UISubAct_suoyaoshilian_rewardWin','refresh')
end
end