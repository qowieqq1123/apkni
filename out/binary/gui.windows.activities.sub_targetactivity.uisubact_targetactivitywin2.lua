







def_class("UISubAct_TargetActivityWin2",UIWindowBase)









function UISubAct_TargetActivityWin2:bindComponents()

self.backgroundModel=UIObject.get(self,0)
self.timeTx=UIText.get(self,1)
self.modelBtn=UIButton.get(self,2)
self.effect=UIObject.get(self,3)
self.model=UIObject.get(self,4)
self.effectEx=UIObject.get(self,5)
self.title=UIImage.get(self,6)
self.foregroundModel=UIObject.get(self,7)
self.rewardTips=UIText.get(self,8)
self.rewardBtn=UIButton.get(self,9)
self.inactive=UIObject.get(self,10)
self.getted=UIObject.get(self,11)
self.rewardList=UIObject.get(self,12)
self.taskList=UIObject.get(self,13)

self.modelBtn:setButtonClick(function()self:onModelBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UISubAct_TargetActivityWin2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backgroundModel);self.backgroundModel=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.modelBtn);self.modelBtn=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.effectEx);self.effectEx=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.foregroundModel);self.foregroundModel=nil;
_UIObject_release(self.rewardTips);self.rewardTips=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.inactive);self.inactive=nil;
_UIObject_release(self.getted);self.getted=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.taskList);self.taskList=nil;
end















local _this=nil
local _taskCmp={
descTx=0,
rewardList=1,
getted=2,
rewardBtn=3,
jumpBtn=4,
jumptext=5,
}
local _sortWeight={2,1,3}



function UISubAct_TargetActivityWin2:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_TargetActivityWin2:__delete()
self:stopCDTick()
self:unbindComponents()
_this=nil
end




function UISubAct_TargetActivityWin2:onShow(argtable,afterOnloaded)
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
self:refreshView(true)
end
self.rewardList:setChildAnchoredPos(0,0)
self.effect:setActive(true)
self.effectEx:setActive(true)
end


function UISubAct_TargetActivityWin2:onHide()
self.effect:setActive(false)
self.effectEx:setActive(false)
end





function UISubAct_TargetActivityWin2:onRewardBtn()
local data=self.info:getData()
if data.bits~=0 then

return
end

local groupInfo=self.config.grouprewards[1]
local taskList=groupInfo[1]
local taskMax=groupInfo[4]or#taskList
local taskCnt=0
for index,taskId in ipairs(taskList)do
local taskData=data.taskList[taskId]
if taskData.task_state==taskModel.taskFinishState then
taskCnt=taskCnt+1
end
end
if taskCnt>=taskMax then
call_activitiesHandle_func('activitiesHandle_targetActivity2','reqGroupReward',self.activityId,self.subId,1)
else

end
end

function UISubAct_TargetActivityWin2:onModelBtn()
local modelBtnParams=self.argtable.modelBtnParams
if modelBtnParams and modelBtnParams.tipsItem then

itemsComponentHelper.onItemClickEx(modelBtnParams.tipsItem)
end
end

function UISubAct_TargetActivityWin2:initView()
self:startCDTick()

local bgModelParams=self.argtable.backgroundModel
if bgModelParams then
self.backgroundModel:setChildUIModelShowTarget(bgModelParams.body or 1,bgModelParams.scale or 1,bgModelParams.componets or{},bgModelParams.anim or eAnimationID.stand,false,false,0,nil)
else
self.backgroundModel:setChildUIModelRemoveTarget()
end

local fgModelParams=self.argtable.foregroundModel
if fgModelParams then
self.foregroundModel:setChildUIModelShowTarget(fgModelParams.body or 1,fgModelParams.scale or 1,fgModelParams.componets or{},fgModelParams.anim or eAnimationID.stand,false,false,0,nil)
else
self.foregroundModel:setChildUIModelRemoveTarget()
end

local modelParams=self.argtable.modelParams
if modelParams then
self.model:setChildUIModelShowTarget(modelParams.body or 1,modelParams.scale or 1,modelParams.componets or{},modelParams.anim or eAnimationID.stand,false,false,0,nil)
self.model:setChildUIModelShowTargetOffset(modelParams.offset[1]or 0,modelParams.offset[2]or 0)
self.model:setChildUIModelShowFlipX(modelParams.flip or false)
else
self.model:setChildUIModelRemoveTarget()
end

