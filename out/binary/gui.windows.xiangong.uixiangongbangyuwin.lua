







def_class("UIXianGongBangYuWin",UIWindowBase)









function UIXianGongBangYuWin:bindComponents()

self.btnClose=UIButton.get(self,0)
self.btnHelp=UIButton.get(self,1)
self.curScore=UIText.get(self,2)
self.leftTime=UIText.get(self,3)
self.progress=UIObject.get(self,4)
self.rewardBubble=UIObject.get(self,5)
self.rewardItem_1=UIBaseItem.get(self,6)
self.rewardItem_2=UIBaseItem.get(self,7)
self.rewardItem_3=UIBaseItem.get(self,8)
self.rewardReddot=UIObject.get(self,9)
self.targetPoints_1=UIObject.get(self,10)
self.targetPoints_2=UIObject.get(self,11)
self.targetPoints_3=UIObject.get(self,12)
self.targetPoints_4=UIObject.get(self,13)
self.targetPoints_5=UIObject.get(self,14)
self.taskContent=UIObject.get(self,15)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btnHelp:setButtonClick(function()self:onBtnHelp()end)
self.rewardItem={
self.rewardItem_1,
self.rewardItem_2,
self.rewardItem_3,
}
self.targetPoints={
self.targetPoints_1,
self.targetPoints_2,
self.targetPoints_3,
self.targetPoints_4,
self.targetPoints_5,
}



end


function UIXianGongBangYuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.btnHelp);self.btnHelp=nil;
_UIObject_release(self.curScore);self.curScore=nil;
_UIObject_release(self.leftTime);self.leftTime=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.rewardBubble);self.rewardBubble=nil;
_UIObject_release(self.rewardItem_1);self.rewardItem_1=nil;
_UIObject_release(self.rewardItem_2);self.rewardItem_2=nil;
_UIObject_release(self.rewardItem_3);self.rewardItem_3=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.targetPoints_1);self.targetPoints_1=nil;
_UIObject_release(self.targetPoints_2);self.targetPoints_2=nil;
_UIObject_release(self.targetPoints_3);self.targetPoints_3=nil;
_UIObject_release(self.targetPoints_4);self.targetPoints_4=nil;
_UIObject_release(self.targetPoints_5);self.targetPoints_5=nil;
_UIObject_release(self.taskContent);self.taskContent=nil;
self.rewardItem=nil;
self.targetPoints=nil;
end

















local _this


function UIXianGongBangYuWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXianGongBangYuWin:__delete()
_this=nil
self:unbindComponents()
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
end
end




function UIXianGongBangYuWin:onShow(argtable,afterOnloaded)
self.baseCfg=cfgHelper.get1(cfg_xiangongbaseconfig_get,1)
self:refreshScorePanel()
self:refreshTaskPanel()
self:refreshLeftTimePanel()
local func=function()
if self and not self.isClose then
self:refreshLeftTimePanel()
end
end
self:setTimer(1,0,func)

self:refreshRewardBubble()
end

function UIXianGongBangYuWin:refreshRewardBubble()
local cfg=cfgHelper.get1(cfg_xiangongbaseconfig_get,1)
local stageCfg=cfg.stage
local curScore=XianGongModel:getStageVal()
local stageIdx=XianGongModel:getStageIdx()
local idx
for i,v in ipairs(stageCfg)do
if stageIdx<i then
idx=i
break
end
end
self:refreshRewardPanel(idx)
end

function UIXianGongBangYuWin:refreshScorePanel()
local curScore=XianGongModel:getStageVal()
local maxScore=XianGongModel:getMaxStageVal()
local stageIdx=XianGongModel:getStageIdx()
self.curScore:setText(curScore)
self.progress:setChildIconFillAmount(curScore/maxScore)
local stage=self.baseCfg.stage
for i,v in ipairs(self.targetPoints)do
local widget=v:getWidgetBase()
local targetScore=stage[i][1]
local finish=curScore>=targetScore
local receive=i<=stageIdx
widget:SetChildText(0,curScore>=targetScore and string.format("<color=#ca631d>%d</color>",targetScore)or targetScore)
widget:SetChildActive(1,finish)
widget:SetChildActive(2,receive)
widget:SetChildButtonClick(3,function()
if self and not self.isClose then
self:onClickScoreItem(i)
end
end)
end
end

