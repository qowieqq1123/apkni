







def_class("UIReportDisplayFrameWin",UIWindowBase)









function UIReportDisplayFrameWin:bindComponents()

self.background=UIButton.get(self,0)
self.display=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIReportDisplayFrameWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.display);self.display=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end















local _this=nil



function UIReportDisplayFrameWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIReportDisplayFrameWin:__delete()
comHelper.setChildFightReportClose(self.winlua,self.display:getID(),self.reportBattle,self.reportStage)
self:unbindComponents()
_this=nil
end




function UIReportDisplayFrameWin:onShow(argtable,afterOnloaded)
self:closeExtra()

self.baseParams=argtable.baseParams
self.reportStage=comHelper.setChildFightReportStart(self.winlua,self.display:getID(),self.baseParams.reportId,self.baseParams.stageId,function(battleId)
self.reportBattle=battleId
self.fightBattle=fightModel:getBattle(battleId)
self.fightBattle:setAccMulti(1,false)
end)
self.display:setChildCanvasGroupDOFade(1,2)

self.extraWin=argtable.extraWin
if self.extraWin then
self.extraParams=argtable.extraParams
self.extraParams.parentWin=self
self:showWindow(self.extraWin,self.extraParams)
end
end


function UIReportDisplayFrameWin:onHide()

end





function UIReportDisplayFrameWin:onBackground()
self:onCloseBtn()
end



function UIReportDisplayFrameWin:onCloseBtn()
self:closeExtra()
self:closeSelf()
end

function UIReportDisplayFrameWin:closeExtra()
if self.extraWin~=nil then
self:closeWindow(self.extraWin)
self.extraWin=nil
self.extraParams=nil
end
end