local modelBtnParams=self.argtable.modelBtnParams
if modelBtnParams then
self.modelBtn:setActive(true)
if modelBtnParams.pos then
self.modelBtn:setChildAnchoredPos(modelBtnParams.pos[1]or 0,modelBtnParams.pos[2]or 0)
end
if modelBtnParams.size then
self.modelBtn:setChildSizeDelta(modelBtnParams.size[1]or 0,modelBtnParams.size[2]or 0)
end
else
self.modelBtn:setActive(false)
end

local titleParams=self.argtable.title
if titleParams then
self.title:setSprite(titleParams.image[1],titleParams.image[2])
self.title:setChildAnchoredPos(titleParams.pos[1],titleParams.pos[2])
else
self.title:setImageIcon("",false)
end

local effectParams=self.argtable.effect
if effectParams then
self.effect:setChildShowEffect(effectParams.id,true)
self.effect:setChildAnchoredPos(effectParams.pos[1]or 0,effectParams.pos[2]or 0)
else
self.effect:setChildShowEffect(-1,false)
end

local effectExParams=self.argtable.effectEx
if effectExParams then
self.effectEx:setChildShowEffect(effectExParams.id,true)
self.effectEx:setChildAnchoredPos(effectExParams.pos[1]or 0,effectExParams.pos[2]or 0)
else
self.effectEx:setChildShowEffect(-1,false)
end

