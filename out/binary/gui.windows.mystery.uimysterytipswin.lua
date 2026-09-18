







def_class("UIMysteryTipsWin",UIWindowBase)









function UIMysteryTipsWin:bindComponents()

self.back=UIObject.get(self,0)
self.text=UIText.get(self,1)
self.icon=UIImage.get(self,2)



end


function UIMysteryTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.text);self.text=nil;
_UIObject_release(self.icon);self.icon=nil;
end



















function UIMysteryTipsWin:onLoaded(...)
self:bindComponents()
end


function UIMysteryTipsWin:__delete()
self:unbindComponents()
end




function UIMysteryTipsWin:onShow(argtable,afterOnloaded)
self.delay=argtable.delay or 5
self.text:setText(argtable.str)
if argtable.icon then
self.icon:setChildIcon(argtable.icon,true)
if argtable.iconPosX then
self.icon:setLocalPosX(argtable.iconPosX)
end
if argtable.iconPosY then
self.icon:setLocalPosY(argtable.iconPosY)
end
end
self.back:setScale(Vector3.New(1,0,1))
self.back:setChildDOScaleY(1,0.1,function()
local t=self.back:setChildDOScaleY(0,0.1,nil)
t:SetDelay(self.delay-0.12)

self:setTimer(self.delay,1,function()
self:closeSelf()
end)
end)
end


function UIMysteryTipsWin:onHide()

end



