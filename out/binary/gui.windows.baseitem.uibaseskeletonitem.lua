







def_class("UIBaseSkeletonItem",UICloneObject)





UIBaseSkeletonItem.abName="ui/windows/baseitem/uibaseskeletonitem.ab"

UIBaseSkeletonItem.assetName="UIBaseSkeletonItem"


function UIBaseSkeletonItem:bindComponents()

self.UIBaseSkeletonItem=UIGameobjectClone.new(self,0)

end


function UIBaseSkeletonItem:unbindComponents()
local _UIObject_release=UIObject.release
self.UIBaseSkeletonItem:deleteSelf();self.UIBaseSkeletonItem=nil;
end








function UIBaseSkeletonItem:onLoaded(...)
self:bindComponents()
end

function UIBaseSkeletonItem:__delete()
self:unbindComponents()
end

function UIBaseSkeletonItem:onShow(argtable,afterOnloaded)

end

function UIBaseSkeletonItem:onHide()

end


