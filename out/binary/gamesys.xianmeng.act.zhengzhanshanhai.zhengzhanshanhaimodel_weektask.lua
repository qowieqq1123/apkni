
local WeekTaskdata={}

local WeekTaskCfg={}


function zhengzhanshanhaiModel:setData_WeekTask(task_len,taskDataList,ex_reward_flag,beginTime)
WeekTaskdata.taskDataList=taskDataList
WeekTaskdata.beginTime=beginTime
WeekTaskdata.ex_reward_flag=CS.LuaHelper.SplitInt32(tonumber(tostring(ex_reward_flag)),"0xFFFFFFF",0)
WeekTaskdata.taskDataListMap={}
WeekTaskdata.CfgGroupMap={}
WeekTaskdata.completeTaskCount=0

if WeekTaskdata.taskDataList then
for i,v in ipairs(WeekTaskdata.taskDataList)do
WeekTaskdata.taskDataListMap[v.param_1]=WeekTaskdata.taskDataList[i]
if v.param_3==1 then
WeekTaskdata.completeTaskCount=WeekTaskdata.completeTaskCount+1
end
end
end

local cfg=zhengzhanshanhaiController:getZZSHCfg_weekTaskAllCfg()
for i,v in ipairs(cfg)do
if not WeekTaskdata.CfgGroupMap[v.groupid]then
WeekTaskdata.CfgGroupMap[v.groupid]={}
end
local id=v.task_id or v.id
table.insert(WeekTaskdata.CfgGroupMap[v.groupid],{id=id,groupid=v.groupid,complete_cnt=v.complete_cnt})
end
end


function zhengzhanshanhaiModel:getBeginTime()
return WeekTaskdata.beginTime
end


function zhengzhanshanhaiModel:getIsShowTask()
local raceState=zhengzhanshanhaiModel:getLunState()
local isShowTask=(eZZSH_State.ePVEFight==raceState)or(zhengzhanshanhaiModel:getBeginTime()~=0)or zhengzhanshanhaiModel:isFirst()
return isShowTask
end


function zhengzhanshanhaiModel:isFirst()
local raceState=zhengzhanshanhaiModel:getLunState()
if(eZZSH_State.ePVPFight==raceState or eZZSH_State.ePVPStandby==raceState)and WeekTaskdata.taskDataList and#WeekTaskdata.taskDataList>0 then
return true
end
return false
end


function zhengzhanshanhaiModel:isAddTime()
return(zhengzhanshanhaiModel:getBeginTime()~=0)or zhengzhanshanhaiModel:isFirst()or zhengzhanshanhaiModel:checkIsSeasonDoNotResetTaskAndZhanLing()
end


function zhengzhanshanhaiModel:getWeekTaskTargetRewardIndex()
local index=0
local exrewards=self:getTargetRewardList()
for i=#exrewards,1,-1 do
local curdata=exrewards[i]
if WeekTaskdata.completeTaskCount>=curdata[1]then
index=i
break
end
end
return index
end



function zhengzhanshanhaiModel:checkTargetReddot_byIndex(val,Index)
local flag=bit.band(val,bit.lshift(1,Index-1))~=0
return not flag
end



function zhengzhanshanhaiModel:get_ex_reward_flag()
return WeekTaskdata.ex_reward_flag
end


function zhengzhanshanhaiModel:changeWeekTaskTargetRewardFlag()
local index=self:getWeekTaskTargetRewardIndex()
if index<0 then
return
end
for i=1,index do
WeekTaskdata.ex_reward_flag=bit.bor(WeekTaskdata.ex_reward_flag,bit.lshift(1,i-1))
end


end


function zhengzhanshanhaiModel:changeWeekTaskRewardByTaskid(Taskid)
if WeekTaskdata.taskDataListMap[Taskid]then
WeekTaskdata.taskDataListMap[Taskid].param_3=1
WeekTaskdata.completeTaskCount=WeekTaskdata.completeTaskCount+1
else

end
end


function zhengzhanshanhaiModel:checkWeekTaskAllComplete()
local allcfg=zhengzhanshanhaiController:getZZSHCfg_weekTaskAllCfg()
if WeekTaskdata.taskDataList and#WeekTaskdata.taskDataList>=#allcfg then
for i,v in ipairs(WeekTaskdata.taskDataList)do
if v.param_3~=1 then
return false
end
end
return true
end
return false
end



function zhengzhanshanhaiModel:checkAllReddot()
return self:checkTargetRewardReddot()or self:checkTaskReddot()
end


function zhengzhanshanhaiModel:checkTaskReddot()
local allcfg=zhengzhanshanhaiController:getZZSHCfg_weekTaskAllCfg()
if WeekTaskdata.taskDataList then
for i,v in ipairs(WeekTaskdata.taskDataList)do
if v.param_3~=1 then
local cur=allcfg[v.param_1]
if v.param_2>=cur.complete_cnt then
return true
end
end
end
end
return false
end


