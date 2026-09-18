







def_class("UISubAct_manufactureRank_mainWin",UIWindowBase)









function UISubAct_manufactureRank_mainWin:bindComponents()

self.topTipsText=UIText.get(self,0)
self.showRankBtn=UIButton.get(self,1)
self.rankFirstList=UIObject.get(self,2)
self.leftBtn=UIButton.get(self,3)
self.rightBtn=UIButton.get(self,4)
self.timeText=UIText.get(self,5)
self.bottomTipsText=UIText.get(self,6)
self.content=UIObject.get(self,7)
self.root=UIObject.get(self,8)

self.showRankBtn:setButtonClick(function()self:onShowRankBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)



end


function UISubAct_manufactureRank_mainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.topTipsText);self.topTipsText=nil;
_UIObject_release(self.showRankBtn);self.showRankBtn=nil;
_UIObject_release(self.rankFirstList);self.rankFirstList=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.bottomTipsText);self.bottomTipsText=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.root);self.root=nil;
end


local _this
local rankItemIndex={
rankTitle=0,
rankIcon=1,
headEmpty=2,
headIcon=3,
headKuang=4,
info=5,
notPlayerInfo=6,
zmName=7,
playerName=8,
manufactureCountTitle=9,
rankPlayerClick=10,
selfManufactureCount=11,
selfRank=12,
selfClick=13,
manufactureCount=14,
manufactureCountIcon=15,
selfManufactureCountIcon=16,
}
















function UISubAct_manufactureRank_mainWin:onLoaded(...)
_this=self
self:bindComponents()

self.targetHor=0
self.smooting=10
self.isAutoMoveRankList=false
self.startAutoMoveDV=0.01
self.last_np=nil
self.isDrag=false

self.rankFirstList:setChildScrollViewInit(0.5,true,nil,nil)



end


function UISubAct_manufactureRank_mainWin:__delete()
self:clearAllTimer()
_this=nil
self:clearSubWindow()
self:unbindComponents()
end




function UISubAct_manufactureRank_mainWin:onShow(argtable,afterOnloaded)
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

activitiesController:sendProtocol(actSendType.eComonReqInfo,self.activityId,self.subType,self.subId)

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time


self:changeRootShowState(true)
self.rankFirstList:setActive(true)
self:refresh(true)

self.winlua:SetChildScrollRectNormalizedPosition(self.rankFirstList:getID(),true,0)









end


function UISubAct_manufactureRank_mainWin:onHide()
self.rankFirstList:setActive(false)
self:changeRootShowState(false)
self:clearAllTimer()
self:clearSubWindow()
end

function UISubAct_manufactureRank_mainWin:refresh(isInit)
local rankCount=#self.config.rankList

self.rankFirstList:setChildScrollViewCreateGrids(rankCount,rankCount)
local grids=self.rankFirstList:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local rankItemId=self.config.rankList[i]and self.config.rankList[i][2]
if item and rankItemId then
local rankData=self.activityData.data.rankFirstList[rankItemId]
if rankData then
local showConfig=self.config.rankShow[i]
local itemConfig=itemsConfig.getConfig(rankItemId)

local rankTitle=FMT.fmt("{0}榜",itemConfig.name)
item:SetChildText(rankItemIndex.rankTitle,rankTitle)


local iconName
if showConfig and showConfig.iconName then
iconName=showConfig.iconName
else

iconName=iconHelper.getIconName(rankItemId)
end
item:SetChildIcon(rankItemIndex.rankIcon,iconName,true)

local moneyType=rankItemId
local moneyIcon=iconHelper.getMoneyIconName(moneyType)

if rankData.topPlayerId~=int64.zero then

item:SetChildActive(rankItemIndex.info,true)
item:SetChildActive(rankItemIndex.notPlayerInfo,false)
item:SetChildActive(rankItemIndex.headEmpty,false)
item:SetChildActive(rankItemIndex.headIcon,true)

