







def_class("UIDiscipleLifeHistoryComponent",UIWindowBase)









function UIDiscipleLifeHistoryComponent:bindComponents()

self.root=UIObject.get(self,0)
self.orderRoot=UIObject.get(self,1)
self.orderList=UIObject.get(self,2)
self.historyRoot=UIObject.get(self,3)
self.scrollview=UIObject.get(self,4)
self.history=UIText.get(self,5)
self.rewardRoot=UIObject.get(self,7)
self.rewardlist=UIObject.get(self,8)
self.returnBtn=UIButton.get(self,9)
self.shieldImg=UIObject.get(self,10)
self.historytitle=UIText.get(self,11)
self.historyTemp=UIText.get(self,12)
self.receiveImg=UIObject.get(self,13)

self.returnBtn:setButtonClick(function()self:onReturnBtn()end)



end


function UIDiscipleLifeHistoryComponent:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.orderRoot);self.orderRoot=nil;
_UIObject_release(self.orderList);self.orderList=nil;
_UIObject_release(self.historyRoot);self.historyRoot=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.history);self.history=nil;
_UIObject_release(self.rewardRoot);self.rewardRoot=nil;
_UIObject_release(self.rewardlist);self.rewardlist=nil;
_UIObject_release(self.returnBtn);self.returnBtn=nil;
_UIObject_release(self.shieldImg);self.shieldImg=nil;
_UIObject_release(self.historytitle);self.historytitle=nil;
_UIObject_release(self.historyTemp);self.historyTemp=nil;
_UIObject_release(self.receiveImg);self.receiveImg=nil;
end
















local cmpOrderItemIndex={
self=0,
stagename=1,
selectimg=2,
}

local ShowType={
stage=1,
history=2,
}

local conditionType={
jingjie=1,
task=2,
tianming=3,
tobecontinued=4
}

local menuPosList={{-120,170},{110,90},{-120,-18},{110,-88}}





function UIDiscipleLifeHistoryComponent:onLoaded(...)
self:bindComponents()

self.showtype=ShowType.stage
self.sStageIndex=0

self:addNotify(notifyConfig.onDiscipleStageFinish,function(...)self:onFinishDiscipleStage(...)end)
end


function UIDiscipleLifeHistoryComponent:__delete()
self:unbindComponents()
end




function UIDiscipleLifeHistoryComponent:onShow(argtable,afterOnloaded)
local isChangeDz=false
if not afterOnloaded then
isChangeDz=not mathHelper.compareInt64(self.disciple_guid,argtable.guid)
end
self.disciple_guid=argtable.guid
self.showType=UIDiscipleModel:getDiscipleType(self.disciple_guid)
self.disciple_id=UIDiscipleModel:getDiscipleID(self.disciple_guid)
self.netdata=UIDiscipleModel:getDiscipleData(self.disciple_guid)
self.bsflag=self.netdata.bsflag
self.config=cfgHelper.get1(cfg_disciplespebackstoryconfig_get,self.disciple_id)

self:showStageMenu()

end


function UIDiscipleLifeHistoryComponent:onHide()

end

function UIDiscipleLifeHistoryComponent:transShowTypeState()
self.orderRoot:setActive(self.showtype==ShowType.stage)
self.historyRoot:setActive(self.showtype==ShowType.history)
end

function UIDiscipleLifeHistoryComponent:showStageMenu()
self.showtype=ShowType.stage
self:transShowTypeState()
self:refreshStageMenu()
end

function UIDiscipleLifeHistoryComponent:refreshStageMenu()
self.orderList:setChildLayoutGroupCreateItems(#self.config,function(index)
local item=self.orderList:getChildLayoutGroupGridItem(index-1)
local data=self.config[index]
item:SetChildActive(-1,data~=nil)
if data then
if data.isopen then
item:SetChildText(cmpOrderItemIndex.stagename,FMT.fmt("第\n{0}\n章",mathHelper.numberToChinese(data.chapterid)))
else
if data.content then
item:SetChildText(cmpOrderItemIndex.stagename,"未完待续")
else
item:SetChildActive(-1,false)
end
end

item:SetBaseItemClickEvent(-1,function()
self.sStageIndex=index
local result,errmsg,jumpargs=self:checkStageUnlockCondition()

if result then
self:showHistory()
else
if jumpargs then
self:showDialog(jumpargs)
end
if errmsg then
UIManager.error(errmsg)
end
end
end)
local pos=menuPosList[index]
item:SetChildAnchoredPos(-1,pos[1],pos[2])
end
end)
end

function UIDiscipleLifeHistoryComponent:showHistory()
self.showtype=ShowType.history
self:transShowTypeState()
self:refreshHistory()
end

function UIDiscipleLifeHistoryComponent:refreshHistory()
local data=self.config[self.sStageIndex]
local isReceive=self:checkCurrentFinish()and 1 or 0


self.historytitle:setText(FMT.fmt("第{0}章",mathHelper.numberToChinese(data.chapterid)))


local rstr=comHelper.getCheckLayoutStr(self.historyTemp:getGameObject(),self.historyTemp:getChildSizeDeltaX(),data.content)
self.history:setText(rstr)


self.receiveImg:setActive(isReceive==0)


