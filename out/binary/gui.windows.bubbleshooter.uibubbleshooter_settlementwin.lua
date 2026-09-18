







def_class("UIBubbleShooter_settlementWin",UIWindowBase)









function UIBubbleShooter_settlementWin:bindComponents()

self.effect=UIObject.get(self,0)
self.success=UIObject.get(self,1)
self.failure=UIObject.get(self,2)
self.settlementEffect=UIObject.get(self,3)
self.showDataPanel=UIObject.get(self,4)
self.bg=UIButton.get(self,5)
self.restartBtn=UIButton.get(self,6)
self.exitBtn=UIButton.get(self,7)

self.bg:setButtonClick(function()self:onBg()end)

self.restartBtn:setButtonClick(function()self:onRestartBtn()end)

self.exitBtn:setButtonClick(function()self:onExitBtn()end)



end


function UIBubbleShooter_settlementWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.success);self.success=nil;
_UIObject_release(self.failure);self.failure=nil;
_UIObject_release(self.settlementEffect);self.settlementEffect=nil;
_UIObject_release(self.showDataPanel);self.showDataPanel=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.restartBtn);self.restartBtn=nil;
_UIObject_release(self.exitBtn);self.exitBtn=nil;
end















local _this




function UIBubbleShooter_settlementWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIBubbleShooter_settlementWin:__delete()
_this=nil
self:unbindComponents()
end




function UIBubbleShooter_settlementWin:onShow(argtable,afterOnloaded)
self.result=argtable and argtable.result

self.parent=argtable and argtable.parent
self.score=argtable and argtable.score
local isSuccess=self.result==1

self.showDataPanel:setActive(false)
self.bg:setImageExGray(not isSuccess)
local showFunc=function()
if _this==nil then return end
_this.showDataPanel:setActive(true)
_this.success:setActive(isSuccess)
_this.failure:setActive(not isSuccess)
if isSuccess then
_this:setSuccessPanel()
else
_this:setFailurePanel()
end
end

local delayTime
if isSuccess then

self.settlementEffect:setChildShowEffect(10060,true)
delayTime=2.0
else

self.settlementEffect:setChildShowEffect(10064,true)
delayTime=2.9
end
self:delayDo(delayTime,showFunc)
end


function UIBubbleShooter_settlementWin:onHide()

end

function UIBubbleShooter_settlementWin:setSuccessPanel()
local panel=self.success:getChildWidgetBase()
local desc="恭喜祖师成功通关！"
panel:SetChildText(0,desc)

local scoreStr=FMT.fmt("获得积分：{0}",self.score)
panel:SetChildText(1,scoreStr)

self.effect:setChildShowEffect(10014,true)


AudioManager.playAudio(502)
end

function UIBubbleShooter_settlementWin:setFailurePanel()
local panel=self.failure:getChildWidgetBase()
local desc="祖师通关失败~"
panel:SetChildText(0,desc)
end




function UIBubbleShooter_settlementWin:onBg()
local isSuccess=self.result==1
if isSuccess then
if self.parent then
self.parent:closeSelf()
else
self:closeSelf()
end
end
end



function UIBubbleShooter_settlementWin:onRestartBtn()
if self.parent then
self.parent:restartGame()
self:closeSelf()
end
end



function UIBubbleShooter_settlementWin:onExitBtn()
if self.parent then
self.parent:closeSelf()
else
self:closeSelf()
end
end

