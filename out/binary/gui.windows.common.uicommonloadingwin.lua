







def_class("UICommonLoadingWin",UIWindowBase)









function UICommonLoadingWin:bindComponents()

self.progressBar=UIProgressBarAni.get(self,0)
self.title=UIText.get(self,1)
self.root=UIObject.get(self,2)
self.mask=UIObject.get(self,3)
self.ani=UIObject.get(self,4)



end


function UICommonLoadingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.ani);self.ani=nil;
end


















function UICommonLoadingWin:onLoaded(...)
self:bindComponents()
self:setAsLastSibling()
end

function UICommonLoadingWin:__delete()
self:unbindComponents()
end

function UICommonLoadingWin:onShow(argtable,afterOnloaded)
self.root:setActive(argtable~=nil)
self.mask:setActive(argtable~=nil)
if argtable==nil then return end
local time=math.ceil(argtable.time)
local title=argtable.title or'请稍候片刻'
local callback=argtable.callback
self.progressBar:animateFiveParams(0,time,time,time,false)
self.title:setText(title)
self:stopAllTimer()
self:delayDo(time,function()
self.root:setActive(false)
self.mask:setActive(false)
if callback then
callback()
end
end)
self.winlua:SetChildSpineAnimation(self.ani:getID(),11,1,nil)
end

function UICommonLoadingWin:onHide()

end



