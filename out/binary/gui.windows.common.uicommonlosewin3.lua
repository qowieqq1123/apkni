







def_class("UICommonLoseWin3",UIWindowBase)









function UICommonLoseWin3:bindComponents()

self.root=UIObject.get(self,0)
self.fightCountBtn=UIButton.get(self,1)
self.fightRestartBtn=UIButton.get(self,2)
self.finalHpPanel=UIObject.get(self,3)
self.closeTips=UIButton.get(self,4)
self.finalHpProgress=UIProgress.get(self,5)

self.fightCountBtn:setButtonClick(function()self:onFightCountBtn()end)

self.fightRestartBtn:setButtonClick(function()self:onFightRestartBtn()end)

self.closeTips:setButtonClick(function()self:onCloseTips()end)



end


function UICommonLoseWin3:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.fightCountBtn);self.fightCountBtn=nil;
_UIObject_release(self.fightRestartBtn);self.fightRestartBtn=nil;
_UIObject_release(self.finalHpPanel);self.finalHpPanel=nil;
_UIObject_release(self.closeTips);self.closeTips=nil;
_UIObject_release(self.finalHpProgress);self.finalHpProgress=nil;
end

















function UICommonLoseWin3:onLoaded(...)
self:bindComponents()
end


function UICommonLoseWin3:__delete()
self:stopCloseTimer()
self:unbindComponents()
self:closeExtra()
end




function UICommonLoseWin3:onShow(argtable,afterOnloaded)
self:closeExtra()
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.4,nil)
end
self:delayDo(0.4,func)
end

self.extraWin=argtable.extraWin
self.fightData=argtable.fightData

self.extraParams=argtable.extraParams or{}
self.battleId=self.extraParams.battleId

self.extraParams.fightData=self.fightData
self.extraParams.parentWin=self
self.battleType=self.extraParams.battleType
self.param=argtable.param
self.logPackage=argtable.logPackage
if self.extraWin~=nil then
self:showWindow(self.extraWin,self.extraParams)
end

self.callback=argtable.callback


local btnsInfo=argtable.btnsInfo
self.quitCallBack=btnsInfo~=nil and btnsInfo.quitCallBack or nil
self.continuCallBack=btnsInfo~=nil and btnsInfo.continuCallBack or nil


if self.battleId then
self.fightCountBtn:setActive(self.fightData~=nil)
self.fightRestartBtn:setActive(self.fightData~=nil)
end

if argtable.isHideFightBtn then
self.fightCountBtn:setActive(false)
self.fightRestartBtn:setActive(false)
end
self.canClose=nil


self.closeTimer=self:delayDo(1.5,function(...)
self.canClose=true
end)


local battle=fightModel:getBattle(self.battleId)
if battle then
local curValue=battle:getRightTeamShield()
local maxValue=battle:getRightTeamShieldMax()
local percent=maxValue>0 and math.ceil(curValue/maxValue*10000)/100 or 0

self.finalHpPanel:setChildCanvasGroupAlpha(0)
self.finalHpPanel:setActive(true)
local progressStr=FMT.fmt("{0}%",percent)
self.finalHpProgress:setProgressValue(percent*100,10000)
self.finalHpProgress:setChildProgressText(progressStr)

local func=function()
self.finalHpPanel:setChildCanvasGroupDOFade(1,0.5,nil)
end
self:delayDo(1.2,func)
else
self.finalHpPanel:setActive(false)
end

end

function UICommonLoseWin3:closeExtra()
if self.extraWin~=nil then
UIManager:closeWindow(self.extraWin)
self.extraWin=nil
self.extraParams=nil
end
end

function UICommonLoseWin3:onCloseTips()
if not self.canClose then return false end
local cb=self.callback
self:closeSelf()

if cb then cb()end
return true
end

function UICommonLoseWin3:onQuitButton()
if self==nil or self.isClose then return end
local cb=self.quitCallBack
self:closeSelf()
if cb then cb()end
end

function UICommonLoseWin3:onContinueButton()
if self==nil or self.isClose then return end
local cb=self.continuCallBack
self:closeSelf()

if cb then cb()end
end

function UICommonLoseWin3:onFightCountBtn()
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
UIManager:showWindow('UIFightCountWin',{fightData=self.fightData,battleId=self.battleId,battleType=self.battleType})
end
end



function UICommonLoseWin3:stopCloseTimer()
if self.closeTimer then
self:stopTimerByID(self.closeTimer)
self.closeTimer=nil
end
end
function UICommonLoseWin3:onFightRestartBtn()
if self.isWait then
return
end
if not self.battleId then

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
