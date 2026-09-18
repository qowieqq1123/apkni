







def_class("UIPlotActionWin",UIWindowBase)







local cshelper=CS.UIHelper

function UIPlotActionWin:auto_bind()
end















function UIPlotActionWin:onLoaded(...)

end


function UIPlotActionWin:__delete()

end


function UIPlotActionWin:onHide()

end




function UIPlotActionWin:onShow(argtable,afterOnloaded)
self.groupid=argtable.groupid
self.callback=argtable.callback
self.isFullOpen=argtable.isFullOpen

self.groupcfg=cfgHelper.get1(cfg_plotactiongroupconfig_get,self.groupid)

plotActionController:setReady(true)
end

function UIPlotActionWin:onBackClick()

end

function UIPlotActionWin:onFinish()
local cb=self.callback

local groupid=self.groupid
plotActionController:closeStage(groupid)

self:closeFullWin()

if cb~=nil then cb()end
end

function UIPlotActionWin:closeFullWin()
if self.isFullOpen then
fullScreenUI.closeActiveUI()
else
UIManager:closeWindow('UIPlotActionWin')
end
end