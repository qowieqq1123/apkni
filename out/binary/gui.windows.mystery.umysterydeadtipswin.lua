







def_class("UMysteryDeadTipsWin",UIWindowBase)









function UMysteryDeadTipsWin:bindComponents()

self.leftObj=UIObject.get(self,0)
self.rightObj=UIObject.get(self,1)
self.tipstxt=UIText.get(self,2)



end


function UMysteryDeadTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftObj);self.leftObj=nil;
_UIObject_release(self.rightObj);self.rightObj=nil;
_UIObject_release(self.tipstxt);self.tipstxt=nil;
end



















function UMysteryDeadTipsWin:onLoaded(...)
self:bindComponents()
end


function UMysteryDeadTipsWin:__delete()
self:unbindComponents()
end




function UMysteryDeadTipsWin:onShow(argtable,afterOnloaded)

end


function UMysteryDeadTipsWin:onHide()

end



