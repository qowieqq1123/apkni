







def_class("UIDialougeWithIcon",UIWindowBase)









function UIDialougeWithIcon:bindComponents()

self.scrollview=UIObject.get(self,0)
self.chooseBox=UIToggleButton.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.linkImageText=UILinkImageText.get(self,3)
self.cancelText=UIText.get(self,4)
self.okText=UIText.get(self,5)
self.chooseText=UIText.get(self,6)
self.cancelButton=UIButton.get(self,7)
self.okButton=UIButton.get(self,8)
self.titleText=UIText.get(self,9)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIDialougeWithIcon:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.chooseBox);self.chooseBox=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.linkImageText);self.linkImageText=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.chooseText);self.chooseText=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end


















local _timer=nil
local auto_timer=nil
local autoOk_timer=nil
local timefunc=nil


function UIDialougeWithIcon:onLoaded(...)
self:bindComponents()
end


function UIDialougeWithIcon:__delete()
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
if timefunc then
timefunc=nil
end
end


function UIDialougeWithIcon:onShow(showdata)
timefunc=nil

timefunc=showdata.timefunc
self.titleText:setText(showdata.title)
if not timefunc then
self.linkImageText:setText(showdata.content)
else
self:setZhuanShuTimer(showdata.content)
end

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
UIManager:showWindow('UITopMoneyHigh_dialougeOnly_Win',{moneytypes=moneytypes,parentName='UIDialougeWithIcon'})
else
showMoney=false
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
self.showMoney=showMoney
end


function UIDialougeWithIcon:handleTimeCount(time)
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


function UIDialougeWithIcon:autoCancelClick(time)
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

function UIDialougeWithIcon:autoOkClick(time)
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

function UIDialougeWithIcon:onOkButton()
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

function UIDialougeWithIcon:onCancelButton()
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

function UIDialougeWithIcon:onBGClick()
if self.showdata.allowclickBG==nil or self.showdata.allowclickBG==true then
self:onCloseBtn()
end
end

function UIDialougeWithIcon:onCloseBtn()
self:doClose()
end

function UIDialougeWithIcon:doClose()
local closecallback=self.showdata.closecallback
self.showdata:deleteSelf()

self:close()
if closecallback then
closecallback()
end
end

function UIDialougeWithIcon:doOk()
local okcallback=self.showdata.okcallback
self.showdata:deleteSelf()
self:close()
if okcallback then
okcallback()
end
end

function UIDialougeWithIcon:doCancel()
self.showdata:deleteSelf()
self:close()
end

function UIDialougeWithIcon:onChangeChoose()

AudioManager.playBtnClick()
end


function UIDialougeWithIcon:setZhuanShuTimer(content)
local func
func=function()
local lerp=timefunc()
if lerp>0 then
local time_str=FMT.fmt(content,timeHelper.format_time_stamp(lerp))
self.linkImageText:setText(time_str)
else
self.ZSTime=nil
end
end

func()
self.ZSTime=self:setTimer(1,0,func)
end