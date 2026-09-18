







def_class("UILayoutPreviewWin",UIWindowBase)









function UILayoutPreviewWin:bindComponents()

self.leaveBtn=UIButton.get(self,0)
self.groundBtn=UIToggleButton.get(self,1)

self.leaveBtn:setButtonClick(function()self:onLeaveBtn()end)



end


function UILayoutPreviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leaveBtn);self.leaveBtn=nil;
_UIObject_release(self.groundBtn);self.groundBtn=nil;
end



















function UILayoutPreviewWin:onLoaded(...)
self:bindComponents()
end


function UILayoutPreviewWin:__delete()
self:unbindComponents()

end




function UILayoutPreviewWin:onShow(argtable,afterOnloaded)
isometricMapSystem:hideDesignGrid()
end


function UILayoutPreviewWin:onHide()

end





function UILayoutPreviewWin:onLeaveBtn()
ims_design_layout:onLeavePreviewMap()

self:delayDo(0.5,function()
isometricMapSystem:showDesignGrid()
UIManager:invokeUIMethod("UILayoutEditWin","showEditWin",true)

self:closeSelf()
end)

end

