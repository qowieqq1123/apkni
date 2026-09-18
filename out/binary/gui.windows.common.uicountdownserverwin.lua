







def_class("UICountdownServerWin",UIWindowBase)









function UICountdownServerWin:bindComponents()

self.btnJump=UIButton.get(self,0)
self.btnClose=UIButton.get(self,1)
self.btntitle=UIObject.get(self,2)
self.btnText=UIText.get(self,3)
self.root=UIObject.get(self,4)
self.openServerTimevalueText=UIText.get(self,5)
self.remainTimeValueText=UIText.get(self,6)
self.remainTimeValueText2=UIText.get(self,7)
self.remainTimeValueText3=UIText.get(self,8)
self.bgModel=UIObject.get(self,9)

self.btnJump:setButtonClick(function()self:onBtnJump()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UICountdownServerWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnJump);self.btnJump=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.btntitle);self.btntitle=nil;
_UIObject_release(self.btnText);self.btnText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.openServerTimevalueText);self.openServerTimevalueText=nil;
_UIObject_release(self.remainTimeValueText);self.remainTimeValueText=nil;
_UIObject_release(self.remainTimeValueText2);self.remainTimeValueText2=nil;
_UIObject_release(self.remainTimeValueText3);self.remainTimeValueText3=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end















local _this
local _delay=0.9



function UICountdownServerWin:onLoaded(...)
self:bindComponents()
_this=self
end


local bgModelId=6408

function UICountdownServerWin:__delete()
self:unbindComponents()
end




function UICountdownServerWin:onShow(argtable,afterOnloaded)


self.bgModel:setChildUIModelShowTarget(bgModelId,1,nil,eAnimationID.enter,false,false,0,function()

end)

local OpenTimeStr=timeHelper.dateServerStamp_PHP()
self.openServerTimevalueText:setText(OpenTimeStr)


if not self.remainTimer then
self.remainTimer=self:setTimer(_delay,0,function(...)
if _this then
_this:setRemainTimeStr()
end
end)
_this:setRemainTimeStr()
end
end

function UICountdownServerWin:setRemainTimeStr()
local HH,MM,SS=CommonController.remainTimeStr()
self.remainTimeValueText:setText(HH)
self.remainTimeValueText2:setText(MM)
self.remainTimeValueText3:setText(SS)
end


function UICountdownServerWin:onHide()

end





function UICountdownServerWin:onBtnJump()
CommonController.JumpURL()
end



function UICountdownServerWin:onBtnClose()
self:closeSelf()
end

