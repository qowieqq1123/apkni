
















activitiesHandle_tianshuxiuxing=new_activitiesHandle('activitiesHandle_tianshuxiuxing',activitiesHandle)

function activitiesHandle_tianshuxiuxing:onInit()

end


function activitiesHandle_tianshuxiuxing.recv_249_65(actid,act2id,tasklistlen,taskList,targetidx)









local subType=SUB_ACTIVITY_TYPE.eTianShuXiuXing
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

local sub_actcfg=activitiesModel:getSubActivityConfig(subType,subid)
local taskLookup={}
local temp={}
if taskList then
for i,v in ipairs(taskList)do
temp[v.param_1]=v
end
end
for i,v in ipairs(sub_actcfg.task)do
if v[4]>0 then
local taskData={groupIndex=i,maxIndex=#v[3]}
taskData.sortid=100-v[4]
if temp[i]then
taskData.task_progress=temp[i].param_3
taskData.rewardIndex=temp[i].param_2
else
taskData.task_progress=0
taskData.rewardIndex=0
end
activitiesHandle_tianshuxiuxing.handleTaskData(taskData,v)
taskLookup[i]=taskData
end
end
data.taskLookup=taskLookup
data.targetidx=targetidx

activitiesModel:setSubActInfoData(actID,subType,subid,data)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_tianshuxiuxing.recv_249_66(actid,act2id,taskidx,taskaimidx)





local subType=SUB_ACTIVITY_TYPE.eTianShuXiuXing
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
if data.taskLookup==nil then return end
local sub_actcfg=activitiesModel:getSubActivityConfig(subType,subid)


local taskTargetIdxList=taskaimidx
for _,v in ipairs(taskTargetIdxList)do
local taskData=data.taskLookup[v.param_1]
taskData.rewardIndex=v.param_2

activitiesHandle_tianshuxiuxing.handleTaskData(taskData,sub_actcfg.task[v.param_1])
activitiesModel:setSubActInfoData(actID,subType,subid,data)
end


UIManager:invokeUIMethod('UISubAct_tianshuxiuxing_win','recv_taskReward')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_tianshuxiuxing.recv_249_67(actid,act2id,targetidx)




local subType=SUB_ACTIVITY_TYPE.eTianShuXiuXing
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
data.targetidx=targetidx
activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_tianshuxiuxing_win','recv_tagReward')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_tianshuxiuxing.recv_249_68(actid,act2id,taskidx,taskprogress)





local subType=SUB_ACTIVITY_TYPE.eTianShuXiuXing
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
if data.taskLookup==nil then return end
local taskData=data.taskLookup[taskidx]
taskData.task_progress=taskprogress
activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_tianshuxiuxing_win','recv_taskRefresh',taskidx)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_tianshuxiuxing.handleTaskData(taskData,cfg)
if taskData.rewardIndex==0 then
taskData.curIndex=1
elseif taskData.rewardIndex>=taskData.maxIndex then
taskData.curIndex=taskData.maxIndex
else
taskData.curIndex=taskData.rewardIndex+1
end
local aim=cfg[3][taskData.curIndex]
taskData.aimnum=aim[1]
taskData.rewards=table.deepCopy(aim[2])
end

function activitiesHandle_tianshuxiuxing.checkTaskReward(taskData)
return taskData.curIndex>taskData.rewardIndex and taskData.task_progress>=taskData.aimnum
end

function activitiesHandle_tianshuxiuxing.checkTaskFinish(taskData)
return taskData.rewardIndex>=taskData.maxIndex
end