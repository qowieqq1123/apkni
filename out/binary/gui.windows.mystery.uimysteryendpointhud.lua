







def_class("UIMysteryEndPointHUD",UICloneObject)





UIMysteryEndPointHUD.abName="ui/windows/mystery/uimysteryendpointhud.ab"

UIMysteryEndPointHUD.assetName="UIMysteryEndPointHUD"


function UIMysteryEndPointHUD:bindComponents()

self.Root=UIObject.get(self,0)
self.Image=UIObject.get(self,1)

end


function UIMysteryEndPointHUD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.Image);self.Image=nil;
end





local _HexMapManager=CS.HexagonMapManagerInterface



function UIMysteryEndPointHUD:onLoaded(...)
self:bindComponents()
end


function UIMysteryEndPointHUD:__delete()
self:unbindComponents()
end




function UIMysteryEndPointHUD:onShow(argtable,afterOnloaded)
if argtable then
if self.Root then
local hudPos=_HexMapManager.GetCellCenterWorld(argtable.pos,argtable.layer,false)
self:setChildPosition(self.Root:getID(),hudPos)
end
end
end


function UIMysteryEndPointHUD:onHide()

end


