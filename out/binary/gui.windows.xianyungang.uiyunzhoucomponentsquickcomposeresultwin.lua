







def_class("UIYunZhouComponentsQuickComposeResultWin",UIWindowBase)









function UIYunZhouComponentsQuickComposeResultWin:bindComponents()

self.backPanel=UIObject.get(self,0)
self.closeTips=UIText.get(self,1)
self.effect=UIObject.get(self,2)
self.mask=UIButton.get(self,3)
self.rewardContent=UIObject.get(self,4)
self.rewardItem=UIBaseItem.get(self,5)
self.root=UIObject.get(self,6)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIYunZhouComponentsQuickComposeResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backPanel);self.backPanel=nil;
_UIObject_release(self.closeTips);self.closeTips=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardItem);self.rewardItem=nil;
_UIObject_release(self.root);self.root=nil;
end



















function UIYunZhouComponentsQuickComposeResultWin:onLoaded(...)
self:bindComponents()
end


function UIYunZhouComponentsQuickComposeResultWin:__delete()
self:unbindComponents()
end




function UIYunZhouComponentsQuickComposeResultWin:onShow(argtable,afterOnloaded)
self.itemid=argtable.itemid
self.rewardList=argtable.ret_list
self:refreshItems()
self:refreshBackReward()
self.effect:setChildShowEffect(10014,true)
self:delayDo(0.2,function()
self.mask:setActive(true)
end)
end

function UIYunZhouComponentsQuickComposeResultWin:refreshBackReward()
if self.rewardList and#self.rewardList>0 then
self.backPanel:setActive(true)
self.rewardContent:setChildLayoutGroupCreateItems(#self.rewardList,function(index)
local item=self.rewardContent:getChildLayoutGroupGridItem(index-1)
local reward=self.rewardList[index]
local itemid=reward.param_1
local itemnum=reward.param_2
local countStr=itemnum>1 and mathHelper.formatNumber(itemnum)or''
local showCountBG=itemnum>1
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(-1,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(-1,prop)
end)
else
self.backPanel:setActive(false)
end
end

function UIYunZhouComponentsQuickComposeResultWin:refreshItems()
local itemid=self.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local widget=self.rewardItem:getWidgetBase()
local iconName=iconHelper.getIconName(itemid)
local suitid=itemConfig.type2
local stage=itemConfig.stage
local color=itemConfig.color
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,suitid,itemConfig.color)
local suitIconName=string.format("icon_suit_%d",suitConfig.icon)
widgetHelper.setItemQulaity(widget,itemid,0)
widget:SetChildIcon(1,iconName,false)
widget:SetChildGroundStarNum(4,stage)
widget:SetChildStarNumber(4,stage)
widget:SetChildIcon(5,suitIconName,false)
self.rewardItem:setBaseItemClickEvent(function(...)tipsManager.showTips({itemid=itemid})end)
end



function UIYunZhouComponentsQuickComposeResultWin:onMask()
self:closeSelf()
end

