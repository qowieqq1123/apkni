







def_class("UISubAct_TargetActivityWin4",UIWindowBase)









function UISubAct_TargetActivityWin4:bindComponents()

self.title=UIText.get(self,0)
self.taskListContent=UIObject.get(self,1)
self.taskScrollView=UIObject.get(self,2)
self.timeText=UIText.get(self,3)



end


function UISubAct_TargetActivityWin4:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.taskListContent);self.taskListContent=nil;
_UIObject_release(self.taskScrollView);self.taskScrollView=nil;
_UIObject_release(self.timeText);self.timeText=nil;
end
















local _this
local taskCmpIndex={
taskDescText=0,
progressbar=1,
rewards=2,
gotoBtn=3,
getRewardBtn=4,
finishFlag=5,
lockMask=6,
lockText=7,
}



function UISubAct_TargetActivityWin4:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_TargetActivityWin4:__delete()
self:clearTimer()
self:unbindComponents()
_this=nil
end




function UISubAct_TargetActivityWin4:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end


self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.beginTime_Zero=timeHelper.getServerZeroStamp(self.activityData.start_time_l)
self.endTime=self.activityData.end_time





self:refresh()


self:setRemainingTimeTimer()
end


function UISubAct_TargetActivityWin4:onHide()
self.taskScrollView:setActive(false)
self:clearTimer()
end

function UISubAct_TargetActivityWin4:refresh()
self.taskScrollView:setActive(true)

self.taskList=self:getSortTaskList()
self.taskListContent:setChildLayoutGroupCreateItems(#self.taskList)
local grids=self.taskListContent:getChildLayoutGroupGridList()
local hasLockTask=false
for i=1,grids.Count do
local widget=grids[i-1]
local task=self.taskList[i]
local taskCfg=task.cfg
local taskData=task.data
local taskId=task.taskId
local isFinish=task.isFinish
local isGot=task.isGot
local isUnlock=task.isUnlock

local taskDesc=string.replaceSpace(taskCfg[7])
widget:SetChildText(taskCmpIndex.taskDescText,taskDesc)


local targetValue=taskCfg[1]
local nowValue=isUnlock and taskData.task_progress or 0
widget:SetChildProgressValue(taskCmpIndex.progressbar,nowValue/targetValue*1000,1000)
widget:SetChildProgressText(taskCmpIndex.progressbar,FMT.fmt("{0}/{1}",nowValue,targetValue))


local rewardList=taskCfg[3]
local rewardGrids=widget:GetChildCommonLayoutGroupWidgetList(taskCmpIndex.rewards)
for i=1,rewardGrids.Count do
local rewardItem=rewardGrids[i-1]
local reward=rewardList[i]
if reward then
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

rewardItem:SetChildActive(-1,true)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
rewardItem:SetChildActive(-1,false)
end
end


local jumpParam=taskCfg[6]
local hasJump=jumpParam~=nil
widget:SetChildActive(taskCmpIndex.gotoBtn,hasJump and not isFinish)
widget:SetChildButtonClick(taskCmpIndex.gotoBtn,function()
self:onClickGotoBtn(jumpParam)
end)

widget:SetChildNewBieComponentId(taskCmpIndex.gotoBtn,FMT.fmt('UISubAct_TargetActivityWin4.taskItem_{0}',i))


widget:SetChildActive(taskCmpIndex.getRewardBtn,isFinish and not isGot)
widget:SetChildButtonClick(taskCmpIndex.getRewardBtn,function()
self:onClickGetRewardBtn(taskId)
end)


widget:SetChildActive(taskCmpIndex.finishFlag,isGot)


widget:SetChildActive(taskCmpIndex.lockMask,not isUnlock)
if not isUnlock then
hasLockTask=true

local unlockDayCount=taskCfg[2]
local unlockTimeStamp=self.beginTime_Zero+(unlockDayCount-1)*86400
local nowTimeStamp=timeHelper.getServerLongTime()
if unlockTimeStamp>nowTimeStamp then
local lerp=unlockTimeStamp-nowTimeStamp
local timeStr=FMT.fmt("{0}后开启",timeHelper.format_time_stamp11(lerp,true))
widget:SetChildText(taskCmpIndex.lockText,timeStr)
else
widget:SetChildText(taskCmpIndex.lockText,"")
end
end
end










self.isRefreshTaskUnlockTime=hasLockTask
end

function UISubAct_TargetActivityWin4:refreshTaskUnlockTimer()

local grids=self.taskListContent:getChildLayoutGroupGridList()
local hasLockTask=false
for i=1,grids.Count do
local widget=grids[i-1]
local task=self.taskList[i]
local taskCfg=task.cfg
local isUnlock=task.isUnlock

widget:SetChildActive(taskCmpIndex.lockMask,not isUnlock)
if not isUnlock then
hasLockTask=true

local unlockDayCount=taskCfg[2]
local unlockTimeStamp=self.beginTime_Zero+(unlockDayCount-1)*86400
local nowTimeStamp=timeHelper.getServerLongTime()
if unlockTimeStamp>nowTimeStamp then
local lerp=unlockTimeStamp-nowTimeStamp
local timeStr=FMT.fmt("{0}后开启",timeHelper.format_time_stamp11(lerp,true))
widget:SetChildText(taskCmpIndex.lockText,timeStr)
end
end
end

if not hasLockTask then


self.isRefreshTaskUnlockTime=false

return self:refresh()
end
end

function UISubAct_TargetActivityWin4:getSortTaskList()
local taskCfgList=self.config.tasks
local sortList={}
local allTaskData=self.activityData.data and self.activityData.data.taskData or{}
local showTaskLine_lookup={}
for i,cfg in ipairs(taskCfgList)do
local taskId=i
local sortWeight=taskId
local isUnlock=self.activityData:checkTaskUnlockById(taskId)
local data=allTaskData[taskId]or{}
local targetValue=cfg[1]
local nowValue=isUnlock and data.task_progress or 0
local isFinish=nowValue>=targetValue
local isGot=data.task_state==3
local taskLineId=cfg[8]
local isShow=true
if taskLineId and taskLineId~=-1 then
if showTaskLine_lookup[taskLineId]then
isShow=false
elseif not isGot then
showTaskLine_lookup[taskLineId]=taskId
end
end

if isShow then
if isFinish and not isGot then
sortWeight=sortWeight-1000
end

if not isUnlock then
sortWeight=sortWeight+1000
end

if isGot then
sortWeight=sortWeight+10000
end
local taskItem={
taskId=taskId,
sortWeight=sortWeight,
isUnlock=isUnlock,
isFinish=isFinish,
isGot=isGot,
cfg=cfg,
data=data,
}
table.insert(sortList,taskItem)
end
end

table.sort(sortList,function(a,b)
return a.sortWeight<b.sortWeight
end)
return sortList
end


function UISubAct_TargetActivityWin4:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
if _this==nil then return end
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.timeText:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp11(lerp,true)))
if self.isRefreshTaskUnlockTime then
return self:refreshTaskUnlockTimer()
end
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end
end

self.timer=self:setTimer(1,0,func)

func()
end

function UISubAct_TargetActivityWin4:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

























function UISubAct_TargetActivityWin4:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end

function UISubAct_TargetActivityWin4:onClickGotoBtn(jumpParam)
jumpManager:jump(jumpParam)
end


function UISubAct_TargetActivityWin4:onClickGetRewardBtn(taskId)
self.activityData:reqGetTaskReward(taskId)
end
