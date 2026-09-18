







def_class("UIMysteryBloodDurHUD",UICloneObject)





UIMysteryBloodDurHUD.abName="ui/windows/mystery/uimysteryblooddurhud.ab"

UIMysteryBloodDurHUD.assetName="UIMysteryBloodDurHUD"


function UIMysteryBloodDurHUD:bindComponents()

self.Root=UIObject.get(self,0)
self.bar=UIProgress.get(self,1)

end


function UIMysteryBloodDurHUD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.bar);self.bar=nil;
end









function UIMysteryBloodDurHUD:onLoaded(...)
self:bindComponents()
end


function UIMysteryBloodDurHUD:__delete()
self:unbindComponents()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
if self.guid then
local entity=mysteryEntityController.invokeFuncByMysteryEntityType(self.etType,'get_entity',self.guid)
if entity then
entity.bloodBar=nil
end
end
end




function UIMysteryBloodDurHUD:onShow(argtable,afterOnloaded)
if argtable then
local etType=argtable.etType
local guid=argtable.guid
self.etType=etType
self.guid=guid
local entity=mysteryEntityController.invokeFuncByMysteryEntityType(etType,'get_entity',guid)
if entity and entity.data and entity.data.blood then
entity.bloodBar=self
self.bar:setProgress(entity.data.blood,10000)
self.updatetime=0
self.updateTimer=self:setTimer(0.02,0,function()self.onUpdate(self)end)
else
self:recycleSelf()
end

end
end

function UIMysteryBloodDurHUD.onUpdate(win)
win.updatetime=win.updatetime+0.02
if win and win.guid then
local model=mysteryEntityController.getModelByEntityType(win.etType)
if model then
if not model:get_entity(win.guid)then
win:recycleSelf()
return
end
if not model:get_entity_visible(win.guid)then
return
end

local hudPos=model:get_hud_position(win.guid,true)
win:refreshPosition(hudPos)

end
end

end

function UIMysteryBloodDurHUD:refreshPosition(hudPos)
if self.Root then
self:setChildPosition(self.Root:getID(),hudPos)
end
end

function UIMysteryBloodDurHUD:refreshBlood()
local entity=mysteryEntityController.invokeFuncByMysteryEntityType(self.etType,'get_entity',self.guid)
if entity and entity.data and entity.data.blood and entity.data.blood>0 then
self.bar:setProgress(entity.data.blood,10000)
else
self:recycleSelf()
end
end


function UIMysteryBloodDurHUD:onHide()

end