playerController:setWidgetHead96(item,rankItemIndex.headIcon,rankData.iconInfo)


local zmName=rankData.topZmName~=""and rankData.topZmName or"暂无"
item:SetChildText(rankItemIndex.zmName,zmName)


item:SetChildText(rankItemIndex.playerName,rankData.topName)


local manufactureNum=mathHelper.int64_to_number(rankData.topShengChanNum)
local manufactureCountStr=mathHelper.formatNumber(manufactureNum)


item:SetChildText(rankItemIndex.manufactureCount,manufactureCountStr)
item:SetChildIcon(rankItemIndex.manufactureCountIcon,moneyIcon,false)
else

item:SetChildActive(rankItemIndex.info,false)
item:SetChildActive(rankItemIndex.notPlayerInfo,true)
item:SetChildActive(rankItemIndex.headEmpty,true)
item:SetChildActive(rankItemIndex.headIcon,false)
end

item:SetChildButtonClick(rankItemIndex.rankPlayerClick,function()
self:onClickPlayer(rankData.topPlayerId)
end)


if isInit then

local kuangId
if showConfig and showConfig.headKuangId then
kuangId=showConfig.headKuangId
else

kuangId=1
end
local kuangIcon=playerModel:getActorFrameIconById(kuangId)
local kuangAnimType,kuangAnim=playerModel:getActorFrameAnimById(kuangId)
playerController:setWidgetHeadKuang(item,rankItemIndex.headKuang,kuangIcon,kuangAnimType,kuangAnim)
end


local selfManufactureNum=mathHelper.int64_to_number(rankData.myShengChanNum)
local selfManufactureCountStr=mathHelper.formatNumber(selfManufactureNum)
item:SetChildText(rankItemIndex.selfManufactureCount,selfManufactureCountStr)
item:SetChildIcon(rankItemIndex.selfManufactureCountIcon,moneyIcon,false)


if rankData.myRank==0 then
item:SetChildText(rankItemIndex.selfRank,"<color=#71655f>未上榜</color>")
else
item:SetChildText(rankItemIndex.selfRank,FMT.fmt("第{0}名",rankData.myRank))
end


item:SetChildButtonClick(rankItemIndex.selfClick,function()
self:onClickRank(i)
end)
end
end
end


self:setRemainingTimeTimer()
end


function UISubAct_manufactureRank_mainWin.rankBeginDragCallback()
_this.isAutoMoveRankList=false
_this.isDrag=true
end

function UISubAct_manufactureRank_mainWin.rankEndDragCallback()
_this.isDrag=false
end

function UISubAct_manufactureRank_mainWin.onScrollChanged()
if _this.isAutoMoveRankList then
local np=_this.winlua:GetChildScrollRectNormalizedPosition(_this.rankFirstList:getID(),true)
if math.abs(_this.targetHor-np)>=_this.startAutoMoveDV then
_this.winlua:SetChildScrollRectNormalizedPosition(_this.rankFirstList:getID(),true,Mathf.Lerp(np,_this.targetHor,Time.deltaTime*_this.smooting))
else
_this.isAutoMoveRankList=false
end
elseif not _this.isDrag then
if _this.last_np==nil then
_this.last_np=_this.winlua:GetChildScrollRectNormalizedPosition(_this.rankFirstList:getID(),true)
else
local np=_this.winlua:GetChildScrollRectNormalizedPosition(_this.rankFirstList:getID(),true)
if math.abs(_this.last_np-np)>=_this.startAutoMoveDV then







_this.last_np=np
end
end
end
end


function UISubAct_manufactureRank_mainWin:checkNextRankAutoMoveTarget(isLeft,isOnlyCheck)
local width_sw=self.rankFirstList:getChildSizeDeltaX()
local width_con=self.content:getChildSizeDeltaX()
local npLength=width_con-width_sw

if npLength>0 then
local width_item=200
local space=30
local offsetStart=30
local offsetEnd=35

