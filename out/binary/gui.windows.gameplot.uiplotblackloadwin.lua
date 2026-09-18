







def_class("UIPlotBlackLoadWin",UIWindowBase)









function UIPlotBlackLoadWin:bindComponents()

self.blackImg=UIObject.get(self,0)



end


function UIPlotBlackLoadWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackImg);self.blackImg=nil;
end

















function UIPlotBlackLoadWin:onLoaded(...)
self:bindComponents()
end


function UIPlotBlackLoadWin:__delete()
self:unbindComponents()
end


function UIPlotBlackLoadWin:onHide()

end




function UIPlotBlackLoadWin:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
self.initFunc=argtable.initFunc
self:blackBegin()
end

function UIPlotBlackLoadWin:blackBegin()
self.blackImg:setChildCanvasGroupAlpha(0)
local func=function()
self:blackEnd()
end
self.blackImg:setChildCanvasGroupDOFade(1,plotActionController.plotBlackInTime,func)
end

function UIPlotBlackLoadWin:blackEnd()
if self.initFunc then
self.initFunc()
end
local func=function()
self:doFinish()
end
self:delayDo(plotActionController.plotBlackStayTime,func)
end

function UIPlotBlackLoadWin:doFinish()
local func=function()
self:blackFinish()
end
self.blackImg:setChildCanvasGroupDOFade(0,plotActionController.plotBlackOutTime,func)
end

function UIPlotBlackLoadWin:blackFinish()
local cb=self.callback
self:closeSelf()
if cb~=nil then
cb()
end
end