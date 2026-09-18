







def_class("UIMysteryGrassBg2Win",UIWindowBase)









function UIMysteryGrassBg2Win:bindComponents()

self.back=UIObject.get(self,0)
self.front=UIObject.get(self,1)
self.front2=UIObject.get(self,2)



end


function UIMysteryGrassBg2Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.front);self.front=nil;
_UIObject_release(self.front2);self.front2=nil;
end



















function UIMysteryGrassBg2Win:onLoaded(...)
self:bindComponents()
end


function UIMysteryGrassBg2Win:__delete()
self:unbindComponents()
UIManager:closeWindow("UIMysteryGrassWin")
end




function UIMysteryGrassBg2Win:onShow(argtable,afterOnloaded)
UIManager:showWindow("UIMysteryGrassWin")
end


function UIMysteryGrassBg2Win:onHide()
UIManager:hideWindow("UIMysteryGrassWin")
end



