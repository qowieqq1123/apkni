







def_class("UICommonPVVideoWin",UIWindowBase)









function UICommonPVVideoWin:bindComponents()

self.bg=UIObject.get(self,0)
self.Player3=UIObject.get(self,1)



end


function UICommonPVVideoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.Player3);self.Player3=nil;
end



















function UICommonPVVideoWin:onLoaded(...)
self:bindComponents()
end


function UICommonPVVideoWin:__delete()
self:unbindComponents()
end




function UICommonPVVideoWin:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
self.url=argtable.url
self.fileName=argtable.name
self:play()
end


function UICommonPVVideoWin:onHide()

end

function UICommonPVVideoWin:play()

self.winlua:PlayURLVideo(self.Player3:getID(),self.url or'','',true,'')
end



