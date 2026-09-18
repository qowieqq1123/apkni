







def_class("UIDialougeBuyWithReward2",UIWindowBase)









function UIDialougeBuyWithReward2:bindComponents()

self.root=UIObject.get(self,0)
self.rewardview=UIScrollView.get(self,1)
self.tip=UIText.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.gotFlag=UIObject.get(self,4)
self.cancelText=UIText.get(self,5)
self.okText=UIText.get(self,6)
self.titleText=UIText.get(self,7)
self.Content=UIObject.get(self,8)
self.cancelButton=UIButton.get(self,9)
self.okButton=UIButton.get(self,10)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIDialougeBuyWithReward2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rewardview);self.rewardview=nil;
_UIObject_release(self.tip);self.tip=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.gotFlag);self.gotFlag=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.okButton);self.okButton=nil;
end



















function UIDialougeBuyWithReward2:onLoaded(...)
self:bindComponents()
end


function UIDialougeBuyWithReward2:__delete()
self:unbindComponents()
end




function UIDialougeBuyWithReward2:onShow(showdata)

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
if showdata.gotFlag~=nil then
self.gotFlag:setActive(showdata.gotFlag)
else
self.gotFlag:setActive(false)
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








self.Content:setChildLayoutGroupCreateItems(len,function(index)
local itemReward=self.Content:getChildLayoutGroupGridItem(index-1)
local v=self.itemlist[index]
local propData=itemsComponentHelper.getCommonFillData({itemid=v.itemid,itemcount=v.itemcount},{showname=false,nomalname=false,showcount=v.itemcount>1,showCountBG=v.itemcount>1})
itemReward:SetChildPropData(0,propData)
itemReward:SetBaseItemClickEvent(0,function()
self.winlua:SetCanvasIndex(-1,8)
itemsComponentHelper.onItemClick(v.itemid,index,v.itemguid)
end)
itemReward:SetChildActive(1,v.gailv or false)
end)


self.rewardview:setChildScrollRectEnable(len>=5)
end
end


function UIDialougeBuyWithReward2:onHide()

end





function UIDialougeBuyWithReward2:onCloseBtn()
local closecallback=self.showdata.closecallback
self.showdata:deleteSelf()

self:close()
if closecallback then
closecallback()
end
end



function UIDialougeBuyWithReward2:onCancelButton()
local cancelcallback=self.showdata.cancelcallback
self.showdata:deleteSelf()

self:close()
if cancelcallback then
cancelcallback()
end
end



function UIDialougeBuyWithReward2:onOkButton()
local okcallback=self.showdata.okcallback
self.showdata:deleteSelf()
self:close()
if okcallback then
okcallback()
end
end

function UIDialougeBuyWithReward2:onBGClick()
if self.showdata.bgClick then
self:onCancelButton()
end
end
