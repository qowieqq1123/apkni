
activitiesHandle_daobingge=new_activitiesHandle('activitiesHandle_daobingge',activitiesHandle)

function activitiesHandle_daobingge:onInit()

end







function activitiesHandle_daobingge.onDaoBingGeInfo(args)
local subType=SUB_ACTIVITY_TYPE.eDaoBingGeAct
local actId=args[1]
local subId=args[2]
local dayTaskLen=args[3]

local dayTaskList=args[4]
local taskLen=args[5]

local taskList=args[6]
local rechargeLen=args[7]

local rechargeList=args[8]

local commonLv=args[9]

local luxuryLv=args[10]

local lv=args[11]

local data={dayTaskList=dayTaskList,
taskList=taskList,
rechargeList=rechargeList,
commonLv=commonLv,
luxuryLv=luxuryLv,
lv=lv}

activitiesModel:setSubActInfoData(actId,subType,subId,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
UIManager:callWindowFunc('UISubAct_DaoBingGeWin','freshInfo')
end





function activitiesHandle_daobingge.onDaoBingGePrize(actId,subId,tasktype,taskline,task_idx)
local subType=SUB_ACTIVITY_TYPE.eDaoBingGeAct
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
local dayTaskList=data.dayTaskList
local taskList=data.taskList
local model=activitiesModel:getSubActInfo(actId,subType,subId)
if tasktype==1 then
activitiesHandle_daobingge.onTaskPrze(data,model,'dayTaskList',tasktype,taskline,task_idx)
elseif tasktype==2 then
activitiesHandle_daobingge.onTaskPrze(data,model,'taskList',tasktype,taskline,task_idx)
end
UIManager:callWindowFunc('UISubAct_DaoBingGeWin','freshInfo')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_daobingge.onDaoBingGeFreshTask(argstable)
local subType=SUB_ACTIVITY_TYPE.eDaoBingGeAct
local actId=argstable[1]
local subId=argstable[2]
local dayTaskLen=argstable[3]
local dayTaskList=argstable[4]
local taskLen=argstable[5]
local taskList=argstable[6]
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
local model=activitiesModel:getSubActInfo(actId,subType,subId)
for i,v in ipairs(dayTaskList or{})do
activitiesHandle_daobingge.onChanggeTask(data,'dayTaskList',v)
end
for i,v in ipairs(taskList or{})do
activitiesHandle_daobingge.onChanggeTask(data,'taskList',v)
end
UIManager:callWindowFunc('UISubAct_DaoBingGeWin','freshInfo')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_daobingge.onDaoBingGeBuyLevel(actId,subId,lv)
local subType=SUB_ACTIVITY_TYPE.eDaoBingGeAct
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
local oldlv=data.lv or 0
data.lv=lv
UIManager:callWindowFunc('UISubAct_DaoBingGeWin','onBuyRet')
if oldlv~=lv then
local args={actId=actId,subType=subType,subId=subId,
oldlv=oldlv,newlv=lv}
UIManager:showWindow('UISubAct_DaoBingGeLevelUpWin',args)
end
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_daobingge.onDaoBingGeExchargeGift(actId,subId,giftnum)
local subType=SUB_ACTIVITY_TYPE.eDaoBingGeAct
UIManager.info('礼盒兑换成功')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_daobingge.onDaoBingGeActiveTrain(actId,subId,rechargeid)
local subType=SUB_ACTIVITY_TYPE.eDaoBingGeAct
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
local rechargeList=data.rechargeList or{}
local has=false
for i,v in ipairs(rechargeList)do
if v==rechargeid then
has=true
break
end
end
if not has then
rechargeList[#rechargeList+1]=rechargeid
data.rechargeList=rechargeList
end
UIManager:callWindowFunc('UISubAct_DaoBingGeWin','freshInfo')
UIManager:callWindowFunc('UISubAct_DaoBingGeActiveWin','freshInfo')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_daobingge.onDaoBingGeLevelPrize(actId,subId,commonLv,luxuryLv)
local subType=SUB_ACTIVITY_TYPE.eDaoBingGeAct
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
data.commonLv=commonLv
data.luxuryLv=luxuryLv
UIManager:callWindowFunc('UISubAct_DaoBingGeWin','freshInfo')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end




















function activitiesHandle_daobingge.onTaskPrze(data,model,enumname,tasktype,taskline,idx)
data[enumname]=data[enumname]or{}
local tasklist=data[enumname]or{}
for i,v in ipairs(tasklist or{})do
if v.task_type==taskline and v.task_idx==idx then
v.task_flag=1
return
end
end
local taskCfg=model:getOneTaskCfg(tasktype,taskline,idx)
local num=0
if taskCfg then
num=taskCfg[2][1]
end
tasklist[#tasklist+1]=
{
task_type=taskline,
task_idx=idx,
task_progress=num,
task_flag=1,
}
end





function activitiesHandle_daobingge.onChanggeTask(data,enumname,task)
data[enumname]=data[enumname]or{}
local tasklist=data[enumname]or{}
for i,v in ipairs(tasklist or{})do
if v.task_type==task.task_type and v.task_idx==task.task_idx then
tasklist[i]=task
return
end
end
tasklist[#tasklist+1]=task
end