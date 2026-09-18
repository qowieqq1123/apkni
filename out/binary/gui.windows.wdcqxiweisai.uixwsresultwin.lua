







def_class("UIXWSResultWin",UIWindowBase)









function UIXWSResultWin:bindComponents()

self.rankRoot=UIObject.get(self,0)
self.rank=UIText.get(self,1)
self.rankIcon=UIImage.get(self,2)
self.rankNum=UIText.get(self,3)
self.resRoot=UIObject.get(self,4)
self.rwScrollView=UIObject.get(self,5)
self.resIcon=UIImage.get(self,6)
self.resText=UIText.get(self,7)
self.tips=UIText.get(self,8)
self.tipsTxt=UIText.get(self,9)



end


function UIXWSResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rankRoot);self.rankRoot=nil;
_UIObject_release(self.rank);self.rank=nil;
_UIObject_release(self.rankIcon);self.rankIcon=nil;
_UIObject_release(self.rankNum);self.rankNum=nil;
_UIObject_release(self.resRoot);self.resRoot=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.resIcon);self.resIcon=nil;
_UIObject_release(self.resText);self.resText=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
end



















function UIXWSResultWin:onLoaded(...)
self:bindComponents()
self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIXWSResultWin:__delete()
self:unbindComponents()
end




function UIXWSResultWin:onShow(argtable,afterOnloaded)
self.resRoot:setActive(false)
local rankInfo=argtable.rankInfo
if rankInfo then
self.rankRoot:setActive(true)
self.rank:setText(rankInfo.rank)
local rankIcon=rankInfo.rankIcon
if rankIcon then
self.rankIcon:setActive(true)
if rankIcon.abName then
self.rankIcon:setSprite(rankIcon.abName,rankIcon.assetName)
else
self.rankIcon:setChildIcon(rankIcon.assetName,true)
end
if rankInfo.iconScale then
self.rankIcon:setScale(rankInfo.iconScale)
end
else
self.rankIcon:setActive(false)
end
local rankNum=rankInfo.rankNum
self.rankNum:setText(rankNum and rankNum or'')
else
self.rankRoot:setActive(false)
end

local rewards=argtable.rewards
if rewards then
self.rwScrollView:setChildScrollViewCreateGrids(#rewards,0)
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local rw=rewards[i]
widgetHelper.setNormalRewardItem(item,0,{rw[1],rw[2],showStage=true})
end
end
local tips=argtable.tips
self.tips:setText(tips and tips or'')
end


function UIXWSResultWin:onHide()

end



