







def_class("UISubAct_ShiGuangPinTuWin",UIWindowBase)









function UISubAct_ShiGuangPinTuWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.colItem_1=UIObject.get(self,1)
self.colItem_2=UIObject.get(self,2)
self.colItem_3=UIObject.get(self,3)
self.colItem_4=UIObject.get(self,4)
self.completeTitleBg=UIImage.get(self,5)
self.completeTitleTx=UIText.get(self,6)
self.crList=UIObject.get(self,7)
self.crView=UIObject.get(self,8)
self.gridItem_1=UIObject.get(self,9)
self.gridItem_10=UIObject.get(self,10)
self.gridItem_11=UIObject.get(self,11)
self.gridItem_12=UIObject.get(self,12)
self.gridItem_13=UIObject.get(self,13)
self.gridItem_14=UIObject.get(self,14)
self.gridItem_15=UIObject.get(self,15)
self.gridItem_16=UIObject.get(self,16)
self.gridItem_2=UIObject.get(self,17)
self.gridItem_3=UIObject.get(self,18)
self.gridItem_4=UIObject.get(self,19)
self.gridItem_5=UIObject.get(self,20)
self.gridItem_6=UIObject.get(self,21)
self.gridItem_7=UIObject.get(self,22)
self.gridItem_8=UIObject.get(self,23)
self.gridItem_9=UIObject.get(self,24)
self.haveIcon=UIImage.get(self,25)
self.haveNum=UIText.get(self,26)
self.helpBtn=UIButton.get(self,27)
self.moneyBg=UIImage.get(self,28)
self.picture=UIImage.get(self,29)
self.rowItem_1=UIObject.get(self,30)
self.rowItem_2=UIObject.get(self,31)
self.rowItem_3=UIObject.get(self,32)
self.rowItem_4=UIObject.get(self,33)
self.taskTitleBg=UIImage.get(self,34)
self.taskTitleTx=UIText.get(self,35)
self.taskView=UILoopListView.new(self,36)
self.timeTx=UIText.get(self,37)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.taskView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)self.colItem={
self.colItem_1,
self.colItem_2,
self.colItem_3,
self.colItem_4,
}
self.gridItem={
self.gridItem_1,
self.gridItem_2,
self.gridItem_3,
self.gridItem_4,
self.gridItem_5,
self.gridItem_6,
self.gridItem_7,
self.gridItem_8,
self.gridItem_9,
self.gridItem_10,
self.gridItem_11,
self.gridItem_12,
self.gridItem_13,
self.gridItem_14,
self.gridItem_15,
self.gridItem_16,
}
self.rowItem={
self.rowItem_1,
self.rowItem_2,
self.rowItem_3,
self.rowItem_4,
}



end


function UISubAct_ShiGuangPinTuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.colItem_1);self.colItem_1=nil;
_UIObject_release(self.colItem_2);self.colItem_2=nil;
_UIObject_release(self.colItem_3);self.colItem_3=nil;
_UIObject_release(self.colItem_4);self.colItem_4=nil;
_UIObject_release(self.completeTitleBg);self.completeTitleBg=nil;
_UIObject_release(self.completeTitleTx);self.completeTitleTx=nil;
_UIObject_release(self.crList);self.crList=nil;
_UIObject_release(self.crView);self.crView=nil;
_UIObject_release(self.gridItem_1);self.gridItem_1=nil;
_UIObject_release(self.gridItem_10);self.gridItem_10=nil;
_UIObject_release(self.gridItem_11);self.gridItem_11=nil;
_UIObject_release(self.gridItem_12);self.gridItem_12=nil;
_UIObject_release(self.gridItem_13);self.gridItem_13=nil;
_UIObject_release(self.gridItem_14);self.gridItem_14=nil;
_UIObject_release(self.gridItem_15);self.gridItem_15=nil;
_UIObject_release(self.gridItem_16);self.gridItem_16=nil;
_UIObject_release(self.gridItem_2);self.gridItem_2=nil;
_UIObject_release(self.gridItem_3);self.gridItem_3=nil;
_UIObject_release(self.gridItem_4);self.gridItem_4=nil;
_UIObject_release(self.gridItem_5);self.gridItem_5=nil;
_UIObject_release(self.gridItem_6);self.gridItem_6=nil;
_UIObject_release(self.gridItem_7);self.gridItem_7=nil;
_UIObject_release(self.gridItem_8);self.gridItem_8=nil;
_UIObject_release(self.gridItem_9);self.gridItem_9=nil;
_UIObject_release(self.haveIcon);self.haveIcon=nil;
_UIObject_release(self.haveNum);self.haveNum=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.moneyBg);self.moneyBg=nil;
_UIObject_release(self.picture);self.picture=nil;
_UIObject_release(self.rowItem_1);self.rowItem_1=nil;
_UIObject_release(self.rowItem_2);self.rowItem_2=nil;
_UIObject_release(self.rowItem_3);self.rowItem_3=nil;
_UIObject_release(self.rowItem_4);self.rowItem_4=nil;
_UIObject_release(self.taskTitleBg);self.taskTitleBg=nil;
_UIObject_release(self.taskTitleTx);self.taskTitleTx=nil;
self.taskView:deleteSelf();self.taskView=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
self.colItem=nil;
self.gridItem=nil;
self.rowItem=nil;
end















