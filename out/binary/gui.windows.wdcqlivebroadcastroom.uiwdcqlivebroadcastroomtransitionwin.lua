







def_class("UIWDCQLiveBroadcastRoomTransitionWin",UIWindowBase)









function UIWDCQLiveBroadcastRoomTransitionWin:bindComponents()

self.transition=UIObject.get(self,0)



end


function UIWDCQLiveBroadcastRoomTransitionWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.transition);self.transition=nil;
end















local _this=nil
local _duration=0.15



function UIWDCQLiveBroadcastRoomTransitionWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIWDCQLiveBroadcastRoomTransitionWin:__delete()
self:unbindComponents()
_this=nil
end




function UIWDCQLiveBroadcastRoomTransitionWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc
self.enterFunc=argtable.enterFunc
self.exitFunc=argtable.exitFunc
self.overTime=argtable.overTime
self.overFunc=argtable.overFunc
self.overTips=argtable.overTips
self.checkFunc=argtable.checkFunc
self:enterView()
end


function UIWDCQLiveBroadcastRoomTransitionWin:onHide()

end



function UIWDCQLiveBroadcastRoomTransitionWin:doCloseWin()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
elseif self.closeFunc then
self.closeFunc()
else
self:closeSelf()
end
end

function UIWDCQLiveBroadcastRoomTransitionWin:enterView()
self.transition:setChildCanvasGroupDOFade(1,_duration,function()
if self.enterFunc then
self.enterFunc()
end
self:startCDTick()
end)
end

function UIWDCQLiveBroadcastRoomTransitionWin:exitView()
self:stopCDTick()
self.transition:setChildCanvasGroupDOFade(0,_duration,function()
if self.exitFunc then
self.exitFunc()
end
self:doCloseWin()
end)
end

function UIWDCQLiveBroadcastRoomTransitionWin:overHanlde()
self:stopCDTick()
self.transition:setChildCanvasGroupDOFade(0,_duration,function()
if self.overFunc then
self.overFunc()
end
if self.overTips then
UIManager.error(self.overTips)
end
self:doCloseWin()
end)
end

function UIWDCQLiveBroadcastRoomTransitionWin:startCDTick()
if self.cdTick==nil then
self.since=timeHelper.getServerShortTime()
self.cdTick=self:setTimer(0.1,0,function()
self:updateCDTick()
end)
end
end

function UIWDCQLiveBroadcastRoomTransitionWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
self.since=nil
end
end

function UIWDCQLiveBroadcastRoomTransitionWin:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
if self.since+self.overTime<nowTime then
self:overHanlde()
return
end
if self.checkFunc()then
self:exitView()
return
end
end