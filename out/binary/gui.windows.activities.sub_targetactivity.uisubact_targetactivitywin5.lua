







def_class("UISubAct_TargetActivityWin5",UIWindowBase)









function UISubAct_TargetActivityWin5:bindComponents()

self.bgModel=UIObject.get(self,0)
self.model=UIObject.get(self,1)
self.progressBar=UIProgress.get(self,2)
self.progressTx=UIText.get(self,3)
self.rewardFlag=UIObject.get(self,4)
self.rewardList=UIObject.get(self,5)
self.rewardReddot=UIObject.get(self,6)
self.rewardRoot=UIButton.get(self,7)
self.root=UIObject.get(self,8)
self.tabList=UIObject.get(self,9)
self.taskList=UIObject.get(self,10)
self.timeTx=UIText.get(self,11)
self.title=UIImage.get(self,12)

self.rewardRoot:setButtonClick(function()self:onRewardRoot()end)



end


function UISubAct_TargetActivityWin5:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressTx);self.progressTx=nil;
_UIObject_release(self.rewardFlag);self.rewardFlag=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.rewardRoot);self.rewardRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.taskList);self.taskList=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.title);self.title=nil;
end
















local _this
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




function UISubAct_TargetActivityWin5:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_TargetActivityWin5:__delete()
self:stopCDTick()
self:unbindComponents()
_this=nil
end




function UISubAct_TargetActivityWin5:onShow(argtable,afterOnloaded)
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

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)

local _abName="ui/windows/activities/sub_targetactivity/targetactivity5_atlas_pak.ab"
self.title:setCSImageSprite(_abName,self.config.titleIcon or"image_zbhj_yinghaoli")

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.model:getID(),false,true,false)
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgModel:getID(),false,true,false)

self.model:setChildUIModelShowTarget(6107,1,nil,eAnimationID.stand,false,false,0,nil)
self.bgModel:setChildUIModelShowTarget(6112,1,nil,eAnimationID.stand,false,false,0,function()
if _this==nil then return end
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
end


function UISubAct_TargetActivityWin5:onHide()

end



function UISubAct_TargetActivityWin5:initView()
self:startCDTick()

local modelParams=self.argtable.modelParams
if modelParams then
self.model:setChildUIModelShowTarget(modelParams.body or 1,modelParams.scale or 1,modelParams.componets or{},modelParams.anim or eAnimationID.stand,false,false,0,nil)
self.model:setChildUIModelShowTargetOffset(modelParams.offset[1]or 0,modelParams.offset[2]or 0)
self.model:setChildUIModelShowFlipX(modelParams.flip or false)
else
self.model:setChildUIModelRemoveTarget()
end

if not self.selectTab then
self.selectTab=self.info:getInitOpenChapter()
end

self:initTabList()
end

function UISubAct_TargetActivityWin5:refreshView()
self:refreshChapter()
self:refreshTabReddot()
end

function UISubAct_TargetActivityWin5:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_TargetActivityWin5:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_TargetActivityWin5:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
self.timeTx:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp3(time)))
end

function UISubAct_TargetActivityWin5:initTabList()
local tabs=self.config.tasks
self.tabList:setChildLayoutGroupCreateItems(#tabs,function(index)
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_tabCmp.select,self.selectTab==index)
item:SetChildText(_tabCmp.name,FMT.fmt("第{0}章",index))
item:SetChildButtonClick(_tabCmp.button,function()
self:onClickTab(index)
end)
end)
end

function UISubAct_TargetActivityWin5:refreshTabReddot()
local tabs=self.config.tasks
local data=self.info:getData()
for chapterId,config in ipairs(tabs)do
local reddot=false
local chapterData=data.chapterData[chapterId]
if chapterData.chapter_state==taskModel.taskRewardState then
reddot=true
end
if not reddot then
local taskList=config.tasklist
for taskId,_ in ipairs(taskList)do
local taskData=chapterData.taskData[taskId]
if taskData.task_state==taskModel.taskRewardState then
reddot=true
break
end
end
end
local item=self.tabList:getChildLayoutGroupGridItem(chapterId-1)
item:SetChildActive(_tabCmp.reddot,reddot)
end
end

function UISubAct_TargetActivityWin5:refreshSingleTabReddot(tab)
local data=self.info:getData()
local config=self.config.tasks[tab]
local reddot=false
local chapterData=data.chapterData[tab]
if chapterData.chapter_state==taskModel.taskRewardState then
reddot=true
end
if not reddot then
local taskList=config.tasklist
for taskId,_ in ipairs(taskList)do
local taskData=chapterData.taskData[taskId]
if taskData.task_state==taskModel.taskRewardState then
reddot=true
break
end
end
end
local item=self.tabList:getChildLayoutGroupGridItem(tab-1)
item:SetChildActive(_tabCmp.reddot,reddot)
end

function UISubAct_TargetActivityWin5:onClickTab(index)
if self.selectTab~=index then
if self.selectTab then
local item=self.tabList:getChildLayoutGroupGridItem(self.selectTab-1)
item:SetChildActive(_tabCmp.select,false)
end
self.selectTab=index
local item=self.tabList:getChildLayoutGroupGridItem(self.selectTab-1)
item:SetChildActive(_tabCmp.select,true)

self:refreshChapter()

if self.modelStateTimer==nil then
self.model:setChildModelAnimationState(eAnimationID.enter,1,function()
if _this==nil then return end
_this.model:setChildModelAnimationState(eAnimationID.stand2,1)
end)
else
self:stopTimerByID(self.modelStateTimer)
self.modelStateTimer=nil
end

