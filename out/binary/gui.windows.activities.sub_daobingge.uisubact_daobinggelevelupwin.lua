







def_class("UISubAct_DaoBingGeLevelUpWin",UIWindowBase)









function UISubAct_DaoBingGeLevelUpWin:bindComponents()

self.level1=UIText.get(self,0)
self.level2=UIText.get(self,1)
self.scrollView=UIObject.get(self,2)



end


function UISubAct_DaoBingGeLevelUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.level1);self.level1=nil;
_UIObject_release(self.level2);self.level2=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
end


















function UISubAct_DaoBingGeLevelUpWin:onLoaded(...)
self:bindComponents()
self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)
end

function UISubAct_DaoBingGeLevelUpWin:__delete()
self.scrollView:setChildScrollViewStopGridCreate()
self:unbindComponents()
end

function UISubAct_DaoBingGeLevelUpWin:onShow(argtable,afterOnloaded)
local oldlv=argtable.oldlv
local newlv=argtable.newlv
local actId=argtable.actId
local subType=argtable.subType
local subId=argtable.subId
self.level1:setText(FMT.fmt('道兵阁：{0}级',oldlv))
self.level2:setText(FMT.fmt('{0}级',newlv))

local model=activitiesModel:getSubActInfo(actId,subType,subId)
local datas=model:getCanPrizeList()
local len=#datas
local col=math.min(len,6)
self.scrollView:setChildScrollViewDelayCreateGrids(len,col,0.02,1,false,false,function(index,item)
local data=datas[index+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)
end

function UISubAct_DaoBingGeLevelUpWin:onHide()

end



function UISubAct_DaoBingGeLevelUpWin:onCloseClick()
self:closeSelf()
end
