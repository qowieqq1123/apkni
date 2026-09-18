







def_class("UISLDialoge",UIWindowBase)









function UISLDialoge:bindComponents()

self.des1=UIText.get(self,0)
self.des2=UIText.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.rwScrollView=UIObject.get(self,3)
self.cancelText=UIText.get(self,4)
self.okText=UIText.get(self,5)
self.cancelButton=UIButton.get(self,6)
self.okButton=UIButton.get(self,7)
self.titleText=UIText.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UISLDialoge:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.des1);self.des1=nil;
_UIObject_release(self.des2);self.des2=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end



















function UISLDialoge:onLoaded(...)
self:bindComponents()

self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UISLDialoge:__delete()
self:unbindComponents()
if self.callback then
self.callback(self.isOk)
end
end




function UISLDialoge:onShow(argtable,afterOnloaded)
self.isOk=false
self.titleText:setText(argtable.title)
self.des1:setText(argtable.des1)
self.des2:setText(argtable.des2)
self.callback=argtable.callback
self:setRewardList(argtable.rewards)
end


function UISLDialoge:onHide()

end

function UISLDialoge:setRewardList(rewards)
local len=#rewards
self.rwScrollView:setChildScrollViewCreateGrids(len,math.min(len,4))
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=rewards[i]
widgetHelper.setNormalRewardItem(item,0,data)
end
end





function UISLDialoge:onCloseBtn()
self:closeSelf()
end



function UISLDialoge:onCancelButton()
self:closeSelf()
end



function UISLDialoge:onOkButton()
self.isOk=true
self:closeSelf()
end

