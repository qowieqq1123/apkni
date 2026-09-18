








def_class("UIDialougeHighest",UIWindowBase)









function UIDialougeHighest:bindComponents()

self.titleText=UIText.get(self,0)
self.dialougeText=UIText.get(self,1)
self.okText=UIText.get(self,2)
self.cancelText=UIText.get(self,3)
self.cancelButton=UIButton.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.okButton=UIButton.get(self,6)
self.chooseBox=UIToggleButton.get(self,7)
self.chooseText=UIText.get(self,8)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIDialougeHighest:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.dialougeText);self.dialougeText=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.chooseBox);self.chooseBox=nil;
_UIObject_release(self.chooseText);self.chooseText=nil;
end
















local _timer=nil
local playerInputCheckTimer=nil


function UIDialougeHighest:onLoaded(...)
self:bindComponents()
self:setAsFirstSibling(-1)
end


function UIDialougeHighest:__delete()
self:unbindComponents()
if _timer then
self:stopTimerByID(_timer)
end
_timer=nil
if playerInputCheckTimer then
self:stopTimerByID(playerInputCheckTimer)
playerInputCheckTimer=nil
end
self._this=nil
end


function UIDialougeHighest:onShow(showdata)
self._this=self
self.titleText:setText(showdata.title)
self.dialougeText:setText(showdata.content)
self.okText:setText(showdata.oktext)
if showdata.canceltext~=nil then
self.cancelText:setText(showdata.canceltext)
else
self.cancelButton:setActive(false)
end
if showdata.showclosebtn then
self.closeBtn:setActive(showdata.showclosebtn)
else
self.closeBtn:setActive(false)
end



if showdata.hideOkBtn then
self.okButton:setActive(false)
end

self.showdata=showdata
self.id=showdata.id

if showdata.useTimeCount then
self:handleTimeCount(showdata.timeCount)
end

if showdata.useTimeCountDown then
self:handleTimeCountDown(showdata.timeCount)
end
if showdata.choosetext~=nil and showdata.choosecallback~=nil then
self.chooseBox:setActive(true)
self.chooseText:setText(showdata.choosetext)
else
self.chooseBox:setActive(false)
end
end

function UIDialougeHighest:handleCheckPlayerInput()


local function tick(i,t,c)

end

if playerInputCheckTimer then
self:stopTimerByID(playerInputCheckTimer)
playerInputCheckTimer=nil
end
playerInputCheckTimer=self:setTimer(0.5,30,tick)
end


function UIDialougeHighest:handleTimeCount(time)
if time>0 then
local function tick(i,t,c)
self.okText:setText(string.format('%s(%d)',self.showdata.oktext,c-1))
if c<=1 then
self.okText:setText(self.showdata.oktext)
self.okButton:setButtonEnable(true,true)
end
end
if _timer then
self:stopTimerByID(_timer)
_timer=nil
end
_timer=self:setTimer(1,time,tick)
self.okButton:setButtonEnable(false,false)
self.okText:setText(string.format('%s(%d)',self.showdata.oktext,time))
end
end


function UIDialougeHighest:handleTimeCountDown(time)
if time>0 then
local function tick(i,t,c)
self.okText:setText(string.format('%s(%d)',self.showdata.oktext,c-1))
if c<=1 then
self.okText:setText(self.showdata.oktext)
self:onOkButton()
end
end
if _timer then
self:stopTimerByID(_timer)
_timer=nil
end
_timer=self:setTimer(1,time,tick)
self.okText:setText(string.format('%s(%d)',self.showdata.oktext,time))
end
end

function UIDialougeHighest:onOkButton()
local okcallback=self.showdata.okcallback

local ret=false
if okcallback then
ret=okcallback()
end


if self.showdata and self.showdata.checkOkCallBackRet then
if ret==nil or ret==false then
return
end
end

local choosecallback=self.showdata and self.showdata.choosecallback or nil
if choosecallback then
choosecallback(self.chooseBox:getToggle())
end
if self.showdata then
self.showdata:deleteSelf()
end

if self._this~=nil and not self._this.isClose then
self:close()
end
end


function UIDialougeHighest:onCancelButton()
local cancelcallback=self.showdata.cancelcallback

local choosecallback=self.showdata.choosecallback
if choosecallback then
choosecallback(self.chooseBox:getToggle())
end
self.showdata:deleteSelf()

self:close()
if cancelcallback then
cancelcallback()
end
end

function UIDialougeHighest:onBGClick()
if self.showdata.allowclickBG==nil or self.showdata.allowclickBG==true then
self:onCloseBtn()
end
end

function UIDialougeHighest:onCloseBtn()

self:doClose()
end

function UIDialougeHighest:doClose()
local closecallback=self.showdata.closecallback
self.showdata:deleteSelf()
self:close()
if closecallback then
closecallback()
end
end

function UIDialougeHighest:doOk()
local okcallback=self.showdata.okcallback
self.showdata:deleteSelf()
self:close()
if okcallback then
okcallback()
end
end

function UIDialougeHighest:doCancel()
self.showdata:deleteSelf()
self:close()
end