function UIXianGongBangYuWin:receiveScoreItem()
local stageIdx=XianGongModel:getStageIdx()
for i,v in ipairs(self.targetPoints)do
local widget=v:getWidgetBase()
local receive=i<=stageIdx
widget:SetChildActive(2,receive)
end
self:refreshRewardBubble()
end

function UIXianGongBangYuWin:receiveTaskUpdateScore()
local curScore=XianGongModel:getStageVal()
local maxScore=XianGongModel:getMaxStageVal()
self.curScore:setText(curScore)
self.progress:setChildImageDOFillAmount(curScore/maxScore,0.15)
local stage=self.baseCfg.stage
for i,v in ipairs(self.targetPoints)do
local widget=v:getWidgetBase()
local targetScore=stage[i][1]
local finish=curScore>=targetScore
widget:SetChildActive(1,finish)
end

self:refreshTaskPanel()
end

function UIXianGongBangYuWin:refreshTaskPanel()
self.taskList=XianGongModel:getSortTaskList()
self.taskContent:setChildLayoutGroupCreateItems(#self.taskList,function(index)
if self and not self.isClose then
self:refreshTaskItem(index)
end
end)
end

function UIXianGongBangYuWin:receiveTaskItem(list)
for i,v in ipairs(list or{})do
local id=v.param_1
for index,v in ipairs(self.taskList)do
if id==v.taskId then
self:refreshTaskItem(index)
break
end
end
end
end

function UIXianGongBangYuWin:refreshTaskItem(index)
local item=self.taskContent:getChildLayoutGroupGridItem(index-1)
local taskId=self.taskList[index].taskId
local taskData=XianGongModel:getTaskDataLookup(taskId)
local taskCfg=cfgHelper.get1(cfg_xiangongtaskconfig_get,taskId)
local aim_idx=taskData.aim_idx
local taskProgress=taskData.task_progress
local cur_aim_idx=aim_idx>=#taskCfg.taskaims and aim_idx or(aim_idx+1)
local taskaim=taskCfg.taskaims[cur_aim_idx]
local taskMaxProgress=taskaim[1]
local taskReceiveFlag=aim_idx>=#taskCfg.taskaims
local descIdx=cur_aim_idx>#taskCfg.taskdesc and#taskCfg.taskdesc or cur_aim_idx
local taskDesc=taskCfg.taskdesc[descIdx]
local taskReward=taskaim[2][1]
local moneyType,moneyCount=taskReward[1],taskReward[2]
local taskScore=taskaim[3]
item:SetChildIconFillAmount(0,taskProgress/taskMaxProgress)
item:SetChildText(1,string.format("进度：%s/%s",mathHelper.formatNumber(taskProgress),mathHelper.formatNumber(taskMaxProgress)))
item:SetChildText(2,FMT.fmt(taskDesc,taskMaxProgress))
item:SetChildIcon(3,iconHelper.getIconName(moneyType),false)
item:SetChildText(4,string.format("%d点%s",moneyCount,itemsModel.getName(moneyType)))

item:SetChildActive(5,taskProgress<taskMaxProgress and not taskReceiveFlag)
item:SetChildButtonClick(5,function()
jumpManager:jump(taskCfg.jump)
end)

item:SetChildActive(6,taskProgress>=taskMaxProgress and not taskReceiveFlag)
item:SetChildButtonClick(6,function()
self:onClickReceiveTaskReward()
end)

item:SetChildActive(7,taskReceiveFlag)
end

