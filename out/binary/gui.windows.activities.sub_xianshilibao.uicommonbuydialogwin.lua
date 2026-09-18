







def_class("UICommonBuyDialogWin",UIWindowBase)









function UICommonBuyDialogWin:bindComponents()

self.title=UIText.get(self,0)
self.scrollerView=UIObject.get(self,1)
self.sureBtn=UIButton.get(self,2)
self.cancelBtn=UIButton.get(self,3)
self.buyLimit=UIText.get(self,4)
self.selectCntSlider=UIObject.get(self,5)
self.costCount=UIText.get(self,6)
self.costIcon=UIImage.get(self,7)
self.handleImg=UIObject.get(self,8)
self.maxCnt=UIButton.get(self,9)
self.subBtn=UIButton.get(self,10)
self.addBtn=UIButton.get(self,11)
self.selectCntText=UIText.get(self,12)
self.canceltxt=UIText.get(self,13)
self.callbacktxt=UIText.get(self,14)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)



end


function UICommonBuyDialogWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.buyLimit);self.buyLimit=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.costCount);self.costCount=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.canceltxt);self.canceltxt=nil;
_UIObject_release(self.callbacktxt);self.callbacktxt=nil;
end



















function UICommonBuyDialogWin:onLoaded(...)
self:bindComponents()
local _onClickRewardItem=function(...)
self:onClickRewardItem(...)
end
self.scrollerView:setChildScrollViewInit(-1,true,_onClickRewardItem,nil)
end


function UICommonBuyDialogWin:__delete()
self:unbindComponents()
end




function UICommonBuyDialogWin:onShow(argtable,afterOnloaded)
self.title:setText(argtable.name)
self.rewards=argtable.rewards

self.leftNum=argtable.leftNum or 0

self.callback=argtable.callback

self.isCheckMaxSelectCount=argtable.isCheckMaxSelectCount
self.maxSelectCount=nil

self.buyLimit:setText(FMT.fmt('限购：{0}/{1}',self.leftNum,argtable.maxcount))

self.selectCnt=1

self.showBuyLimit=true
if argtable.showBuyLimit~=nil then
self.showBuyLimit=argtable.showBuyLimit
end
self.freshback=argtable.freshback


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
self.costCount:setText(argtable.comfirmText or"兑换")
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

self.selectCnt=self.min

local func=function(...)
self:onSliderChange(...)
end
self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.max>1)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,self.min,self.max,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end


self:refreshItem()


self.ReqPaycallback=argtable.ReqPaycallback
self.canReqPay=false
self:changeReqPay()


local freshback=self.freshback
if freshback then
local str=freshback(self.selectCnt)
self.callbacktxt:setText(str)
end
end

function UICommonBuyDialogWin:refreshItem()
local rewards=self.rewards
if#rewards>5 then
self.scrollerView:setChildScrollRectEnable(true)
end

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



function UICommonBuyDialogWin:onHide()

end

function UICommonBuyDialogWin:onMaxCnt()
end



function UICommonBuyDialogWin:onSubBtn()
if self.selectCnt<=1 then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UICommonBuyDialogWin:onAddBtn()
if self.max<=1 then
return
end

if self.min==self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UICommonBuyDialogWin:onLongPressBtn(id)
if id==1 then
if self.selectCnt<=1 then
return
end
self.selectCnt=self.selectCnt-1
else
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UICommonBuyDialogWin:onSliderChange(value)

self.selectCnt=value
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
self:changeReqPay()

local freshback=self.freshback
if freshback then
local str=freshback(value)
self.callbacktxt:setText(str)
end
end



function UICommonBuyDialogWin:onSureBtn()

if self.cost then
local moneyType=self.cost[1]
local moneyCount=self.cost[2]
if moneyType<=0 then
UIManager.error(FMT.fmt('没有找到货币类型{0}',moneyType))
return
end

self.selectCnt=self.selectCnt or 1

if self:checkCurrencyExceedsLimit(self.selectCnt)then
return
end

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

function UICommonBuyDialogWin:onCancelBtn()
if self.canReqPay and self.ReqPaycallback then
self.ReqPaycallback()
end
self:closeSelf()
end

function UICommonBuyDialogWin:onClickRewardItem(clickCount,index)
local rewards=self.rewards
local itemid=rewards[index+1][1]
if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid})
end


function UICommonBuyDialogWin:changeReqPay()
self.canReqPay=false
if self.ReqPaycallback then
if self.selectCnt and self.selectCnt==1 then
self.canceltxt:setText('前往付费')
self.canReqPay=true
else
self.canceltxt:setText('取消')
end
end
end


function UICommonBuyDialogWin:checkCurrencyExceedsLimit(buyCount)
for _,info in ipairs(self.rewards)do
local id=info[1]
local count=info[2]
if itemsConfig.isMoney(id)then
if moneyModel.checkMoneyOverflow(id,count*buyCount)then
local moneyName=moneyModel.getMoneyName(id)
UIManager.error(FMT.fmt("购买后{0}超出上限，无法购买",moneyName))
return true
end
end
end

return false
end
