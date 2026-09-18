







def_class("UISFPYqingxuWin",UIWindowBase)









function UISFPYqingxuWin:bindComponents()

self.closebutton=UIButton.get(self,0)
self.btn1=UIButton.get(self,1)
self.btn2=UIButton.get(self,2)
self.fztitlle=UIText.get(self,3)
self.titleBg=UIButton.get(self,4)

self.closebutton:setButtonClick(function()self:onClosebutton()end)

self.btn1:setButtonClick(function()self:onBtn1()end)

self.btn2:setButtonClick(function()self:onBtn2()end)

self.titleBg:setButtonClick(function()self:onTitleBg()end)



end


function UISFPYqingxuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closebutton);self.closebutton=nil;
_UIObject_release(self.btn1);self.btn1=nil;
_UIObject_release(self.btn2);self.btn2=nil;
_UIObject_release(self.fztitlle);self.fztitlle=nil;
_UIObject_release(self.titleBg);self.titleBg=nil;
end



















function UISFPYqingxuWin:onLoaded(...)
self:bindComponents()
end


function UISFPYqingxuWin:__delete()
self:unbindComponents()
end




function UISFPYqingxuWin:onShow(argtable,afterOnloaded)

end


function UISFPYqingxuWin:onHide()

end





function UISFPYqingxuWin:onClosebutton()
end

