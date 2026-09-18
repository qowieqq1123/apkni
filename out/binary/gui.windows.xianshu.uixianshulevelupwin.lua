







def_class("UIXianShuLevelUpWin",UIWindowBase)









function UIXianShuLevelUpWin:bindComponents()

self.level1=UIText.get(self,0)
self.level2=UIText.get(self,1)
self.scrollView=UIObject.get(self,2)



end


function UIXianShuLevelUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.level1);self.level1=nil;
_UIObject_release(self.level2);self.level2=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
end



















function UIXianShuLevelUpWin:onLoaded(...)
self:bindComponents()

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIXianShuLevelUpWin:__delete()
self.scrollView:setChildScrollViewStopGridCreate()

self:unbindComponents()
end




function UIXianShuLevelUpWin:onShow(argtable,afterOnloaded)
local lastLevel=argtable.lastLevel
local currLevel=argtable.currLevel

self.level1:setText(FMT.fmt('仙书：{0}级',lastLevel))
self.level2:setText(FMT.fmt('{0}级',currLevel))

local datas=UIXianShuControl:getRewardDataInRange(lastLevel+1,currLevel)
local len=#datas
local col=math.min(len,6)
self.scrollView:setChildScrollViewDelayCreateGrids(len,col,0.02,1,false,false,function(index,item)
local data=datas[index+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)
end


function UIXianShuLevelUpWin:onHide()

end




function UIXianShuLevelUpWin:onCloseClick()
self:closeSelf()
end