function UIXianGongBangYuWin:onClickReceiveTaskReward()
local temp={}
for index,v in ipairs(self.taskList)do
local taskId=v.taskId
local taskData=XianGongModel:getTaskDataLookup(taskId)
local taskCfg=cfgHelper.get1(cfg_xiangongtaskconfig_get,taskId)
local aim_idx=taskData.aim_idx
local taskProgress=taskData.task_progress
local receive_aim_idx=0
for idx=aim_idx+1,#taskCfg.taskaims do
local taskaim=taskCfg.taskaims[idx]
local taskMaxProgress=taskaim[1]
if taskProgress>=taskMaxProgress then
receive_aim_idx=idx
else
break
end
end
if receive_aim_idx>aim_idx then
table.insert(temp,{taskId,receive_aim_idx})
end
end
if#temp>0 then
XianGongController.reqReceiveTaskReward(#temp,temp)
end
end

function UIXianGongBangYuWin:onClickScoreItem(index)
local stageVal=XianGongModel:getStageVal()
local stageIdx=XianGongModel:getStageIdx()
if index<=stageIdx then
self:refreshRewardPanel(index)
else
local idx=self:getRewardReceiveIdx()
if idx then
XianGongController.reqReceiveStageReward(idx)
end
self:refreshRewardPanel(index)
end
end

function UIXianGongBangYuWin:getRewardReceiveIdx()
local stageVal=XianGongModel:getStageVal()
local stageIdx=XianGongModel:getStageIdx()
local cfg=cfgHelper.get1(cfg_xiangongbaseconfig_get,1)
local stageCfg=cfg.stage
local idx
for i,v in ipairs(stageCfg)do
local target=v[1]
if i>stageIdx and target<=stageVal then
idx=i
end
end
return idx,#stageCfg
end

function UIXianGongBangYuWin:refreshRewardPanel(index)
if not index then
self.rewardBubble:setActive(false)
return
end
local lastIdx=self.rewardIdx
self.rewardIdx=index
self.rewardBubble:setActive(true)
local stage=self.baseCfg.stage
local curScore=XianGongModel:getStageVal()
local stageIdx=XianGongModel:getStageIdx()
local targetScore=stage[index][1]
local rewardList=stage[index][2]
local finish=curScore>=targetScore
local receive=index<=stageIdx
local canReceive=finish and not receive
local gray=0
if receive then
gray=eGrayType.eMaskGray
end
for i,v in ipairs(self.rewardItem)do
local reward=rewardList[i]
if reward then
v:setActive(true)
local itemId,itemNum=unpack(reward)
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local conf={itemid=itemId,itemcount=countStr,showCountBG=itemNum>1,showname=false,showStage=true,gray=gray,colorEffect=canReceive,}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
v:setBaseItemClickEvent(function(...)
local idx=self:getRewardReceiveIdx()
local stageIdx=XianGongModel:getStageIdx()
if idx and index>stageIdx then
XianGongController.reqReceiveStageReward(idx)
else
itemsComponentHelper.onItemClick(...)
end
end)
v:setChildPropData(prop)
else
v:setActive(false)
end
end
self:doPunchRotation(canReceive)
if lastIdx~=self.rewardIdx then
local targetPoint=self.targetPoints[index]
local pos=targetPoint:getChildAnchoredPosition()
self.rewardBubble:setChildAnchoredPosition(Vector2(pos.x,0))
self.rewardBubble:setScale(Vector3.zero)
if self.bubbleTween~=nil then
self.bubbleTween:Kill()
self.bubbleTween=nil
end
self.bubbleTween=self.rewardBubble:setChildDOScale(1,0.25,function()
if _this==nil then return end
_this.bubbleTween=nil
end)
end
end


function UIXianGongBangYuWin:doPunchRotation(reddot)
self.rewardReddot:setActive(reddot)
if reddot then
if self.reddotTweener==nil then
self.rewardReddot:setRotation(0,0,0)
local tweener=self.rewardReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.rewardReddot:setRotation(0,0,0)
end
end
end

function UIXianGongBangYuWin:refreshLeftTimePanel()
if not self.MondayleftTime then
self.MondayleftTime=timeHelper.getWeakDateStamp(1,1,5,0,0)-timeHelper.getServerLongTime()
else
self.MondayleftTime=self.MondayleftTime-1
end
self.leftTime:setText(string.format("刷新倒计时：%s",timeHelper.format_time_stamp11(self.MondayleftTime,true)))
end


function UIXianGongBangYuWin:onBtnClose()
self:closeSelf()
end

function UIXianGongBangYuWin:onBtnHelp()
local d={}
d.title='规则'
d.mode=3
d.name="xgby_help_%d"
UIManager:showWindow('UIRuleWin',d)
end