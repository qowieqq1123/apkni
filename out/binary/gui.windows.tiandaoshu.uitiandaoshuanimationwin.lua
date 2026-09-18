







def_class("UITianDaoShuAnimationWin",UIWindowBase)









function UITianDaoShuAnimationWin:bindComponents()

self.background=UIButton.get(self,0)
self.doBtn=UIButton.get(self,1)

self.background:setButtonClick(function()self:onBackground()end)

self.doBtn:setButtonClick(function()self:onDoBtn()end)



end


function UITianDaoShuAnimationWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.doBtn);self.doBtn=nil;
end



















function UITianDaoShuAnimationWin:onLoaded(...)
self:bindComponents()
end


function UITianDaoShuAnimationWin:__delete()
self:unbindComponents()
end




function UITianDaoShuAnimationWin:onShow(argtable,afterOnloaded)
self.doFunc=argtable.doFunc
self.closeFunc=argtable.closeFunc
self:doAnimation()
end


function UITianDaoShuAnimationWin:onHide()

end




function UITianDaoShuAnimationWin:onDoBtn()
if self.animation then return end
if self.doFunc then
self.doFunc()
end

end

function UITianDaoShuAnimationWin:onBackground()
if self.animation then return end
if self.closeFunc then
self.closeFunc()
end
self:closeSelf()
end

function UITianDaoShuAnimationWin:doAnimation()
local height=self.background:getChildRectHeight()
local sizeY=self.doBtn:getChildSizeDeltaY()
self.animation=self.doBtn:setChildDOAnchorPosY(-height/2+sizeY/2,1,function()
self.animation=nil
end)
end