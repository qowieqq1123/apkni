







def_class("UIXianGouBuyDialogWin",UIWindowBase)









function UIXianGouBuyDialogWin:bindComponents()

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

self.sureBtn:setButtonClick(function()self:onSureBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)



end


function UIXianGouBuyDialogWin:unbindComponents()
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
end

















local packTypeChinese={'日','周','月'}


function UIXianGouBuyDialogWin:onLoaded(...)
self:bindComponents()
local _onClickRewardItem=function(...)
self:onClickRewardItem(...)
end
self.scrollerView:setChildScrollViewInit(-1,true,_onClickRewardItem,nil)
end


function UIXianGouBuyDialogWin:__delete()
self:unbindComponents()
end




function UIXianGouBuyDialogWin:onShow(argtable,afterOnloaded)
self.config=argtable
self.title:setText(argtable.name)
self.rewards=argtable.rewards
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(argtable.id)
self.buyLimit:setText(FMT.fmt('每{0}限购：{1}/{2}',packTypeChinese[argtable.gifttype],buyNum,argtable.maxcount))

self.maxSelectCount=nil

self.selectCnt=1

local price=argtable.price
if price then
local moneyType=price[1]
local moneyCount=price[2]
self.cost={moneyType,moneyCount}
local name=''
if moneyType>0 then
name=itemsConfig.getItemName(moneyType)
end

local enough=moneyModel.checkEnoughMoney(moneyType,moneyCount)
if enough then
self.costCount:setText(FMT.fmt("{0}{1}",moneyCount,name))
else
self.costCount:setText(FMT.cfmt(FONT_COLOR.eRedColor,"{0}{1}",moneyCount,name))
end


local canUseMoneyCount=moneyModel.getMoney(moneyType)
if moneyType==eMoneyType.mtLingYu then

canUseMoneyCount=canUseMoneyCount+moneyModel.getMoney(eMoneyType.mtXianYu)
end
self.maxSelectCount=math.floor(canUseMoneyCount/moneyCount)
if self.maxSelectCount<=0 then
self.maxSelectCount=1
end

self.max=argtable.maxcount-buyNum
if self.maxSelectCount and self.max>self.maxSelectCount then
self.max=self.maxSelectCount
end

self.min=1
if self.max<=1 then
self.buyLimit:setActive(true)
self.selectCntSlider:setActive(false)
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

else

if self.config.rechargeid then
self.rechargeid=self.config.rechargeid
local rechargecfg=cfg_rechargeconfig_get(self.config.rechargeid)
local rmb=rechargecfg.rmb
if rmb then
self.costCount:setText(pfwindowslController:showDesc_ByMoneyType(rechargecfg))
end
self.buyLimit:setActive(true)
self.selectCntSlider:setActive(false)
end
end



self:refreshItem()
end

function UIXianGouBuyDialogWin:refreshItem()
local rewards=rechargeModel:getXianGouLiBaoRewards(self.rewards)
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


function UIXianGouBuyDialogWin:onHide()

end




function UIXianGouBuyDialogWin:onMaxCnt()
end



function UIXianGouBuyDialogWin:onSubBtn()
if self.selectCnt<=1 then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UIXianGouBuyDialogWin:onAddBtn()
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

function UIXianGouBuyDialogWin:onLongPressBtn(id)
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

function UIXianGouBuyDialogWin:onSliderChange(value)

self.selectCnt=value
self.selectCntText:setText(self.selectCnt)
local moneyCount=self.cost[2]
self.need=self.selectCnt*moneyCount
local name=''
if self.cost[1]>0 then
name=itemsConfig.getItemName(self.cost[1])
end
local enough=moneyModel.checkEnoughMoney(self.cost[1],self.need)
if enough then
self.costCount:setText(FMT.fmt("{0}{1}",self.need,name))
else
self.costCount:setText(FMT.cfmt(FONT_COLOR.eRedColor,"{0}{1}",self.need,name))
end
self:refreshItem()
end



function UIXianGouBuyDialogWin:onSureBtn()


if self:checkCurrencyExceedsLimit()then
return
end

local configId=self.config.id
if self.cost then
local moneyType=self.cost[1]
local moneyCount=self.cost[2]
if moneyType<=0 then
UIManager.error(FMT.fmt('没有找到货币类型{0}',moneyType))
return
end

self.selectCnt=self.selectCnt or 1

local selectCnt=self.selectCnt
local cb=function(...)
rechargeController:reqXianGouLiBaoBuy(configId,selectCnt)
end

moneySystem:useMoney(moneyType,moneyCount*self.selectCnt,cb,WARNING_TYPE.eWarning)
else

if self.rechargeid then
payControl.reqPay(self.rechargeid)

end
end
self:closeSelf()
end

function UIXianGouBuyDialogWin:onCancelBtn()
self:closeSelf()
end

function UIXianGouBuyDialogWin:onClickRewardItem(clickCount,index)
local cfgs=self.config.rewards
local rewards=rechargeModel:getXianGouLiBaoRewards(cfgs)
local itemid=rewards[index+1][1]
if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid})
end


function UIXianGouBuyDialogWin:checkCurrencyExceedsLimit()
local rewardInfos=self.rewards[1][3]
for _,info in ipairs(rewardInfos)do
local id=info[1]
local count=info[2]
if itemsConfig.isMoney(id)then
if moneyModel.checkMoneyOverflow(id,count)then
local moneyName=moneyModel.getMoneyName(id)
UIManager.error(FMT.fmt("购买后{0}超出上限，无法购买",moneyName))
return true
end
end
end

return false
end
