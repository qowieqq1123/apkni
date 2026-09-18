







def_class("UIFuLuMatUseWin",UIWindowBase)









function UIFuLuMatUseWin:bindComponents()

self.scrollview=UIObject.get(self,0)
self.countSlider=UIObject.get(self,1)
self.cutBtn=UIButton.get(self,2)
self.addBtn=UIButton.get(self,3)
self.applyBtn=UIButton.get(self,4)
self.time=UIText.get(self,5)
self.count=UIText.get(self,6)

self.cutBtn:setButtonClick(function()self:onCutBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)



end


function UIFuLuMatUseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.countSlider);self.countSlider=nil;
_UIObject_release(self.cutBtn);self.cutBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.count);self.count=nil;
end
















local _this




function UIFuLuMatUseWin:onLoaded(...)
self:bindComponents()

_this=self

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIFuLuMatUseWin:__delete()
self:unbindComponents()

_this=nil
end




function UIFuLuMatUseWin:onShow(argtable,afterOnloaded)
local itemList=argtable.cost
self.bdData=argtable.bdData
self.pData=argtable.pData
self.percent=self.pData[1]or 0
self.id=argtable.id
self.config=argtable.cfg
self.minMakeNum=1
self.maxMakeNum=UIFuLuFangModel:getCanMakeNum(itemList,self.percent)
self.itemList=itemList
self.onSliderChange(self.minMakeNum)
self.countSlider:setChildSliderInit(self.makeNum,1,self.maxMakeNum,self.onSliderChange)
end

function UIFuLuMatUseWin.onSliderChange(val)
if val~=_this.makeNum then
_this.makeNum=val
_this.count:setText(val)
_this:setCostList()
end
end

function UIFuLuMatUseWin:setCostList()
local len=#self.itemList
self.scrollview:setChildScrollViewCreateGrids(len,0)
self.grids=self.scrollview:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
local data=self.itemList[i]
local id=data[1]
local need=data[2]*self.makeNum
if id==eMoneyType.mtFuZhi then
need=math.ceil(need*(1+self.percent*0.01))
end
widgetHelper.setNormalRewardItem(item,0,{id,need})
end

local timeStr=timeHelper.format_time_stamp11(self.config.lz_time*self.makeNum,true)
self.time:setText(timeStr)
end


function UIFuLuMatUseWin:onHide()

end




function UIFuLuMatUseWin:onCutBtn()
if self.makeNum>self.minMakeNum then
self.countSlider:setChildSliderValue(self.makeNum-1)
end
end

function UIFuLuMatUseWin:onAddBtn()
if self.makeNum<self.maxMakeNum then
self.countSlider:setChildSliderValue(self.makeNum+1)
end
end

function UIFuLuMatUseWin:onApplyBtn()
local spItemId=self.itemList.spCost and self.itemList.spCost[1]or 0
local ubdId=self.bdData.un_build_id
UIFullFuLuFangControl:reqMakeYuFu(mapIdType.zhufeng,ubdId,self.id,spItemId,self.makeNum)
self:onCloseClick()
end

function UIFuLuMatUseWin:onCloseClick()
self:closeSelf()
end