







def_class("UICommonVictoryWin",UIWindowBase)









function UICommonVictoryWin:bindComponents()

self.btnRoot=UIObject.get(self,0)
self.closeTips=UIButton.get(self,1)
self.closeTips2=UIButton.get(self,2)
self.closeTipTxt=UIText.get(self,3)
self.continueButton=UIButton.get(self,4)
self.continueDescText=UIText.get(self,5)
self.continueText=UIText.get(self,6)
self.dragonBack=UIObject.get(self,7)
self.fightCountBtn=UIButton.get(self,8)
self.fightRestartBtn=UIButton.get(self,9)
self.quitButton=UIButton.get(self,10)
self.quitText=UIText.get(self,11)

self.closeTips:setButtonClick(function()self:onCloseTips()end)

self.closeTips2:setButtonClick(function()self:onCloseTips2()end)

self.continueButton:setButtonClick(function()self:onContinueButton()end)

self.fightCountBtn:setButtonClick(function()self:onFightCountBtn()end)

self.fightRestartBtn:setButtonClick(function()self:onFightRestartBtn()end)

self.quitButton:setButtonClick(function()self:onQuitButton()end)



end


function UICommonVictoryWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnRoot);self.btnRoot=nil;
_UIObject_release(self.closeTips);self.closeTips=nil;
_UIObject_release(self.closeTips2);self.closeTips2=nil;
_UIObject_release(self.closeTipTxt);self.closeTipTxt=nil;
_UIObject_release(self.continueButton);self.continueButton=nil;
_UIObject_release(self.continueDescText);self.continueDescText=nil;
_UIObject_release(self.continueText);self.continueText=nil;
_UIObject_release(self.dragonBack);self.dragonBack=nil;
_UIObject_release(self.fightCountBtn);self.fightCountBtn=nil;
_UIObject_release(self.fightRestartBtn);self.fightRestartBtn=nil;
_UIObject_release(self.quitButton);self.quitButton=nil;
_UIObject_release(self.quitText);self.quitText=nil;
end
































local continuDefaultName='继续'
local quitDefaultName='关 闭'
local _this=nil


function UICommonVictoryWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UICommonVictoryWin:__delete()
_this=nil
self:unbindComponents()
self:closeExtra()
tipsManager.closeTips()
end


function UICommonVictoryWin:onHide()

end




function UICommonVictoryWin:onShow(argtable,afterOnloaded)
self:closeExtra()
self.cd=0
self.mLockTime=nil
self.extraWin=argtable.extraWin
self.extraParams=argtable.extraParams
self.extraParams.parentWin='UICommonVictoryWin'
self.fightData=argtable.fightData
self.logPackage=argtable.logPackage
self.restartCallback=argtable.restartCallback
self.noShowCloseTip=0
if argtable.argtableEx then
self.noShowCloseTip=argtable.argtableEx.noShowCloseTip and 1 or 0
self.closeTipPos=argtable.argtableEx.closeTipPos
end

self.battleId=self.extraParams.battleId
self.resultType=self.extraParams.resultType
self.battleType=self.extraParams.battleType
self.param=argtable.param
if self.extraWin then
self:showWindow(self.extraWin,self.extraParams)
end

if self.battleType==eBattleType.qiecuo then

local headdata=self.extraParams.headdata_param
if headdata then
self.isShareFight=true
if headdata[9]then
self.isShareFight=false
end
end
end

self.callback=argtable.callback
self.isDisableCd=nil

if self.closeTipPos then
self.closeTipTxt:setChildAnchoredPos(self.closeTipPos[1],self.closeTipPos[2])
end


