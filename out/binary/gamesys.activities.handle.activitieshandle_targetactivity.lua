







activitiesHandle_targetActivity=new_activitiesHandle('activitiesHandle_targetActivity',activitiesHandle)

function activitiesHandle_targetActivity:onInit()

end

function activitiesHandle_targetActivity:reqTaskReward(actId,subId,groupId)

local subType=SUB_ACTIVITY_TYPE.eMuBiaoHuoDong
local jstr=jsonHelper.encode({1,groupId})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_targetActivity:reqGroupReward(actId,subId,groupId)

local subType=SUB_ACTIVITY_TYPE.eMuBiaoHuoDong
local jstr=jsonHelper.encode({2,groupId})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end

function activitiesHandle_targetActivity.recv_249_15(datas)
local actId=datas[1]
local subId=datas[2]
local subType=SUB_ACTIVITY_TYPE.eMuBiaoHuoDong
local data={}
local groupData={}
if datas[4]then
for i,v in ipairs(datas[4])do
groupData[v.param_1]=v.param_2
end
end
data.groupData=groupData
local taskData={}
if datas[6]then
for i,v in ipairs(datas[6])do
taskData[v.taskid]=v
end
end
data.taskData=taskData
data.progress=datas[7]
activitiesModel:setSubActInfoData(actId,subType,subId,data)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_targetActivity.recv_249_16(actId,subId,taskId)
local subType=SUB_ACTIVITY_TYPE.eMuBiaoHuoDong
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
local task=data.taskData[taskId]
task.taskstate=3

local cfg=cfgHelper.get1(cfg_targetactivity1config_get,subId)
local td=cfg.tasks[taskId]
local groupId=td.task[2]
local info=activitiesModel:getSubActInfo(actId,SUB_ACTIVITY_TYPE.eMuBiaoHuoDong,subId)
if info['isGroupComplete'](info,subId,groupId)then
data.groupData[groupId]=2
end

UIManager:callWindowFunc('UITargetActivityWin','refresh')

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_targetActivity.recv_249_17(actId,subId,groupId)
local subType=SUB_ACTIVITY_TYPE.eMuBiaoHuoDong
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
data.groupData[groupId]=3

UIManager:callWindowFunc('UITargetActivityWin','refresh')

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)








end

function activitiesHandle_targetActivity.recv_249_18(actId,subId,progress)
local subType=SUB_ACTIVITY_TYPE.eMuBiaoHuoDong
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
data.progress=progress

UIManager:callWindowFunc('UITargetActivityWin','refresh')
end

function activitiesHandle_targetActivity.recv_249_19(actId,subId,len,arr)
local subType=SUB_ACTIVITY_TYPE.eMuBiaoHuoDong
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
local info=activitiesModel:getSubActInfo(actId,SUB_ACTIVITY_TYPE.eMuBiaoHuoDong,subId)
local cfg=cfgHelper.get1(cfg_targetactivity1config_get,subId)
if len>0 then

for i,v in ipairs(arr)do
if data.taskData==nil then data.taskData={}end
data.taskData[v.taskid]=v




if v.taskstate==3 then
local td=cfg.tasks[v.taskid]
local groupId=td.task[2]
if info['isGroupComplete'](info,subId,groupId)then
data.groupData[groupId]=2
end
end
end



end

UIManager:callWindowFunc('UITargetActivityWin','refresh')

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end