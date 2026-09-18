







def_class("UIAirMiniGame_finishAnimWin",UIWindowBase)









function UIAirMiniGame_finishAnimWin:bindComponents()

self.animRoot=UIObject.get(self,0)
self.animModel=UIObject.get(self,1)
self.root=UIObject.get(self,2)



end


function UIAirMiniGame_finishAnimWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.animRoot);self.animRoot=nil;
_UIObject_release(self.animModel);self.animModel=nil;
_UIObject_release(self.root);self.root=nil;
end















local _this




function UIAirMiniGame_finishAnimWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIAirMiniGame_finishAnimWin:__delete()
self:clearFadeTweener()
self:stopDelayTimer()
_this=nil
self:unbindComponents()
end




function UIAirMiniGame_finishAnimWin:onShow(argtable,afterOnloaded)
self.isVictory=argtable and argtable.resultFlag==1
self.callBackFunc=argtable and argtable.callback or nil
self.root:setChildCanvasGroupAlpha(0)

self:stopDelayTimer()
local func=function()
if not _this then return end
self:clearFadeTweener()
self.fadeTweener=self.root:setChildCanvasGroupDOFade(1,0.5,function()
if not _this then return end
return self:onStartPlayAnim()
end)
end
if self.isVictory then
self.delayTimer=self:delayDo(1,func)
else
return func()
end
end


function UIAirMiniGame_finishAnimWin:onHide()
self:clearFadeTweener()
self:stopDelayTimer()
end

function UIAirMiniGame_finishAnimWin:stopDelayTimer()
if self.delayTimer then
self:stopTimerByID(self.delayTimer)
self.delayTimer=nil
end
end

function UIAirMiniGame_finishAnimWin:clearFadeTweener()
if self.fadeTweener then
self.fadeTweener:Complete()
self.fadeTweener:Kill()
self.fadeTweener=nil
end
end



function UIAirMiniGame_finishAnimWin:onStartPlayAnim()
local modelId=self.isVictory and 5527 or 5528
local delayTime=self.isVictory and 2 or 1.5
self.animModel:setChildUIModelShowTarget(modelId,1,nil,2306)

self.animRoot:setChildCanvasGroupAlpha(1)
self.animRoot:setActive(true)

self:delayDo(delayTime,function()
if not _this then return end
return self.animRoot:setChildCanvasGroupDOFade(0,0.5,function()
if not _this then return end
return self:onAnimFinish()
end)
end)
end

function UIAirMiniGame_finishAnimWin:onAnimFinish()
if self.callBackFunc then
local func=self.callBackFunc
func()
end

self:closeSelf()
end