local _this=nil
local _gridCmp={
root=-1,
button=0,
icon=1,
num=2,
}
local _colrowItem={
root=-1,
box=0,
getted=1,
effect=2,
button=3,
}
local _completeItem={
item=0,
flag=1,
effect=2,
}
local _taskCmp={
descTx=0,
rewardIcon=1,
rewardNum=2,
gotoBtn=3,
rewardBtn=4,
gotFlag=5,
back=6,
}
local _redColor=Color.StrToColor("#FF0000")
local _greenColor=Color.StrToColor(FONT_TIPS_COLOR_VAL[FONT_COLOR.eGreenColor])
local _abName="ui/windows/activities/sub_shiguangpintu/shiguangpintu_atlas_pak.ab"



function UISubAct_ShiGuangPinTuWin:onLoaded(...)
self:bindComponents()
_this=self

self:addProNotify(247,81,self.on_247_81)
self:addProNotify(247,83,self.on_247_83)
self:addProNotify(247,84,self.on_247_84)
self:addProNotify(247,85,self.on_247_85)
self:addNotify(notifyConfig.on_money_changed,self.on_money_change)

self.gridWidget={}
for i,v in ipairs(self.gridItem)do
local widget=v:getChildWidgetBase()
widget:SetChildButtonClick(_gridCmp.button,function()
self:onClickGridItem(i)
end)
self.gridWidget[i]=widget
end
self.colWidget={}
for i,v in ipairs(self.colItem)do
local widget=v:getChildWidgetBase()
widget:SetChildButtonClick(_colrowItem.button,function()
self:onClickColItem(i)
end)
self.colWidget[i]=widget
end
self.rowWidget={}
for i,v in ipairs(self.rowItem)do
local widget=v:getChildWidgetBase()
widget:SetChildButtonClick(_colrowItem.button,function()
self:onClickRowItem(i)
end)
self.rowWidget[i]=widget
end
end


function UISubAct_ShiGuangPinTuWin:__delete()
self:unbindComponents()
_this=nil

self:stopCDTick()
end




function UISubAct_ShiGuangPinTuWin:onShow(argtable,afterOnloaded)
if argtable then
local old=self.actId==argtable.act_id and self.subType==argtable.sub_act_type and self.subId==argtable.sub_act_id
if not old then
self.actId=argtable.act_id
self.subType=argtable.sub_act_type
self.subId=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.argtable=argtable
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self:initView()
self:initTaskList()
self:startCDTick()
self:refreshAllGrid()
self:refreshAllCol()
self:refreshAllRow()
self:refreshCompleteReward()
self:refreshMoney()
end
end
end


function UISubAct_ShiGuangPinTuWin:onHide()

end




function UISubAct_ShiGuangPinTuWin:onHelpBtn()
local d={}
d.title='规则'
d.mode=3
d.name=self.config.rule
UIManager:showWindow('UIRuleWin',d)
end

function UISubAct_ShiGuangPinTuWin:onStartAction()
end

function UISubAct_ShiGuangPinTuWin:onFreshAction(index,widget)
local taskId=self.taskDatas[index]
local taskCfg=self.config.task_list[taskId]
local reward=taskCfg[2][1]
widget:SetChildCSImageSprite(_taskCmp.back,_abName,taskCfg[5])
widget:SetChildCSImageIcon(_taskCmp.rewardIcon,iconHelper.getIconName(reward[1]),false)
widget:SetChildText(_taskCmp.rewardNum,FMT.fmt("X{0}",mathHelper.formatNumber(reward[2])))
widget:SetChildButtonClick(_taskCmp.rewardBtn,function()
self:onClickTaskReward(index)
end)
widget:SetChildButtonClick(_taskCmp.gotoBtn,function()
self:onClickTaskGoto(index)
end)
self:refreshTaskState(index,widget)
end

