







def_class("UIMysteryTrapHUD",UICloneObject)





UIMysteryTrapHUD.abName="ui/windows/mystery/uimysterytraphud.ab"

UIMysteryTrapHUD.assetName="UIMysteryTrapHUD"


function UIMysteryTrapHUD:bindComponents()

self.Root=UIObject.get(self,0)
self.Text=UIText.get(self,1)

end


function UIMysteryTrapHUD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.Text);self.Text=nil;
end









function UIMysteryTrapHUD:onLoaded(...)
self:bindComponents()
end


function UIMysteryTrapHUD:__delete()
self:unbindComponents()
end




function UIMysteryTrapHUD:onShow(argtable,afterOnloaded)

self.step=argtable.step

local layer=mysteryRoomModel:get_GroundLayer(argtable.roomId)
local hudPos=_HexMapManager.GetCellCenterWorld(argtable.pos,layer,false)
self:setChildPosition(self.Root:getID(),hudPos)

if self.step<=0 then
self.Root:setActive(false)
else
self.Root:setActive(true)
self.Text:setText(self.step)
end


end

function UIMysteryTrapHUD:refreshStep(step)
if step<=0 then
self.Root:setActive(false)
else
self.Root:setActive(true)
self.Text:setText(step)
end
end


function UIMysteryTrapHUD:onHide()

end


