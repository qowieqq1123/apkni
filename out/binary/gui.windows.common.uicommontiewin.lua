







def_class("UICommonTieWin",UIWindowBase)









function UICommonTieWin:bindComponents()

self.dragonBack=UIObject.get(self,0)
self.closeTips=UIButton.get(self,1)
self.btnRoot=UIObject.get(self,2)
self.quitButton=UIButton.get(self,3)
self.quitText=UIText.get(self,4)
self.continueButton=UIButton.get(self,5)
self.continueText=UIText.get(self,6)
self.fightCountBtn=UIButton.get(self,7)

self.closeTips:setButtonClick(function()self:onCloseTips()end)

self.quitButton:setButtonClick(function()self:onQuitButton()end)

self.continueButton:setButtonClick(function()self:onContinueButton()end)

self.fightCountBtn:setButtonClick(function()self:onFightCountBtn()end)



end


function UICommonTieWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dragonBack);self.dragonBack=nil;
_UIObject_release(self.closeTips);self.closeTips=nil;
_UIObject_release(self.btnRoot);self.btnRoot=nil;
_UIObject_release(self.quitButton);self.quitButton=nil;
_UIObject_release(self.quitText);self.quitText=nil;
_UIObject_release(self.continueButton);self.continueButton=nil;
_UIObject_release(self.continueText);self.continueText=nil;
_UIObject_release(self.fightCountBtn);self.fightCountBtn=nil;
end
































local continuDefaultName='继续'
local quitDefaultName='关 闭'
local _this=nil


function UICommonTieWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UICommonTieWin:__delete()
_this=nil
self:unbindComponents()
self:closeExtra()
tipsManager.closeTips()
end


function UICommonTieWin:onHide()

end




function UICommonTieWin:onShow(argtable,afterOnloaded)
self:closeExtra()
self.cd=0
self.extraWin=argtable.extraWin
self.extraParams=argtable.extraParams
self.extraParams.parentWin='UICommonTieWin'
self.fightData=argtable.fightData

self.battleId=self.extraParams.battleId
self.battleType=self.extraParams.battleType
if self.extraWin then
self:showWindow(self.extraWin,self.extraParams)
end

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


self.fightCountBtn:setActive(self.fightData~=nil)
end

function UICommonTieWin:closeExtra()
if self.extraWin~=nil then
UIManager:closeWindow(self.extraWin)
self.extraWin=nil
self.extraParams=nil
end
end

function UICommonTieWin:startContinue(time)
if time then
self.cd=time
end
if self.cd then
self.continueTimer=self:setTimer(1,self.cd,function()
self.cd=self.cd-1
self.continueText:setText(FMT.fmt("{0}({1})",self.continueBtnName or continuDefaultName,self.cd))
if self.cd<=0 then
self:onContinueButton()
end
end)
end
end

function UICommonTieWin:reStartContinue()
if self.continueTimer then
self:startContinue()
end
end

function UICommonTieWin:setCloudClose()
self.isCloudClose=true
end

function UICommonTieWin:onCloseTips()
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

function UICommonTieWin:onCloseTipsEx()
local cb=self.callback
self:closeSelf()

if cb then cb()end
end

function UICommonTieWin:onQuitButton()
local cb=self.quitCallBack
self:closeSelf()

if cb then cb()end
end

function UICommonTieWin:onContinueButton()
local cb=self.continuCallBack
self:closeSelf()

if cb then cb()end
end

function UICommonTieWin:onFightCountBtn()
if self.continueTimer then
self:stopTimerByID(self.continueTimer)
end
UIManager:showWindow('UIFightCountWin',{fightData=self.fightData,battleId=self.battleId,battleType=self.battleType})
end