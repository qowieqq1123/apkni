







def_class("UISubAct_tanbaoge_rewardWin",UIWindowBase)









function UISubAct_tanbaoge_rewardWin:bindComponents()

self.rankRewardPanel=UIObject.get(self,0)
self.closeButton=UIButton.get(self,1)
self.rankRewardListScroller=UIObject.get(self,2)

self.closeButton:setButtonClick(function()self:onCloseButton()end)



end


function UISubAct_tanbaoge_rewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rankRewardPanel);self.rankRewardPanel=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.rankRewardListScroller);self.rankRewardListScroller=nil;
end
















local rankRewardItemIndex={
playerInfo=0,
notPlayerInfo=1,
desc=2,
headBg=3,
name=4,
zmName=5,
rewards=7,
gotFlag=8,
}




function UISubAct_tanbaoge_rewardWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_tanbaoge_rewardWin:__delete()
self:unbindComponents()
end




function UISubAct_tanbaoge_rewardWin:onShow(argtable,afterOnloaded)
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


self.activityData:reqTanBaoGeGetFirstClearInfo()

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time

self:refresh(true)
end


function UISubAct_tanbaoge_rewardWin:onHide()

end


function UISubAct_tanbaoge_rewardWin:refresh()
if not self.activityData.data.isInitConfig then

self.activityData:initRankRewardConfigList_sort()
end


local count=#self.activityData.data.rankRewardCfg
self.rankRewardListScroller:setChildScrollViewCreateGrids(count,1)
local grids=self.rankRewardListScroller:getChildScrollViewItemWidgets()
for i=1,count do
self:refreshRankRewardItem(grids[i-1],i)
end
end

function UISubAct_tanbaoge_rewardWin:refreshRankRewardItem(item,index)
if item==nil then
item=self.rankRewardListScroller:getChildScrollViewItemWidget(index-1)
end

local rankRewardCfg=self.activityData.data.rankRewardCfg[index]

if item and rankRewardCfg then
local isFinish=false
local isGot=false

local playerInfo=nil

if self.activityData.data.rankRewardInfoList_lookup and self.activityData.data.rankRewardInfoList_lookup[rankRewardCfg.clearFloor]then
isGot=self.activityData.data.rankRewardInfoList_lookup[rankRewardCfg.clearFloor].rwFlag==1
isFinish=true
playerInfo=self.activityData.data.rankRewardInfoList_lookup[rankRewardCfg.clearFloor]
end


local descStr=FMT.fmt("跨服首位玩家探宝阁达到{0}层",rankRewardCfg.clearFloor)
item:SetChildText(rankRewardItemIndex.desc,descStr)

item:SetChildActive(rankRewardItemIndex.playerInfo,isFinish)
item:SetChildActive(rankRewardItemIndex.notPlayerInfo,not isFinish)


if isFinish then
item:SetChildText(rankRewardItemIndex.name,playerInfo.name)
item:SetChildText(rankRewardItemIndex.zmName,playerInfo.zmName)


local headArgs={}
headArgs.iconInfo=playerInfo.iconInfo
headArgs.scale=0.75
playerController:setHeadIcon(item,-1,headArgs)
item:SetChildButtonClickWithID(rankRewardItemIndex.headBg,function(index)
self:onClickHead(index)
end,index)
end



local rewards=rankRewardCfg.rewards
item:SetChildLayoutGroupCreateItems(rankRewardItemIndex.rewards,#rewards)
local grids=item:GetChildLayoutGroupGridList(rankRewardItemIndex.rewards)
for i=1,#rewards do
local widget=grids[i-1]
local reward=rewards[i]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local graynum=isGot and 1 or 0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
if isFinish and not isGot then

widget:SetBaseItemClickEvent(0,function(...)
self:onGetRewardItem(rankRewardCfg.clearFloor)
end)
else

widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end


widget:SetBaseItemLongTouchEvent(0,function(...)
self:onClickRewardItem(...)
end)


widget:SetChildActive(2,isFinish and not isGot)
end


item:SetChildActive(rankRewardItemIndex.gotFlag,isGot)



end
end


function UISubAct_tanbaoge_rewardWin:onCloseButton()
self:closeSelf()
end


function UISubAct_tanbaoge_rewardWin:onGetRewardItem(floor)
self.activityData:reqTanBaoGeGetFirstClearReward(floor)
end


function UISubAct_tanbaoge_rewardWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end


function UISubAct_tanbaoge_rewardWin:onClickHead(index)
local rankRewardCfg=self.activityData.data.rankRewardCfg[index]
local playerInfo
if self.activityData.data.rankRewardInfoList_lookup and self.activityData.data.rankRewardInfoList_lookup[rankRewardCfg.clearFloor]then
playerInfo=self.activityData.data.rankRewardInfoList_lookup[rankRewardCfg.clearFloor]
end

if playerInfo then
local attach={
serverid=playerInfo.serverId
}
otherPlayerController:openOtherPlayerInfoWin(playerInfo.playerId,false,nil,attach)
end
end