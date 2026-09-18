







def_class("UICommonDragonBoneWin",UIWindowBase)









function UICommonDragonBoneWin:bindComponents()

self.mask=UIObject.get(self,0)
self.back=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.title=UIText.get(self,3)



end


function UICommonDragonBoneWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
end
















local body_id={
back=2016,
}










function UICommonDragonBoneWin:onLoaded(argtable)
self:bindComponents()

self.mask:setChildCanvasGroupAlpha(0)

if not argtable.noBlackBg then
self.mask:setChildCanvasGroupDOFade(1,0.5,nil)
end
end


function UICommonDragonBoneWin:__delete()
self:unbindComponents()
self:closeExtra()
end


function UICommonDragonBoneWin:onHide()

end




function UICommonDragonBoneWin:onShow(argtable,afterOnloaded)
self:closeExtra()
self.extraWin=argtable.extraWin
self.canvasIdx=argtable.canvasIdx
self.extraParams=argtable.extraParams or{}
self.extraParams.parentWin=self
if self.extraWin then
local wincfg=UIManager.get_window_config(self.extraWin)
local canvasIdx=self.canvasIdx or wincfg.canvas
self:setCanvasIndex(-1,canvasIdx)
end

local titleName=argtable.titleName
self.title:setText(titleName)

local cb=function()
self:onLoadFinish()
end
if afterOnloaded then
self.back:setChildUIModelShowTarget(body_id.back,1,{},eAnimationID.common_window_enter,false,false,0,cb)
else
cb()
end
end

function UICommonDragonBoneWin:closeExtra()
if self.extraWin~=nil then
self:closeWindow(self.extraWin)
self.extraWin=nil
self.extraParams=nil
end
end

function UICommonDragonBoneWin:onLoadFinish()
self:showWindow(self.extraWin,self.extraParams)
end

function UICommonDragonBoneWin:onClickClose()
self:closeSelf()
end