







def_class("UIMysteryGrassBgWin",UIWindowBase)









function UIMysteryGrassBgWin:bindComponents()

self.back=UIObject.get(self,0)
self.maopao=UIObject.get(self,1)
self.front=UIObject.get(self,2)
self.front2=UIObject.get(self,3)



end


function UIMysteryGrassBgWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.maopao);self.maopao=nil;
_UIObject_release(self.front);self.front=nil;
_UIObject_release(self.front2);self.front2=nil;
end



















function UIMysteryGrassBgWin:onLoaded(...)
self:bindComponents()

end


function UIMysteryGrassBgWin:__delete()
self:unbindComponents()
UIManager:closeWindow("UIMysteryGrassWin")
end




function UIMysteryGrassBgWin:onShow(argtable,afterOnloaded)
UIManager:showWindow("UIMysteryGrassWin")
end


function UIMysteryGrassBgWin:onHide()
UIManager:hideWindow("UIMysteryGrassWin")
end