local groupInfo=self.config.grouprewards[1]
local rewards=groupInfo[2]
self.rewardList:setChildLayoutGroupCreateItems(#rewards,function(index)
local item=self.rewardList:getChildLayoutGroupGridItem(index-1)
local data=rewards[index]
local showCountBG=data[2]>1
local countStr=showCountBG and data[2]or""
local conf={itemid=data[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
end

function UISubAct_TargetActivityWin2:refreshView(init)
if self.info:hasData()then
self:refreshRewards()
self:refreshTaskList(init)
end
end

function UISubAct_TargetActivityWin2:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_TargetActivityWin2:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_TargetActivityWin2:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
self.timeTx:setText(FMT.fmt("{0}后结束",timeHelper.format_time_stamp3(time)))
end

function UISubAct_TargetActivityWin2:refreshRewards()
local data=self.info:getData()
local getted=data.bits~=0
self.getted:setActive(getted)
if getted then
self.inactive:setActive(false)
self.rewardBtn:setActive(false)
self.rewardTips:setText("")
else
local groupInfo=self.config.grouprewards[1]
local taskList=groupInfo[1]
local taskMax=groupInfo[4]or#taskList
local taskCnt=0
for index,taskId in ipairs(taskList)do
local taskData=data.taskList[taskId]
if taskData.task_state==taskModel.taskFinishState then
taskCnt=taskCnt+1
end
end
local enough=taskCnt>=taskMax
local tipsStr=""
if not enough then
local str=FMT.cfmt(enough and FONT_COLOR.eGreenColor or FONT_COLOR.eRedColor,"{0}/{1}",taskCnt,taskMax)
tipsStr=FMT.fmt("完成<color=#ff0000>{1}</color>个目标可领取（{0}）",str,taskMax)
end
self.inactive:setActive(not enough)
self.rewardBtn:setActive(enough)
self.rewardTips:setText(tipsStr)
end
end

function UISubAct_TargetActivityWin2:refreshTaskList(init)
local data=self.info:getData()
local groupInfo=self.config.grouprewards[1]
local tasks=groupInfo[1]
self.sortList={}
for i,v in ipairs(tasks)do
local taskInfo=data.taskList[v]
local weight=_sortWeight[taskInfo.task_state]*10000+i
table.insert(self.sortList,{index=i,taskId=v,data=taskInfo,sortWeight=weight})
end
table.sort(self.sortList,function(a,b)
return a.sortWeight<b.sortWeight
end)

self.taskList:setChildLayoutGroupCreateItems(#self.sortList,function(index)
local item=self.taskList:getChildLayoutGroupGridItem(index-1)
local data=self.sortList[index].data
local config=self.config.tasks[data.task_id]
local changeBtnTextcfg=self.config.changeBtnText and self.config.changeBtnText[data.task_id]or nil
self:refreshTaskItem(index,item,data,config,init,changeBtnTextcfg)
end)
end

function UISubAct_TargetActivityWin2:refreshTaskItem(index,item,data,config,isInit,changeBtnTextcfg)
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
local progressStr=FMT.fmt("{0}/{1}",Mathf.Clamp(current,0,target),target)
if current<target then
progressStr=FMT.cfmt(FONT_COLOR.eRedColor,progressStr)
else
progressStr=FMT.cfmt(FONT_COLOR.eGreenColor,progressStr)
end
progressStr=FMT.fmt("({0})",progressStr)
local descStr=FMT.fmt(config[6],progressStr)
item:SetChildText(_taskCmp.descTx,descStr)
item:SetChildActive(_taskCmp.getted,getted)
if not getted then
local complete=current>=target
item:SetChildActive(_taskCmp.rewardBtn,complete)
item:SetChildActive(_taskCmp.jumpBtn,config[5]~=nil and not complete)
else
item:SetChildActive(_taskCmp.rewardBtn,false)
item:SetChildActive(_taskCmp.jumpBtn,false)
end
if changeBtnTextcfg then
item:SetChildText(_taskCmp.jumptext,changeBtnTextcfg[1])
else
item:SetChildText(_taskCmp.jumptext,"前往")
end

local rewards=config[2]
item:SetChildLayoutGroupCreateItems(_taskCmp.rewardList,#rewards,function(idx)
local rewardItem=item:GetChildLayoutGroupGridItem(_taskCmp.rewardList,idx-1)
local data=rewards[idx]
local showCountBG=data[2]>1
local countStr=showCountBG and data[2]or""
local conf={itemid=data[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(-1,prop)
rewardItem:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
if isInit then
item:SetChildButtonClick(_taskCmp.jumpBtn,function()
self:onClickJump(index,changeBtnTextcfg)
end)
item:SetChildButtonClick(_taskCmp.rewardBtn,function()
self:onClickReward(index)
end)
end
end

function UISubAct_TargetActivityWin2:refreshTaskDesc(item,data,config)
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
progressStr=FMT.fmt("({0})",progressStr)
local descStr=FMT.fmt(config[6],progressStr)
item:SetChildText(_taskCmp.descTx,descStr)
end

function UISubAct_TargetActivityWin2:onClickJump(index,changeBtnTextcfg)
local sortData=self.sortList[index]
local taskId=sortData.taskId
local config=self.config.tasks[taskId]
if changeBtnTextcfg and changeBtnTextcfg[2]and changeBtnTextcfg[2]==1 then
if not xianmengModel:hasXM()then
UIManager.info("未加入仙盟无法分享")
return
end
end
jumpManager:jump(config[5])
end

function UISubAct_TargetActivityWin2:onClickReward(index)
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

function UISubAct_TargetActivityWin2:on_249_109(actId,subId)
if self.info:compare(actId,self.subType,subId)then
self:refreshView()
end
end

function UISubAct_TargetActivityWin2:on_249_110(actId,subId,enoughs,ids)
if self.info:compare(actId,self.subType,subId)then
if#enoughs>0 then
self:refreshView()
else
for index,sortData in ipairs(self.sortList)do
if table.containsValue(ids,sortData.taskId)then
local item=self.taskList:getChildLayoutGroupGridItem(index-1)
local config=self.config.tasks[sortData.taskId]
local data=sortData.data
self:refreshTaskDesc(item,data,config)
end
end
end
end
end

function UISubAct_TargetActivityWin2:on_249_111(actId,subId,taskId)
if self.info:compare(actId,self.subType,subId)then
self:refreshTaskList()
self:refreshRewards()
end
end

function UISubAct_TargetActivityWin2:on_249_112(actId,subId,group)
if self.info:compare(actId,self.subType,subId)and group==1 then
self.inactive:setActive(false)
self.rewardBtn:setActive(false)
self.getted:setActive(true)
self.rewardTips:setText("")
end
end
