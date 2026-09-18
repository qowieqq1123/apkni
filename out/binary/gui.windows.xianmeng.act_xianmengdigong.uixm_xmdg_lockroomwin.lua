







def_class("UIXM_XMDG_lockRoomWin",UIWindowBase)









function UIXM_XMDG_lockRoomWin:bindComponents()

self.addBtn=UIButton.get(self,0)
self.btnCancel=UIButton.get(self,1)
self.btnClose=UIButton.get(self,2)
self.btnSave=UIButton.get(self,3)
self.btnStartDown=UIButton.get(self,4)
self.btnStartUp=UIButton.get(self,5)
self.handleImg=UIObject.get(self,6)
self.maxCnt=UIButton.get(self,7)
self.nextStartTime=UIText.get(self,8)
self.prevStartTime=UIText.get(self,9)
self.root=UIObject.get(self,10)
self.selectCntSlider=UIObject.get(self,11)
self.selectCntText=UIText.get(self,12)
self.selectStartTime=UIText.get(self,13)
self.subBtn=UIButton.get(self,14)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.btnCancel:setButtonClick(function()self:onBtnCancel()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btnSave:setButtonClick(function()self:onBtnSave()end)

self.btnStartDown:setButtonClick(function()self:onBtnStartDown()end)

self.btnStartUp:setButtonClick(function()self:onBtnStartUp()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)



end


function UIXM_XMDG_lockRoomWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.btnCancel);self.btnCancel=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.btnSave);self.btnSave=nil;
_UIObject_release(self.btnStartDown);self.btnStartDown=nil;
_UIObject_release(self.btnStartUp);self.btnStartUp=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.nextStartTime);self.nextStartTime=nil;
_UIObject_release(self.prevStartTime);self.prevStartTime=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.selectStartTime);self.selectStartTime=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
end















local convertTimeStr=function(time)
local str=time>9 and tostring(time)or'0'..time
return str
end
local convertHourMinTimeStr=function(hour,min)
local str=string.format("%s:%s",convertTimeStr(hour),convertTimeStr(min))
return str
end
local addHalfHourTime=function(h,m)
local hour,min=h,m
if min<30 then
min=30
else
hour=hour+1
if hour>=24 then
hour=0
end
min=0
end
return hour,min
end
local subHalfHourTime=function(h,m)
local hour,min=h,m
if min>=30 then
min=0
else
hour=hour-1
if hour<0 then
hour=23
end
min=30
end
return hour,min
end
local defaultStartHour=12
local defaultStartMin=30
local defaultEndHour=13
local defaultEndMin=0
local stepHour=0.5



function UIXM_XMDG_lockRoomWin:onLoaded(...)
self:bindComponents()
local gbLockTime=cfgHelper.get2(cfg_guilddigongbaseconfig_get,1,"gbLockTime")
local minLock,maxLock=unpack(gbLockTime)
self.min=math.floor(minLock/(stepHour*3600))
self.max=math.floor(maxLock/(stepHour*3600))
end


function UIXM_XMDG_lockRoomWin:__delete()
self:unbindComponents()
end




function UIXM_XMDG_lockRoomWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupDOFade(1,0.6)
end
self.s_h,self.s_m=xianmengdigongModel:getLockRoomHourMin()
if not self.s_h or self.s_h<0 then
self.s_h,self.s_m=defaultStartHour,defaultStartMin
end

self.selectCnt=1
local _,lockSeconds=xianmengdigongModel:getLockRoomData()
if lockSeconds and lockSeconds>0 then
self.selectCnt=math.min((lockSeconds/1800),self.max)
end

self:refreshStartTime()
self:refreshSliderEndTime()
end

function UIXM_XMDG_lockRoomWin:refreshStartTime()
self.selectStartTime:setText(convertHourMinTimeStr(self.s_h,self.s_m))

local prevStartTime_h,prevStartTime_m=subHalfHourTime(self.s_h,self.s_m)
self.prevStartTime:setText(convertHourMinTimeStr(prevStartTime_h,prevStartTime_m))

local nextStartTime_h,nextStartTime_m=addHalfHourTime(self.s_h,self.s_m)
self.nextStartTime:setText(convertHourMinTimeStr(nextStartTime_h,nextStartTime_m))
end

function UIXM_XMDG_lockRoomWin:refreshSliderEndTime()
local func=function(...)
self:onSliderChange(...)
end
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,self.min,self.max,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIXM_XMDG_lockRoomWin:onSliderChange(value)
self.selectCnt=value
self.selectCntText:setText(self.selectCnt*stepHour)
end

function UIXM_XMDG_lockRoomWin:onBtnCancel()
xianmengdigongController:send_20_139(0,0)
self:closeSelf()
end

function UIXM_XMDG_lockRoomWin:onBtnSave()
local startShortTime=timeHelper.convertShortStamp(timeHelper.getTodayXXStamp(self.s_h,self.s_m,0))
local seconds=self.selectCnt*stepHour*3600
xianmengdigongController:send_20_139(startShortTime,seconds)
self:closeSelf()
end

function UIXM_XMDG_lockRoomWin:onBtnClose()
self:closeSelf()
end

function UIXM_XMDG_lockRoomWin:onBtnStartDown()
self.s_h,self.s_m=addHalfHourTime(self.s_h,self.s_m)
self:refreshStartTime()
end

function UIXM_XMDG_lockRoomWin:onBtnStartUp()
self.s_h,self.s_m=subHalfHourTime(self.s_h,self.s_m)
self:refreshStartTime()
end

function UIXM_XMDG_lockRoomWin:onAddBtn()
if self.min>=self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIXM_XMDG_lockRoomWin:onSubBtn()
if self.selectCnt<=self.min then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIXM_XMDG_lockRoomWin:onMaxCnt()

end