







def_class("UIDiscipleCoupleLoseWin",UIWindowBase)









function UIDiscipleCoupleLoseWin:bindComponents()

self.root=UIObject.get(self,0)
self.closeTips=UIButton.get(self,1)
self.manName=UIText.get(self,2)
self.womanName=UIText.get(self,3)
self.manHead=UIObject.get(self,4)
self.womanHead=UIObject.get(self,5)

self.closeTips:setButtonClick(function()self:onCloseTips()end)



end


function UIDiscipleCoupleLoseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeTips);self.closeTips=nil;
_UIObject_release(self.manName);self.manName=nil;
_UIObject_release(self.womanName);self.womanName=nil;
_UIObject_release(self.manHead);self.manHead=nil;
_UIObject_release(self.womanHead);self.womanHead=nil;
end



















function UIDiscipleCoupleLoseWin:onLoaded(...)
self:bindComponents()
end


function UIDiscipleCoupleLoseWin:__delete()
self:unbindComponents()
end




function UIDiscipleCoupleLoseWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.4,nil)
end
self:delayDo(0.4,func)
end
self.canClose=nil

self.closeTimer=self:delayDo(1.5,function(...)
self.canClose=true
end)
self.manGuid=argtable.man
self.womanGuid=argtable.woman
local manName=UIDiscipleModel:getDiscipleName(self.manGuid)
local womanName=UIDiscipleModel:getDiscipleName(self.womanGuid)

self.manName:setText(manName)
self.womanName:setText(womanName)

comHelper.setChildModelRawImage(self.winlua,self.manGuid,self.manHead:getID(),0,eHeadCenterType.eHead)
comHelper.setChildModelRawImage(self.winlua,self.womanGuid,self.womanHead:getID(),0,eHeadCenterType.eHead)
end


function UIDiscipleCoupleLoseWin:onHide()

end





function UIDiscipleCoupleLoseWin:onCloseTips()
if not self.canClose then return false end
self:closeSelf()
end