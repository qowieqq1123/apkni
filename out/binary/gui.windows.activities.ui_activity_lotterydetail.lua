







def_class("UI_activity_lotteryDetail",UIWindowBase)









function UI_activity_lotteryDetail:bindComponents()

self.normalList=UIObject.get(self,0)
self.normalPrList=UIObject.get(self,1)
self.normalTitle=UIObject.get(self,2)
self.normalTitleText=UIText.get(self,3)
self.null=UIObject.get(self,4)
self.nullTips=UIText.get(self,5)
self.proList=UIObject.get(self,6)
self.proPrList=UIObject.get(self,7)
self.proTitle=UIObject.get(self,8)
self.proTitleText=UIText.get(self,9)
self.specialList=UIObject.get(self,10)
self.specialTitle=UIObject.get(self,11)
self.specialTitleText=UIText.get(self,12)



end


function UI_activity_lotteryDetail:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.normalList);self.normalList=nil;
_UIObject_release(self.normalPrList);self.normalPrList=nil;
_UIObject_release(self.normalTitle);self.normalTitle=nil;
_UIObject_release(self.normalTitleText);self.normalTitleText=nil;
_UIObject_release(self.null);self.null=nil;
_UIObject_release(self.nullTips);self.nullTips=nil;
_UIObject_release(self.proList);self.proList=nil;
_UIObject_release(self.proPrList);self.proPrList=nil;
_UIObject_release(self.proTitle);self.proTitle=nil;
_UIObject_release(self.proTitleText);self.proTitleText=nil;
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




function UI_activity_lotteryDetail:onLoaded(...)
self:bindComponents()
_this=self
end


function UI_activity_lotteryDetail:__delete()
self:unbindComponents()
_this=nil
end




function UI_activity_lotteryDetail:onShow(argtable,afterOnloaded)
self.activityId=argtable.activityId
self.subType=argtable.subType
self.subId=argtable.subId
self.title_normal=argtable.normalTitle
self.title_special=argtable.specialTitle
self.title_pro=argtable.proTitle
self.reward_idx=argtable.reward_idx
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


function UI_activity_lotteryDetail:onHide()

end

function UI_activity_lotteryDetail:refreshNormalList()
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

function UI_activity_lotteryDetail:refreshNormalPrList()
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

function UI_activity_lotteryDetail:refreshProList()
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

function UI_activity_lotteryDetail:refreshProPrList()
local datas=self.config.reward_preview_pro_pr or{}
if self.reward_idx then
datas=datas[self.reward_idx]or{}
end
local listItemCount=#datas
self.proPrList:setActive(listItemCount>0)
if listItemCount>0 then
self.proPrList:setChildLayoutGroupCreateItems(listItemCount,function(index)
local item=self.proPrList:getChildLayoutGroupGridItem(index-1)
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

local isShowTitle=self.title_pro~=nil
self.proTitle:setActive(isShowTitle and listItemCount>0)
if isShowTitle then
self.proTitleText:setText(self.title_pro)
end
end
end

function UI_activity_lotteryDetail:refreshSpecialList()
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



