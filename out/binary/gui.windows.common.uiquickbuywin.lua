







def_class("UIQuickBuyWin",UIWindowBase)









function UIQuickBuyWin:bindComponents()

self.root=UIObject.get(self,0)
self.titleName=UIText.get(self,1)
self.panel=UIObject.get(self,2)
self.empty=UIObject.get(self,3)
self.title=UIText.get(self,4)
self.okTxt=UIText.get(self,5)
self.useScrollView=UIObject.get(self,6)
self.okbtn=UIButton.get(self,7)
self.emptyTips=UIText.get(self,8)

self.okbtn:setButtonClick(function()self:onOkbtn()end)



end


function UIQuickBuyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.panel);self.panel=nil;
_UIObject_release(self.empty);self.empty=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.okTxt);self.okTxt=nil;
_UIObject_release(self.useScrollView);self.useScrollView=nil;
_UIObject_release(self.okbtn);self.okbtn=nil;
_UIObject_release(self.emptyTips);self.emptyTips=nil;
end


















function UIQuickBuyWin:onLoaded(...)
self:bindComponents()
end

function UIQuickBuyWin:__delete()
self:unbindComponents()
end

function UIQuickBuyWin:onShow(argtable,afterOnloaded)
self:stopAllNotify()
local name=argtable.name
local rewards=argtable.rewards
local title=argtable.title
local btnTxt=argtable.btnTxt
self.closeCallback=argtable.closeCallback
self.okCallback=argtable.okCallback
self.parentWin=argtable.parentWin
self.gray=argtable.gray or false
local showCallback=argtable.showCallback
self.title:setText(title)
self.okTxt:setText(btnTxt)
self:showItemList(rewards)
if showCallback then
showCallback(self)
end
local notifyCallBack=argtable.notifyCallBack
if notifyCallBack then
notifyCallBack(self)
end
self.empty:setActive(false)
self.titleName:setText(name)
self:setBtnGray(self.gray)
end

function UIQuickBuyWin:onHide()

end





function UIQuickBuyWin:onOkbtn()
if self.okCallback then
self:okCallback()
end
end

function UIQuickBuyWin:setBtnGray(gray)
self.gray=gray
self.winlua:SetChildGray(self.okbtn:getID(),gray)
end

function UIQuickBuyWin:showItemList(rewards)
local len=#rewards
self.useScrollView:setChildScrollViewCreateGrids(len,1)
local grids=self.useScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=rewards[i]
local itemId=data[1]
local itemCount=data[2]or 1
widgetHelper.setNormalRewardItem(item,0,{itemId,itemCount})
local cfg=itemsConfig.getConfig(itemId)
item:SetChildText(1,cfg.name)
end
end

function UIQuickBuyWin:onCloseClick()
if self.closeCallback then
self:closeCallback()
elseif self.parentWin then
self.parentWin:onCloseClick()
end
end