function UISubAct_ShiGuangPinTuWin:onClickTaskReward(index)
local taskId=self.taskDatas[index]
local taskData=self.info:getTaskData(taskId)
if taskData.task_state==taskModel.taskRewardState then
local taskList=self.info:findCanRewardTaskList()
call_activitiesHandle_func("activitiesHandle_shiguangpintu","reqTaskReward",self.actId,self.subId,taskList)
end
end

function UISubAct_ShiGuangPinTuWin:onClickTaskGoto(index)
local taskId=self.taskDatas[index]
local taskData=self.info:getTaskData(taskId)
if taskData.task_state==taskModel.taskDoingState then
local jump=self.config.task_list[taskId][4]
jumpManager:jump(jump)
end
end

function UISubAct_ShiGuangPinTuWin:onClickCompleteItem(itemId,index,guid,attach)
local getted=self.info:getCompleteFlag()
local enough=self.info:checkCompleteEnough()
if not getted and enough then
call_activitiesHandle_func("activitiesHandle_shiguangpintu","reqCompleteReward",self.actId,self.subId)
else
itemsComponentHelper.onItemClickEx(itemId,index,guid,attach)
end
end

function UISubAct_ShiGuangPinTuWin:onClickGridItem(index)
local getted=self.info:getGridFlagEx(index)
if not getted then
local cfg=self.config.puzzle_conf[index]
local args={
parentWin=self,
content="是否消耗quad-icon={0}-quad{1}个，解锁拼图？",
money=cfg[1][1],
rewards=cfg[2],
callback=function()
call_activitiesHandle_func("activitiesHandle_shiguangpintu","reqGridReward",self.actId,self.subId,index)
end,
}
self:showWindow("UISubAct_ShiGuangPinTuGridDialog",args)
end
end

function UISubAct_ShiGuangPinTuWin:onClickRowItem(row)
local getted=self.info:getRowFlag(row)
local enough=self.info:checkRowEnough(row)
if not getted and enough then
local rowList=self.info:findCanRewardRowList()
local colList=self.info:findCanRewardColList()
call_activitiesHandle_func("activitiesHandle_shiguangpintu","reqRowColReward",self.actId,self.subId,rowList,colList)
elseif not getted then
local rewards=self.config.row_reward[row][1]
local args={
parentWin=self,
title='本行奖励',
rewardTitle=-1,
desc1="解锁本行拼图可领取以下奖励",
rewards=rewards,
showCancel=false,
commitName='确定',
}
self:showWindow('UIDialougeRewardWin',args)
else
UIManager.error("已领取")
end
end

function UISubAct_ShiGuangPinTuWin:onClickColItem(col)
local getted=self.info:getColFlag(col)
local enough=self.info:checkColEnough(col)
if not getted and enough then
local rowList=self.info:findCanRewardRowList()
local colList=self.info:findCanRewardColList()
call_activitiesHandle_func("activitiesHandle_shiguangpintu","reqRowColReward",self.actId,self.subId,rowList,colList)
elseif not getted then
local rewards=self.config.col_reward[col][1]
local args={
parentWin=self,
title='本列奖励',
rewardTitle=-1,
desc1="解锁本列拼图可领取以下奖励",
rewards=rewards,
showCancel=false,
commitName='确定',
}
self:showWindow('UIDialougeRewardWin',args)
else
UIManager.error("已领取")
end
end

