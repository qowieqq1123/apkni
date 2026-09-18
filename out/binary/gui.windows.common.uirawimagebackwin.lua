







def_class("UIRawImageBackWin",UIWindowBase)









function UIRawImageBackWin:bindComponents()

self.blackCmp=UIObject.get(self,0)
self.RawImage=UIObject.get(self,1)
self.wxBack=UIImage.get(self,2)



end


function UIRawImageBackWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackCmp);self.blackCmp=nil;
_UIObject_release(self.RawImage);self.RawImage=nil;
_UIObject_release(self.wxBack);self.wxBack=nil;
end


















function UIRawImageBackWin:onLoaded(...)
self:bindComponents()
self.showRawImage=false
end

function UIRawImageBackWin:__delete()
self:unbindComponents()
end

function UIRawImageBackWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
self.sortLayer=argtable.sortLayer
self.sortOrder=argtable.sortOrder
self.showBlack=argtable.showBlack

self:setAsFirstSibling()
if self.showRawImage then return end
self.showRawImage=true

if webGLHelper:isWebGLOptimization()then
self.blackCmp:setActive(true)
self.wxBack:setCSImageSprite("ui/windows/common/sharedtextures/image_tyuibg_2.ab","image_tyuibg_2")
if self.sortLayer and self.sortOrder then
self.blackCmp:setChildCanvas(self.sortLayer,self.sortOrder)
end
self.RawImage:setActive(false)

if cameraControl.isSpecialCamera()then
cameraControl.setCameraActive(false)
end
return
end

local camera=cameraControl.getCameraTransform()
if camera==nil then return end
self.RawImage:setActive(false)
dragonControl.lockEntity(true)

if self.sortLayer and self.sortOrder then
self.RawImage:setActive(true)
self:setImageCanvas(self.sortLayer,self.sortOrder)
end

if api_Available_CaptureScreenBlurImage()then
self.RawImage:setActive(true)
self.widget:CaptureScreenBlurImage(self.RawImage:getID(),camera,3,0.05,4)
if cameraControl.isSpecialCamera()then
camera.gameObject:SetActive(false)
end
else
self.RawImage:setActive(false)
self:setTimer(0.1,1,function()self.RawImage:setActive(true)end)
self.widget:EnableCaptureScreenBlur(self.RawImage:getID(),camera)
end

self.RawImage:setChildCanvasGroupDOFade(1,1)
self.blackCmp:setActive(self.showBlack or false)
end

function UIRawImageBackWin:setImageCanvas(sortLayer,sortOrder)
self.RawImage:setChildCanvas(sortLayer,sortOrder)
end

function UIRawImageBackWin:resetImageCanvas()
self.RawImage:setChildRemoveCanvas()
end

function UIRawImageBackWin:onHide()
self:closeScreenBlur()
end

function UIRawImageBackWin:__delete()
self:closeScreenBlur()
end



function UIRawImageBackWin:closeScreenBlur()
if not self.showRawImage then return end
self.showRawImage=false
if webGLHelper:isWebGLOptimization()then
cameraControl.setCameraActive(true)
return
end
self:stopAllTimer()
dragonControl.lockEntity(false)
self.RawImage:setActive(false)
self.RawImage:setChildCanvasGroupAlpha(0)
local camera,cameraType=cameraControl.getCameraTransform()
if camera==nil then
return
end
if api_Available_CaptureScreenBlurImage()then
camera.gameObject:SetActive(true)
else
self.widget:DisableCaptureScreenBlur(self.RawImage:getID(),camera)
end
end
