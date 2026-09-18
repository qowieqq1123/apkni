







def_class("UIBaseAttr6Dialouge",UIWindowBase)









function UIBaseAttr6Dialouge:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.titleText=UIText.get(self,1)
self.dialougeText=UIText.get(self,2)
self.attrRoot=UIObject.get(self,3)
self.cancelButton=UIButton.get(self,4)
self.okButton=UIButton.get(self,5)
self.cancelText=UIText.get(self,6)
self.okText=UIText.get(self,7)
self.attrText=UIText.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIBaseAttr6Dialouge:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.dialougeText);self.dialougeText=nil;
_UIObject_release(self.attrRoot);self.attrRoot=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.attrText);self.attrText=nil;
end


















local _timer=nil
local auto_timer=nil
local autoOk_timer=nil

function UIBaseAttr6Dialouge:onLoaded(...)
self:bindComponents()
if _timer then
self:stopTimerByID(_timer)
end
_timer=nil
if auto_timer then
self:stopTimerByID(auto_timer)
auto_timer=nil
end
if autoOk_timer then
self:stopTimerByID(autoOk_timer)
autoOk_timer=nil
end
if self.showMoney then
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
end


function UIBaseAttr6Dialouge:__delete()
self:unbindComponents()
if _timer then
self:stopTimerByID(_timer)
end
_timer=nil
if auto_timer then
self:stopTimerByID(auto_timer)
auto_timer=nil
end
if autoOk_timer then
self:stopTimerByID(autoOk_timer)
autoOk_timer=nil
end
if self.showMoney then
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
end




function UIBaseAttr6Dialouge:onShow(showdata,afterOnloaded)
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

self.showdata=showdata
self.id=showdata.id

if showdata.useTimeCount then
self:handleTimeCount(showdata.timeCount)
end
if showdata.cancelTimeCount then
self:autoCancelClick(showdata.cancelTimeCount)
end
if showdata.OkTimeCount then
self:autoOkClick(showdata.OkTimeCount)
end



local showMoney
local moneytypes=showdata.moneytypes
if moneytypes then
showMoney=true
UIManager:showWindow('UITopMoneyHigh_dialougeOnly_Win',{moneytypes=moneytypes,parentName='UIBaseAttr6Dialouge'})
else
showMoney=false
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
self.showMoney=showMoney

if showdata.attrText then
self.attrText:setText(showdata.attrText)
end
end


function UIBaseAttr6Dialouge:setContent(content)
self.dialougeText:setText(content)
end


function UIBaseAttr6Dialouge:handleTimeCount(time)
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


function UIBaseAttr6Dialouge:autoCancelClick(time)
if time>0 then
local function tick(i,t,c)
self.cancelText:setText(string.format('%s(%d)',self.showdata.canceltext,c-1))
if c<=1 then
self.cancelText:setText(self.showdata.canceltext)
self:onCancelButton()
end
end
if auto_timer then
self:stopTimerByID(auto_timer)
auto_timer=nil
end
auto_timer=self:setTimer(1,time,tick)
self.cancelText:setText(string.format('%s(%d)',self.showdata.canceltext,time))
end
end

function UIBaseAttr6Dialouge:autoOkClick(time)
if time>0 then
local function tick(i,t,c)
self:set_OKText(string.format('%s(%d)',self.showdata.oktext,c-1))
if c<=1 then
self.okText:setText(self.showdata.oktext)
self:onOkButton()
end
end
if autoOk_timer then
self:stopTimerByID(autoOk_timer)
autoOk_timer=nil
end
autoOk_timer=self:setTimer(1,time,tick)
self.okText:setText(string.format('%s(%d)',self.showdata.oktext,time))
end
end

function UIBaseAttr6Dialouge:onOkButton()
local okcallback=self.showdata.okcallback

self:closeSelf()
if okcallback then
okcallback()
end
end


function UIBaseAttr6Dialouge:onCancelButton()
local cancelcallback=self.showdata.cancelcallback



self:closeSelf()
if cancelcallback then
cancelcallback()
end
end

function UIBaseAttr6Dialouge:onBGClick()
if self.showdata.allowclickBG==nil or self.showdata.allowclickBG==true then
self:onCloseBtn()
end
end

function UIBaseAttr6Dialouge:onCloseBtn()
self:doClose()
end

function UIBaseAttr6Dialouge:doClose()
local closecallback=self.showdata.closecallback
self:closeSelf()
if closecallback then
closecallback()
end
end

function UIBaseAttr6Dialouge:doOk()
local okcallback=self.showdata.okcallback
self:closeSelf()
if okcallback then
okcallback()
end
end

function UIBaseAttr6Dialouge:doCancel()
self:closeSelf()
end