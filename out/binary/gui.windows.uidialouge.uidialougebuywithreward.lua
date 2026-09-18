







def_class("UIDialougeBuyWithReward",UIWindowBase)









function UIDialougeBuyWithReward:bindComponents()

self.root=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.cancelButton=UIButton.get(self,2)
self.cancelText=UIText.get(self,3)
self.okButton=UIButton.get(self,4)
self.okText=UIText.get(self,5)
self.rewardview=UIScrollView.get(self,6)
self.tip=UIText.get(self,7)
self.titleText=UIText.get(self,8)
self.rewardlist=UIObject.get(self,9)
self.selfroot=UIObject.get(self,10)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIDialougeBuyWithReward:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.rewardview);self.rewardview=nil;
_UIObject_release(self.tip);self.tip=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.rewardlist);self.rewardlist=nil;
_UIObject_release(self.selfroot);self.selfroot=nil;
end



















function UIDialougeBuyWithReward:onLoaded(...)
self:bindComponents()
end


function UIDialougeBuyWithReward:__delete()
self:unbindComponents()
end




function UIDialougeBuyWithReward:onShow(showdata)

self.titleText:setText(showdata.title)


if showdata.canceltext~=nil then
self.cancelText:setText(showdata.canceltext)
else
self.cancelButton:setActive(false)
end

if showdata.canvasindex then
self.winlua:SetCanvasIndex(10,showdata.canvasindex)
end


if showdata.oktext~=nil then
self.okText:setText(showdata.oktext)
else
self.okButton:setActive(false)
end


if showdata.showclosebtn then
self.closeBtn:setActive(showdata.showclosebtn)
else
self.closeBtn:setActive(false)
end


if showdata.tip then
self.tip:setText(showdata.tip)
else
self.tip:setActive(false)
end

self.showdata=showdata
self.id=showdata.id

self.itemlist=showdata.itemlist
if self.itemlist then
local len=#self.itemlist
local propData={}
for i,v in ipairs(self.itemlist)do
table.insert(propData,itemsComponentHelper.getCommonFillData({itemid=v.itemid,itemcount=v.itemcount},{showname=false,nomalname=false,showcount=v.itemcount>1,showCountBG=v.itemcount>1}))
end




self.rewardlist:setChildLayoutGroupCreateItems(len,function(index)
local itemReward=self.rewardlist:getChildLayoutGroupGridItem(index-1)
itemReward:SetChildPropData(0,propData[index])
itemReward:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end)
self.rewardlist:setChildSizeDelta(len*82+(len-1)*10,94.857)

self.rewardview:setChildScrollRectEnable(len>=5)
end
end


function UIDialougeBuyWithReward:onHide()

end





function UIDialougeBuyWithReward:onCloseBtn()
local closecallback=self.showdata.closecallback
self.showdata:deleteSelf()

self:close()
if closecallback then
closecallback()
end
end



function UIDialougeBuyWithReward:onCancelButton()
local cancelcallback=self.showdata.cancelcallback
self.showdata:deleteSelf()

self:close()
if cancelcallback then
cancelcallback()
end
end



function UIDialougeBuyWithReward:onOkButton()
local okcallback=self.showdata.okcallback
self.showdata:deleteSelf()
self:close()
if okcallback then
okcallback()
end
end

