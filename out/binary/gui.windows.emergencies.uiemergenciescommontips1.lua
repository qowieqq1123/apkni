







def_class("UIEmergenciesCommonTips1",UIWindowBase)









function UIEmergenciesCommonTips1:bindComponents()

self.text=UIText.get(self,0)
self.icon=UIImage.get(self,1)
self.back=UIObject.get(self,2)



end


function UIEmergenciesCommonTips1:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.text);self.text=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.back);self.back=nil;
end



















function UIEmergenciesCommonTips1:onLoaded(...)
self:bindComponents()
end


function UIEmergenciesCommonTips1:__delete()
self:unbindComponents()

if self.tween then
self.tween:Kill()
self.tween=nil
end

if self.tick then
self:stopTimerByID(self.tick)
self.tick=nil
end
end




function UIEmergenciesCommonTips1:onShow(argtable,afterOnloaded)

if argtable==nil then
self:closeSelf()
return
end
if self.str==argtable.str then return end
self.delay=argtable.delay or 5
self.str=argtable.str
self.text:setText(argtable.str)
if argtable.icon then
self.icon:setChildIcon(argtable.icon,true)
self.icon:setChildUIModelRemoveTarget()
elseif argtable.model then
self.icon:setChildIcon("",true)
self.icon:setChildUIModelShowTarget(model.body,model.scale or 1,model.componets or{},model.anim or 0)
elseif argtable.image then
self.icon:setCSImageSprite(argtable.image[1],argtable.image[2])
self.icon:setChildUIModelRemoveTarget()
end

if self.tween then
self.tween:Kill()
self.tween=nil
end
self.back:setScale(Vector3.New(1,0,1))
self.tween=Lua.SequenceProxy.New()
self.tween:Append(self.back:setChildDOScaleY(1,0.1))
self.tween:AppendInterval(self.delay)
self.tween:Append(self.back:setChildDOScaleY(0,0.1))
if self.tick then
self:stopTimerByID(self.tick)
self.tick=nil
end
self.tick=self:setTimer(self.delay+0.2,1,function()
self:closeSelf()
end)
end


function UIEmergenciesCommonTips1:onHide()

end