function UISubAct_ShiGuangPinTuWin:initView()
for i,v in ipairs(self.gridWidget)do
local cfg=self.config.puzzle_conf[i]
v:SetChildCSImageSprite(_gridCmp.button,_abName,cfg[3])
v:SetChildCSImageIcon(_gridCmp.icon,iconHelper.getIconName(cfg[1][1][1]),false)
v:SetChildText(_gridCmp.num,cfg[1][1][2])
end
for i,v in ipairs(self.colWidget)do
local cfg=self.config.col_reward[i]
v:SetChildCSImageSprite(_colrowItem.button,_abName,cfg[4])
v:SetChildCSImageSprite(_colrowItem.box,_abName,cfg[2])
v:SetChildCSImageSprite(_colrowItem.getted,_abName,cfg[3])
end
for i,v in ipairs(self.rowWidget)do
local cfg=self.config.row_reward[i]
v:SetChildCSImageSprite(_colrowItem.button,_abName,cfg[4])
v:SetChildCSImageSprite(_colrowItem.box,_abName,cfg[2])
v:SetChildCSImageSprite(_colrowItem.getted,_abName,cfg[3])
end
self.picture:setSprite(self.config.picture[1],self.config.picture[2])
self.haveIcon:setImageIcon(iconHelper.getIconName(self.config.money),false)
self.taskTitleTx:setText(self.config.task_title)
self.taskTitleBg:setSprite(_abName,self.config.taskTitleBg)
self.completeTitleTx:setText(self.config.complete_title)
self.completeTitleBg:setSprite(_abName,self.config.completeTitleBg)
self.moneyBg:setSprite(_abName,self.config.moneyBg)
self.bgModel:setChildUIModelShowTarget(self.config.bgSpine,1,defaultT,eAnimationID.stand)
local crRewards=self.config.all_reward
self.crList:setChildLayoutGroupCreateItems(#crRewards,function(index)
local item=self.crList:getChildLayoutGroupGridItem(index-1)
local rewardData=crRewards[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local _itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local _itemProp=itemsComponentHelper.getCommonFillDataSmall(_itemConf)
item:SetChildPropData(_completeItem.item,_itemProp)
item:SetBaseItemClickEvent(_completeItem.item,function(...)
self:onClickCompleteItem(...)
end)
end)
self.crView:setChildScrollRectEnable(#crRewards>3)
end

function UISubAct_ShiGuangPinTuWin:initTaskList()
local createList={}
self.taskDatas=self.info:getTaskSortList()
for i,v in ipairs(self.taskDatas)do
table.insert(createList,i)
end
self.taskView:initData("taskItem",createList,#createList)
end

function UISubAct_ShiGuangPinTuWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_ShiGuangPinTuWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_ShiGuangPinTuWin:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.actId,self.subType,self.subId)
self.timeTx:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp3(time)))
end

function UISubAct_ShiGuangPinTuWin:refreshAllGrid()
for i,v in ipairs(self.gridWidget)do
self:refreshGridItem(i,v)
end
end

function UISubAct_ShiGuangPinTuWin:refreshGridItem(index,widget)
widget=widget or self.gridWidget[index]
local flag=self.info:getGridFlagEx(index)
widget:SetChildActive(_gridCmp.root,flag~=true)
end

function UISubAct_ShiGuangPinTuWin:refreshAllCol()
for i,v in ipairs(self.colWidget)do
self:refreshColItem(i,v)
end
end

function UISubAct_ShiGuangPinTuWin:refreshColItem(col,widget)
widget=widget or self.colWidget[col]
local flag=self.info:getColFlag(col)
widget:SetChildActive(_colrowItem.box,flag~=true)
widget:SetChildActive(_colrowItem.getted,flag==true)
if not flag then
local enough=self.info:checkColEnough(col)
if enough then
widget:SetChildDOTweenAnimation_DOPlay(_colrowItem.box,nil,0,2)
else
widget:SetChildDOTweenAnimation_DOPause(_colrowItem.box)
widget:SetChildRotation(_colrowItem.box,0,0,0)
end

else

widget:SetChildDOTweenAnimation_DOPause(_colrowItem.box)
widget:SetChildRotation(_colrowItem.box,0,0,0)
end
end

function UISubAct_ShiGuangPinTuWin:refreshAllRow()
for i,v in ipairs(self.rowWidget)do
self:refreshRowItem(i,v)
end
end

function UISubAct_ShiGuangPinTuWin:refreshRowItem(row,widget)
widget=widget or self.rowWidget[row]
local flag=self.info:getRowFlag(row)
widget:SetChildActive(_colrowItem.box,flag~=true)
widget:SetChildActive(_colrowItem.getted,flag==true)
if not flag then
local enough=self.info:checkRowEnough(row)
if enough then
widget:SetChildDOTweenAnimation_DOPlay(_colrowItem.box,nil,0,2)
else
widget:SetChildDOTweenAnimation_DOPause(_colrowItem.box)
widget:SetChildRotation(_colrowItem.box,0,0,-90)
end

else

widget:SetChildDOTweenAnimation_DOPause(_colrowItem.box)
widget:SetChildRotation(_colrowItem.box,0,0,-90)
end
end

function UISubAct_ShiGuangPinTuWin:refreshMoney()
local haveNum=itemsModel.getCount(self.config.money)
self.haveNum:setText(mathHelper.formatNumber(haveNum))

for i,v in ipairs(self.gridWidget)do
local needNum=self.config.puzzle_conf[i][1][1][2]
local color=haveNum>=needNum and _greenColor or _redColor
v:SetTextColor(_gridCmp.num,color)
end
end

