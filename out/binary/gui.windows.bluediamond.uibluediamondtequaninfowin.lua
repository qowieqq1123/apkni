







def_class("UIBlueDiamondTeQuanInfoWin",UIWindowBase)









function UIBlueDiamondTeQuanInfoWin:bindComponents()

self.dailyBtn=UIButton.get(self,0)
self.GrowUpBtn=UIButton.get(self,1)
self.item_1=UIObject.get(self,2)
self.item_2=UIObject.get(self,3)
self.item_3=UIObject.get(self,4)
self.item_4=UIObject.get(self,5)
self.NewBieBtn=UIButton.get(self,6)
self.root=UIObject.get(self,7)

self.dailyBtn:setButtonClick(function()self:onDailyBtn()end)

self.GrowUpBtn:setButtonClick(function()self:onGrowUpBtn()end)

self.NewBieBtn:setButtonClick(function()self:onNewBieBtn()end)
self.item={
self.item_1,
self.item_2,
self.item_3,
self.item_4,
}



end


function UIBlueDiamondTeQuanInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dailyBtn);self.dailyBtn=nil;
_UIObject_release(self.GrowUpBtn);self.GrowUpBtn=nil;
_UIObject_release(self.item_1);self.item_1=nil;
_UIObject_release(self.item_2);self.item_2=nil;
_UIObject_release(self.item_3);self.item_3=nil;
_UIObject_release(self.item_4);self.item_4=nil;
_UIObject_release(self.NewBieBtn);self.NewBieBtn=nil;
_UIObject_release(self.root);self.root=nil;
self.item=nil;
end
















local _this=nil




function UIBlueDiamondTeQuanInfoWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onActorBlueDiamondChange,self.onActorBlueDiamondChange)
end


function UIBlueDiamondTeQuanInfoWin:__delete()
self:unbindComponents()
_this=nil
end

function UIBlueDiamondTeQuanInfoWin.onActorBlueDiamondChange()
_this:refreshPanel()
end




function UIBlueDiamondTeQuanInfoWin:onShow(argtable,afterOnloaded)

self:refreshPanel()

if afterOnloaded then
self:initRoot()
end
end

function UIBlueDiamondTeQuanInfoWin:onShowArgRecv(argtable)
self:initRoot()
end

function UIBlueDiamondTeQuanInfoWin:initRoot()
if not self.delayTimers then
self.delayTimers={}
end
if not self.tweeners then
self.tweeners={}
end
for i=1,4 do
self.item[i]:setChildCanvasGroupAlpha(0)
local cavasGroup=self.item[i]:getCommonComponent('CanvasGroup')
if self.delayTimers[i]then
self:stopTimerByID(self.delayTimers[i])
self.delayTimers[i]=nil
end
if self.tweeners[i]then
self.tweeners[i]:Kill(false)
self.tweeners[i]=nil
end
self.delayTimers[i]=self:delayDo(0.2+0.1*i,function()
if not _this then return end
_this.tweeners[i]=_DOTweenProxy.DOFade(cavasGroup,1,0.5)
_this.tweeners[i]:SetDelay(0.2)
_this.delayTimers[i]=nil
end)
end
end


function UIBlueDiamondTeQuanInfoWin:onHide()

end

function UIBlueDiamondTeQuanInfoWin:refreshPanel()

end




function UIBlueDiamondTeQuanInfoWin:onDailyBtn()
UIManager:invokeUIMethod("UIBlueDiamondBottomMaskWin","on_click_callback",1)
end

function UIBlueDiamondTeQuanInfoWin:onGrowUpBtn()
UIManager:invokeUIMethod("UIBlueDiamondBottomMaskWin","on_click_callback",3)
end

function UIBlueDiamondTeQuanInfoWin:onNewBieBtn()
UIManager:invokeUIMethod("UIBlueDiamondBottomMaskWin","on_click_callback",2)
end