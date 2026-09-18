







def_class("UIXFWDRewardWin",UIWindowBase)









function UIXFWDRewardWin:bindComponents()

self.rwScrollView=UIObject.get(self,0)



end


function UIXFWDRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
end



















function UIXFWDRewardWin:onLoaded(...)
self:bindComponents()

self.abName='ui/windows/xianfawendao/xfwd_atlas_pak.ab'
self.bgIconNames={'image_xianfawendaoui_19','image_xianfawendaoui_18','image_xianfawendaoui_17'}
self.tpIconNames={'image_xianfawendaoui_20','image_xianfawendaoui_21','image_xianfawendaoui_22'}

self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIXFWDRewardWin:__delete()
self:unbindComponents()
end




function UIXFWDRewardWin:onShow(argtable,afterOnloaded)
local cfgs=cfg_xianfawendaoscoreconfig()
self.rwScrollView:setChildScrollViewCreateGrids(3,0)
local indexs={4,3,2}
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local cfg=cfgs[indexs[i]]
item:SetChildCSImageSprite(0,self.abName,self.bgIconNames[i])
for ii=4,6 do
item:SetChildCSImageSprite(ii,self.abName,self.tpIconNames[i])
end
local rewards=cfg.reward
for ii=1,3 do
local rw=rewards[ii]
if rw then
item:SetChildActive(ii,true)
widgetHelper.setNormalRewardItem(item,ii,rw)
else
item:SetChildActive(ii,false)
end
end
end
end


function UIXFWDRewardWin:onHide()

end




function UIXFWDRewardWin:onCloseClick()
self:closeSelf()
end