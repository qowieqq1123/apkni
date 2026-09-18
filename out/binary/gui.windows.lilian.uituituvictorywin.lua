







def_class("UITuiTuVictoryWin",UIWindowBase)









function UITuiTuVictoryWin:bindComponents()

self.title=UIText.get(self,0)
self.rwScrollView=UIObject.get(self,1)
self.tipsRoot=UIObject.get(self,2)
self.tips=UIText.get(self,3)



end


function UITuiTuVictoryWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.tipsRoot);self.tipsRoot=nil;
_UIObject_release(self.tips);self.tips=nil;
end



















function UITuiTuVictoryWin:onLoaded(...)
self:bindComponents()

self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UITuiTuVictoryWin:__delete()
self:unbindComponents()
end




function UITuiTuVictoryWin:onShow(argtable,afterOnloaded)
local rewards=argtable.items
self:showRewards(rewards)

local tips=argtable.tips
local showTips=tips~=nil
self.tipsRoot:setActive(showTips)
if showTips then
self.tips:setText(tips)
end
end


function UITuiTuVictoryWin:onHide()

end

function UITuiTuVictoryWin:showRewards(rewards)
local len=#rewards
self.rwScrollView:setChildScrollViewCreateGrids(len,math.min(len,6))
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=rewards[i]
widgetHelper.setNormalRewardItem(item,0,{data.itemid,data.num,guid=data.itemguid,showStage=true})
end
end



