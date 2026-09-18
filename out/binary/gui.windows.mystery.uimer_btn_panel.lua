







def_class("UIMER_Btn_Panel",UIWindowBase)









function UIMER_Btn_Panel:bindComponents()

self.SelectRuleButton=UIButton.get(self,0)
self.LeaveButton=UIButton.get(self,1)
self.TextRight=UIText.get(self,2)
self.TextLeft=UIText.get(self,3)

self.SelectRuleButton:setButtonClick(function()self:onSelectRuleButton()end)

self.LeaveButton:setButtonClick(function()self:onLeaveButton()end)



end

function UIMER_Btn_Panel:bindChildComponents()

self.child=self.child or{}

end


function UIMER_Btn_Panel:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.SelectRuleButton);self.SelectRuleButton=nil;
_UIObject_release(self.LeaveButton);self.LeaveButton=nil;
_UIObject_release(self.TextRight);self.TextRight=nil;
_UIObject_release(self.TextLeft);self.TextLeft=nil;
end


















function UIMER_Btn_Panel:onChildLoaded(child)
self.child=child
self:bindChildComponents()
end


function UIMER_Btn_Panel:onLoaded(...)
self:bindComponents()
end


function UIMER_Btn_Panel:__delete()
self:unbindComponents()
self.child=nil
end

local leaveText
local confirmText
local leaveCallBack
local confirmCallBack




function UIMER_Btn_Panel:onShow(argtable,afterOnloaded)
if argtable then
leaveText=argtable.leaveText
leaveCallBack=argtable.leaveCallBack
confirmText=argtable.confirmText
confirmCallBack=argtable.confirmCallBack

self.TextLeft:setText(leaveText or"")
self.TextRight:setText(confirmText or"")
end
end


function UIMER_Btn_Panel:onHide()

end





function UIMER_Btn_Panel:onSelectRuleButton()
if confirmCallBack then
confirmCallBack()
end
end



function UIMER_Btn_Panel:onLeaveButton()
if leaveCallBack then
leaveCallBack()
else
UIManager:closeWindow("UIMER_Btn_Panel")
end
end

