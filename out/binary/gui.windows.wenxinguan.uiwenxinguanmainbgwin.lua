







def_class("UIWenXinGuanMainBgWin",UIWindowBase)









function UIWenXinGuanMainBgWin:bindComponents()

self.bg=UIObject.get(self,0)
self.Root=UIObject.get(self,1)



end


function UIWenXinGuanMainBgWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.Root);self.Root=nil;
end



















function UIWenXinGuanMainBgWin:onLoaded(...)
self:bindComponents()
end


function UIWenXinGuanMainBgWin:__delete()
self:unbindComponents()
end




function UIWenXinGuanMainBgWin:onShow(argtable,afterOnloaded)
self:showBgModel()
self:setRotateBackground(argtable)
end


function UIWenXinGuanMainBgWin:onHide()

end

function UIWenXinGuanMainBgWin:onDoFade()
local tweener=self.Root:setChildCanvasGroupDOFade(1,1)
tweener:SetEase(DG.Tweening.Ease.Linear)
end

function UIWenXinGuanMainBgWin:showBgModel()
local animId=eAnimationID.stand
local cb=function()
self:onDoFade()
UIManager:invokeUIMethod("UIWenXinGuanEnterWin","loopStandAnim")
UIManager:invokeUIMethod("UIWenXinGuanEnterBgWin","doFade",1,0.5)
UIManager:invokeUIMethod("UIWenXinGuanEnterWin","onDoFadeImg",1,0.5)
UIManager:invokeUIMethod("UIWenXinGuanTopWin","onDoFade",1,0.5)
end
self.bg:setChildUIModelShowTarget(5547,1,{},animId,true,false,0,cb)
end

function UIWenXinGuanMainBgWin:setRotateBackground(argtable)
local rate=0
if argtable>=6 then
rate=5
end

self.bg:setChildDORotation(Vector3(0,0,rate),0,DG.Tweening.RotateMode.Fast)
end

function UIWenXinGuanMainBgWin:doRotateBackground(rate,callback)
self.bg:setChildDORotation(Vector3(0,0,rate),2.5,DG.Tweening.RotateMode.Fast,callback)
end

function UIWenXinGuanMainBgWin:onSetSpeedBackground(speed)
self.winlua:SetChildUIModelAnimationSpeed(self.bg:getID(),speed)
end

function UIWenXinGuanMainBgWin:closeWindow()
self:closeSelf()
end



