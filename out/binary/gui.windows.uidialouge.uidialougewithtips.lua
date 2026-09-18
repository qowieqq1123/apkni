







def_class("UIDialougeWithTips",UIWindowBase)









function UIDialougeWithTips:bindComponents()

self.tipsRoot=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.cancelText=UIText.get(self,2)
self.okText=UIText.get(self,3)
self.chooseText=UIText.get(self,4)
self.cancelButton=UIButton.get(self,5)
self.okButton=UIButton.get(self,6)
self.titleText=UIText.get(self,7)
self.dialougeText=UILinkImageText.get(self,8)
self.dialougeText2=UIText.get(self,9)
self.chooseBox=UIToggleButton.get(self,10)
self.tipsPanel=UIObject.get(self,11)
self.tipsBtn=UIButton.get(self,12)
self.tipsTx=UIText.get(self,13)

self.tipsRoot:setButtonClick(function()self:onTipsRoot()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)



end


function UIDialougeWithTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tipsRoot);self.tipsRoot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.chooseText);self.chooseText=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.dialougeText);self.dialougeText=nil;
_UIObject_release(self.dialougeText2);self.dialougeText2=nil;
_UIObject_release(self.chooseBox);self.chooseBox=nil;
_UIObject_release(self.tipsPanel);self.tipsPanel=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
end
















local _timer=nil
local auto_timer=nil
local autoOk_timer=nil


function UIDialougeWithTips:onLoaded(...)
self:bindComponents()
end


function UIDialougeWithTips:__delete()
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

function UIDialougeWithTips:onShow(showdata)

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
UIManager:showWindow('UITopMoneyHigh_dialougeOnly_Win',{moneytypes=moneytypes,parentName='UIDialougeWithTips'})
else
showMoney=false
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
self.showMoney=showMoney

self.dialougeText2:setActive(showdata.otherContent~=nil)
if showdata.otherContent then
self.dialougeText2:setText(showdata.otherContent)
end
self.tipsTx:setText(showdata.tipContent)
self.winlua:ForceLayoutRect(self.tipsPanel:getID())
self.winlua:SetChildAnchoredPosition(self.tipsPanel:getID(),showdata.tipsPos)
self.tipsRoot:setActive(false)
end

function UIDialougeWithTips:setContent(content)
self.dialougeText:setText(content)
end


function UIDialougeWithTips:handleTimeCount(time)
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


function UIDialougeWithTips:autoCancelClick(time)
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

function UIDialougeWithTips:autoOkClick(time)
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

function UIDialougeWithTips:onOkButton()
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


function UIDialougeWithTips:onCancelButton()
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

function UIDialougeWithTips:onBGClick()
if self.showdata.allowclickBG==nil or self.showdata.allowclickBG==true then
self:onCloseBtn()
end
end

function UIDialougeWithTips:onCloseBtn()

self:doClose()
end

function UIDialougeWithTips:doClose()
local closecallback=self.showdata.closecallback
self.showdata:deleteSelf()
self:close()
if closecallback then
closecallback()
end
end

function UIDialougeWithTips:doOk()
local okcallback=self.showdata.okcallback
self.showdata:deleteSelf()
self:close()
if okcallback then
okcallback()
end
end

function UIDialougeWithTips:doCancel()
self.showdata:deleteSelf()
self:close()
end

function UIDialougeWithTips:onTipsRoot()
self.tipsRoot:setActive(false)
end

function UIDialougeWithTips:onTipsBtn()
self.tipsRoot:setActive(true)
end