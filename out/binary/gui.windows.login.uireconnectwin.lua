







def_class("UIReconnectWin",UIWindowBase)









function UIReconnectWin:bindComponents()

self.content=UIText.get(self,0)



end


function UIReconnectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.content);self.content=nil;
end
















function UIReconnectWin:onLoaded(...)
self:bindComponents()
end


function UIReconnectWin:__delete()
self:unbindComponents()
if self.flushTextTime~=nil then
self:stopTimerByID(self.flushTextTime)
self.flushTextTime=nil
end

if self.comfirmDialog~=nil then
self.comfirmDialog.hide()
end
end




function UIReconnectWin:onShow(showMsg,afterOnloaded)
self.count=0
self.timePass=0
self:setContentTip(showMsg)
local flushText=function(...)
self.count=self.count+1
self:setContentTip(showMsg)
end

if self.flushTextTime==nil then
self.flushTextTime=self:setTimer(0.5,-1,flushText,true)
end
end


function UIReconnectWin:OnEnable()

end


function UIReconnectWin:OnDisable()

end

function UIReconnectWin:setContentTip(showMsg)
self.showText=showMsg or"断线重连中"
local tip=self.showText
if self.count==1 then
tip=self.showText.."."
elseif self.count==2 then
tip=self.showText..".."
elseif self.count==3 then
tip=self.showText.."..."
self.count=0
end
self.content:setText(tip)
end

function UIReconnectWin:showBackLoginWin()
local showdata=
{
type='UIDialougeHighest',
title='提示',
content='网络连接不稳定,建议返回登录界面',
oktext='确定',
allowclickBG='false',
okcallback=function(...)
reconnectState:giveupReconnect()
loginState:logout()
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end