







def_class("UIDiscipleLinggenResetAllBackWin",UIWindowBase)









function UIDiscipleLinggenResetAllBackWin:bindComponents()

self.blackImg=UIObject.get(self,0)
self.jtImage=UIObject.get(self,1)
self.resetDescTxt=UIText.get(self,2)
self.resetTimeTxt=UIText.get(self,3)
self.root=UIObject.get(self,4)



end


function UIDiscipleLinggenResetAllBackWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.jtImage);self.jtImage=nil;
_UIObject_release(self.resetDescTxt);self.resetDescTxt=nil;
_UIObject_release(self.resetTimeTxt);self.resetTimeTxt=nil;
_UIObject_release(self.root);self.root=nil;
end



















function UIDiscipleLinggenResetAllBackWin:onLoaded(...)
self:bindComponents()
end


function UIDiscipleLinggenResetAllBackWin:__delete()
self:unbindComponents()
if self.closeFunc then
self.closeFunc()
self.closeFunc=nil
end
end




function UIDiscipleLinggenResetAllBackWin:onShow(argtable,afterOnloaded)
self.closeFunc=argtable.closeFunc
self.resetDescTxt:setText(argtable.descStr)
self.resetTimeTxt:setText(argtable.timeStr)
if argtable.type==1 then
self.root:setLocalPosX(267)
self.jtImage:setLocalPosX(180)
else
self.root:setLocalPosX(-383)
self.jtImage:setLocalPosX(-153)
end
end


function UIDiscipleLinggenResetAllBackWin:onHide()
end



