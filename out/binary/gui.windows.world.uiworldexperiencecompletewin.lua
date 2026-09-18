







def_class("UIWorldExperienceCompleteWin",UIWindowBase)









function UIWorldExperienceCompleteWin:bindComponents()

self.TextName=UIText.get(self,0)
self.ProgressBar0=UIProgress.get(self,1)
self.ProgressBar1=UIProgress.get(self,2)
self.ContentText=UIText.get(self,3)
self.UnlockText=UIText.get(self,4)
self.UnlockBg=UIObject.get(self,5)



end


function UIWorldExperienceCompleteWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.TextName);self.TextName=nil;
_UIObject_release(self.ProgressBar0);self.ProgressBar0=nil;
_UIObject_release(self.ProgressBar1);self.ProgressBar1=nil;
_UIObject_release(self.ContentText);self.ContentText=nil;
_UIObject_release(self.UnlockText);self.UnlockText=nil;
_UIObject_release(self.UnlockBg);self.UnlockBg=nil;
end



















function UIWorldExperienceCompleteWin:onLoaded(...)
self:bindComponents()
end


function UIWorldExperienceCompleteWin:__delete()
self:unbindComponents()
local cb=self.callback
if cb then cb()end
end




function UIWorldExperienceCompleteWin:onShow(argtable,afterOnloaded)

self.TextName:setText(argtable.name)
self.ProgressBar0:setProgressValue(argtable.newValue,100)
self.ProgressBar1:setProgressValue(argtable.oldValue,100)
self.ProgressBar1:setChildProgressText(FMT.fmt("+{0}%",argtable.newValue-argtable.oldValue))
self.ProgressBar1:setProgress(argtable.newValue,100)
self.ContentText:setText(argtable.tips)
self.UnlockText:setText(argtable.unlock and FMT.fmt("<color=#6B4131FF>解锁：</color>{0}系统",argtable.unlock)or"")
self.UnlockBg:setActive(argtable.unlock~=nil)
self.callback=argtable.callback
end


function UIWorldExperienceCompleteWin:onHide()

end



function UIWorldExperienceCompleteWin:onClickClose()
self:closeSelf()
end