local np=self.winlua:GetChildScrollRectNormalizedPosition(self.rankFirstList:getID(),true)
local showWidth_left=np*npLength
if showWidth_left>npLength then
showWidth_left=npLength
elseif showWidth_left<0 then
showWidth_left=0
end

local showWidth_right=showWidth_left+width_sw

if isLeft then

local nowLeftIndex=math.ceil((showWidth_left-offsetStart)/(width_item+space))+1

if nowLeftIndex-1<=0 then

return false
end

if isOnlyCheck then

return true
end
local nextLeftIndex=nowLeftIndex-1
local nextLeftItem_left=offsetStart+(nextLeftIndex-1)*(width_item+space)-space/2
if nextLeftItem_left<0 then
nextLeftItem_left=0
end
self.targetHor=nextLeftItem_left/npLength
self.isAutoMoveRankList=true
else

local nowRightIndex=math.floor((showWidth_right-offsetStart)/(width_item+space))
local isOnSpace=(showWidth_right-offsetStart)%(width_item+space)>=width_item
if isOnSpace then
nowRightIndex=nowRightIndex+1
end

if nowRightIndex+1>#self.config.rankList then

return false
end

if isOnlyCheck then

return true
end
local nextRightIndex=nowRightIndex+1
local nextRightItem_right=offsetStart+nextRightIndex*(width_item+space)-space/2
if nextRightItem_right>width_con then
nextRightItem_right=width_con
end
self.targetHor=(npLength-(width_con-nextRightItem_right))/npLength
self.isAutoMoveRankList=true
end
end
end


function UISubAct_manufactureRank_mainWin:clearSubWindow()
self:closeWindow('UISubAct_manufactureRank_rankWin')
end


function UISubAct_manufactureRank_mainWin:changeRootShowState(isShow,needRefreshData)

self.showRankBtn:setActive(isShow)













if isShow and needRefreshData then

activitiesController:sendProtocol(actSendType.eComonReqInfo,self.activityId,self.subType,self.subId)
end
end


function UISubAct_manufactureRank_mainWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
self:refreshRemainingTimeTimer()
end

self.timer=self:setTimer(1,0,func)

self:refreshRemainingTimeTimer()
end


function UISubAct_manufactureRank_mainWin:refreshRemainingTimeTimer()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
if time>0 then

local time_str=FMT.fmt('活动剩余时间: <color=#F7F7F7>{0}</color>',timeHelper.format_time_stamp11(time,true))
self.timeText:setText(time_str)
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end
end



function UISubAct_manufactureRank_mainWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UISubAct_manufactureRank_mainWin:clearUpdateTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end


function UISubAct_manufactureRank_mainWin:clearAllTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end

if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end




function UISubAct_manufactureRank_mainWin:onShowRankBtn()

self:showWindow('UISubAct_manufactureRank_rankWin',{act_id=self.activityId,sub_act_type=self.subType,sub_act_id=self.subId})


self:changeRootShowState(false)
end



function UISubAct_manufactureRank_mainWin:onLeftBtn()
if self.isAutoMoveRankList then


end

self:checkNextRankAutoMoveTarget(true)
end



function UISubAct_manufactureRank_mainWin:onRightBtn()
if self.isAutoMoveRankList then


end

self:checkNextRankAutoMoveTarget(false)
end


function UISubAct_manufactureRank_mainWin:onClickPlayer(actorId)

if actorId==int64.zero then
return
end

local attach={
type=otherPlayerController.eAttachType.Rank,
rankType=eRankListType.eManufactureRank
}
otherPlayerController:openOtherPlayerInfoWin(actorId,true,nil,attach)
end


function UISubAct_manufactureRank_mainWin:onClickRank(rankIndex)

self:showWindow('UISubAct_manufactureRank_rankWin',{act_id=self.activityId,sub_act_type=self.subType,sub_act_id=self.subId,selectMenuIndex=rankIndex})


self:changeRootShowState(false)
end