







function taskModel:checkActivePlot(taskid,taskstate)
if taskstate==taskModel.taskDoingState then
return self:activeAcceptPlot(taskid)
elseif taskstate==taskModel.taskRewardState then
return self:activeRewardPlot(taskid)
elseif taskstate==taskModel.taskFinishState then
return self:activeFinishPlot(taskid)
end
end

function taskModel:activeAcceptPlot(taskid)
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg.acceptPlot~=nil then
return taskModel:activeTaskPlot(taskcfg.acceptPlot,taskcfg.screenParams)
end
end

function taskModel:activeRewardPlot(taskid)
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg.rewardPlot~=nil then
return taskModel:activeTaskPlot(taskcfg.rewardPlot,taskcfg.screenParams)
end
end

function taskModel:activeFinishPlot(taskid)
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg.finishPlot~=nil then
return taskModel:activeTaskPlot(taskcfg.finishPlot,taskcfg.screenParams)
end
end



function taskModel:activeTaskPlot(params,screenParams)
local plot_type=params[1]
local plot_name=params[2]
local plot_add=params[3]==1
local check=true
if plot_type==1 or plot_type==4 then
check=taskModel:checkTaskPlot(plot_name)
end
if check then
local callBack=function(flag_)
if flag_ then
local flag=gameplotController.activePlot(params,plot_add)
if flag then
if plot_type==1 or plot_type==4 then
local marklist=userActorSetting.get('taskPlotMark',{})
marklist[plot_name]=true
userActorSetting.flushVal('taskPlotMark',marklist,{})
end
end
end
end
if screenParams~=nil then
cameraMoveController:Begin(screenParams,nil,callBack)
else
callBack(true)
end
return true
end
end

function taskModel:checkTaskPlot(plot_name)

if plot_name=="story_46_zongmencefeng_1"and webGLHelper:isRunMiniGame()then
return false
end
local marklist=userActorSetting.get('taskPlotMark',{})
if marklist[plot_name]~=nil then
return false
end
return true
end

function taskModel:checkTaskPlot2(params)
local plot_type=params[1]
local plot_name=params[2]
local check=true
if plot_type==1 or plot_type==4 then
check=taskModel:checkTaskPlot(plot_name)
end
return check
end

function taskModel:clearTaskPlotMark(plot_name)
local marklist=userActorSetting.get('taskPlotMark',{})
marklist[plot_name]=nil
userActorSetting.flushVal('taskPlotMark',marklist,{})
end

function taskModel:hasFirstInZongMenPlot()
local firstid=taskModel:getLineFirstID(taskModel.lineMain)
local taskdata=taskModel:getTask(firstid)
if taskdata then
local t_taskstate=taskModel:getTaskState_transfromstate(taskdata)
if t_taskstate==taskModel.taskDoingState then
return true
end
end
return false
end

function taskModel:testClearTaskPlotMark()
userActorSetting.flushVal('taskPlotMark',{})
end