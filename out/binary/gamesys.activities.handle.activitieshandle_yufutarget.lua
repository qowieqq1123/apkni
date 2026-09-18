







activitiesHandle_yufutarget=new_activitiesHandle('activitiesHandle_yufutarget',activitiesHandle)

activitiesHandle_yufutarget.clientTaskType={196,197,198}

function activitiesHandle_yufutarget:onInit()

end



function activitiesHandle_yufutarget.recv_249_208(args)
local subType=SUB_ACTIVITY_TYPE.eYuFuMuBiao
local actId=args[1]
local subId=args[2]

local len=args[3]
local tasklist=args[4]or{}
local len2=args[5]
local zjrwTagList=args[6]or{}


local data={len=len,tasklist=tasklist,len2=len2,zjrwTagList=zjrwTagList}
activitiesModel:setSubActInfoData(actId,subType,subId,data)


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_yufutarget.recv_249_209(actId,subId,len,tasklist)
local subType=SUB_ACTIVITY_TYPE.eYuFuMuBiao
local actId=actId
local subId=subId
local len=len
local tasklist=tasklist
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if data.tasklist then
local tasktb=table.weakCopy(data.tasklist)
for k,v in ipairs(tasklist)do
local flag=false
for k1,v1 in ipairs(data.tasklist)do
if v.taskId==v1.taskId then
v1.finishFlag=v.finishFlag
v1.finishNum=v.finishNum
v1.rwFlag=v.rwFlag
flag=true
end
end
if not flag then
tasktb[#tasktb+1]=v
end
end
data.tasklist=tasktb
else
data.len=len
data.tasklist=tasklist
end

activitiesModel:setSubActInfoData(actId,subType,subId,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
UIManager:invokeUIMethod('UISubAct_YuFuActivityWin','refresh',actId,subType,subId)

end

function activitiesHandle_yufutarget.recv_249_211(actId,subId,len,zjrwTagList)
local subType=SUB_ACTIVITY_TYPE.eYuFuMuBiao

local data=activitiesModel:getSubActInfoData(actId,subType,subId)

data.len2=len
data.zjrwTagList=zjrwTagList

activitiesModel:setSubActInfoData(actId,subType,subId,data)
UIManager:invokeUIMethod('UISubAct_YuFuActivityWin','refresh',actId,subType,subId)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_yufutarget:reqtaskReward(actId,subId,id)
local subType=SUB_ACTIVITY_TYPE.eYuFuMuBiao
local jstr=jsonHelper.encode({id})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jstr)
end