







def_class("UIXFWDLevelUpWin",UIWindowBase)









function UIXFWDLevelUpWin:bindComponents()

self.levelIcon=UIImage.get(self,0)
self.rwScrollView=UIObject.get(self,1)
self.effect=UIObject.get(self,2)



end


function UIXFWDLevelUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.levelIcon);self.levelIcon=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.effect);self.effect=nil;
end



















function UIXFWDLevelUpWin:onLoaded(...)
self:bindComponents()

self.abName='ui/windows/xianfawendao/xfwd_atlas_pak.ab'
self.levelIcons={
'icon_zongmendjhz_4',
'icon_zongmendjhz_3',
'icon_zongmendjhz_2',
'icon_zongmendjhz_1',
}
self.effect:setChildShowEffect(10337,true)
self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIXFWDLevelUpWin:__delete()
self:unbindComponents()
end




function UIXFWDLevelUpWin:onShow(argtable,afterOnloaded)
local level=argtable
local currOrder=level or UIXianFaWenDaoControl:getOrderLevel()
self.levelIcon:setSprite(self.abName,self.levelIcons[currOrder])
local cfg=cfgHelper.get1(cfg_xianfawendaoscoreconfig_get,currOrder)
local rewards=cfg.reward
local len=#rewards
local col=math.min(len,5)
self.rwScrollView:setChildScrollViewCreateGrids(len,col)
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=rewards[i]
widgetHelper.setNormalRewardItem(item,0,{data[1],data[2],showStage=true})
end
end


function UIXFWDLevelUpWin:onHide()

end




function UIXFWDLevelUpWin:onCloseClick()
self:closeSelf()
end