







def_class("UIYunZhouComponentsQuickComposeWin",UIWindowBase)









function UIYunZhouComponentsQuickComposeWin:bindComponents()

self.cancelBtn=UIButton.get(self,0)
self.costIcon=UIObject.get(self,1)
self.costNum=UIText.get(self,2)
self.descText=UIText.get(self,3)
self.okBtn=UIButton.get(self,4)
self.okText=UIText.get(self,5)
self.rewardItem=UIBaseItem.get(self,6)
self.rewardRoot=UIObject.get(self,7)
self.titlle=UIText.get(self,8)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.okBtn:setButtonClick(function()self:onOkBtn()end)



end


function UIYunZhouComponentsQuickComposeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.okBtn);self.okBtn=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.rewardItem);self.rewardItem=nil;
_UIObject_release(self.rewardRoot);self.rewardRoot=nil;
_UIObject_release(self.titlle);self.titlle=nil;
end



















function UIYunZhouComponentsQuickComposeWin:onLoaded(...)
self:bindComponents()
end


function UIYunZhouComponentsQuickComposeWin:__delete()
self:unbindComponents()
end




function UIYunZhouComponentsQuickComposeWin:onShow(argtable,afterOnloaded)
local itemid=argtable.itemid
self.cost=argtable.cost or{}
self.okfunc=argtable.okfunc
self.cancelfunc=argtable.cancelfunc

self.descText:setText(argtable.desc or'')
self.costIcon:setChildIcon(iconHelper.getIconName(self.cost[1]),false)
local has=itemsModel.getCount(self.cost[1])
self.costNum:setText(has<self.cost[2]and FMT.cfmt(FONT_COLOR.eRedColor,self.cost[2])or self.cost[2])

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


function UIYunZhouComponentsQuickComposeWin:onHide()

end



function UIYunZhouComponentsQuickComposeWin:onCancelBtn()
if self.cancelfunc then
self.cancelfunc()
end
self:closeSelf()
end

function UIYunZhouComponentsQuickComposeWin:onOkBtn()
if self.okfunc then
self.okfunc()
end
self:closeSelf()
end