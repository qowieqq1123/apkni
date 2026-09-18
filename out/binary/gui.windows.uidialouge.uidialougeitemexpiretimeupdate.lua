







def_class("UIDialougeItemExpireTimeUpdate",UIWindowBase)









function UIDialougeItemExpireTimeUpdate:bindComponents()

self.chooseBox=UIToggleButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.linkImageText=UILinkImageText.get(self,2)
self.cancelText=UIText.get(self,3)
self.okText=UIText.get(self,4)
self.chooseText=UIText.get(self,5)
self.cancelButton=UIButton.get(self,6)
self.okButton=UIButton.get(self,7)
self.titleText=UIText.get(self,8)
self.timeImageText=UILinkImageText.get(self,9)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIDialougeItemExpireTimeUpdate:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.chooseBox);self.chooseBox=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.linkImageText);self.linkImageText=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.chooseText);self.chooseText=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.timeImageText);self.timeImageText=nil;
end



















function UIDialougeItemExpireTimeUpdate:onLoaded(...)
self:bindComponents()
end


function UIDialougeItemExpireTimeUpdate:__delete()
self:clearTimer()
self:unbindComponents()
if self.showMoney then
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
end




function UIDialougeItemExpireTimeUpdate:onShow(argtable,afterOnloaded)
local showdata=argtable
self.titleText:setText(showdata.title)
self.content=showdata.content
self.linkImageText:setText(showdata.content)
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

self.showdata=showdata
self.id=showdata.id

if showdata.endTime then
self:setRefreshTextTimer(showdata.timeText,showdata.endTime,showdata.showTime)
end

if showdata.choosetext~=nil and showdata.choosecallback~=nil then
self.chooseBox:setActive(true)
self.chooseText:setText(showdata.choosetext)
else
self.chooseBox:setActive(false)
end

local showMoney
local moneytypes=showdata.moneytypes
if moneytypes then
showMoney=true
UIManager:showWindow('UITopMoneyHigh_dialougeOnly_Win',{moneytypes=moneytypes,parentName='UIDialougeWithIcon'})
else
showMoney=false
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
self.showMoney=showMoney
end


function UIDialougeItemExpireTimeUpdate:onHide()
self:clearTimer()
end

function UIDialougeItemExpireTimeUpdate:setRefreshTextTimer(timeText,endTime,showTime)
if not timeText then
timeText="{0}"
end
self:clearTimer()
local func=function()
local nowTime=timeHelper.getServerShortTime()
local lerp=endTime-nowTime

if lerp<=0 then
self:clearTimer()
return self:doClose()
else
if not showTime or nowTime>=showTime then
local timerStr=FMT.fmt(timeText,timeHelper.format_time_stamp7(lerp))
self.timeImageText:setText(timerStr)
self.timeImageText:setActive(true)
else
self.timeImageText:setActive(false)
end
end
end
self.timer=self:setTimer(1,0,func)
func()
end

function UIDialougeItemExpireTimeUpdate:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end




function UIDialougeItemExpireTimeUpdate:onCloseBtn()
self:doClose()
end



function UIDialougeItemExpireTimeUpdate:onCancelButton()
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



function UIDialougeItemExpireTimeUpdate:onOkButton()
local okcallback=self.showdata.okcallback

local choosecallback=self.showdata.choosecallback
if choosecallback then
choosecallback(self.chooseBox:getToggle())
end
self.showdata:deleteSelf()

self:close()
if okcallback then
okcallback()
end
end

function UIDialougeItemExpireTimeUpdate:onBGClick()
if self.showdata.allowclickBG==nil or self.showdata.allowclickBG==true then
self:onCloseBtn()
end
end

function UIDialougeItemExpireTimeUpdate:doClose()
local closecallback=self.showdata.closecallback
self.showdata:deleteSelf()

self:close()
if closecallback then
closecallback()
end
end

function UIDialougeItemExpireTimeUpdate:doOk()
local okcallback=self.showdata.okcallback
self.showdata:deleteSelf()
self:close()
if okcallback then
okcallback()
end
end

function UIDialougeItemExpireTimeUpdate:doCancel()
self.showdata:deleteSelf()
self:close()
end

function UIDialougeItemExpireTimeUpdate:onChangeChoose()

AudioManager.playBtnClick()
end