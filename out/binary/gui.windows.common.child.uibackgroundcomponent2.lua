







def_class("UIBackgroundComponent2",UIWindowBase)









function UIBackgroundComponent2:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.title=UIText.get(self,1)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIBackgroundComponent2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIBackgroundComponent2:onLoaded(...)
self:bindComponents()
end


function UIBackgroundComponent2:__delete()
self:unbindComponents()
end




function UIBackgroundComponent2:onShow(argtable,afterOnloaded)
self.titleName=argtable.title
self.closeCB=argtable.close
self.title:setText(self.titleName)
end


function UIBackgroundComponent2:onHide()

end



function UIBackgroundComponent2:onCloseBtn()
local cb=self.closeCB
if cb then
cb()
end
gubaoModel:setYetGubaoIndex(0)
end

function UIBackgroundComponent2:setTitle(title)
self.title:setText(title or self.titleName)
end