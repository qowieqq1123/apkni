







def_class("UICSFallDisciple",UICloneObject)





UICSFallDisciple.abName="ui/windows/littlegame/child/uicsfalldisciple.ab"

UICSFallDisciple.assetName="UICSFallDisciple"


function UICSFallDisciple:bindComponents()

self.UICSFallDisciple=UIObject.get(self,0)

end


function UICSFallDisciple:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.UICSFallDisciple);self.UICSFallDisciple=nil;
end









function UICSFallDisciple:onLoaded(...)
self:bindComponents()
end


function UICSFallDisciple:__delete()
self:unbindComponents()
end




function UICSFallDisciple:onShow(argtable,afterOnloaded)
local discipleid=argtable.discipleid
if discipleid then
self.UICSFallDisciple:setChildUIModelShowTarget(discipleid,1,nil,eAnimationID.stand)
end
end


function UICSFallDisciple:onHide()

end

function UICSFallDisciple:doMoveY(posx,posy,toposy)
self.UICSFallDisciple:setChildLocalPosition(Vector3(posx,posy,0))
self.UICSFallDisciple:setChildDOLocalMoveY(toposy,8,function()
self:recycleSelf()
end)
end


