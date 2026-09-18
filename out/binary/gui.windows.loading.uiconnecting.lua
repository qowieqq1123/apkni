







def_class("UIConnecting",UIWindowBase)









function UIConnecting:bindComponents()

self.Image=UIObject.get(self,0)



end


function UIConnecting:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Image);self.Image=nil;
end



















function UIConnecting:onLoaded(...)
self:bindComponents()
end


function UIConnecting:__delete()
self:unbindComponents()
end




function UIConnecting:onShow(argtable,afterOnloaded)

end


function UIConnecting:onHide()

end



