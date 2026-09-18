







def_class("UIShuiYinWin",UIWindowBase)









function UIShuiYinWin:bindComponents()

self.root=UIObject.get(self,0)
self.Text=UIText.get(self,1)



end


function UIShuiYinWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.Text);self.Text=nil;
end



















function UIShuiYinWin:onLoaded(...)
self:bindComponents()
end


function UIShuiYinWin:__delete()
self:unbindComponents()
end




function UIShuiYinWin:onShow(argtable,afterOnloaded)
local stype=argtable[1]
self:resetMap(stype)
end


function UIShuiYinWin:onHide()

end

function UIShuiYinWin:resetMap(stype)
local posY=stype==eSceneType.eWorld and 310 or 365
self.Text:setLocalPosY(posY)
end



