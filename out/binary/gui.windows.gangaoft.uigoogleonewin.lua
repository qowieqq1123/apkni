







def_class("UIGoogleOneWin",UIWindowBase)









function UIGoogleOneWin:bindComponents()

self.titleDesc=UIText.get(self,0)
self.Desc1=UIText.get(self,1)
self.Button=UIButton.get(self,2)
self.btnText=UIText.get(self,3)
self.ReturntoBtn=UIButton.get(self,4)
self.Returntotext=UIText.get(self,5)

self.Button:setButtonClick(function()self:onButton()end)

self.ReturntoBtn:setButtonClick(function()self:onReturntoBtn()end)



end


function UIGoogleOneWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleDesc);self.titleDesc=nil;
_UIObject_release(self.Desc1);self.Desc1=nil;
_UIObject_release(self.Button);self.Button=nil;
_UIObject_release(self.btnText);self.btnText=nil;
_UIObject_release(self.ReturntoBtn);self.ReturntoBtn=nil;
_UIObject_release(self.Returntotext);self.Returntotext=nil;
end

















local WinState=
{
Authorization=1,
checkAuthorization=2,
}
local title=
{
[WinState.Authorization]=
{
title="登入",
Desc="為保障您的遊戲體驗，進入遊戲前需要在GooglePlay登入並勾選全部許可權。",
btnDesc="前往GooglePlay",
},
[WinState.checkAuthorization]=
{
title="請在瀏覽器登入",
Desc="已在瀏覽器開啟GooglePlay，若已授權成功請點選“我已授權。",
btnDesc="我已授權",
}
}

local this




function UIGoogleOneWin:onLoaded(...)
self:bindComponents()
this=self
end


function UIGoogleOneWin:__delete()
self:unbindComponents()
end




function UIGoogleOneWin:onShow(argtable,afterOnloaded)
self.winState=argtable.winState
self:refreshView()
end


function UIGoogleOneWin:refreshView()
local Desccfg=title[self.winState]or title[WinState.Authorization]
self.titleDesc:setText(Desccfg.title)
self.Desc1:setText(Desccfg.Desc)
self.btnText:setText(Desccfg.btnDesc)
self.ReturntoBtn:setActive(self.winState==WinState.checkAuthorization)
end



function UIGoogleOneWin:onHide()

end





function UIGoogleOneWin:onButton()
if self.winState==WinState.Authorization then
platformSDK:reqEfunGoogleOAuthBegin()
local func=function()
if this then
this.winState=WinState.checkAuthorization
this:refreshView()
end
end
self:delayDo(0.5,func)
else
platformSDK:reqGoogleOAuthCompleteState()
end
end


function UIGoogleOneWin:onReturntoBtn()
platformSDK:reqEfunGoogleReOAuthBegin()
end
