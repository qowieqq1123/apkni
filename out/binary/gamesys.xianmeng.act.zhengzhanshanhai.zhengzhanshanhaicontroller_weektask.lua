
function zhengzhanshanhaiController:onAppStart_weekTask()
socketManager:register_receiver(20,210,self.recv_20_210)
socketManager:register_receiver(20,211,self.recv_20_211)
socketManager:register_receiver(20,212,self.recv_20_212)


socketManager:register_receiver(44,210,self.recv_44_210)
socketManager:register_receiver(44,211,self.recv_44_211)
socketManager:register_receiver(44,212,self.recv_44_212)

end

function zhengzhanshanhaiController:checkSystemOpen_weekTask()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then

return systemModel.isOpen(SYSTEM_DEFINE.eShanHaiWeekTask)
else

return systemModel.isOpen(SYSTEM_DEFINE.eShanHaiWeekTaskNew)
end
end




function zhengzhanshanhaiController:req_weekTaskInit()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_210()
else
socketManager:send_20_210()
end
end


function zhengzhanshanhaiController:req_weekTaskReward(value)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_211(value)
else
socketManager:send_20_211(value)
end
end




function zhengzhanshanhaiController.recv_20_210(task_len,taskDataList,ex_reward_flag,beginTime)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getWeekTaskData(task_len,taskDataList,ex_reward_flag,beginTime)
end


function zhengzhanshanhaiController.recv_20_211(task_id)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

if task_id==0 then
zhengzhanshanhaiModel:changeWeekTaskTargetRewardFlag()
UIManager:invokeUIMethod("UIXM_ZZSH_WeekTaskWin","initTargetPanel",true,false)
else

zhengzhanshanhaiModel:setCompleteTaskRewardflag()
UIManager:invokeUIMethod("UIXM_ZZSH_WeekTaskWin","RefreshShow")
end
notifySystem:postNotify(notifyConfig.onZZSH_WeekTaskReddot)
end


function zhengzhanshanhaiController.recv_20_212(task_id,complete_cnt)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_changeWeekTaskData(task_id,complete_cnt)
end



function zhengzhanshanhaiController.recv_44_210(task_len,taskDataList,ex_reward_flag,beginTime)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getWeekTaskData(task_len,taskDataList,ex_reward_flag,beginTime)
end


function zhengzhanshanhaiController.recv_44_211(task_id)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
if task_id==0 then
zhengzhanshanhaiModel:changeWeekTaskTargetRewardFlag()
UIManager:invokeUIMethod("UIXM_ZZSH_WeekTaskWin","initTargetPanel",true,false)
else

zhengzhanshanhaiModel:setCompleteTaskRewardflag()
UIManager:invokeUIMethod("UIXM_ZZSH_WeekTaskWin","RefreshShow")
end
notifySystem:postNotify(notifyConfig.onZZSH_WeekTaskReddot)
end


function zhengzhanshanhaiController.recv_44_212(task_id,complete_cnt)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_changeWeekTaskData(task_id,complete_cnt)
end



function zhengzhanshanhaiController.recv_getWeekTaskData(task_len,taskDataList,ex_reward_flag,beginTime)
zhengzhanshanhaiModel:setData_WeekTask(task_len,taskDataList,ex_reward_flag,beginTime)
UIManager:invokeUIMethod("UIXM_ZZSH_PvEMainWin","checkWeekTaskOpen")
UIManager:invokeUIMethod("UIXM_ZZSH_PvPMainWin","checkWeekTaskOpen")
end


function zhengzhanshanhaiController.recv_getWeekTaskReward(task_id)
if task_id==0 then
zhengzhanshanhaiModel:changeWeekTaskTargetRewardFlag()
UIManager:invokeUIMethod("UIXM_ZZSH_WeekTaskWin","initTargetPanel",true,false)
else

zhengzhanshanhaiModel:setCompleteTaskRewardflag()
UIManager:invokeUIMethod("UIXM_ZZSH_WeekTaskWin","RefreshShow")
end
notifySystem:postNotify(notifyConfig.onZZSH_WeekTaskReddot)
end


function zhengzhanshanhaiController.recv_changeWeekTaskData(task_id,complete_cnt)
zhengzhanshanhaiModel:changeWeekTaskDataByTaskid(task_id,complete_cnt)
UIManager:invokeUIMethod("UIXM_ZZSH_WeekTaskWin","doRefreshActiveCellViews")
UIManager:invokeUIMethod("UIXM_ZZSH_PvEMainWin","checkWeekTaskOpen")
UIManager:invokeUIMethod("UIXM_ZZSH_PvPMainWin","checkWeekTaskOpen")
notifySystem:postNotify(notifyConfig.onZZSH_WeekTaskReddot)
end



function zhengzhanshanhaiController.finishSHWeekTask()
UIManager:invokeUIMethod("UIXM_ZZSH_WeekTaskWin","onShow")
end