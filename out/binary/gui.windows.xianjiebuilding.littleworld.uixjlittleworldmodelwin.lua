







def_class("UIXJLittleWorldModelWin",UIWindowBase)









function UIXJLittleWorldModelWin:bindComponents()

self.map=UIObject.get(self,0)



end


function UIXJLittleWorldModelWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.map);self.map=nil;
end



















function UIXJLittleWorldModelWin:onLoaded(...)
self:bindComponents()
end


function UIXJLittleWorldModelWin:__delete()
self:unbindComponents()
end




function UIXJLittleWorldModelWin:onShow(argtable,afterOnloaded)

end


function UIXJLittleWorldModelWin:onHide()

end