function UISubAct_ShiGuangPinTuWin:refreshTaskList()
self.taskDatas=self.info:getTaskSortList()
local startIdx,endIdx=self.taskView:getVisableIndex()
for index=startIdx,endIdx do
local widget=self.taskView:getItemWidget(index)
if widget then
self:onFreshAction(index,widget)
end
end
end

function UISubAct_ShiGuangPinTuWin:refreshTaskItems(taskIds)
for i,v in ipairs(taskIds)do
self:refreshTaskItem(v)
end
end

function UISubAct_ShiGuangPinTuWin:refreshTaskItem(taskId)
local index=table.findValue(self.taskDatas,taskId)
local widget=self.taskView:getItemWidget(index)
if widget then
self:refreshTaskState(index,widget)
end
end

function UISubAct_ShiGuangPinTuWin:refreshTaskState(index,widget)
local taskId=self.taskDatas[index]
local taskCfg=self.config.task_list[taskId]
local taskData=self.info:getTaskData(taskId)
local getted=taskData.task_state==taskModel.taskFinishState
local target=taskData.task_target
local current=getted and target or taskData.server_progress
if not getted and taskData.count_flag then
if mathHelper.getBitValue(taskData.count_flag,2)then
if taskData.server_progress<taskData.task_target then
current=taskData.client_progress
end
else
current=taskData.client_progress
end
end
local color=current>=target and FONT_COLOR_VAL[FONT_COLOR.eGreenColor]or FONT_COLOR_VAL[FONT_COLOR.eRedColor]
local progressStr=FMT.cfmt2(color,"{0}/{1}",mathHelper.formatNumber(current),mathHelper.formatNumber(target))
local descStr=FMT.fmt("{0}({1})",taskCfg[3],progressStr)
widget:SetChildText(_taskCmp.descTx,descStr)
widget:SetChildActive(_taskCmp.gotoBtn,taskData.task_state==taskModel.taskDoingState)
widget:SetChildActive(_taskCmp.rewardBtn,taskData.task_state==taskModel.taskRewardState)
widget:SetChildActive(_taskCmp.gotFlag,taskData.task_state==taskModel.taskFinishState)
end

function UISubAct_ShiGuangPinTuWin:refreshCompleteReward()
local crItems=self.crList:getChildLayoutGroupGridList()
local flag=self.info:getCompleteFlag()
local enough=self.info:checkCompleteEnough()
for i=1,crItems.Count do
local item=crItems[i-1]
item:SetChildActive(_completeItem.flag,flag==true)
item:SetChildActive(_completeItem.effect,flag~=true and enough==true)
end
end

function UISubAct_ShiGuangPinTuWin.on_247_81(args)
local subType=SUB_ACTIVITY_TYPE.eShiGuangPinTu
local actId=args[1]
local subId=args[2]
if _this.info:compare(actId,subType,subId)then
_this:refreshAllGrid()
_this:refreshAllCol()
_this:refreshAllRow()
_this:refreshCompleteReward()
_this:refreshTaskList()
end
end

function UISubAct_ShiGuangPinTuWin.on_247_83(actId,subId,puzzleIndex,result)
if result~=0 then return end

local subType=SUB_ACTIVITY_TYPE.eShiGuangPinTu
if _this.info:compare(actId,subType,subId)then
_this:refreshGridItem(puzzleIndex)

local row,col=_this.info:covertGrid2RowCol(puzzleIndex)
_this:refreshRowItem(row)
_this:refreshColItem(col)

_this:refreshCompleteReward()
end
end

function UISubAct_ShiGuangPinTuWin.on_247_84(args)
local actId=args[1]
local subId=args[2]
local result=args[3]
local rowLen=args[4]
local rowList=args[5]
local colLen=args[6]
local colList=args[7]
if result~=0 then return end

local subType=SUB_ACTIVITY_TYPE.eShiGuangPinTu
if _this.info:compare(actId,subType,subId)then
for i=1,rowLen do
_this:refreshRowItem(rowList[i])
end
for i=1,colLen do
_this:refreshColItem(colList[i])
end
end
end

function UISubAct_ShiGuangPinTuWin.on_247_85(actId,subId,result)
if result~=0 then return end

local subType=SUB_ACTIVITY_TYPE.eShiGuangPinTu
if _this.info:compare(actId,subType,subId)then
_this:refreshCompleteReward()
end
end

function UISubAct_ShiGuangPinTuWin.on_money_change(moneyType,lastVal,newValue)
if moneyType==_this.config.money then
_this:refreshMoney()
end
end