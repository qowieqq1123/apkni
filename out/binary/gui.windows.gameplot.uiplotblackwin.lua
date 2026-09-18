







def_class("UIPlotBlackWin",UIWindowBase)









function UIPlotBlackWin:bindComponents()

self.back=UIButton.get(self,0)

self.back:setButtonClick(function()self:onBack()end)



end


function UIPlotBlackWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
end

















function UIPlotBlackWin:onLoaded(...)
self:bindComponents()
self:setAsFirstSibling()
end


function UIPlotBlackWin:__delete()
self:unbindComponents()
end


function UIPlotBlackWin:onHide()

end




function UIPlotBlackWin:onShow(argtable,afterOnloaded)

local alpha=argtable.alpha or 0.8
self.back:setChildCanvasGroupAlpha(alpha)
end

function UIPlotBlackWin:onDelayClose(delay)
if delay~=nil and delay>0 then
if self.mDelayTimer~=nil then return end
local func=function()
self.mDelayTimer=nil
UIManager:hideWindow('UIPlotBlackWin')
end
self.mDelayTimer=self:setTimer(delay,1,func)
else
self:clearMyTimer()
UIManager:hideWindow('UIPlotBlackWin')
end
end

function UIPlotBlackWin:clearMyTimer()
if self.mDelayTimer~=nil then
self:stopTimerByID(self.mDelayTimer)
self.mDelayTimer=nil
end
end