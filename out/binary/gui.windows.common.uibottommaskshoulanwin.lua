







def_class("UIBottomMaskShouLanWin",UIWindowBase)









function UIBottomMaskShouLanWin:bindComponents()

self.bgModel=UIObject.get(self,0)



end


function UIBottomMaskShouLanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
end



















function UIBottomMaskShouLanWin:onLoaded(...)
self:bindComponents()
end


function UIBottomMaskShouLanWin:__delete()
self:unbindComponents()
end




function UIBottomMaskShouLanWin:onShow(argtable,afterOnloaded)
self:setAsFirstSibling()
self.bgModel:setChildUIModelShowTarget(6516,1,{},eAnimationID.stand)
end


function UIBottomMaskShouLanWin:onHide()

end

function UIBottomMaskShouLanWin:setTitle()

end

function UIBottomMaskShouLanWin:onBackClick()
fullScreenUI.closeActiveUI(true)
end



