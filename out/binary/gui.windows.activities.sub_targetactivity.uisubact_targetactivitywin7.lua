







def_class("UISubAct_TargetActivityWin7",UIWindowBase)









function UISubAct_TargetActivityWin7:bindComponents()

self.actItemBtn=UIButton.get(self,0)
self.actItemIcon=UIButton.get(self,1)
self.actItemSpine=UIObject.get(self,2)
self.bgModel=UIObject.get(self,3)
self.helpBtn=UIButton.get(self,4)
self.model=UIObject.get(self,5)
self.root=UIObject.get(self,6)
self.taskList=UIObject.get(self,7)
self.timeTx=UIText.get(self,8)
self.title=UIImage.get(self,9)

self.actItemBtn:setButtonClick(function()self:onActItemBtn()end)

self.actItemIcon:setButtonClick(function()self:onActItemIcon()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UISubAct_TargetActivityWin7:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.actItemBtn);self.actItemBtn=nil;
_UIObject_release(self.actItemIcon);self.actItemIcon=nil;
_UIObject_release(self.actItemSpine);self.actItemSpine=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.taskList);self.taskList=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.title);self.title=nil;
end
















local _this
local _taskCmp={
none=0,
jumpBtn=1,
descTx=2,
rewards=3,
getted=4,
numLimit=5,
receiveBtn=6,
receiveCnt=7,
}
local _abName="ui/windows/activities/sub_targetactivity/targetactivity7_atlas_pak.ab"



function UISubAct_TargetActivityWin7:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_TargetActivityWin7:__delete()
self:stopCDTick()
self:unbindComponents()
_this=nil
end




function UISubAct_TargetActivityWin7:onShow(argtable,afterOnloaded)
if argtable then
self.activityId=argtable.act_id
self.subType=argtable.sub_act_type
self.subId=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.argtable=argtable
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
self.taskBgIcon=self.config.taskBgIcon
if self.info and self.info:hasData()then
self:refreshView()
self:startCDTick()
end
end

if afterOnloaded then
self.title:setCSImageSprite(_abName,self.config.titleIcon or"image_mbxz_tjmb")

if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgModel:getID(),false,true,false)
end
self.root:setChildCanvasGroupAlpha(0)
self.bgModel:setChildUIModelShowTarget(self.config.bgSpine,1,nil,eAnimationID.stand,false,false,0,function()
if _this==nil then return end
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)

self:refreshShowItem()
end
end

function UISubAct_TargetActivityWin7:refreshView()
self:refreshTaskList()
end

function UISubAct_TargetActivityWin7:refreshShowItem()
local itemid=self.config.showItem
self.actItemIcon:setChildIcon(iconHelper.getIconName(itemid),true)
local x,y,isShow,moveY,moveDuration,bgSpine,bgX,bgY=unpack(self.config.showItemPos)
self.actItemBtn:setChildAnchoredPos(x,y)
if isShow==0 then
self.actItemBtn:setChildIcon(nil,true)
end
if moveY~=0 and moveDuration>0 then
if self.tween then
self.tween:Kill()
end
self.tween=self.actItemBtn:setChildDOLocalMoveY(y+moveY,moveDuration)
self.tween:SetEase(_Ease.Linear)
self.tween:SetLoops(-1,_LoopType.Yoyo)
end
if bgSpine>0 then
self.actItemSpine:setChildUIModelShowTarget(bgSpine,1,nil,eAnimationID.stand,false,false,0)
self.actItemSpine:setChildUIModelShowTargetOffset(bgX,bgY)
end
end

function UISubAct_TargetActivityWin7:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_TargetActivityWin7:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_TargetActivityWin7:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
self.timeTx:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp3(time)))
end

function UISubAct_TargetActivityWin7:refreshTaskList()
local tasksCfg=self.config.tasks
local data=self.info:getData()
local tasksData=data.tasksData
self.tasksList={}
for idx,v in ipairs(tasksCfg)do
local sortWeight=idx
local aimCnt=v[3]
local resetType=v[4]
local rewardCntMax=v[5]
local taskData=tasksData[idx]
local rewardCnt=taskData and taskData.rewardCnt or 0
local completeCnt=taskData and taskData.completeCnt or 0
local getted=resetType~=0 and rewardCnt>=rewardCntMax
local complete=completeCnt>=((rewardCnt+1)*aimCnt)
local canReceiveReward=not getted and complete
if canReceiveReward then
sortWeight=sortWeight-1000000
end
if resetType==0 then
sortWeight=sortWeight-10000
else
if rewardCnt>=rewardCntMax then
if resetType==1 then
sortWeight=sortWeight+10000
elseif resetType==2 then
sortWeight=sortWeight+20000
end
end
end

