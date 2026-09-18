







def_class("UIPackageLoadProgressWin",UIWindowBase)









function UIPackageLoadProgressWin:bindComponents()

self.precent=UIText.get(self,0)
self.progress=UIProgressBarAni.get(self,1)



end


function UIPackageLoadProgressWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.precent);self.precent=nil;
_UIObject_release(self.progress);self.progress=nil;
end



















function UIPackageLoadProgressWin:onLoaded(...)
self:bindComponents()
end


function UIPackageLoadProgressWin:__delete()
self:unbindComponents()
end




function UIPackageLoadProgressWin:onShow(argtable,afterOnloaded)
local fileGroupid=argtable.fileGroupid
self.fileGroupid=fileGroupid
local progress=argtable.progress or 0
local value=math.floor(100*progress)
self.progress:animateThreeParams(value,100,0.2)
self.precent:setText(FMT.fmt('{0}%',math.floor(progress*100)))
end


function UIPackageLoadProgressWin:onHide()

end





function UIPackageLoadProgressWin:onBtn()
UIManager:showWindow('UIFileDownDoadDialogueWin',self.UIFileDownDoadDialogueWin)
end

function UIPackageLoadProgressWin:refreshProgress(fileGroupid,progress)
if self.fileGroupid~=fileGroupid then return end
local value=math.floor(100*progress)
self.progress:animateThreeParams(value,100,0.2)
self.precent:setText(FMT.fmt('{0}%',math.floor(progress*100)))
end

