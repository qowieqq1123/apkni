







def_class("ResPoint_BillBoard",UICloneObject)





ResPoint_BillBoard.abName="ui/windows/world/billbroad/respoint_billboard.ab"

ResPoint_BillBoard.assetName="ResPoint_BillBoard"


function ResPoint_BillBoard:bindComponents()

self.Root=UIObject.get(self,0)
self.Icon=UIButton.get(self,1)

self.Icon:setButtonClick(function()self:onIcon()end)

end


function ResPoint_BillBoard:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.Icon);self.Icon=nil;
end









function ResPoint_BillBoard:onLoaded(...)
self:bindComponents()
end


function ResPoint_BillBoard:__delete()
self:unbindComponents()
end




function ResPoint_BillBoard:onShow(argtable,afterOnloaded)

self.unitKey=argtable.unitKey
local data=worldController:getUnit(self.unitKey)
local guid=data.Model:GetModelEntity().GUID
self:getWidget():SetChildFollowEntitySlot(self.Root:getID(),guid,argtable.slotName,argtable.offset or Vector3.zero)
local param=argtable.param


self.Icon:setChildIcon(param.icon,true)
self.Icon:setScale(argtable.scale or Vector3.one)
end


function ResPoint_BillBoard:onHide()

end



function ResPoint_BillBoard:changeColor(color,duration)
self:getWidget():SetChildImageDOColor(self.Icon:getID(),color,duration)
end

function ResPoint_BillBoard:onIcon()
worldController.clickUnit(self.unitKey)
end