local btnsInfo=argtable.btnsInfo
local haveBtns=btnsInfo~=nil
self.btnRoot:setActive(haveBtns)
self.closeTips:setActive(not haveBtns and self.noShowCloseTip==0)
if haveBtns then
self.delayClose=btnsInfo.delayClose
self.continuCallBack=btnsInfo.continuCallBack
self.quitCallBack=btnsInfo.quitCallBack
local hideQuitBtn=btnsInfo.hidequitbtn
self.quitButton:setActive(hideQuitBtn~=true)
local hideContinue=btnsInfo.hideContinue==true
self.continueButton:setActive(not hideContinue)
if not hideContinue then
self.continueBtnName=btnsInfo.continueBtnName or continuDefaultName
if btnsInfo.cd or btnsInfo.disableCd then
local times=btnsInfo.cd or btnsInfo.disableCd
local isDisableCd=false
if btnsInfo.disableCd then
isDisableCd=true
end
self.continueText:setText(FMT.fmt("{0}({1})",self.continueBtnName,times))
self:startContinue(times,isDisableCd)
else
self.continueText:setText(self.continueBtnName)
end
self.continueDescText:setText(btnsInfo.continueBtnDesc or'')
if not self.isDisableCd then
self.continueButton:setGray(false)
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

function UICommonVictoryWin:setLockTime(time)
self.mLockTime=Time.realtimeSinceStartup+time

end

function UICommonVictoryWin:checkLockTime()
if self.mLockTime and Time.realtimeSinceStartup<self.mLockTime then
return false
end
return true
end

function UICommonVictoryWin:closeExtra()
if self.extraWin~=nil then
UIManager:closeWindow(self.extraWin)
self.extraWin=nil
self.extraParams=nil
end
end

function UICommonVictoryWin:startContinue(time,isDisableCd)
if time then
self.cd=time
self.isDisableCd=isDisableCd
end
if self.cd then
self.continueTimer=self:setTimer(1,self.cd,function()
self.cd=self.cd-1
self.continueText:setText(FMT.fmt("{0}({1})",self.continueBtnName or continuDefaultName,self.cd))
if self.cd<=0 then
if isDisableCd then
self.continueButton:setGray(false)
self.continueText:setText(FMT.fmt("{0}",self.continueBtnName or continuDefaultName))
self:stopTimerByID(self.continueTimer)
self.continueTimer=nil
else
self:onContinueButton(true)
end
else
if isDisableCd then
self.continueButton:setGray(true)
end
end
end)
end
end

function UICommonVictoryWin:reStartContinue()
if self.continueTimer then
self:startContinue(nil,self.isDisableCd)
end
end

function UICommonVictoryWin:hideCloseTips()
self.closeTips:setActive(false)
end

function UICommonVictoryWin:setCloudClose()
self.isCloudClose=true
end

function UICommonVictoryWin:onCloseTips()
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

function UICommonVictoryWin:onCloseTipsEx()
local cb=self.callback


self:closeSelf()
if cb then cb()end
end

function UICommonVictoryWin:onQuitButton()
if not self:checkLockTime()then
return
end
local cb=self.quitCallBack

if self.delayClose then
if cb then cb()end
self:delayDo(self.delayClose,function()
self:closeSelf()
end)
return
end
self:closeSelf()

if cb then cb()end
end

function UICommonVictoryWin:onContinueButton(outtime)
if not self:checkLockTime()then
return
end

if self.isDisableCd then

if self.cd>0 then
UIManager.error(FMT.fmt("点击过快，请{0}秒后再试",self.cd))
return
end
end

local cb=self.continuCallBack
self:closeSelf()

if cb then cb(outtime)end
end

function UICommonVictoryWin:onFightCountBtn()
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
if self.continueTimer then
self:stopTimerByID(self.continueTimer)
end
UIManager:showWindow('UIFightCountWin',{fightData=self.fightData,battleId=self.battleId,battleType=self.battleType,isShareFight=self.isShareFight})
end
end

function UICommonVictoryWin:onFightRestartBtn()
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

function UICommonVictoryWin:onCloseTips2()
local func=function()
if _this==nil then return end
_this:onCloseTipsEx()
end
loadingControl.openCloud(func,1.5)
end