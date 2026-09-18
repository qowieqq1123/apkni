







def_class("UIManufactureRewardWin",UIWindowBase)









function UIManufactureRewardWin:bindComponents()

self.scrollview=UIObject.get(self,0)
self.tips=UIText.get(self,1)



end


function UIManufactureRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.tips);self.tips=nil;
end



















function UIManufactureRewardWin:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIManufactureRewardWin:__delete()
self:unbindComponents()

UIManager:invokeUIMethod('UIManufactureWin','setTotalBtnImage',false)
end




function UIManufactureRewardWin:onShow(argtable,afterOnloaded)
local bdData=argtable
local slist=zongmenControl:getPlanStepReward(bdData)
local len=#slist
self.scrollview:setChildScrollViewCreateGrids(len,math.min(len,3))
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=slist[i]
widgetHelper.setNormalRewardItem(item,0,data)
end
self.tips:setActive(len<=0)
end


function UIManufactureRewardWin:onHide()

end




function UIManufactureRewardWin:onCloseClick()
self:closeSelf()
end