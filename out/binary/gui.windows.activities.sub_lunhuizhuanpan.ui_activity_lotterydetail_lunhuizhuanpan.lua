







def_class("UI_activity_lotteryDetail_lunhuizhuanpan",UIWindowBase)









function UI_activity_lotteryDetail_lunhuizhuanpan:bindComponents()

self.normalList=UIObject.get(self,0)
self.normalPrList=UIObject.get(self,1)
self.normalTitle=UIObject.get(self,2)
self.normalTitleText=UIText.get(self,3)
self.null=UIObject.get(self,4)
self.nullTips=UIText.get(self,5)
self.previewContent=UIObject.get(self,6)
self.previewMask=UIButton.get(self,7)
self.proList=UIObject.get(self,8)
self.proPrList=UIObject.get(self,9)
self.proReward=UIObject.get(self,10)
self.proTitle=UIObject.get(self,11)
self.proTitleText=UIText.get(self,12)
self.rewardPreviewPanel=UIObject.get(self,13)
self.specialList=UIObject.get(self,14)
self.specialTitle=UIObject.get(self,15)
self.specialTitleText=UIText.get(self,16)

self.previewMask:setButtonClick(function()self:onPreviewMask()end)



end


function UI_activity_lotteryDetail_lunhuizhuanpan:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.normalList);self.normalList=nil;
_UIObject_release(self.normalPrList);self.normalPrList=nil;
_UIObject_release(self.normalTitle);self.normalTitle=nil;
_UIObject_release(self.normalTitleText);self.normalTitleText=nil;
_UIObject_release(self.null);self.null=nil;
_UIObject_release(self.nullTips);self.nullTips=nil;
_UIObject_release(self.previewContent);self.previewContent=nil;
_UIObject_release(self.previewMask);self.previewMask=nil;
_UIObject_release(self.proList);self.proList=nil;
_UIObject_release(self.proPrList);self.proPrList=nil;
_UIObject_release(self.proReward);self.proReward=nil;
_UIObject_release(self.proTitle);self.proTitle=nil;
_UIObject_release(self.proTitleText);self.proTitleText=nil;
_UIObject_release(self.rewardPreviewPanel);self.rewardPreviewPanel=nil;
_UIObject_release(self.specialList);self.specialList=nil;
_UIObject_release(self.specialTitle);self.specialTitle=nil;
_UIObject_release(self.specialTitleText);self.specialTitleText=nil;
end
















local _this=nil
local normalListItemIndex={
item=0,
self=1,
flag=2,
percent=3,
}
local specialListItemIndex={
item=0,
flag=1,
}




function UI_activity_lotteryDetail_lunhuizhuanpan:onLoaded(...)
self:bindComponents()
_this=self
end


function UI_activity_lotteryDetail_lunhuizhuanpan:__delete()
self:unbindComponents()
_this=nil
end




function UI_activity_lotteryDetail_lunhuizhuanpan:onShow(argtable,afterOnloaded)
self.activityId=argtable.activityId
self.subType=argtable.subType
self.subId=argtable.subId
self.title_normal=argtable.normalTitle
self.title_special=argtable.specialTitle
self.title_pro=argtable.proTitle
self.reward_idx=argtable.reward_idx or 0
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)


self:refreshProList()

self:refreshProPrList()


self:refreshNormalList()

self:refreshNormalPrList()


self:refreshSpecialList()

if argtable.nullTips then
self.null:setActive(true)
self.nullTips:setText(argtable.nullTips)
end
end


function UI_activity_lotteryDetail_lunhuizhuanpan:onHide()

end

