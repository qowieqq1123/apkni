







def_class("UICommonVictoryWinJS",UIWindowBase)








function UICommonVictoryWinJS:bindComponents()

self.dragonBack=UIObject.get(self,0)
self.closeTips=UIButton.get(self,1)
self.btnRoot=UIObject.get(self,2)
self.fightCountBtn=UIButton.get(self,3)
self.fightRestartBtn=UIButton.get(self,4)
self.quitButton=UIButton.get(self,5)
self.continueButton=UIButton.get(self,6)
self.quitText=UIText.get(self,7)
self.continueText=UIText.get(self,8)

self.closeTips:setButtonClick(function()self:onCloseTips()end)

self.fightCountBtn:setButtonClick(function()self:onFightCountBtn()end)

self.fightRestartBtn:setButtonClick(function()self:onFightRestartBtn()end)

self.quitButton:setButtonClick(function()self:onQuitButton()end)

self.continueButton:setButtonClick(function()self:onContinueButton()end)



end


function UICommonVictoryWinJS:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dragonBack);self.dragonBack=nil;
_UIObject_release(self.closeTips);self.closeTips=nil;
_UIObject_release(self.btnRoot);self.btnRoot=nil;
_UIObject_release(self.fightCountBtn);self.fightCountBtn=nil;
_UIObject_release(self.fightRestartBtn);self.fightRestartBtn=nil;
_UIObject_release(self.quitButton);self.quitButton=nil;
_UIObject_release(self.continueButton);self.continueButton=nil;
_UIObject_release(self.quitText);self.quitText=nil;
_UIObject_release(self.continueText);self.continueText=nil;
end
































local continuDefaultName='继续'
local quitDefaultName='关 闭'


function UICommonVictoryWinJS:onLoaded(...)
self:bindComponents()
end


function UICommonVictoryWinJS:__delete()
self:unbindComponents()
self:closeExtra()
tipsManager.closeTips()
end


function UICommonVictoryWinJS:onHide()

end




function UICommonVictoryWinJS:onShow(argtable,afterOnloaded)
self:closeExtra()
self.cd=0
self.extraWin=argtable.extraWin
self.extraParams=argtable.extraParams
self.extraParams.parentWin='UICommonVictoryWinJS'
self.fightData=argtable.fightData
self.logPackage=argtable.logPackage
self.restartCallback=argtable.restartCallback

self.battleId=self.extraParams.battleId
self.resultType=self.extraParams.resultType
self.battleType=self.extraParams.battleType
self.param=argtable.param

self:showWindow(self.extraWin,self.extraParams)

self.callback=argtable.callback


local btnsInfo=argtable.btnsInfo
local haveBtns=btnsInfo~=nil
self.btnRoot:setActive(haveBtns)
self.closeTips:setActive(not haveBtns)
if haveBtns then
self.continuCallBack=btnsInfo.continuCallBack
self.quitCallBack=btnsInfo.quitCallBack
local hideQuitBtn=btnsInfo.hidequitbtn
self.quitButton:setActive(hideQuitBtn~=true)
local hideContinue=btnsInfo.hideContinue==true
self.continueButton:setActive(not hideContinue)
if not hideContinue then
self.continueBtnName=btnsInfo.continueBtnName or continuDefaultName
if btnsInfo.cd then
local times=btnsInfo.cd
self.continueText:setText(FMT.fmt("{0}({1})",self.continueBtnName,times))
self:startContinue(times)
else
self.continueText:setText(self.continueBtnName)
end
end
local quitBtnName=btnsInfo.quitBtnName or quitDefaultName
self.quitText:setText(quitBtnName)
end


if self.battleId then
self.fightCountBtn:setActive(self.fightData~=nil)
self.fightRestartBtn:setActive(self.fightData~=nil)
end

if argtable.isHideFightBtn then
self.fightCountBtn:setActive(false)
self.fightRestartBtn:setActive(false)
end

if self.resultType and self.resultType==eShowResultType.qiecuo then
DiZiDuelModel:setbattlelog(self.logPackage.logStr)
end
end

function UICommonVictoryWinJS:closeExtra()
if self.extraWin~=nil then
self:closeWindow(self.extraWin)
self.extraWin=nil
self.extraParams=nil
end
end

function UICommonVictoryWinJS:startContinue(time)
if time then
self.cd=time
end
if self.cd then
self.continueTimer=self:setTimer(1,self.cd,function()
self.cd=self.cd-1
self.continueText:setText(FMT.fmt("{0}({1})",self.continueBtnName or continuDefaultName,self.cd))
if self.cd<=0 then
self:onContinueButton(true)
end
end)
end
end

function UICommonVictoryWinJS:reStartContinue()
if self.continueTimer then
self:startContinue()
end
end

function UICommonVictoryWinJS:onCloseTips()
local cb=self.callback

self:closeSelf()
if cb then cb()end
return true
end

function UICommonVictoryWinJS:onQuitButton()
local cb=self.quitCallBack

self:closeSelf()
if cb then cb()end
end

function UICommonVictoryWinJS:onContinueButton(outtime)
local cb=self.continuCallBack

self:closeSelf()
if cb then cb(outtime)end
end

function UICommonVictoryWinJS:onFightCountBtn()
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
table.insert(resList,res)
end
local fightData=resList
self.fightData=fightData
local battleType=self.battleType
UIManager:showWindow('UIFightCountWin',{fightData=fightData,battleId=battleID,battleType=battleType})
end)
end
else
if self.continueTimer then
self:stopTimerByID(self.continueTimer)
end
UIManager:showWindow('UIFightCountWin',{fightData=self.fightData,battleId=self.battleId,battleType=self.battleType})
end
end

function UICommonVictoryWinJS:onFightRestartBtn()
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
if handle then
local battle=fightModel:getBattle(battleID)
local useComplete=battle==nil or(battle and not battle.isRestart)

if useComplete and handle.onCompleteBattle then
handle.onCompleteBattle(battleID,fightResultType.Victory,param,showWindow,false)
end

local callback=function()
if handle.onResultComplete then
handle.onResultComplete(battleID,fightResultType.Victory,param)
end

notifySystem:postNotify(notifyConfig.onBattleResultComplete,battleType,fightResultType.Victory,battleID)
end

fightResultController:startResult({handle.resultType,battleType,fightResultType.Victory,battleID,
logPackage,callback,param,showWindow,stageCfg})
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

