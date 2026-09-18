







def_class("UIMoJieZhenTaiFinishWin",UIWindowBase)









function UIMoJieZhenTaiFinishWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.effect=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.spine=UIObject.get(self,4)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIMoJieZhenTaiFinishWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.spine);self.spine=nil;
end



















function UIMoJieZhenTaiFinishWin:onLoaded(...)
self:bindComponents()
end


function UIMoJieZhenTaiFinishWin:__delete()
self:unbindComponents()
end




function UIMoJieZhenTaiFinishWin:onShow(argtable,afterOnloaded)
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6)
self:delayDo(0.2,function()
self.effect:setChildShowEffect(22692,true)
end)
end

xianjieModel:setZhenTaiFinishFlag(argtable.seasonType,argtable.stageIndex)
end


function UIMoJieZhenTaiFinishWin:onHide()

end



function UIMoJieZhenTaiFinishWin:onBackground()
self:closeSelf()
end

function UIMoJieZhenTaiFinishWin:onCloseBtn()
self:closeSelf()
end

