







def_class("UIXFWDRegRewardWin",UIWindowBase)









function UIXFWDRegRewardWin:bindComponents()

self.tips=UIText.get(self,0)
self.rwScrollView=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.titleText=UIText.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXFWDRegRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end



















function UIXFWDRegRewardWin:onLoaded(...)
self:bindComponents()

self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIXFWDRegRewardWin:__delete()
self:unbindComponents()
end




function UIXFWDRegRewardWin:onShow(argtable,afterOnloaded)
local cfg=cfgHelper.get1(cfg_xianfawendaoconfig_get,1)
local rewards=cfg.signupreward
self.rwScrollView:setChildScrollViewCreateGrids(#rewards,0)
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local rw=rewards[i]
widgetHelper.setNormalRewardItem(item,0,{rw[1],rw[2],showStage=true})
end
end


function UIXFWDRegRewardWin:onHide()

end





function UIXFWDRegRewardWin:onCloseBtn()
self:closeSelf()
end

