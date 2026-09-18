







def_class("UIGooglePayWin",UIWindowBase)









function UIGooglePayWin:bindComponents()

self.Confirm=UIObject.get(self,0)
self.Failure=UIObject.get(self,1)
self.SuccessDesc=UIText.get(self,2)
self.FailureDesc=UIText.get(self,3)
self.cancel=UIButton.get(self,4)
self.ok=UIButton.get(self,5)
self.FailureBtn=UIButton.get(self,6)

self.cancel:setButtonClick(function()self:onCancel()end)

self.ok:setButtonClick(function()self:onOk()end)

self.FailureBtn:setButtonClick(function()self:onFailureBtn()end)



end


function UIGooglePayWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Confirm);self.Confirm=nil;
_UIObject_release(self.Failure);self.Failure=nil;
_UIObject_release(self.SuccessDesc);self.SuccessDesc=nil;
_UIObject_release(self.FailureDesc);self.FailureDesc=nil;
_UIObject_release(self.cancel);self.cancel=nil;
_UIObject_release(self.ok);self.ok=nil;
_UIObject_release(self.FailureBtn);self.FailureBtn=nil;
end















local WinState=
{
Confirm=1,
Failure=2,
}

local title=
{
[WinState.Confirm]=
{
Desc="請確認支付結果",
},

}
local this




function UIGooglePayWin:onLoaded(...)
self:bindComponents()
this=self
end


function UIGooglePayWin:__delete()
self:unbindComponents()
end




function UIGooglePayWin:onShow(argtable,afterOnloaded)
self.winState=argtable.winState
self.Msg=argtable.Msg
self.Code=argtable.Code
self.GoogleOAuth=argtable.GoogleOAuth
self:refreshView()
end

function UIGooglePayWin:refreshView()
self.Confirm:setActive(self.winState==WinState.Confirm)
self.Failure:setActive(self.winState==WinState.Failure)
if self.winState==WinState.Failure then
self.FailureDesc:setText(string.format("code: %s , msg:%s ",self.Code,self.Msg))
else

local textCfg=title[WinState.Confirm]
self.SuccessDesc:setText(textCfg.Desc)
end
end


function UIGooglePayWin:onHide()

end

function UIGooglePayWin:onFailureBtn()
if self.GoogleOAuth then
UIManager:showWindow('UIGoogleOneWin',{winState=2})
end
self:closeSelf()
end



function UIGooglePayWin:onCancel()
self:closeSelf()
end

function UIGooglePayWin:onOk()
UIManager:hideWindow("UIGooglePayWin")
platformSDK:EfunGoogleVerifyOrder()
end



