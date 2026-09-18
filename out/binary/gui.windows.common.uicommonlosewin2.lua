







def_class("UICommonLoseWin2",UIWindowBase)









function UICommonLoseWin2:bindComponents()

self.dragonBack=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.fightCountBtn=UIButton.get(self,2)
self.fightRestartBtn=UIButton.get(self,3)
self.closeTips=UIButton.get(self,4)
self.quitButton=UIButton.get(self,5)
self.quitText=UIText.get(self,6)

self.fightCountBtn:setButtonClick(function()self:onFightCountBtn()end)

self.fightRestartBtn:setButtonClick(function()self:onFightRestartBtn()end)

self.closeTips:setButtonClick(function()self:onCloseTips()end)

self.quitButton:setButtonClick(function()self:onQuitButton()end)



end


function UICommonLoseWin2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dragonBack);self.dragonBack=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.fightCountBtn);self.fightCountBtn=nil;
_UIObject_release(self.fightRestartBtn);self.fightRestartBtn=nil;
_UIObject_release(self.closeTips);self.closeTips=nil;
_UIObject_release(self.quitButton);self.quitButton=nil;
_UIObject_release(self.quitText);self.quitText=nil;
end

















local quitDefaultName='退 出'
local _this=nil


function UICommonLoseWin2:onLoaded(...)
_this=self
self:bindComponents()
end


function UICommonLoseWin2:__delete()
_this=nil
self:stopCloseTimer()
self:unbindComponents()
self:closeExtra()
end




function UICommonLoseWin2:onShow(argtable,afterOnloaded)
self:closeExtra()
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.4,nil)
end
self:delayDo(0.4,func)
end
self.dragonBack:setChildUIModelShowTarget(2035,1,{},eAnimationID.common_window_enter)

self.extraWin=argtable.extraWin
self.fightData=argtable.fightData

self.extraParams=argtable.extraParams or{}
self.extraParams.fightData=self.fightData
self.extraParams.parentWin='UICommonLoseWin2'
self.battleType=self.extraParams.battleType
self.battleId=self.extraParams.battleId
self.resultType=self.extraParams.resultType

self.param=argtable.param
self.logPackage=argtable.logPackage
if self.extraWin~=nil then
self:showWindow(self.extraWin,self.extraParams)
end

self.callback=argtable.callback


local btnsInfo=argtable.btnsInfo
self.quitCallBack=btnsInfo~=nil and btnsInfo.quitCallBack or nil
local haveBtns=btnsInfo~=nil and btnsInfo.quitCallBack~=nil
self.quitButton:setActive(haveBtns)
self.closeTips:setActive(not haveBtns)
if haveBtns then
local quitBtnName=btnsInfo.quitBtnName or quitDefaultName
self.quitText:setText(quitBtnName)
end

if self.battleId then
self.fightCountBtn:setActive(self.fightData~=nil)
self.fightRestartBtn:setActive(self.fightData~=nil)
end

if not haveBtns then
self.closeTimer=self:delayDo(1.5,function(...)
self.canClose=true
end)
end
end


function UICommonLoseWin2:onHide()

end

function UICommonLoseWin2:closeExtra()
if self.extraWin~=nil then
UIManager:closeWindow(self.extraWin)
self.extraWin=nil
self.extraParams=nil
end
end

function UICommonLoseWin2:stopCloseTimer()
if self.closeTimer then
self:stopTimerByID(self.closeTimer)
self.closeTimer=nil
end
end

function UICommonLoseWin2:setCloudClose()
self.isCloudClose=true
end


function UICommonLoseWin2:onCloseTips()
if not self.canClose then return false end
if self.isCloudClose then
local func=function()
if _this==nil then return end
_this:onCloseTipsEx()
end
loadingControl.openCloud(func)
else
self:onCloseTipsEx()
end
return true
end

function UICommonLoseWin2:onCloseTipsEx()
local cb=self.callback
self:closeSelf()

if cb then cb()end
end

function UICommonLoseWin2:onQuitButton()
local cb=self.quitCallBack
self:closeSelf()

if cb then cb()end
end

function UICommonLoseWin2:onFightCountBtn()
if self.isWait then
return
end
if not self.fightData then
local log=self.logPackage.logStr
local battleID=fightController:startBallte(log,false,nil,nil,{})
local battle=fightModel:getBattle(battleID)
if battle then
battle:onSkipAll()
self.isWait=true
self:delayDo(2,function()
self.isWait=false
local resList={}
local list=battle:getStatisticsList()
for i,v in ipairs(list)do
local res=v.statistics
local round=v.round
local maxRound=v.maxRound
res.round=round
res.maxRound=maxRound
local leftId=battle:getLeftActorId()
local rightId=battle:getRightActorId()
res.leftId=leftId
res.rightId=rightId
table.insert(resList,res)
end
local fightData=resList
self.fightData=fightData
local battleType=self.battleType
UIManager:showWindow('UIFightCountWin',{fightData=fightData,battleId=battleID,battleType=battleType})
end)
end
else
UIManager:showWindow('UIFightCountWin',{fightData=self.fightData,battleId=self.battleId,battleType=self.battleType})
end
end

function UICommonLoseWin2:onFightRestartBtn()
if self.isWait then
return
end
if not self.battleId then
local handle=fightBattleHandle:getHandle(self.battleType)

self:delayDo(2,function()
self.isWait=false
end)
local battleType=self.battleType
local log=self.logPackage.logStr
local logPackage=self.logPackage
local param=self.param
local battleID=fightController:startBallte(log,true,function(battleID,showWindow,stageCfg)



















local record=fightResultModel:getRecord()
if record then
record.battleId=battleID
record.fightData=fightResultModel:calculateFightData(battleID)
fightResultController:reShowResult()
end
end,nil,{hideExitWatch=true})
self:closeSelf()

else
local nowTime=timeHelper.getServerShortTime()
if self.lastTime then
if nowTime<self.lastTime+5 then
return
end
self.lastTime=nowTime
else
self.lastTime=nowTime
end
if self.battleId then
local battleId=self.battleId
local battle=fightModel:getBattle(battleId)
if battle then
battle.fightIndex=0
battle:restart()
self:closeSelf()

end
end
end
end