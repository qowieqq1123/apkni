







def_class("UIFBuyFixedNumDialogWin",UIWindowBase)









function UIFBuyFixedNumDialogWin:bindComponents()

self.addBtn=UIButton.get(self,0)
self.buyLimit=UIText.get(self,1)
self.cancelBtn=UIButton.get(self,2)
self.costCount=UIText.get(self,3)
self.costIcon=UIImage.get(self,4)
self.desc=UIText.get(self,5)
self.handleImg=UIObject.get(self,6)
self.maxCnt=UIButton.get(self,7)
self.scrollerView=UIObject.get(self,8)
self.selectCntSlider=UIObject.get(self,9)
self.selectCntText=UIText.get(self,10)
self.subBtn=UIButton.get(self,11)
self.sureBtn=UIButton.get(self,12)
self.title=UIText.get(self,13)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)



end


function UIFBuyFixedNumDialogWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.buyLimit);self.buyLimit=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.costCount);self.costCount=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIFBuyFixedNumDialogWin:onLoaded(...)
self:bindComponents()
local _onClickRewardItem=function(...)
self:onClickRewardItem(...)
end
self.scrollerView:setChildScrollViewInit(-1,true,_onClickRewardItem,nil)
end


function UIFBuyFixedNumDialogWin:__delete()
self:unbindComponents()
end




function UIFBuyFixedNumDialogWin:onShow(argtable,afterOnloaded)
self.title:setText(argtable.name)
self.rewards=argtable.rewards or{}

self.leftNum=argtable.leftNum or 0

self.callback=argtable.callback

self.refreshCallback=argtable.refreshCallback

self.numArray=argtable.numArray

self.isCheckMaxSelectCount=argtable.isCheckMaxSelectCount
self.maxSelectCount=nil

self.buyLimit:setText(FMT.fmt('限购：{0}/{1}',self.leftNum,argtable.maxcount))

self.selectCntIdx=1
self.selectCnt=self.numArray and self.numArray[self.selectCntIdx]or self.selectCntIdx

self.showBuyLimit=true
if argtable.showBuyLimit~=nil then
self.showBuyLimit=argtable.showBuyLimit
end

local price=argtable.price
if price then
local moneyType=price[1]
local moneyCount=price[2]
self.cost={moneyType,moneyCount}
local name=''
if moneyType>0 then
name=itemsConfig.getItemName(moneyType)
end

local enough=itemsModel.checkItemEnough(moneyType,moneyCount)
if enough then
self.costCount:setText(FMT.fmt("{0}{1}",moneyCount,name))
else
self.costCount:setText(FMT.cfmt(FONT_COLOR.eRedColor,"{0}{1}",moneyCount,name))
end

if self.isCheckMaxSelectCount then
local canUseMoneyCount=itemsModel.getCount(moneyType)
if moneyType==eMoneyType.mtLingYu then

canUseMoneyCount=canUseMoneyCount+itemsModel.getCount(eMoneyType.mtXianYu)
end
self.maxSelectCount=math.floor(canUseMoneyCount/moneyCount)
if self.maxSelectCount<=0 then
self.maxSelectCount=1
end
end
else
self.costCount:setText(argtable.comfirmText or"购买")
end
self.max=argtable.maxcount-self.leftNum
if self.maxSelectCount and self.max>self.maxSelectCount then
self.max=self.maxSelectCount
end
self.min=1
if self.max<=1 then
self.buyLimit:setActive(self.showBuyLimit)
self.selectCntSlider:setActive(false)
if not self.showBuyLimit then
local anchoredPos=self.scrollerView:getChildAnchoredPosition()
self.scrollerView:setChildAnchoredPosition(Vector2(anchoredPos.x,0))
end
else
self.buyLimit:setActive(false)
self.selectCntSlider:setActive(true)

self.selectCntIdx=self.min

local func=function(...)
self:onSliderChange(...)
end
self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.max>1)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCntIdx,self.min,self.max,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCntIdx)
end


self:refreshItem()

self:refreshDesc()
end

function UIFBuyFixedNumDialogWin:refreshItem()
local rewards=self.rewards
self.scrollerView:setChildScrollViewCreateGrids(#rewards,#rewards)
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local reward=rewards[i]
local itemid=reward[1]
local count=reward[2]
local conf={itemid=itemid,itemcount=count*self.selectCnt,showCountBG=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
end
end
end

function UIFBuyFixedNumDialogWin:refreshDesc()
if self.refreshCallback then
local str=self.refreshCallback(self.selectCnt)
self.desc:setText(str)
end
end

function UIFBuyFixedNumDialogWin:onMaxCnt()
end



function UIFBuyFixedNumDialogWin:onSubBtn()
if self.selectCntIdx<=1 then
return
end
self.selectCntIdx=self.selectCntIdx-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCntIdx)
end



function UIFBuyFixedNumDialogWin:onAddBtn()
if self.max<=1 then
return
end

if self.min==self.max then
return
end
if self.selectCntIdx>=self.max then
return
end
self.selectCntIdx=self.selectCntIdx+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCntIdx)
end

function UIFBuyFixedNumDialogWin:onLongPressBtn(id)
if id==1 then
if self.selectCntIdx<=1 then
return
end
self.selectCntIdx=self.selectCntIdx-1
else
if self.selectCntIdx>=self.max then
return
end
self.selectCntIdx=self.selectCntIdx+1
end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCntIdx)
end

function UIFBuyFixedNumDialogWin:onSliderChange(value)

self.selectCntIdx=value
self.selectCnt=self.numArray and self.numArray[self.selectCntIdx]or self.selectCntIdx
self.selectCntText:setText(self.selectCnt)
if self.cost then
local moneyCount=self.cost[2]
self.need=self.selectCnt*moneyCount
local name=''
if self.cost[1]>0 then
name=itemsConfig.getItemName(self.cost[1])
end
local enough=itemsModel.checkItemEnough(self.cost[1],self.need)
if enough then
self.costCount:setText(FMT.fmt("{0}{1}",self.need,name))
else
self.costCount:setText(FMT.cfmt(FONT_COLOR.eRedColor,"{0}{1}",self.need,name))
end
end
self:refreshItem()
self:refreshDesc()
end



function UIFBuyFixedNumDialogWin:onSureBtn()
if self.cost then
local moneyType=self.cost[1]
local moneyCount=self.cost[2]
if moneyType<=0 then
UIManager.error(FMT.fmt('没有找到货币类型{0}',moneyType))
return
end

self.selectCnt=self.selectCnt or 1
local selectCnt=self.selectCnt
local callback=self.callback
local cb=function(...)
local cnt=selectCnt
if callback then
callback(cnt)
end
end

if itemsConfig.isMoney(moneyType)then
moneySystem:useMoney(moneyType,moneyCount*self.selectCnt,cb,WARNING_TYPE.eWarning)
else
if itemsModel.checkItemEnough(moneyType,self.selectCnt*moneyCount)then
cb()
else
gainControl:showGainWin(moneyType)
end
end
else
local selectCnt=self.selectCnt
local callback=self.callback
local cnt=selectCnt
if callback then
callback(cnt)
end
end
self:closeSelf()
end

function UIFBuyFixedNumDialogWin:onCancelBtn()
self:closeSelf()
end

function UIFBuyFixedNumDialogWin:onClickRewardItem(clickCount,index)
local rewards=self.rewards
local itemid=rewards[index+1][1]
if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid})
end
