







def_class("UIMysteryCountHUD",UICloneObject)





UIMysteryCountHUD.abName="ui/windows/mystery/uimysterycounthud.ab"

UIMysteryCountHUD.assetName="UIMysteryCountHUD"


function UIMysteryCountHUD:bindComponents()

self.Root=UIObject.get(self,0)
self.CountRoot=UIObject.get(self,1)
self.EntityCount=UIText.get(self,2)

end


function UIMysteryCountHUD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.CountRoot);self.CountRoot=nil;
_UIObject_release(self.EntityCount);self.EntityCount=nil;
end









function UIMysteryCountHUD:onLoaded(...)
self:bindComponents()
end


function UIMysteryCountHUD:__delete()
self.CountRoot:setActive(false)
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
end
self:unbindComponents()
end




function UIMysteryCountHUD:onShow(argtable,afterOnloaded)
self.entity=argtable.entity
if self.entity then
self.count=0
self.entity.countHUD=self
local model=mysteryEntityController.getModelByEntityType(self.entity.entityType)
if model then
self.count=model:get_my_range_count(self.entity)or 0
end
self:refreshCount(self.count)
else
self.count=argtable.count or 0
self:refreshCount(self.count)
end
end


function UIMysteryCountHUD:onHide()

end

function UIMysteryCountHUD:refreshCount(count)
if not self.CountRoot and not self.EntityCount then
return
end
if not self.entity.isVisible then
self.CountRoot:setActive(false)
self.isVisible=false
return
end
if count>1 then
local position=mysteryEntityController.invokeFuncByMysteryEntityType(self.entity.entityType,'get_hud_position',self.entity.guid,false)
self:refreshPosition(position)
self.EntityCount:setText(count)
self.CountRoot:setActive(true)
self.isVisible=true
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
end
self.updateTimer=self:setTimer(0.05,0,function()self:updatePosition()end)
else
self.CountRoot:setActive(false)
end
end

function UIMysteryCountHUD:updatePosition()
if self.isVisible then
if self.entity then
local position=mysteryEntityController.invokeFuncByMysteryEntityType(self.entity.entityType,'get_hud_position',self.entity.guid,false)
self:refreshPosition(position)
end
else
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
end
end
end

function UIMysteryCountHUD:refreshPosition(hudPos)
if self.Root then
self:setChildPosition(self.Root:getID(),hudPos)
end
end



