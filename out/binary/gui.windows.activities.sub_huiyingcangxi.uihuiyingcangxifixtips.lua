







def_class("UIHuiYingCangXiFixTips",UIWindowBase)









function UIHuiYingCangXiFixTips:bindComponents()

self.cancelButton=UIButton.get(self,0)
self.cancelText=UIText.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.Content=UIObject.get(self,3)
self.mbg=UIObject.get(self,4)
self.okButton=UIButton.get(self,5)
self.okText=UIText.get(self,6)
self.rewardview=UIScrollView.get(self,7)
self.root=UIObject.get(self,8)
self.tip=UIText.get(self,9)
self.titleText=UIText.get(self,10)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIHuiYingCangXiFixTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.rewardview);self.rewardview=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tip);self.tip=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end
















local _this




function UIHuiYingCangXiFixTips:onLoaded(...)
self:bindComponents()
_this=self
end


function UIHuiYingCangXiFixTips:__delete()
self:unbindComponents()
_this=nil
end




function UIHuiYingCangXiFixTips:onShow(showdata,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(6397,1,nil,eAnimationID.enter)
self:delayDo(0.2,function()
if not _this then return end
return _this.root:setChildCanvasGroupDOFade(1,0.5)
end)
end


self.titleText:setText(showdata.title)


if showdata.canceltext~=nil then
self.cancelText:setText(showdata.canceltext)
else
self.cancelButton:setActive(false)
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
local hasnum
if itemsConfig.isMoney(v.itemid)then
hasnum=moneyModel.getMoney(v.itemid)
else
hasnum=bagControl.invokeFuncByItemId(v.itemid,'getItemCountByItemID',v.itemid)
end
local isGray=hasnum<v.itemcount
table.insert(propData,itemsComponentHelper.getCommonFillData({itemid=v.itemid,itemcount=v.itemcount},{showname=false,nomalname=false,showcount=v.itemcount>1,showCountBG=v.itemcount>1,gray=isGray and 2 or 0}))
end
self.Content:setChildLayoutGroupCreateItems(len,function(index)
local itemReward=self.Content:getChildLayoutGroupGridItem(index-1)
itemReward:SetChildPropData(0,propData[index])
itemReward:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end)
self.Content:setChildSizeDelta(len*82+(len-1)*10,94.857)

self.rewardview:setChildScrollRectEnable(len>=5)
end
end


function UIHuiYingCangXiFixTips:onHide()

end





function UIHuiYingCangXiFixTips:onCancelButton()
local cancelcallback=self.showdata.cancelcallback

if self.showdata.parentWin then
self.showdata.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
if cancelcallback then
cancelcallback()
end
end



function UIHuiYingCangXiFixTips:onCloseBtn()
local closecallback=self.showdata.closecallback


if self.showdata.parentWin then
self.showdata.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
if closecallback then
closecallback()
end
end



function UIHuiYingCangXiFixTips:onOkButton()
local okcallback=self.showdata.okcallback

if self.showdata.parentWin then
self.showdata.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
if okcallback then
okcallback()
end
end

