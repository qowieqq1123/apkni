







def_class("UISubAct_TargetActivityWin1",UIWindowBase)









function UISubAct_TargetActivityWin1:bindComponents()

self.rewardReddot=UIObject.get(self,0)
self.rewardList=UIObject.get(self,1)
self.progressBar=UIProgress.get(self,2)
self.rewardFlag=UIObject.get(self,3)
self.bgModel=UIObject.get(self,4)
self.timeTx=UIText.get(self,5)
self.model=UIObject.get(self,6)
self.title=UIImage.get(self,7)
self.rewardRoot=UIButton.get(self,8)
self.tabList=UIObject.get(self,9)
self.progressTx=UIText.get(self,10)
self.taskList=UIObject.get(self,11)

self.rewardRoot:setButtonClick(function()self:onRewardRoot()end)



end


function UISubAct_TargetActivityWin1:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.rewardFlag);self.rewardFlag=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.rewardRoot);self.rewardRoot=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.progressTx);self.progressTx=nil;
_UIObject_release(self.taskList);self.taskList=nil;
end















local _this=nil
local _tabCmp={
button=-1,
select=0,
name=1,
reddot=2,
}
local _taskCmp={
rewardBtn=0,
jumpBtn=1,
descTx=2,
rewards=3,
getted=4,
}
local _sortWeight={2,1,3}



function UISubAct_TargetActivityWin1:onLoaded(...)
self:bindComponents()
_this=self

self.bgModel:setChildUIModelShowTarget(5006,1,{},eAnimationID.stand,false,false,0)
end


function UISubAct_TargetActivityWin1:__delete()
self:stopCDTick()
self:unbindComponents()
_this=nil
end




function UISubAct_TargetActivityWin1:onShow(argtable,afterOnloaded)
if argtable then
local old=self.activityId==argtable.act_id and self.subType==argtable.sub_act_type and self.subId==argtable.sub_act_id
self.activityId=argtable.act_id
self.subType=argtable.sub_act_type
self.subId=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.argtable=argtable
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
if not old then
self:initView()
end
if self.info and self.info:hasData()then
self:refreshView()
end
end
end


function UISubAct_TargetActivityWin1:onHide()

end



function UISubAct_TargetActivityWin1:initView()
self:startCDTick()

local modelParams=self.argtable.modelParams
if modelParams then
self.model:setChildUIModelShowTarget(modelParams.body or 1,modelParams.scale or 1,modelParams.componets or{},modelParams.anim or eAnimationID.stand,false,false,0,nil)
self.model:setChildUIModelShowTargetOffset(modelParams.offset[1]or 0,modelParams.offset[2]or 0)
self.model:setChildUIModelShowFlipX(modelParams.flip or false)
else
self.model:setChildUIModelRemoveTarget()
end

local titleParams=self.argtable.title
if titleParams then
self.title:setSprite(titleParams.image[1],titleParams.image[2])
self.title:setChildAnchoredPos(titleParams.pos[1],titleParams.pos[2])
else
self.title:setImageIcon("",false)
end

if not self.selectTab then
self.selectTab=1
end

self:initTabList()
end

function UISubAct_TargetActivityWin1:refreshView()
self:refreshChapter()
self:refreshTabReddot()
end

function UISubAct_TargetActivityWin1:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_TargetActivityWin1:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_TargetActivityWin1:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
self.timeTx:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp3(time)))
end

function UISubAct_TargetActivityWin1:initTabList()
local tabs=self.config.grouprewards
self.tabList:setChildLayoutGroupCreateItems(#tabs,function(index)
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
local data=tabs[index]
item:SetChildActive(_tabCmp.select,self.selectTab==index)
item:SetChildText(_tabCmp.name,data[3]or"")
item:SetChildButtonClick(_tabCmp.button,function()
self:onClickTab(index)
end)
end)
end

function UISubAct_TargetActivityWin1:refreshTabReddot()
local tabs=self.config.grouprewards
local data=self.info:getData()
for index,config in ipairs(tabs)do
local reddot=false
if not mathHelper.getBitValue(data.bits,index)then
local groupTasks=config[1]
local cnt=0
for idx,taskId in ipairs(groupTasks)do
local taskData=data.taskList[taskId]
if taskData.task_state==taskModel.taskRewardState then
reddot=true
break
elseif taskData.task_state==taskModel.taskFinishState then
cnt=cnt+1
end
end
reddot=reddot or(#groupTasks<=cnt)
end
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_tabCmp.reddot,reddot)
end
end