local dropid=data.dropid
local showItems=zongmenControl:getRewardConfigData(dropid,zongmenModel:getLevel())

self.rewardlist:setChildLayoutGroupCreateItems(#showItems,function(index)
local item=self.rewardlist:getChildLayoutGroupGridItem(index-1)
local itemData=showItems[index]


local conf={
itemid=itemData[1],
itemcount=itemData[2],
range=itemData.range,
gray=isReceive,
showname=false,
showCountBG=itemData[2]>1 or itemData.range~=nil
}

local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,propData)
item:SetChildActive(1,isReceive==0)
item:SetChildActive(2,isReceive==1)
end)
end

function UIDiscipleLifeHistoryComponent:isToBeContinued(index)
local stageCfg=self.config[index]
local condition=stageCfg.conditions[1]
return condition[1]==conditionType.tobecontinued
end

function UIDiscipleLifeHistoryComponent:checkCurrentFinish()
return bitHelper.check_pos(self.bsflag,self.sStageIndex-1)
end

function UIDiscipleLifeHistoryComponent:showDialog(args)

local showdata=
{
type='UIDialouge',
title='提示',
content=args.content,
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=args.okcallback,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end

function UIDiscipleLifeHistoryComponent:checkStageUnlockCondition()

if self:checkCurrentFinish()then
return true
end


if self.sStageIndex~=1 and not bitHelper.check_pos(self.bsflag,self.sStageIndex-2)then
return false,"请先阅读完上一章节的内容"
end

local conditions=self.config[self.sStageIndex].conditions
for k,condition in pairs(conditions)do
local type=condition[1]

if type==conditionType.jingjie then

local state=self.netdata.jingjielv>=condition[2]
if state then
return state
else
local curlevelName=UIDiscipleModel:getJJNameEx(self.netdata.jingjielv)
local targetName=UIDiscipleModel:getJJNameEx(condition[2])
local targetLevelName=FMT.cfmt(FONT_COLOR.eOrangeColor,targetName)
local desc=FMT.fmt("本章节须弟子境界达到{0}后解锁\n(弟子当前境界：{1})",targetLevelName,curlevelName)
return state,nil,{
content=desc,
okcallback=function()


UIFullCommonControl:jumpDiscipleMain(self.disciple_guid,FULL_TAB_TYPE.eDiscipleInfo,nil)
end
}
end
elseif type==conditionType.task then

if taskModel:checkTaskFinish(condition[2])then
return true
else
local taskid=condition[2]
local taskCfg=taskModel:getTaskConfig(taskid)
local content=FMT.fmt("本章节须完成任务{1}后解锁",FMT.cfmt(FONT_COLOR.eOrangeColor,taskCfg.name))
return false,nil,{
content=content,
okcallback=function()


jumpManager:jump({
id=JUMP_TYPE.eTaskMain,
args={taskid=taskid}
})
end
}
end
elseif type==conditionType.tianming then

if self.netdata.tmlv>=condition[2]then
return true
else
local curTmName=UIDiscipleModel:getTianMingLevelFloorName(self.netdata.tmlv)
local targetTmName=UIDiscipleModel:getTianMingLevelFloorName(condition[2])
local targetTmColorName=FMT.cfmt(FONT_COLOR.eOrangeColor,targetTmName)
local content=FMT.fmt("本章节须弟子天命达到{0}后解锁\n（弟子当前天命：{1})",targetTmColorName,curTmName)
return false,nil,{
content=content,
okcallback=function()


end
}
end
elseif type==conditionType.tobecontinued then

return false,"故事尚未完结，敬请期待更新"
end
end
end

function UIDiscipleLifeHistoryComponent:onFinishDiscipleStage(guid,chapterid)
if mathHelper.compareInt64(guid,self.disciple_guid)then
bitHelper.set_1(self.bsflag,chapterid)
self:refreshHistory()
end
end


local cmpRewardItemIndex={
item=0,
reddot=1,
receiveimg=2,
}
function UIDiscipleLifeHistoryComponent:bindRewardWidget(index,item)
local dropid=data.dropid
local showItems=cfgHelper.get2(cfg_awardconfig_get,dropid,"showItems")
local reward=showItems[index]
item:SetChildActive(-1,reward~=nil)
if reward then
local conf={itemid=reward[1],itemcount=reward[2]>1 and reward[2]or'',showCountBG=reward[2]>1,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

local isFinish=self:checkCurrentFinish()
item:SetChildActive(cmpRewardItemIndex.reddot,not isFinish)
item:SetChildActive(cmpRewardItemIndex.receiveimg,isFinish)
item:SetChildPropData(cmpRewardItemIndex.item,prop)
end
end




function UIDiscipleLifeHistoryComponent:onReturnBtn()
if not self:checkCurrentFinish()then

local data=self.config[self.sStageIndex]
UIDiscipleController:req_story_reward(self.disciple_guid,data.chapterid)
end
self:showStageMenu()
end

function UIDiscipleLifeHistoryComponent:onReceiveReward()
if not self:checkCurrentFinish()then
local data=self.config[self.sStageIndex]
UIDiscipleController:req_story_reward(self.disciple_guid,data.chapterid)
else
UIManager.info('奖励已经领取了')
end
end

