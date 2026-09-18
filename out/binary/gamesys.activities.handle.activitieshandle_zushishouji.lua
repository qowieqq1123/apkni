







activitiesHandle_zushishouji=new_activitiesHandle('activitiesHandle_zushishouji',activitiesHandle)

function activitiesHandle_zushishouji:onInit()

end

function activitiesHandle_zushishouji:onEnterState()

end

function activitiesHandle_zushishouji:onLeaveState()

end

function activitiesHandle_zushishouji.onShowPrize(prizeType,prizelist,effectData)









end


function activitiesHandle_zushishouji.recv_247_105(args)

local subType=SUB_ACTIVITY_TYPE.eZuShiShouJi
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
data.jdrwMax=args[3]or 0
data.ztTaskList={}
data.ztLiBaoList={}
data.TfinishNum=0
data.finishTime=args[6]or 0
if args[4]>0 and args[5]then
for k,v in ipairs(args[5])do
local ztid=v.ztid

if v.len>0 and v.taskList then
local temp={}
for _,task in ipairs(v.taskList)do
temp[task.taskId]=task
end
data.ztTaskList[ztid]=temp
end

if v.len2>0 and v.lbList then
local temp={}
for _,libao in ipairs(v.lbList)do
temp[libao.param_1]=libao
end
data.ztLiBaoList[ztid]=temp
end
end
data.TfinishNum=activitiesHandle_zushishouji:getFinishTaskNum(data.ztTaskList)
end
activitiesModel:setSubActInfoData(actID,subType,subid,data)

local activityData=activitiesModel:getSubActInfo(actID,subType,subid)
activityData:initFreshTaskList2()
activityData:reqFreshTaskList()



reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)




activitiesController:refreshActEnter(actID,true)
end

function activitiesHandle_zushishouji.recv_247_106(...)
local args={...}
local subType=SUB_ACTIVITY_TYPE.eZuShiShouJi
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
if not data.ztTaskList then
data.ztTaskList={}
end
if not data.ztLiBaoList then
data.ztLiBaoList={}
end
data.finishTime=args[5]or 0
local ztid
if args[3]>0 and args[4]then
for k,v in ipairs(args[4])do
ztid=v.ztid

if v.len>0 and v.taskList then
if data.ztTaskList[ztid]then
for _,task in ipairs(v.taskList)do
data.ztTaskList[ztid][task.taskId]=task
end
else
local temp={}
for _,task in ipairs(v.taskList)do
temp[task.taskId]=task
end
data.ztTaskList[ztid]=temp
end
end

if v.len2>0 and v.lbList then
if data.ztLiBaoList[ztid]then
for _,libao in ipairs(v.lbList)do
data.ztLiBaoList[ztid][libao.param_1]=libao
end
else
local temp={}
for _,libao in ipairs(v.lbList)do
temp[libao.param_1]=libao
end
data.ztLiBaoList[ztid]=temp
end
end
end
data.TfinishNum=activitiesHandle_zushishouji:getFinishTaskNum(data.ztTaskList)
end
activitiesModel:setSubActInfoData(actID,subType,subid,data)


UIManager:invokeUIMethod("UISubAct_zushishouji","severfreshZTReddot",actID,subType,subid)
UIManager:invokeUIMethod("UISubAct_zushishouji","severfreshBtnReddot",actID,subType,subid)
UIManager:invokeUIMethod("UISubAct_zushishouji","sever_tagReward",actID,subType,subid)
UIManager:invokeUIMethod("UISubAct_zushishouji","sever_taskreward",actID,subType,subid,ztid)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_zushishouji.recv_247_107(...)
local args={...}
local subType=SUB_ACTIVITY_TYPE.eZuShiShouJi
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
data.jdrwMax=args[3]or 0
data.finishTime=args[4]or 0
activitiesModel:setSubActInfoData(actID,subType,subid,data)


UIManager:invokeUIMethod("UISubAct_zushishouji","severfreshZTReddot",actID,subType,subid)
UIManager:invokeUIMethod("UISubAct_zushishouji","sever_tagReward",actID,subType,subid)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end



function activitiesHandle_zushishouji:getFinishTaskNum(ztTaskList)
local Allnum=0
for k,v in pairs(ztTaskList)do
for _,data in pairs(v)do
if data.rwFlag and data.rwFlag>0 then
Allnum=Allnum+1
end
end
end
return Allnum
end