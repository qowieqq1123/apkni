







def_class("UIXWSTipsWin",UIWindowBase)









function UIXWSTipsWin:bindComponents()

self.Root=UIObject.get(self,0)
self.time=UIText.get(self,1)
self.Cnt=UIText.get(self,2)
self.gotoBtn=UIButton.get(self,3)
self.todayNoTip=UIToggleButton.get(self,4)
self.bgmodel=UIObject.get(self,5)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UIXWSTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.Cnt);self.Cnt=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.todayNoTip);self.todayNoTip=nil;
_UIObject_release(self.bgmodel);self.bgmodel=nil;
end



















function UIXWSTipsWin:onLoaded(...)
self:bindComponents()

self.todayNoTip:setToggle(false)
self.todayNoTip:setToggleChange(function(name,isOn)
XiWeiSaiController:saveTipsWinShowTime(isOn)
end)

self.bgmodel:setChildUIModelShowTarget(5642,1,nil,eAnimationID.enter,false,false,0,function()end)
self:delayDo(0.4,function()
self.Root:setChildCanvasGroupDOFade(1,0.5,function()end)
end)
end


function UIXWSTipsWin:__delete()
if self.timerId then
self:stopTimerByID(self.timerId)
self.timerId=nil
end

self:unbindComponents()
end




function UIXWSTipsWin:onShow(argtable,afterOnloaded)
self.endTime=argtable.endTime
local leftCnt=argtable.leftCnt
self.Cnt:setText(leftCnt)
local func=function()
local curTime=timeHelper.getServerShortTime()
local leftTime=self.endTime-curTime
if leftTime<0 then
leftTime=0
end
self.time:setText(timeHelper.format_time_stamp3(leftTime))
end
func()
self.timerId=self:setTimer(1,0,func)
end


function UIXWSTipsWin:onHide()

end





function UIXWSTipsWin:onGotoBtn()
self:closeSelf()
UIFullWenDingCangQiongControl:showHaiXuanWin({loading=true})
end