function UISubAct_TargetActivityWin1:refreshSingleTabReddot(tab)
local data=self.info:getData()
local config=self.config.grouprewards[tab]
local reddot=false
if not mathHelper.getBitValue(data.bits,tab)then
local groupTasks=config[1]
local cnt=0
for idx,taskId in ipairs(groupTasks)do
local taskData=data.taskList[taskId]
if taskData.task_state==taskModel.taskRewardState then
reddot=true
break
elseif taskData.task_state==taskModel.taskFinishState then
cnt=cnt+1
end
end
reddot=reddot or(#groupTasks<=cnt)
end
local item=self.tabList:getChildLayoutGroupGridItem(tab-1)
item:SetChildActive(_tabCmp.reddot,reddot)
end

function UISubAct_TargetActivityWin1:onClickTab(index)
if self.selectTab~=index then
if self.selectTab then
local item=self.tabList:getChildLayoutGroupGridItem(self.selectTab-1)
item:SetChildActive(_tabCmp.select,false)
end
self.selectTab=index
local item=self.tabList:getChildLayoutGroupGridItem(self.selectTab-1)
item:SetChildActive(_tabCmp.select,true)

self:refreshChapter()
end
end

function UISubAct_TargetActivityWin1:refreshChapter()
self:refreshTaskList()
self:refreshRewardBoard()
self:refreshRewardProgress()
self:refreshRewardFlag()
end

function UISubAct_TargetActivityWin1:refreshRewardBoard()
local groupCfg=self.config.grouprewards[self.selectTab]
local rewards=groupCfg[2]
self.rewardList:setChildLayoutGroupCreateItems(#rewards,function(index)
local rewardItem=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=rewards[index]
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(-1,prop)
rewardItem:SetBaseItemClickEvent(-1,function(...)
self:onClickBoardItem(...)
end)
end)
end

function UISubAct_TargetActivityWin1:refreshRewardFlag()
local data=self.info:getData()
local getted=mathHelper.getBitValue(data.bits,self.selectTab)
self.rewardFlag:setActive(getted)
local rewardItems=self.rewardList:getChildLayoutGroupGridList()
for i=1,rewardItems.Count do
local rewardItem=rewardItems[i-1]
local prop={}
prop[PropIndex(DataPropKey.eWidgetGray,0)]=getted
prop[PropIndex(DataPropKey.eWidgetGray,1)]=getted
prop[PropIndex(DataPropKey.eWidgetActive,7)]=getted
rewardItem:SetChildPropData(-1,prop)
end
end

function UISubAct_TargetActivityWin1:onClickBoardItem(...)
if not self:onRewardRoot()then
itemsComponentHelper.onItemClickEx(...)
end
end

function UISubAct_TargetActivityWin1:refreshRewardProgress()
local data=self.info:getData()
local groupCfg=self.config.grouprewards[self.selectTab]
local tasks=groupCfg[1]
local max=#tasks
local cnt=0
local flag=mathHelper.getBitValue(data.bits,self.selectTab)
for idx,taskId in ipairs(tasks)do
local taskData=data.taskList[taskId]
if taskData.task_state==taskModel.taskFinishState then
cnt=cnt+1
end
end

self.progressTx:setText(FMT.fmt("{0}/{1}",cnt,max))
self.progressBar:setProgressValue(math.floor(cnt/max*10000),10000)
self.progressBar:setChildProgressText(FMT.fmt("{0}/{1}",cnt,max))
self.rewardReddot:setActive(not flag and cnt>=max)
end

function UISubAct_TargetActivityWin1:refreshTaskList()
local groupCfg=self.config.grouprewards[self.selectTab]
local data=self.info:getData()
local tasks=groupCfg[1]
self.sortList={}
for i,v in ipairs(tasks)do
local taskInfo=data.taskList[v]
local weight=_sortWeight[taskInfo.task_state]*10000+i
table.insert(self.sortList,{index=i,taskId=v,data=taskInfo,sortWeight=weight})
end
table.sort(self.sortList,function(a,b)
return a.sortWeight<b.sortWeight
end)

self.taskList:setChildLayoutGroupCreateItems(#tasks,function(index)
local item=self.taskList:getChildLayoutGroupGridItem(index-1)
local taskData=self.sortList[index].data
local taskCfg=self.config.tasks[taskData.task_id]
self:refreshTaskItem(index,item,taskData,taskCfg,true)
end)
end

function UISubAct_TargetActivityWin1:refreshTaskItem(index,item,data,config,isInit)
if isInit then
item:SetChildButtonClick(_taskCmp.rewardBtn,function()
self:onClickTaskReward(index)
end)
item:SetChildButtonClick(_taskCmp.jumpBtn,function()
self:onClickTaskJump(index)
end)
local rewards=config[2]
item:SetChildLayoutGroupCreateItems(_taskCmp.rewards,#rewards,function(idx)
local rewardItem=item:GetChildLayoutGroupGridItem(_taskCmp.rewards,idx-1)
local rewardData=rewards[idx]
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
rewardItem:SetChildActive(1,itemsConfig.getItemColor(rewardData[1])>=eQualityColor.eRed)
end)
end

local getted=data.task_state==taskModel.taskFinishState
local target=data.task_target
local current=getted and target or data.server_progress
if not getted and data.count_flag then
if mathHelper.getBitValue(data.count_flag,2)then
if data.server_progress<data.task_target then
current=data.client_progress
end
else
current=data.client_progress
end
end
local progressStr=FMT.fmt("({0}/{1})",Mathf.Clamp(current,0,target),target)
if current<target then
progressStr=FMT.cfmt(FONT_COLOR.eRedColor,progressStr)
else
progressStr=FMT.cfmt(FONT_COLOR.eGreenColor,progressStr)
end
local descStr=FMT.fmt(config[6],progressStr)
item:SetChildText(_taskCmp.descTx,descStr)
item:SetChildActive(_taskCmp.getted,getted)
if not getted then
local complete=current>=target
item:SetChildActive(_taskCmp.rewardBtn,complete)
item:SetChildActive(_taskCmp.jumpBtn,not complete)
else
item:SetChildActive(_taskCmp.rewardBtn,false)
item:SetChildActive(_taskCmp.jumpBtn,false)
end
end

function UISubAct_TargetActivityWin1:refreshTaskDesc(item,data,config)
local getted=data.task_state==taskModel.taskFinishState
local target=data.task_target
local current=getted and target or data.server_progress
if not getted and data.count_flag then
if mathHelper.getBitValue(data.count_flag,2)then
if data.server_progress<data.task_target then
current=data.client_progress
end
else
current=data.client_progress
end
end
local progressStr=FMT.fmt("({0}/{1})",Mathf.Clamp(current,0,target),target)
if current<target then
progressStr=FMT.cfmt(FONT_COLOR.eRedColor,progressStr)
else
progressStr=FMT.cfmt(FONT_COLOR.eGreenColor,progressStr)
end
local descStr=FMT.fmt(config[6],progressStr)
item:SetChildText(_taskCmp.descTx,descStr)
end

function UISubAct_TargetActivityWin1:onRewardRoot()
local data=self.info:getData()
if mathHelper.getBitValue(data.bits,self.selectTab)then
return false
end

local groupInfo=self.config.grouprewards[self.selectTab]
local taskList=groupInfo[1]
local taskMax=#taskList
local taskCnt=0
for index,taskId in ipairs(taskList)do
local taskData=data.taskList[taskId]
if taskData.task_state==taskModel.taskFinishState then
taskCnt=taskCnt+1
end
end
if taskCnt>=taskMax then
call_activitiesHandle_func('activitiesHandle_targetActivity2','reqGroupReward',self.activityId,self.subId,self.selectTab)
return true
end
return false
end

function UISubAct_TargetActivityWin1:onClickTaskReward(index)
local sortData=self.sortList[index]
local taskId=sortData.taskId
local config=self.config.tasks[taskId]
local taskInfo=sortData.data
local target=config[1]
local current=taskInfo.server_progress
if taskInfo.count_flag then
if mathHelper.getBitValue(taskInfo.count_flag,2)then
if taskInfo.server_progress<taskInfo.task_target then
current=taskInfo.client_progress
end
else
current=taskInfo.client_progress
end
end
if current>=target then
call_activitiesHandle_func('activitiesHandle_targetActivity2','reqTaskReward',self.activityId,self.subId,taskId)
end
end

function UISubAct_TargetActivityWin1:onClickTaskJump(index)
local sortData=self.sortList[index]
local taskId=sortData.taskId
local config=self.config.tasks[taskId]
jumpManager:jump(config[5])
end

function UISubAct_TargetActivityWin1:on_249_109(actId,subId)
if self.info:compare(actId,self.subType,subId)then
self:refreshView()
end
end

function UISubAct_TargetActivityWin1:on_249_110(actId,subId,enoughs,ids)

if self.info:compare(actId,self.subType,subId)then
local groupCfg=self.config.grouprewards
if#enoughs>0 then
for index,gCfg in ipairs(groupCfg)do
local tasks=gCfg[1]
for idx,taskId in ipairs(tasks)do
if table.containsValue(enoughs,taskId)then
self:refreshSingleTabReddot(index)
if index==self.selectTab then
self:refreshTaskList()
end
break
end
end
end
else
for index,taskInfo in ipairs(self.sortList)do
if table.containsValue(ids,taskInfo.taskId)then
local item=self.taskList:getChildLayoutGroupGridItem(index-1)
local taskData=taskInfo.data

local taskCfg=self.config.tasks[taskInfo.taskId]
self:refreshTaskDesc(item,taskData,taskCfg)
end
end
end
end
end

function UISubAct_TargetActivityWin1:on_249_111(actId,subId,taskId)
if self.info:compare(actId,self.subType,subId)then
local groupCfg=self.config.grouprewards
for i,v in ipairs(groupCfg)do
if table.containsValue(v[1],taskId)then
if self.selectTab==i then
self:refreshRewardProgress()
self:refreshTaskList()
end
self:refreshSingleTabReddot(i)
return
end
end
end
end

function UISubAct_TargetActivityWin1:on_249_112(actId,subId,group)
if self.info:compare(actId,self.subType,subId)then
local item=self.tabList:getChildLayoutGroupGridItem(group-1)
item:SetChildActive(_tabCmp.reddot,false)
if self.selectTab==group then
self.rewardReddot:setActive(false)
self:refreshRewardFlag()
end
end
end