table.insert(self.tasksList,{taskIdx=idx,sortWeight=sortWeight})
end
table.sort(self.tasksList,function(a,b)
return a.sortWeight<b.sortWeight
end)

self.taskList:setChildLayoutGroupCreateItems(#self.tasksList,function(index)
local item=self.taskList:getChildLayoutGroupGridItem(index-1)
item:SetChildCSImageSprite(-1,_abName,self.taskBgIcon)
self:refreshTaskItem(index,item)
end)
end

function UISubAct_TargetActivityWin7:refreshTaskItem(index,item)
local taskIdx=self.tasksList[index].taskIdx
local taskCfg=self.config.tasks[taskIdx]
local data=self.info:getData()
local tasksData=data.tasksData
local taskData=tasksData[taskIdx]

local aimCnt=taskCfg[3]
local resetType=taskCfg[4]
local rewardCntMax=taskCfg[5]
local rewards=taskCfg[6]
local descStr=taskCfg[8]

local rewardCnt=taskData and taskData.rewardCnt or 0
local completeCnt=taskData and taskData.completeCnt or 0
local getted=resetType~=0 and rewardCnt>=rewardCntMax
local canReceiveCnt=math.floor((completeCnt-rewardCnt*aimCnt)/aimCnt)
local complete=completeCnt>=((rewardCnt+1)*aimCnt)
local canReceiveReward=not getted and complete

item:SetChildButtonClick(_taskCmp.jumpBtn,function()
self:onClickTaskJump(taskIdx)
end)
item:SetChildButtonClick(_taskCmp.receiveBtn,function()
self:onClickTaskReward(taskIdx)
end)
item:SetChildLayoutGroupCreateItems(_taskCmp.rewards,#rewards,function(idx)
local rewardItem=item:GetChildLayoutGroupGridItem(_taskCmp.rewards,idx-1)
local rewardData=rewards[idx]
local itemid,itemnum=unpack(rewardData)
local showCountBG=itemnum>1
local countStr=showCountBG and itemnum or""
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function()
itemsComponentHelper.onItemClick(itemid)
end)

end)

item:SetChildText(_taskCmp.descTx,descStr)
item:SetChildActive(_taskCmp.getted,getted and resetType~=1)
item:SetChildActive(_taskCmp.none,getted and resetType==1)
if not getted then
item:SetChildActive(_taskCmp.jumpBtn,not complete)
item:SetChildActive(_taskCmp.receiveBtn,complete)
item:SetChildText(_taskCmp.receiveCnt,canReceiveCnt)
else
item:SetChildActive(_taskCmp.jumpBtn,false)
item:SetChildActive(_taskCmp.receiveBtn,false)
end
local limitStr=""
if resetType==0 then
limitStr=string.format("已领取：<color=#549327>%d</color>",rewardCnt)
elseif resetType==1 then
limitStr=string.format("今日可领取：<color=%s>%d/%d</color>",getted and"#C82C2C"or"#549327",rewardCnt,rewardCntMax)
elseif resetType==2 then
limitStr=string.format("活动可领取：<color=%s>%d/%d</color>",getted and"#C82C2C"or"#549327",rewardCnt,rewardCntMax)
end
item:SetChildText(_taskCmp.numLimit,limitStr)
end

function UISubAct_TargetActivityWin7:onClickTaskReward(taskIdx)
self.info:reqGetTaskReward(taskIdx)
end

function UISubAct_TargetActivityWin7:onClickTaskJump(taskIdx)
local taskCfg=self.config.tasks[taskIdx]
jumpManager:jump(taskCfg[7])
end

function UISubAct_TargetActivityWin7:onHelpBtn()
local d={}
d.title='规则'
d.mode=3
d.name='mibaoxunzong_help_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UISubAct_TargetActivityWin7:onActItemBtn()
local itemid=self.config.showItem
itemsComponentHelper.onItemClick(itemid)
end

function UISubAct_TargetActivityWin7:onActItemIcon()
local itemid=self.config.showItem
itemsComponentHelper.onItemClick(itemid)
end