







def_class("UINewbieChildEffect",UICloneObject)





UINewbieChildEffect.abName="ui/windows/newbie/child/uinewbiechildeffect.ab"

UINewbieChildEffect.assetName="UINewbieChildEffect"


function UINewbieChildEffect:bindComponents()

self.effect=UIObject.get(self,0)

end


function UINewbieChildEffect:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect);self.effect=nil;
end








function UINewbieChildEffect:onLoaded(...)
self:bindComponents()
end

function UINewbieChildEffect:__delete()
self:unbindComponents()
end

function UINewbieChildEffect:onShow(argtable,afterOnloaded)
local effectid=argtable[1]
local effectPos=argtable[2]or{0,0}
self.widget:SetChildShowEffect(self.effect:getID(),effectid,true)

if effectPos then
self.widget:SetChildLocalPosition(self.effect:getID(),Vector3(effectPos[1],effectPos[2],0))
end
end

function UINewbieChildEffect:onHide()

end