function UI_activity_lotteryDetail_lunhuizhuanpan:refreshNormalList()
local datas=self.config.reward_preview or{}
if self.reward_idx then
datas=datas[self.reward_idx]or{}
end
local listItemCount=#datas
self.normalList:setActive(listItemCount>0)
if listItemCount>0 then
self.normalList:setChildLayoutGroupCreateItems(listItemCount,function(index)
local item=self.normalList:getChildLayoutGroupGridItem(index-1)
local data=datas[index]
local rewardId=data[1]
if rewardId<=0 then
item:SetChildCanvasGroupAlpha(-1,0)
return
end
local rewardNum=data[2]

local rewardFlag=data[4]==1
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(normalListItemIndex.item,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(normalListItemIndex.item,prop)
item:SetChildActive(normalListItemIndex.flag,rewardFlag)

end)

local isShowTitle=self.title_normal~=nil
self.normalTitle:setActive(isShowTitle and listItemCount>0)
if isShowTitle then
self.normalTitleText:setText(self.title_normal)
end
end
end

function UI_activity_lotteryDetail_lunhuizhuanpan:refreshNormalPrList()
local datas=self.config.reward_preview_pr or{}
if self.reward_idx then
datas=datas[self.reward_idx]or{}
end
local listItemCount=#datas
self.normalPrList:setActive(listItemCount>0)
if listItemCount>0 then
self.normalPrList:setChildLayoutGroupCreateItems(listItemCount,function(index)
local item=self.normalPrList:getChildLayoutGroupGridItem(index-1)
local data=datas[index]
local rewardId=data[1]
if rewardId<=0 then
item:SetChildCanvasGroupAlpha(-1,0)
return
end
local rewardNum=data[2]
local rewardPercent=data[3]
local rewardFlag=data[4]==1
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(normalListItemIndex.item,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(normalListItemIndex.item,prop)
item:SetChildActive(normalListItemIndex.flag,rewardFlag)
item:SetChildText(normalListItemIndex.percent,FMT.fmt("{0}%",rewardPercent/100))
end)

local isShowTitle=self.title_normal~=nil
self.normalTitle:setActive(isShowTitle and listItemCount>0)
if isShowTitle then
self.normalTitleText:setText(self.title_normal)
end
end
end

function UI_activity_lotteryDetail_lunhuizhuanpan:refreshProList()
local datas=self.config.reward_preview_pro or{}
if self.reward_idx then
datas=datas[self.reward_idx]or{}
end
local listItemCount=#datas
self.proList:setActive(listItemCount>0)
if listItemCount>0 then
self.proList:setChildLayoutGroupCreateItems(listItemCount,function(index)
local item=self.proList:getChildLayoutGroupGridItem(index-1)
local data=datas[index]
local rewardId=data[1]
if rewardId<=0 then
item:SetChildCanvasGroupAlpha(-1,0)
return
end
local rewardNum=data[2]

local rewardFlag=data[4]==1
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(normalListItemIndex.item,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(normalListItemIndex.item,prop)
item:SetChildActive(normalListItemIndex.flag,rewardFlag)

end)

local isShowTitle=self.title_pro~=nil
self.proTitle:setActive(isShowTitle and listItemCount>0)
if isShowTitle then
self.proTitleText:setText(self.title_pro)
end
end
end

function UI_activity_lotteryDetail_lunhuizhuanpan:refreshProPrList()
local datas=self.config.reward_preview_pro_pr or{}
if self.reward_idx>0 then
datas=datas[self.reward_idx][1]or{}
end
local listItemCount=#datas
if self.reward_idx<=0 then
listItemCount=0
end

self.proList:setActive(listItemCount>0)
if listItemCount>0 then
local total_percent=self.config.reward_preview_pro_pr[self.reward_idx][2]
local item=self.proReward:getChildWidgetBase()
local isRewardList=listItemCount>1
local data=datas[1]
local rewardId=data[1]
local rewardNum=data[2]
local rewardPercent=data[3]
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(normalListItemIndex.item,prop)
item:SetChildActive(normalListItemIndex.item,not isRewardList)
item:SetChildActive(normalListItemIndex.flag,isRewardList)
item:SetChildText(normalListItemIndex.percent,FMT.fmt("<color=#ca631d>{0}：</color>{1}%",isRewardList and"最终大奖"or itemsConfig.getItemName(rewardId),total_percent/100))
item:SetChildButtonClick(4,function()
if not isRewardList then
itemsComponentHelper.onItemClick(rewardId)
else
self:refreshPreviewReward(self.reward_idx)
self.previewMask:setActive(true)
end
end)
end
end

function UI_activity_lotteryDetail_lunhuizhuanpan:refreshPreviewReward(index)
local select_idx=index
if select_idx<=0 then return end
local rewards=self.config.reward_preview_pro_pr[select_idx][1]
self.previewContent:setChildLayoutGroupCreateItems(#rewards,function(index)
local item=self.previewContent:getChildLayoutGroupGridItem(index-1)
local reward=rewards[index]
local itemid=reward[1]
local count=reward[2]
local pr=reward[3]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local graynum=0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
itemsComponentHelper.onItemClickEx(...)
end)
item:SetChildText(1,FMT.fmt("{0}%",pr/100))
end)
end

function UI_activity_lotteryDetail_lunhuizhuanpan:onPreviewMask()
self.previewMask:setActive(false)
end

function UI_activity_lotteryDetail_lunhuizhuanpan:refreshSpecialList()
local datas=self.config.reward_preview_special or{}
if self.reward_idx then
datas=datas[self.reward_idx]or{}
end
local listItemCount=#datas

self.specialList:setActive(listItemCount>0)
if listItemCount>0 then
self.specialList:setChildLayoutGroupCreateItems(listItemCount,function(index)
local item=self.specialList:getChildLayoutGroupGridItem(index-1)
local data=datas[index]
local rewardId=data[1]
local rewardNum=data[2]
local rewardFlag=data[3]==1
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(specialListItemIndex.item,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(specialListItemIndex.item,prop)
item:SetChildActive(specialListItemIndex.flag,rewardFlag)
end)

local isShowTitle=self.title_special~=nil
self.specialTitle:setActive(isShowTitle and listItemCount>0)
if isShowTitle then
self.specialTitleText:setText(self.title_special)
end
end
end



