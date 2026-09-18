







def_class("UIMysteryBloodNumHUD",UICloneObject)





UIMysteryBloodNumHUD.abName="ui/windows/mystery/uimysterybloodnumhud.ab"

UIMysteryBloodNumHUD.assetName="UIMysteryBloodNumHUD"


function UIMysteryBloodNumHUD:bindComponents()

self.Root=UIObject.get(self,0)
self.bloodChange=UIText.get(self,1)

end


function UIMysteryBloodNumHUD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.bloodChange);self.bloodChange=nil;
end









function UIMysteryBloodNumHUD:onLoaded(...)
self:bindComponents()
self.updateTimer=self:setTimer(0.02,0,function()self.onUpdate(self)end)
end


function UIMysteryBloodNumHUD:__delete()
self:unbindComponents()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end




function UIMysteryBloodNumHUD:onShow(argtable,afterOnloaded)
local delay=argtable.delay or 3
self.eType=argtable.bindType
self.guid=argtable.bindguid
local str=argtable.str
self.bloodChange:setText(str or 0)
self:setTimer(delay,1,function()
self:recycleSelf()
end)
end

function UIMysteryBloodNumHUD.onUpdate(win)
if win then
if win.guid then
local hudPos=mysteryEntityController.invokeFuncByMysteryEntityType(win.eType,"get_hud_position",win.guid)
win:refreshPosition(hudPos)
end
end
end

function UIMysteryBloodNumHUD:refreshPosition(hudPos)
if self.Root then
self:setChildPosition(self.Root:getID(),hudPos)
end
end


function UIMysteryBloodNumHUD:onHide()

end


