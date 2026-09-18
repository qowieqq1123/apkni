







def_class("UISubAct_tanbaoge_detailWin",UIWindowBase)









function UISubAct_tanbaoge_detailWin:bindComponents()

self.normalList=UIObject.get(self,0)
self.normalTitle=UIObject.get(self,1)
self.normalTitleText=UIText.get(self,2)
self.specialList=UIObject.get(self,3)
self.specialTitle=UIObject.get(self,4)
self.specialTitleText=UIText.get(self,5)



end


function UISubAct_tanbaoge_detailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.normalList);self.normalList=nil;
_UIObject_release(self.normalTitle);self.normalTitle=nil;
_UIObject_release(self.normalTitleText);self.normalTitleText=nil;
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
canGetText=2,
}




function UISubAct_tanbaoge_detailWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_tanbaoge_detailWin:__delete()
_this=nil
self:unbindComponents()
end




function UISubAct_tanbaoge_detailWin:onShow(argtable,afterOnloaded)
self.activityId=argtable.activityId
self.subType=argtable.subType
self.subId=argtable.subId
self.title_normal=argtable.normalTitle
self.title_special=argtable.specialTitle

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)


self:refreshNormalList()


self:refreshSpecialList()
end


function UISubAct_tanbaoge_detailWin:onHide()

end

function UISubAct_tanbaoge_detailWin:refreshNormalList()
local datas=self.config.reward_preview or{}
local listItemCount=#datas

self.normalList:setActive(listItemCount>0)
if listItemCount>0 then
self.normalList:setChildLayoutGroupCreateItems(listItemCount,function(index)
local item=self.normalList:getChildLayoutGroupGridItem(index-1)
local data=datas[index]
local rewardId=data[1]
local rewardNum=data[2]
local rewardPercent=data[3]
local rewardFlag=data[4]==1
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local isDaoBing=itemsConfig.isDaoBing(rewardId)
local showStage=not isDaoBing
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=true,showStage=showStage}
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

function UISubAct_tanbaoge_detailWin:refreshSpecialList()
local datas=self.config.reward_preview_special or{}
local listItemCount=#datas

self.specialList:setActive(listItemCount>0)
if listItemCount>0 then
self.specialList:setChildLayoutGroupCreateItems(listItemCount,function(index)
local item=self.specialList:getChildLayoutGroupGridItem(index-1)
local data=datas[index]
local rewardId=data[1]
local rewardNum=data[2]

local canGetNum=data[3]or 0
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local isDaoBing=itemsConfig.isDaoBing(rewardId)
local showStage=not isDaoBing
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=true,showStage=showStage}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(specialListItemIndex.item,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(specialListItemIndex.item,prop)

local isShowCanGetText=canGetNum~=0
item:SetChildActive(specialListItemIndex.canGetText,isShowCanGetText)
if isShowCanGetText then
local canGetNumStr
local canGetNumStrParam=self.config.rewardCanGetText
if canGetNum<0 then
canGetNumStr=canGetNumStrParam[2]
else
canGetNumStr=FMT.fmt(canGetNumStrParam[1],canGetNum)
end
item:SetChildText(specialListItemIndex.canGetText,canGetNumStr)
end
end)

local isShowTitle=self.title_special~=nil
self.specialTitle:setActive(isShowTitle and listItemCount>0)
if isShowTitle then
self.specialTitleText:setText(self.title_special)
end
end
end




