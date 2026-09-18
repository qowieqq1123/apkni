







def_class("UISMBaiShanEventWin",UIWindowBase)









function UISMBaiShanEventWin:bindComponents()

self.root=UIObject.get(self,0)
self.bg=UIButton.get(self,1)
self.icon=UIImage.get(self,2)
self.title=UIText.get(self,3)
self.desc=UIText.get(self,4)

self.bg:setButtonClick(function()self:onBg()end)



end


function UISMBaiShanEventWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.desc);self.desc=nil;
end



















function UISMBaiShanEventWin:onLoaded(...)
self:bindComponents()
end


function UISMBaiShanEventWin:__delete()
self:stopCloseTimer()
self:unbindComponents()

if self.callback then
self.callback(self.clickBg)
end
end




function UISMBaiShanEventWin:onShow(argtable,afterOnloaded)
local iconName=argtable.iconName
local title=argtable.title
local content=argtable.content
local time=argtable.time
self.callback=argtable.callback
self.title:setText(title)
self.icon:setImageIcon(iconName or'icon_zmzt_3',false)

self.desc:setText(content)
self:stopCloseTimer()

if time then
self.closeTimer=self:delayDo(time,function(...)
self:closeSelf()
end)
end
end


function UISMBaiShanEventWin:onHide()

end

function UISMBaiShanEventWin:stopCloseTimer()
if self.closeTimer then
self:stopTimerByID(self.closeTimer)
self.closeTimer=nil
end
end



function UISMBaiShanEventWin:onBg()
if self.clickBg then return end
self.clickBg=true
self.root:setChildDORotation(Vector3(-90,0,0),0.3,DG.Tweening.RotateMode.Fast)
local fadeTween=self.root:setChildCanvasGroupDOFade(0,0.2,function(...)
self:closeSelf()
end)
fadeTween:SetDelay(0.1)










end