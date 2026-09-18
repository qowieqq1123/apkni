
activitiesHandle_zongmengxiuxing=new_activitiesHandle('activitiesHandle_zongmengxiuxing',activitiesHandle)










function activitiesHandle_zongmengxiuxing.recv_249_245(args)
local actid,act2id,recv_idx,len,sectTasks,len2,recordIdxs=args[1],args[2],args[3],args[4],args[5],args[6],args[7]
local subType=SUB_ACTIVITY_TYPE.eSectPractice
local actID=actid
local subID=act2id
local data={}
data.targetRecvIdx=recv_idx
local taskdatalookUp={}
local tasks=activitiesModel:getSubActivityConfig(subType,subID,"tasks")
for i,v in ipairs(tasks)do
local temp={}
temp.task_idx=i
temp.task_progress=0
temp.task_flag=0
taskdatalookUp[i]=temp
end
if len>0 then
for i,v in ipairs(sectTasks)do
taskdatalookUp[v.task_idx]=v
end
end
data.taskdatalookUp=taskdatalookUp

local selectList={}
local target_rewards=activitiesModel:getSubActivityConfig(subType,subID,"target_rewards")
local localSelectList=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_selectList',actID,subID),{})
local noFixIndex=0
for i,v in ipairs(target_rewards)do
local rewards=v[2]
local isFix=#rewards==1
local selectIdx=1
if not isFix then
noFixIndex=noFixIndex+1
selectIdx=localSelectList[i]
if recordIdxs and recordIdxs[noFixIndex]then
selectIdx=recordIdxs[noFixIndex]
end
end
selectList[i]=selectIdx
end
data.selectList=selectList
activitiesModel:setSubActInfoData(actID,subType,subID,data)
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_selectList',actID,subID),selectList)
end

function activitiesHandle_zongmengxiuxing.recv_249_246(actid,act2id,len,taskIds)
if len<=0 then
return
end
local subType=SUB_ACTIVITY_TYPE.eSectPractice
local actID=actid
local subID=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
local taskdatalookUp=data.taskdatalookUp
for i,v in ipairs(taskIds)do
if taskdatalookUp[v]then
taskdatalookUp[v].task_flag=2
end
end
UIManager:invokeUIMethod("UISubAct_ZMXiuXing_Win","sortTaskDayCfg")
UIManager:invokeUIMethod("UISubAct_ZMXiuXing_Win","refreshHorContent")
UIManager:invokeUIMethod("UISubAct_ZMXiuXing_Win","refreshVerContent")
UIManager:invokeUIMethod("UISubAct_ZMXiuXing_Win","refreshProgressContent",true)
UIManager:invokeUIMethod("UISubAct_ZMXX_HW_Win","sortTaskDayCfg")
UIManager:invokeUIMethod("UISubAct_ZMXX_HW_Win","refreshHorContent")
UIManager:invokeUIMethod("UISubAct_ZMXX_HW_Win","refreshVerContent")
UIManager:invokeUIMethod("UISubAct_ZMXX_HW_Win","refreshProgressContent",true)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_zongmengxiuxing.recv_249_247(actid,act2id,recv_idx)
local subType=SUB_ACTIVITY_TYPE.eSectPractice
local actID=actid
local subID=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
data.targetRecvIdx=recv_idx
UIManager:invokeUIMethod("UISubAct_ZMXiuXing_Win","refreshProgressContent",true)
UIManager:invokeUIMethod("UISubAct_ZMXX_HW_Win","refreshProgressContent",true)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_zongmengxiuxing.recv_249_248(actid,act2id,len,sectTasks)
local subType=SUB_ACTIVITY_TYPE.eSectPractice
local actID=actid
local subID=act2id

local data=activitiesModel:getSubActInfoData(actID,subType,subID)
local taskdatalookUp=data.taskdatalookUp
if not taskdatalookUp then
data.taskdatalookUp={}
taskdatalookUp=data.taskdatalookUp
local tasks=activitiesModel:getSubActivityConfig(subType,subID,"tasks")
for i,v in ipairs(tasks)do
local temp={}
temp.task_idx=i
temp.task_progress=0
temp.task_flag=0
taskdatalookUp[i]=temp
end
end
if len>0 then
for i,v in ipairs(sectTasks)do
taskdatalookUp[v.task_idx]=v
end
end
if not data.targetRecvIdx then
data.targetRecvIdx=0
end
activitiesModel:setSubActInfoData(actID,subType,subID,data)
UIManager:invokeUIMethod("UISubAct_ZMXiuXing_Win","sortTaskDayCfg")
UIManager:invokeUIMethod("UISubAct_ZMXiuXing_Win","refreshHorContent")
UIManager:invokeUIMethod("UISubAct_ZMXiuXing_Win","refreshVerContent")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_zongmengxiuxing:reqTaskReward(actId,subId,taskIdList)
local subType=SUB_ACTIVITY_TYPE.eSectPractice
local actID=actId
local subID=subId

local jstr=jsonHelper.encode({1,taskIdList})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)

end

function activitiesHandle_zongmengxiuxing:reqTargetReward(actId,subId,selectIdxsLsit)
local subType=SUB_ACTIVITY_TYPE.eSectPractice
local actID=actId
local subID=subId

local jstr=jsonHelper.encode({2,selectIdxsLsit})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end



