







def_class("UISFPYresetWin",UIWindowBase)









function UISFPYresetWin:bindComponents()

self.closebutton=UIButton.get(self,0)
self.titleBg=UIObject.get(self,1)
self.fztitlle=UIText.get(self,2)
self.btn1=UIButton.get(self,3)
self.btn2=UIButton.get(self,4)

self.closebutton:setButtonClick(function()self:onClosebutton()end)

self.btn1:setButtonClick(function()self:onBtn1()end)

self.btn2:setButtonClick(function()self:onBtn2()end)



end


function UISFPYresetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closebutton);self.closebutton=nil;
_UIObject_release(self.titleBg);self.titleBg=nil;
_UIObject_release(self.fztitlle);self.fztitlle=nil;
_UIObject_release(self.btn1);self.btn1=nil;
_UIObject_release(self.btn2);self.btn2=nil;
end



















function UISFPYresetWin:onLoaded(...)
self:bindComponents()
end


function UISFPYresetWin:__delete()
self:unbindComponents()
end




function UISFPYresetWin:onShow(argtable,afterOnloaded)
if argtable then
self.reflag=argtable.reflag
end
end


function UISFPYresetWin:onHide()

end





function UISFPYresetWin:onClosebutton()


if self.reflag==1 then
return
end
UIManager:closeWindow("UISFPYresetWin")
end


function UISFPYresetWin:onBtn1()
if self.reflag then
local _rechallenge=1
local _chapter_id=SiFangPingYaoModel:getZhangjieIdex()
local _flag=3
if self.reflag==1 then
_flag=2
elseif self.reflag==2 then
_flag=3
end
self:showWindow('UISFPYreFightWin',{flag=_flag,rechallenge=_rechallenge,chapter_id=_chapter_id})
end
end


function UISFPYresetWin:onBtn2()
if self.reflag then
local _rechallenge=2
local _chapter_id=SiFangPingYaoModel:getZhangjieIdex()
local _flag=3
if self.reflag==1 then
_flag=2
elseif self.reflag==2 then
_flag=3
end
self:showWindow('UISFPYreFightWin',{flag=_flag,rechallenge=_rechallenge,chapter_id=_chapter_id})
end
end


