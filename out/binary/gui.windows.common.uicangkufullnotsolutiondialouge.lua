







def_class("UICangKuFullNotSolutionDialouge",UIWindowBase)









function UICangKuFullNotSolutionDialouge:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.cancelButton=UIButton.get(self,1)
self.okButton=UIButton.get(self,2)
self.itemGroup=UIObject.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UICangKuFullNotSolutionDialouge:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.itemGroup);self.itemGroup=nil;
end



















function UICangKuFullNotSolutionDialouge:onLoaded(...)
self:bindComponents()
end


function UICangKuFullNotSolutionDialouge:__delete()
self:unbindComponents()
end




function UICangKuFullNotSolutionDialouge:onShow(argtable,afterOnloaded)
self.itemList=argtable.itemList
self.okCallback=argtable.okCallback

self:refresh()
end


function UICangKuFullNotSolutionDialouge:onHide()

end

function UICangKuFullNotSolutionDialouge:refresh()
local count=#self.itemList
self.itemGroup:setChildLayoutGroupCreateItems(count)
local grids=self.itemGroup:getChildLayoutGroupGridList()
for i=1,grids.Count do
local widget=grids[i-1]
local item=self.itemList[i]
local itemId=item[1]
local itemCount=item[2]
local itemCountStr=mathHelper.formatNumber(itemCount)
widget:SetChildIcon(0,iconHelper.getIconName(itemId),false)
widget:SetChildText(1,FMT.fmt("-{0}",itemCountStr))
end
end





function UICangKuFullNotSolutionDialouge:onCloseBtn()
self:closeSelf()
end



function UICangKuFullNotSolutionDialouge:onCancelButton()
self:closeSelf()
end



function UICangKuFullNotSolutionDialouge:onOkButton()
local callback=self.okCallback
if callback then
callback()
end
self:closeSelf()
end


function UICangKuFullNotSolutionDialouge:onBGClick()
self:closeSelf()
end

