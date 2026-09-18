







def_class("UIDialougeBuyWithReward3",UIWindowBase)









function UIDialougeBuyWithReward3:bindComponents()

self.cancelButton=UIButton.get(self,0)
self.cancelText=UIText.get(self,1)
self.chooseBox=UIToggleButton.get(self,2)
self.chooseText=UIText.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.Content=UIObject.get(self,5)
self.okButton=UIButton.get(self,6)
self.okText=UIText.get(self,7)
self.rewardview=UIScrollView.get(self,8)
self.root=UIObject.get(self,9)
self.tip=UIText.get(self,10)
self.tip2=UIText.get(self,11)
self.titleText=UIText.get(self,12)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIDialougeBuyWithReward3:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.chooseBox);self.chooseBox=nil;
_UIObject_release(self.chooseText);self.chooseText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.rewardview);self.rewardview=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tip);self.tip=nil;
_UIObject_release(self.tip2);self.tip2=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end



















function UIDialougeBuyWithReward3:onLoaded(...)
self:bindComponents()
end


function UIDialougeBuyWithReward3:__delete()
self:unbindComponents()
end




function UIDialougeBuyWithReward3:onShow(showdata,afterOnloaded)

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
if showdata.tipRefresh then
showdata.tipRefresh(self)
end
else
self.tip:setActive(false)
end

if showdata.tip2 then
self.tip2:setText(showdata.tip2)
else
self.tip2:setActive(false)
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
self.Content:setChildLayoutGroupCreateItems(len,function(index)
local itemReward=self.Content:getChildLayoutGroupGridItem(index-1)
itemReward:SetChildPropData(0,propData[index])
itemReward:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end)
self.Content:setChildSizeDelta(len*82+(len-1)*10,94.857)

end

if showdata.choosetext~=nil and showdata.choosecallback~=nil then
self.chooseBox:setActive(true)
self.chooseText:setText(showdata.choosetext)
else
self.chooseBox:setActive(false)
end
end


function UIDialougeBuyWithReward3:onHide()

end





function UIDialougeBuyWithReward3:onCancelButton()
local choosecallback=self.showdata.choosecallback
if choosecallback then
choosecallback(self.chooseBox:getToggle())
end

local cancelcallback=self.showdata.cancelcallback
self.showdata:deleteSelf()

self:close()
if cancelcallback then
cancelcallback()
end
end



function UIDialougeBuyWithReward3:onCloseBtn()
local closecallback=self.showdata.closecallback
self.showdata:deleteSelf()

self:close()
if closecallback then
closecallback()
end
end



function UIDialougeBuyWithReward3:onOkButton()
local choosecallback=self.showdata.choosecallback
if choosecallback then
choosecallback(self.chooseBox:getToggle())
end

local okcallback=self.showdata.okcallback
self.showdata:deleteSelf()
self:close()
if okcallback then
okcallback()
end
end

function UIDialougeBuyWithReward3:onBGClick()
if self.showdata.bgClick then
self:onCancelButton()
end
end

function UIDialougeBuyWithReward3:onChangeChoose()

AudioManager.playBtnClick()
end