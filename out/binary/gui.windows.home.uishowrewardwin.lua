







def_class("UIShowRewardWin",UIWindowBase)









function UIShowRewardWin:bindComponents()

self.scrollview=UIObject.get(self,0)



end


function UIShowRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
end



















function UIShowRewardWin:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIShowRewardWin:__delete()
self:unbindComponents()
end




function UIShowRewardWin:onShow(argtable,afterOnloaded)
local rewards=argtable
self.scrollview:setChildScrollViewCreateGrids(#rewards,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local data=rewards[i+1]
local item=grids[i]
widgetHelper.setNormalRewardItem(item,0,data)
end
end


function UIShowRewardWin:onHide()

end



function UIShowRewardWin:onClickClose()
self:closeSelf()
end