







def_class("UICommonVictoryWinGain",UIWindowBase)









function UICommonVictoryWinGain:bindComponents()

self.closeTips=UIButton.get(self,0)
self.closeTips2=UIButton.get(self,1)
self.fightCountBtn=UIButton.get(self,2)
self.fightRestartBtn=UIButton.get(self,3)

self.closeTips:setButtonClick(function()self:onCloseTips()end)

self.closeTips2:setButtonClick(function()self:onCloseTips2()end)

self.fightCountBtn:setButtonClick(function()self:onFightCountBtn()end)

self.fightRestartBtn:setButtonClick(function()self:onFightRestartBtn()end)



end


function UICommonVictoryWinGain:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeTips);self.closeTips=nil;
_UIObject_release(self.closeTips2);self.closeTips2=nil;
_UIObject_release(self.fightCountBtn);self.fightCountBtn=nil;
_UIObject_release(self.fightRestartBtn);self.fightRestartBtn=nil;
end
























local _this=nil




function UICommonVictoryWinGain:onLoaded(...)
_this=self
self:bindComponents()
end


function UICommonVictoryWinGain:__delete()
_this=nil
self:unbindComponents()
self:closeExtra()
tipsManager.closeTips()
end




function UICommonVictoryWinGain:onShow(argtable,afterOnloaded)
self:closeExtra()
self.cd=0
self.mLockTime=nil
self.extraWin=argtable.extraWin
self.extraParams=argtable.extraParams
self.extraParams.parentWin='UICommonVictoryWinGain'
self.fightData=argtable.fightData
self.logPackage=argtable.logPackage
self.restartCallback=argtable.restartCallback
self.noShowCloseTip=argtable.noShowCloseTip and 1 or 0

self.battleId=self.extraParams.battleId
self.resultType=self.extraParams.resultType
self.battleType=self.extraParams.battleType
self.param=argtable.param
if self.extraWin then
self:showWindow(self.extraWin,self.extraParams)
end

self.callback=argtable.callback


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


if MysteryGuildOrder:isInAuto()then
self:delayDo(3,function()
if self==nil or self.isClose then return end
self:onCloseTips()
end)
end


local activityData=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eCloudCityTreasure)
if activityData then
local sub_actInfo=activityData[1]
if sub_actInfo then
if sub_actInfo:isfrightAuto()then
self:delayDo(3,function()
if self==nil or self.isClose then return end
self:onCloseTips()
end)
end
end
end


local issfpy=SiFangPingYaoModel:getfightresult()
if issfpy and issfpy~=0 then
self.closeTips2:setActive(true)
end
end


function UICommonVictoryWinGain:onHide()

end

function UICommonVictoryWinGain:setLockTime(time)
self.mLockTime=Time.realtimeSinceStartup+time

end

function UICommonVictoryWinGain:checkLockTime()
if self.mLockTime and Time.realtimeSinceStartup<self.mLockTime then
return false
end
return true
end

function UICommonVictoryWinGain:closeExtra()
if self.extraWin~=nil then
UIManager:closeWindow(self.extraWin)
self.extraWin=nil
self.extraParams=nil
end
end

function UICommonVictoryWinGain:onCloseTipsEx()
local cb=self.callback

self:closeSelf()
if cb then cb()end
end




function UICommonVictoryWinGain:onCloseTips()
if self==nil or self.isClose then return end
if not self:checkLockTime()then
return false
end
if self.isCloudClose then
local func=function()
if _this==nil or _this.isClose then return end
_this:onCloseTipsEx()
end
loadingControl.openCloud(func)
else
self:onCloseTipsEx()
end
return true
end


function UICommonVictoryWinGain:onCloseTips2()
local func=function()
if _this==nil then return end
_this:onCloseTipsEx()
end
loadingControl.openCloud(func,nil,true)
end


function UICommonVictoryWinGain:onFightCountBtn()
if self.isWait then
return
end
if not self:checkLockTime()then
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


function UICommonVictoryWinGain:onFightRestartBtn()
if self.isWait then
return
end
if not self:checkLockTime()then
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

