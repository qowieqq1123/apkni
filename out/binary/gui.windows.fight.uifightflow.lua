







def_class("UIFightFlow",UICloneObject)





UIFightFlow.abName="ui/windows/fight/uifightflow.ab"

UIFightFlow.assetName="UIFightFlow"


function UIFightFlow:bindComponents()

self.Root=UIObject.get(self,0)
self.EntityName=UIText.get(self,1)

end


function UIFightFlow:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.EntityName);self.EntityName=nil;
end






function UIFightFlow:onLoaded()
self:bindComponents()
end

function UIFightFlow:__delete()
self:unbindComponents()
if self.delayCloseTimer~=nil then
self.delayCloseTimer:cancel()
end
end

function UIFightFlow:onShow(args)
self.ent=args.fightEnt
self.value=args.hpChange
self.parent=args.parent

self:setChildPosition(self.Root:getID(),self.ent.position+Vector3.New(0.5,1.0,0))

local str=''
if self.value>0 then
str=FMT.fmt("<color=#ff0000>{0}</color>",self.value)
else
str=FMT.fmt("<color=#00ff00>{0}</color>",math.abs(self.value))
end
self.EntityName:setText(str)

local delayClose=function(...)
self.delayCloseTimer=nil
self.parent:closeSubWin(self)
end

self.delayCloseTimer=timer.new()
self.delayCloseTimer:start(1.0,delayClose,1)
end

