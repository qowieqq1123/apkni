







def_class("UICommonBuyWin",UIWindowBase)









function UICommonBuyWin:bindComponents()

self.countSlider=UIObject.get(self,0)
self.cutBtn=UIButton.get(self,1)
self.addBtn=UIButton.get(self,2)
self.scrollView=UIObject.get(self,3)
self.title=UIText.get(self,4)
self.des=UIText.get(self,5)
self.buyBtn=UIButton.get(self,6)
self.level=UIText.get(self,7)
self.needText=UIText.get(self,8)
self.needIcon=UIImage.get(self,9)

self.cutBtn:setButtonClick(function()self:onCutBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)



end


function UICommonBuyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.countSlider);self.countSlider=nil;
_UIObject_release(self.cutBtn);self.cutBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.des);self.des=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.needText);self.needText=nil;
_UIObject_release(self.needIcon);self.needIcon=nil;
end



















function UICommonBuyWin:onLoaded(...)
self:bindComponents()

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)

end


function UICommonBuyWin:__delete()
self.scrollView:setChildScrollViewStopGridCreate()

self:unbindComponents()

end




function UICommonBuyWin:onShow(argtable,afterOnloaded)
if afterOnloaded and argtable.moneyList then
self:showWindow('UITopMoneyWin',argtable.moneyList)
end
local maxLevel=argtable.max_lv
local level=argtable.curLevel
self.argtable=argtable
self.selectLevel=level+1
self.minLevel=self.selectLevel
self.maxLevel=maxLevel
self.createCount=1
self:setInfo(level,self.selectLevel)
self.winlua:SetChildSliderInit(self.countSlider:getID(),self.selectLevel,self.selectLevel,maxLevel,function(val)
if val~=self.selectLevel then
self.selectLevel=val
self:setInfo(level,val)
end
end)
local canvas=argtable.canvas
if canvas then
self:setCanvasIndex(-1,canvas)
end
end


function UICommonBuyWin:onHide()

end

function UICommonBuyWin:setInfo(currLevel,buyLevel)
local argtable=self.argtable
self.des:setText(FMT.fmt(argtable.desFmtStr,buyLevel))
self.buyLevelNum=buyLevel-currLevel
self.level:setText(FMT.fmt(argtable.levelFmtStr,self.buyLevelNum))
self.scrollView:setChildScrollViewStopGridCreate()

self.scrollView:setChildScrollViewCreateGrids(0,0)

local datas=argtable.getDataFunc(currLevel+1,buyLevel)
local len=#datas
self.scrollView:setChildScrollViewDelayCreateGrids(len,0,0.02,self.createCount,false,false,function(index,item)
local data=datas[index+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)

local ntype=argtable.consumeItemId
self.needIcon:setChildIcon(iconHelper.getIconName(ntype),true)
local need=argtable.getNeedValueFunc(self.buyLevelNum)
local have=moneyModel.getMoney(ntype)
if have>=need then
self.needText:setText(need)
else
self.needText:setText(FMT.fmt('<color=red>{0}</color>',need))
end
end


function UICommonBuyWin:onBuyBtn()
local argtable=self.argtable
local ntype=argtable.consumeItemId
local need=argtable.getNeedValueFunc(self.buyLevelNum)

local enough=itemsModel:canUseItem(ntype,need)
if enough then
local selectLevel=self.selectLevel
itemsModel:useItem(ntype,need,function()
argtable.buyFunc(selectLevel)
self:onCloseClick()
end)
else
gainControl:showGainWin(ntype)
end
end

function UICommonBuyWin:onAddBtn()
if self.selectLevel>=self.maxLevel then
return
end
self.createCount=18
self.winlua:SetChildSliderValue(self.countSlider:getID(),self.selectLevel+1)
self.createCount=1
end

function UICommonBuyWin:onCutBtn()
if self.selectLevel<=self.minLevel then
return
end
self.createCount=18
self.winlua:SetChildSliderValue(self.countSlider:getID(),self.selectLevel-1)
self.createCount=1
end

function UICommonBuyWin:onCloseClick()
self:closeSelf()
end