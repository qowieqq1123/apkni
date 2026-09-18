







def_class("UIReportDisplayWin",UIWindowBase)









function UIReportDisplayWin:bindComponents()

self.background=UIButton.get(self,0)
self.display=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIReportDisplayWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.display);self.display=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end















local _this=nil



function UIReportDisplayWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIReportDisplayWin:__delete()
self:hideReport()
self:unbindComponents()
_this=nil
end




function UIReportDisplayWin:onShow(argtable,afterOnloaded)
self.reportId=argtable.reportId
self.stageId=argtable.stageId
self.position=argtable.position
self.size=argtable.size
if self.position then
self.display:setChildAnchoredPos(self.position[1],self.position[2])
end
if self.size then
self.display:setChildSizeDelta(self.size[1],self.size[2])
end
self:showReport()
end


function UIReportDisplayWin:onHide()

end





function UIReportDisplayWin:onCloseBtn()
self:closeSelf()
end

function UIReportDisplayWin:onBackground()

end

function UIReportDisplayWin:showReport()
if not self._onFightStageLoaded then
self._onFightStageLoaded=function()
local report=fightModel:getFightReport(self.reportId)
self.battleId=fightController:startBallte(report,true,nil,nil,{hideStartWin=true,repeatPlayRound=true,entHideHud=true,resetCamera=true,fightUseType=FIGHT_USE_TYPE.eYanShi})
local sizeDeltaX=self.display:getChildSizeDeltaX()
local sizeDeltaY=self.display:getChildSizeDeltaY()
self.winlua:SetChildFightRenderToImage(self.display:getID(),true,sizeDeltaX,sizeDeltaY)
self.display:setActive(true)
end
end

self.fightStage=fightStage:create(self.stageId,self._onFightStageLoaded,{})
end

function UIReportDisplayWin:hideReport()
if self.battleId then
fightController:completeBattle(self.battleId,true)
fightController:closeBattle(self.battleId)
self.battleId=nil
end

if self.fightStage then
self.fightStage:close()
end

self.winlua:SetChildFightRenderToImage(self.display:getID(),false,0,0)
end