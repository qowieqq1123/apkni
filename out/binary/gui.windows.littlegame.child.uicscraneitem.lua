







def_class("UICSCraneItem",UICloneObject)





UICSCraneItem.abName="ui/windows/littlegame/child/uicscraneitem.ab"

UICSCraneItem.assetName="UICSCraneItem"


function UICSCraneItem:bindComponents()

self.UICSCraneItem=UIObject.get(self,0)

end


function UICSCraneItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.UICSCraneItem);self.UICSCraneItem=nil;
end









function UICSCraneItem:onLoaded(...)
self:bindComponents()
end


function UICSCraneItem:__delete()
self:unbindComponents()
end




function UICSCraneItem:onShow(argtable,afterOnloaded)
local modelid=argtable.modelid
if modelid then
self.UICSCraneItem:setChildUIModelShowTarget(modelid,1,nil,eAnimationID.stand)
end
end


function UICSCraneItem:onHide()

end

function UICSCraneItem:doMoveX(posy,direction)
local scaleFactor=CS.CSGUIManager.Instance.CanvasScaleValue
local width=UnityEngine.Screen.width/scaleFactor.x
local posx=direction==1 and-100 or width+100
local toposx=direction==1 and width+100 or-100
self.UICSCraneItem:setChildLocalPosition(Vector3(posx,posy,0))
self.UICSCraneItem:setChildDOLocalMoveX(toposx,8,function()
self:recycleSelf()
end)
end