function zhengzhanshanhaiModel:checkTargetRewardReddot()
local index=self:getWeekTaskTargetRewardIndex()
if index<=0 then
return false
end
local reddot=zhengzhanshanhaiModel:checkTargetReddot_byIndex(WeekTaskdata.ex_reward_flag,index)
return reddot
end


function zhengzhanshanhaiModel:changeWeekTaskDataByTaskid(Taskid,complete_cnt)
if WeekTaskdata.taskDataListMap[Taskid]then
WeekTaskdata.taskDataListMap[Taskid].param_2=complete_cnt
else
if not WeekTaskdata.taskDataList then
WeekTaskdata.taskDataList={}
end
local adddata={param_1=Taskid,param_2=complete_cnt,param_3=0}
table.insert(WeekTaskdata.taskDataList,adddata)
WeekTaskdata.taskDataListMap[Taskid]=adddata
end
end


function zhengzhanshanhaiModel:clearData_WeekTask()
WeekTaskdata={}
WeekTaskCfg={}
end



function zhengzhanshanhaiModel:getTargetRewardList()

local const_def=zhengzhanshanhaiController:getZZSHCfg_weekTask_const_def()
local TargetRewardcfg=const_def
if TargetRewardcfg then
return TargetRewardcfg.exrewards
else

end
end




function zhengzhanshanhaiModel:getNeddCompleteMaxTaskCount()
local exrewards=self:getTargetRewardList()
if exrewards then
return exrewards[#exrewards][1]
end
return 0
end



function zhengzhanshanhaiModel:getcompleteTaskCount()
return WeekTaskdata.completeTaskCount
end



function zhengzhanshanhaiModel:getSortTaskList()
local sortList={}
for i,v in pairs(WeekTaskdata.CfgGroupMap)do
if#v>1 then
local curdata=self:checkGroupIndex(v)
self:AddSort(sortList,curdata)
else
local curdata=v[1]
self:AddSort(sortList,curdata)
end
end
table.sort(sortList,function(a,b)return a.sortIndex<b.sortIndex end)
return sortList
end


function zhengzhanshanhaiModel:AddSort(sortList,selectData)
local sortIndex=selectData.groupid
local complete_cnt,rewardflag,needComplete_cnt=self:getComplete_cntAndrewardflag(selectData)
if rewardflag==1 then
sortIndex=selectData.groupid+100
else
if complete_cnt>=needComplete_cnt then
sortIndex=selectData.groupid-100
else
sortIndex=selectData.groupid
end
end
table.insert(sortList,{sortIndex=sortIndex,Data=selectData})
end



function zhengzhanshanhaiModel:checkGroupIndex(v)
local selectData
table.sort(v,function(a,b)
return a.complete_cnt<b.complete_cnt
end)
for j,curdata in ipairs(v)do


local complete_cnt,rewardflag,needComplete_cnt=self:getComplete_cntAndrewardflag(curdata)
if rewardflag==0 and complete_cnt>=needComplete_cnt then
selectData=curdata
break
end
end
if not selectData then
for j,curdata in ipairs(v)do
local complete_cnt,rewardflag,needComplete_cnt=self:getComplete_cntAndrewardflag(curdata)
if rewardflag==0 and complete_cnt<needComplete_cnt then
selectData=curdata
break
end
end
end
if not selectData then
selectData=v[#v]
end
return selectData
end


function zhengzhanshanhaiModel:getComplete_cntAndrewardflag(curdata)
local complete_cnt=0
local rewardflag=0
local needComplete_cnt=0
if WeekTaskdata.taskDataListMap[curdata.id]then
complete_cnt=WeekTaskdata.taskDataListMap[curdata.id].param_2
rewardflag=WeekTaskdata.taskDataListMap[curdata.id].param_3
end
local cfg=zhengzhanshanhaiController:getZZSHCfg_weekTask(curdata.id)
if cfg then
needComplete_cnt=cfg.complete_cnt
end
return complete_cnt,rewardflag,needComplete_cnt
end


function zhengzhanshanhaiModel:setCompleteTaskRewardflag()
if WeekTaskdata and WeekTaskdata.taskDataListMap then
local rewardNum=0
for id,v in pairs(WeekTaskdata.taskDataListMap)do
local rewardflag=v.param_3
if rewardflag~=1 then
local cfg=zhengzhanshanhaiController:getZZSHCfg_weekTask(id)
local needComplete_cnt=cfg.complete_cnt
local complete_cnt=v.param_2
if complete_cnt>=needComplete_cnt then
v.param_3=1
rewardNum=rewardNum+1
end
end
end
WeekTaskdata.completeTaskCount=(WeekTaskdata.completeTaskCount or 0)+rewardNum
end
end
