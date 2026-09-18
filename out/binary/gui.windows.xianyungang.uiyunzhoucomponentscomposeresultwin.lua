







def_class("UIYunZhouComponentsComposeResultWin",UIWindowBase)









function UIYunZhouComponentsComposeResultWin:bindComponents()

self.backPanel=UIObject.get(self,0)
self.bg=UIObject.get(self,1)
self.closeTips=UIText.get(self,2)
self.effect=UIObject.get(self,3)
self.mask=UIButton.get(self,4)
self.newItem=UIBaseItem.get(self,5)
self.oldItem=UIBaseItem.get(self,6)
self.rewardContent=UIObject.get(self,7)
self.root=UIObject.get(self,8)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIYunZhouComponentsComposeResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backPanel);self.backPanel=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.closeTips);self.closeTips=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.newItem);self.newItem=nil;
_UIObject_release(self.oldItem);self.oldItem=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.root);self.root=nil;
end



















function UIYunZhouComponentsComposeResultWin:onLoaded(...)
self:bindComponents()
end


function UIYunZhouComponentsComposeResultWin:__delete()
self:unbindComponents()
end




function UIYunZhouComponentsComposeResultWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
self.oldItemId=argtable[1]
self.newItemId=argtable[2]
self.rewardList=argtable[3]
if not self.oldItemId or not self.newItemId then
loggerUtil.logErrFMT("界面参数为空")
self:closeSelf()
else
self:refreshItems()
self:refreshBackReward()
self.effect:setChildShowEffect(10014,true)
self:delayDo(0.2,function()
self.mask:setActive(true)
end)
end
end

function UIYunZhouComponentsComposeResultWin:refreshBackReward()
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

function UIYunZhouComponentsComposeResultWin:refreshItems()
local oldItemConfig=itemsConfig.getConfig(self.oldItemId)
local newItemConfig=itemsConfig.getConfig(self.newItemId)
local attrType,attrValue=unpack(oldItemConfig.static[1])
local name,valstr=equipsHelper.getAttr(attrType,attrValue,TO_INT_TYPE.eDown)
attrType,attrValue=unpack(newItemConfig.static[1])
local _,newValstr=equipsHelper.getAttr(attrType,attrValue,TO_INT_TYPE.eDown)

local itemWidget=self:getChildCSGUIBaseItem(self.oldItem:getID())
local itemid=self.oldItemId
local itemConfig=itemsConfig.getConfig(itemid)
local iconName=iconHelper.getIconName(itemid)
local suitid=itemConfig.type2
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,suitid,itemConfig.color)
local suitIconName=string.format("icon_suit_%d",suitConfig.icon)
local maxStar=yunZhouEquipsConfig.getEquipMaxStar(itemid)
widgetHelper.setItemQulaity(itemWidget,itemid,0)
itemWidget:SetChildIcon(1,iconName,false)
itemWidget:SetChildActive(2,false)
itemWidget:SetChildText(3,'')
itemWidget:SetChildIcon(4,suitIconName,false)
itemWidget:SetChildGroundStarNum(5,maxStar)
itemWidget:SetChildStarNumber(5,itemConfig.stage)
itemWidget:SetChildText(6,itemConfig.name)
itemWidget:SetChildText(7,string.format("%s加成：%s",name,valstr))

local itemWidget=self:getChildCSGUIBaseItem(self.newItem:getID())
local itemid=self.newItemId
local itemConfig=itemsConfig.getConfig(itemid)
local iconName=iconHelper.getIconName(itemid)
local suitid=itemConfig.type2
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,suitid,itemConfig.color)
local suitIconName=string.format("icon_suit_%d",suitConfig.icon)
local maxStar=yunZhouEquipsConfig.getEquipMaxStar(itemid)
widgetHelper.setItemQulaity(itemWidget,itemid,0)
itemWidget:SetChildIcon(1,iconName,false)
itemWidget:SetChildActive(2,false)
itemWidget:SetChildText(3,'')
itemWidget:SetChildIcon(4,suitIconName,false)
itemWidget:SetChildGroundStarNum(5,maxStar)
itemWidget:SetChildStarNumber(5,itemConfig.stage)
itemWidget:SetChildText(6,itemConfig.name)
itemWidget:SetChildText(7,newValstr)
end



function UIYunZhouComponentsComposeResultWin:onMask()
self:closeSelf()
end