self.modelStateTimer=self:setTimer(2,1,function()
if _this==nil then return end
self.modelStateTimer=nil
_this.model:setChildModelAnimationState(eAnimationID.stand,1)
end)
end
end

function UISubAct_TargetActivityWin5:refreshChapter()
self:refreshTaskList()
self:refreshRewardBoard()
self:refreshRewardProgress()
self:refreshRewardFlag()
end

function UISubAct_TargetActivityWin5:refreshRewardBoard()
local data=self.info:getData()
local groupCfg=self.config.tasks[self.selectTab]
local chapterData=data.chapterData[self.selectTab]
local canReward=chapterData.chapter_state==taskModel.taskRewardState

local rewards=groupCfg.rewards
self.rewardList:setChildLayoutGroupCreateItems(#rewards,function(index)
local rewardItem=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=rewards[index]
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=canReward}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(-1,prop)
rewardItem:SetBaseItemClickEvent(-1,function(...)
self:onClickBoardItem(...)
end)
end)
end

function UISubAct_TargetActivityWin5:refreshRewardFlag()
local data=self.info:getData()
local chapterData=data.chapterData[self.selectTab]
local getted=chapterData.chapter_state==taskModel.taskFinishState
self.rewardFlag:setActive(getted)
local rewardItems=self.rewardList:getChildLayoutGroupGridList()
for i=1,rewardItems.Count do
local rewardItem=rewardItems[i-1]
local prop={}
prop[PropIndex(DataPropKey.eWidgetActive,7)]=getted
rewardItem:SetChildPropData(-1,prop)
end
end

function UISubAct_TargetActivityWin5:onClickBoardItem(...)
if not self:onRewardRoot()then
itemsComponentHelper.onItemClickEx(...)
end
end

function UISubAct_TargetActivityWin5:refreshRewardProgress()
local data=self.info:getData()
local groupCfg=self.config.tasks[self.selectTab]
local tasks=groupCfg.tasklist
local max=#tasks
local cnt=0
local chapterData=data.chapterData[self.selectTab]
local flag=chapterData.chapter_state==taskModel.taskRewardState
for taskId,v in ipairs(tasks)do
local taskData=chapterData.taskData[taskId]
if taskData.task_state==taskModel.taskFinishState then
cnt=cnt+1
end
end

self.progressTx:setText(FMT.fmt("{0}/{1}",cnt,max))
self.progressBar:setProgressValue(math.floor(cnt/max*10000),10000)
self.progressBar:setChildProgressText(FMT.fmt("{0}/{1}",cnt,max))
self.rewardReddot:setActive(flag)
end

function UISubAct_TargetActivityWin5:refreshTaskList()
local groupCfg=self.config.tasks[self.selectTab]
local data=self.info:getData()
local tasks=groupCfg.tasklist
self.sortList={}
local chapterData=data.chapterData[self.selectTab]
for taskid,v in ipairs(tasks)do
local taskInfo=chapterData.taskData[taskid]
table.insert(self.sortList,{taskId=taskid,data=taskInfo,sortWeight=taskInfo.sortWeight})
end
table.sort(self.sortList,function(a,b)
return a.sortWeight<b.sortWeight
end)

self.taskList:setChildLayoutGroupCreateItems(#tasks,function(index)
local item=self.taskList:getChildLayoutGroupGridItem(index-1)
local taskData=self.sortList[index].data
local taskCfg=tasks[taskData.task_id]
self:refreshTaskItem(index,item,taskData,taskCfg,true)
end)
end

function UISubAct_TargetActivityWin5:refreshTaskItem(index,item,data,config,isInit)
if isInit then
item:SetChildButtonClick(_taskCmp.rewardBtn,function()
self:onClickTaskReward(index)
end)
item:SetChildButtonClick(_taskCmp.jumpBtn,function()
self:onClickTaskJump(index)
end)
local rewards=config[4]
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
local descStr=FMT.fmt(config[6]or"{0}",progressStr)
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

function UISubAct_TargetActivityWin5:refreshTaskDescList(id)
for index,sortData in ipairs(self.sortList)do
if id==sortData.taskId then
local item=self.taskList:getChildLayoutGroupGridItem(index-1)
local config=self.config.tasks[self.selectTab].tasklist[sortData.taskId]
local data=sortData.data
self:refreshTaskDesc(item,data,config)
end
end
end

function UISubAct_TargetActivityWin5:refreshTaskDesc(item,data,config)
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
local progressStr
if current<target then
progressStr=FMT.fmt("<color=#c82c2c>(</color><color=#549327>{0}</color><color=#c82c2c>/{1})</color>",Mathf.Clamp(current,0,target),target)
else
progressStr=FMT.fmt("({0}/{1})",Mathf.Clamp(current,0,target),target)
progressStr=FMT.cfmt(FONT_COLOR.eGreenColor,progressStr)
end
local descStr=FMT.fmt(config[6]or"{0}",progressStr)
item:SetChildText(_taskCmp.descTx,descStr)
end

function UISubAct_TargetActivityWin5:onRewardRoot()
local data=self.info:getData()

if data.chapterData[self.selectTab].chapter_state==taskModel.taskRewardState then
self.info:reqGetChapterReward(self.selectTab)
return true
end
return false
end

function UISubAct_TargetActivityWin5:onClickTaskReward(index)
local sortData=self.sortList[index]
if sortData.data.task_state==taskModel.taskRewardState then
self.info:reqGetTaskReward(self.selectTab,sortData.taskId)
end
end

function UISubAct_TargetActivityWin5:onClickTaskJump(index)
local sortData=self.sortList[index]
local taskId=sortData.taskId
local config=self.config.tasks[self.selectTab].tasklist[taskId]
jumpManager:jump(config[5])
end

