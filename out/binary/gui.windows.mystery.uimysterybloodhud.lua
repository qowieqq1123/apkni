







def_class("UIMysteryBloodHUD",UICloneObject)





UIMysteryBloodHUD.abName="ui/windows/mystery/uimysterybloodhud.ab"

UIMysteryBloodHUD.assetName="UIMysteryBloodHUD"


function UIMysteryBloodHUD:bindComponents()

self.Root=UIObject.get(self,0)
self.bar=UIProgress.get(self,1)

end


function UIMysteryBloodHUD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.bar);self.bar=nil;
end









function UIMysteryBloodHUD:onLoaded(...)
self:bindComponents()
end


function UIMysteryBloodHUD:__delete()
self:unbindComponents()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end




function UIMysteryBloodHUD:onShow(argtable,afterOnloaded)
if argtable then
local etType=argtable.etType
local guid=argtable.guid
local blood=argtable.blood

local oldBlood=argtable.oldBlood
self.time=argtable.time
self.etType=etType
self.guid=guid
local entity=mysteryEntityController.invokeFuncByMysteryEntityType(etType,'get_entity',guid)
if entity then
local oldPercent=oldBlood/100
local newPercent=blood/100
self.bar:setProgressOnTime(oldPercent,newPercent,10)
self.updatetime=0
self.updateTimer=self:setTimer(0.02,0,function()self.onUpdate(self)end)
end

end
end

function UIMysteryBloodHUD.onUpdate(win)
win.updatetime=win.updatetime+0.02
if win and win.guid then
local hudPos=mysteryEntityController.invokeFuncByMysteryEntityType(win.etType,'get_hud_position',win.guid,true)
win:refreshPosition(hudPos)
end

if win.updatetime>=win.time then
win:recycleSelf()
end
end

function UIMysteryBloodHUD:refreshPosition(hudPos)
if self.Root then
self:setChildPosition(self.Root:getID(),hudPos)
end
end


function UIMysteryBloodHUD:onHide()

end


