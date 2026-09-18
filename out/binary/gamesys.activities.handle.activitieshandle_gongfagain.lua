







activitiesHandle_gongfagain=new_activitiesHandle('activitiesHandle_gongfagain',activitiesHandle)

function activitiesHandle_gongfagain:onInit()

end


function activitiesHandle_gongfagain:reqDailyReward(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eTianDaoMiJi
local is_assistant=0
local jstr=jsonHelper.encode({1,is_assistant})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_gongfagain:reqTaskReward(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eTianDaoMiJi
local jstr=jsonHelper.encode({2})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_gongfagain.recv_249_116(actId,subId,dailySec,taskProgress,rewardFlag)
local subType=SUB_ACTIVITY_TYPE.eTianDaoMiJi

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if not info then return end

if info:hasData()then
local data=info:getData()
data.dailySec=dailySec
data.taskProgress=taskProgress
data.rewardFlag=rewardFlag
else
local data={
dailySec=dailySec,
taskProgress=taskProgress,
rewardFlag=rewardFlag,
}
info:setData(data)
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_gongfagain:autoReceiveFreeGift(checkReddot)
local subType=SUB_ACTIVITY_TYPE.eTianDaoMiJi
local actList=activitiesModel:getActSubList_subType_open_doing(subType)
local protocolData={}
if actList then
for _,sub_actInfo in ipairs(actList)do
local act_id=sub_actInfo.act_id
local sub_act_id=sub_actInfo.sub_act_id
local data=sub_actInfo.data
if data.dailySec<=0 or not timeHelper.isTodayShort(data.dailySec)then
if checkReddot then
return true
end
local jsonStr=jsonHelper.encode({1,1})
table.insert(protocolData,{act_id,sub_act_id,jsonStr})
end
end
end
if#protocolData>0 then
for i,v in ipairs(protocolData)do
local act_id=v[1]
local sub_act_id=v[2]
local jsonStr=v[3]
activitiesController:sendProtocol(actSendType.eComonReqHandle,act_id,subType,sub_act_id,jsonStr)
end
end
end