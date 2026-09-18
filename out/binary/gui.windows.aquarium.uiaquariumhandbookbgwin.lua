







def_class("UIAquariumHandbookBGWin",UIWindowBase)









function UIAquariumHandbookBGWin:bindComponents()

self.title=UIText.get(self,0)
self.closeBtn=UIButton.get(self,1)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIAquariumHandbookBGWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end



















function UIAquariumHandbookBGWin:onLoaded(...)
self:bindComponents()
end


function UIAquariumHandbookBGWin:__delete()
self:unbindComponents()
end




function UIAquariumHandbookBGWin:onShow(argtable,afterOnloaded)
self.titleName=argtable.title
self.closeCB=argtable.close
self.title:setText(self.titleName)
end


function UIAquariumHandbookBGWin:onHide()

end

function UIAquariumHandbookBGWin:setTitle(title)
self.title:setText(title or self.titleName)
end




function UIAquariumHandbookBGWin:onCloseClick()
if self.closeCB then
self.closeCB()
end
end

function UIAquariumHandbookBGWin:onCloseBtn()
self:onCloseClick()
end