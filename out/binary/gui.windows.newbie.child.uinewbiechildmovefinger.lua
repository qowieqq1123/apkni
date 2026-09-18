







def_class("UINewbieChildMoveFinger",UICloneObject)





UINewbieChildMoveFinger.abName="ui/windows/newbie/child/uinewbiechildmovefinger.ab"

UINewbieChildMoveFinger.assetName="UINewbieChildMoveFinger"


function UINewbieChildMoveFinger:bindComponents()

self.Image=UIObject.get(self,0)
self.arrow=UIObject.get(self,1)

end


function UINewbieChildMoveFinger:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Image);self.Image=nil;
_UIObject_release(self.arrow);self.arrow=nil;
end








function UINewbieChildMoveFinger:onLoaded(...)
self:bindComponents()
end

function UINewbieChildMoveFinger:__delete()
self:unbindComponents()
end

function UINewbieChildMoveFinger:onShow(argtable,afterOnloaded)

local widget=self:getWidget()
local fingerpos=argtable.fingerpos
local arrowpos=argtable.arrowpos
local fingertargetpos=argtable.fingertargetpos
local arrowsize=argtable.arrowsize
local duration=argtable.duration or 1
local fingerratation=argtable.fingerratation
local arrowratation=argtable.arrowratation

if fingerpos then
widget:SetChildLocalPosition(self.Image:getID(),Vector3(fingerpos[1],fingerpos[2],0))
end

if arrowpos then
widget:SetChildLocalPosition(self.arrow:getID(),Vector3(arrowpos[1],arrowpos[2],0))
end

if fingertargetpos then
local callback
callback=function(...)
widget:SetChildDOLocalMove(self.Image:getID(),Vector3(fingertargetpos[1],fingertargetpos[2],0),duration,callback)
end
callback()
end
if arrowsize then
local callback
callback=function(...)
widget:SetChildDOSizeDelta(self.arrow:getID(),Vector2(arrowsize[1],arrowsize[2]),duration,callback)
end
callback()
end

if fingerratation then
widget:SetChildRotation(self.arrow:getID(),fingerratation[1],0,fingerratation[2])
end

if arrowratation then
widget:SetChildRotation(self.arrow:getID(),arrowratation[1],0,arrowratation[2])
end
end

function UINewbieChildMoveFinger:onHide()

end


