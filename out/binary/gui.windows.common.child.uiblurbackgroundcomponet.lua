







def_class("UIBlurBackgroundComponet",UICloneObject)





UIBlurBackgroundComponet.abName="ui/windows/common/child/uiblurbackgroundcomponet.ab"

UIBlurBackgroundComponet.assetName="UIBlurBackgroundComponet"


function UIBlurBackgroundComponet:bindComponents()

self.RawImage=UIObject.get(self,0)

end


function UIBlurBackgroundComponet:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.RawImage);self.RawImage=nil;
end









function UIBlurBackgroundComponet:onLoaded(...)
self:bindComponents()
end


function UIBlurBackgroundComponet:__delete()
self:closeBlur()
self:unbindComponents()
end




function UIBlurBackgroundComponet:onShow(argtable,afterOnloaded)
self.duration=argtable.duration or 0.2
self.callback=argtable.callback
self:startBlur()
end


function UIBlurBackgroundComponet:onHide()

end




function UIBlurBackgroundComponet:startBlur()
local cameraGO=mainControl:getUICamera()
local cameraTF=cameraGO.transform
self.RawImage:setActive(true)
self.widget:EnableCaptureScreenBlur(self.RawImage:getID(),cameraTF,true)
self.RawImage:setChildCanvasGroupDOFade(1,self.duration,self.callback)
end

function UIBlurBackgroundComponet:closeBlur()
local cameraGO=mainControl:getUICamera()
local cameraTF=cameraGO.transform
self.RawImage:setActive(false)
self.RawImage:setChildCanvasGroupAlpha(0)
self.widget:DisableCaptureScreenBlur(self.RawImage:getID(),cameraTF)
end