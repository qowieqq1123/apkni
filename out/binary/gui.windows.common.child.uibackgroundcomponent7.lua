







def_class("UIBackgroundComponent7",UIWindowBase)









function UIBackgroundComponent7:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.titleImg=UIImage.get(self,1)
self.model=UIObject.get(self,2)
self.uiroot=UIObject.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIBackgroundComponent7:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.titleImg);self.titleImg=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.uiroot);self.uiroot=nil;
end



















function UIBackgroundComponent7:onLoaded(...)
self:bindComponents()
end


function UIBackgroundComponent7:__delete()
self:unbindComponents()
end




function UIBackgroundComponent7:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.model:setChildUIModelShowTarget(6067,1,nil,eAnimationID.enter)
self.uiroot:setChildCanvasGroupAlpha(0)
local func=function()
self.uiroot:setChildCanvasGroupDOFade(1,0.3,nil)
end
self:delayDo(0.3,func)
end
local titleImg=argtable.titleImg
self.closeCB=argtable.close
if titleImg then
self.titleImg:setSprite(titleImg[1],titleImg[2])
end
end


function UIBackgroundComponent7:onHide()

end

function UIBackgroundComponent7:onCloseBtn()
local cb=self.closeCB
if cb then
cb()
end
end

function UIBackgroundComponent7:setTitleImg(titleImg)
self.titleImg:setSprite(titleImg[1],titleImg[2])
end

function UIBackgroundComponent7:setTitle(title)

end

