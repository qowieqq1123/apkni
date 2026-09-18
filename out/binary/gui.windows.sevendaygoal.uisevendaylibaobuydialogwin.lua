







def_class("UISevenDayLibaoBuyDialogWin",UIWindowBase)









function UISevenDayLibaoBuyDialogWin:bindComponents()

self.title=UIText.get(self,0)
self.sureBtn=UIButton.get(self,1)
self.cancelBtn=UIButton.get(self,2)
self.selectCntSlider=UIObject.get(self,3)
self.handleImg=UIObject.get(self,4)
self.maxCnt=UIButton.get(self,5)
self.subBtn=UIButton.get(self,6)
self.addBtn=UIButton.get(self,7)
self.selectCntText=UIText.get(self,8)
self.costCount=UIText.get(self,9)
self.scrollerView=UIObject.get(self,10)
self.buyLimit=UIText.get(self,11)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)



end


function UISevenDayLibaoBuyDialogWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.costCount);self.costCount=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.buyLimit);self.buyLimit=nil;
end
















local _this




function UISevenDayLibaoBuyDialogWin:onLoaded(...)
_this=self
self:bindComponents()


local _onClickRewardItem=function(...)
self:onClickRewardItem(...)
end
self.scrollerView:setChildScrollViewInit(0.5,true,_onClickRewardItem,nil)
end


function UISevenDayLibaoBuyDialogWin:__delete()
self:unbindComponents()
_this=nil
end




function UISevenDayLibaoBuyDialogWin:onShow(argtable,afterOnloaded)
self.maxSelectCount=nil
if argtable then
self.libaoId=argtable.libaoId
self.libaoType=argtable.libaoType
self.buyParam=argtable.buyParam
self.isCheckMaxSelectCount=argtable.isCheckMaxSelectCount

local moneyType=self.buyParam.id
local moneyCount=self.buyParam.price
if self.isCheckMaxSelectCount then
local canUseMoneyCount=moneyModel.getMoney(moneyType)
if moneyType==eMoneyType.mtLingYu then

canUseMoneyCount=canUseMoneyCount+moneyModel.getMoney(eMoneyType.mtXianYu)
end
self.maxSelectCount=math.floor(canUseMoneyCount/moneyCount)
if self.maxSelectCount<=0 then
self.maxSelectCount=1
end
end
else
logErr("打开七日签到购买礼包界面未传参 请检查方法调用是否正确")
return self:closeSelf()
end

if not self.libaoId then
logErr("打开七日签到购买礼包界面未传入礼包id 请检查方法调用是否正确")
return self:closeSelf()
end

if self.libaoType~=2 then
logErr(FMT.fmt("打开七日签到购买礼包界面传入礼包类型为{0}, 不符合货币礼包类型 请检查方法调用是否正确",self.libaoType))
return self:closeSelf()
end

self.buyCount=sevenDayGoalModel:getLibaoBuyNum(self.libaoId)
self.config=cfgHelper.get1(cfg_sevendaytargetlibaoconfig_get,self.libaoId)

local title=self.config.name or"提示"
self.title:setText(title)

self:initSlider()
self:refresh()
end


function UISevenDayLibaoBuyDialogWin:onHide()

end

function UISevenDayLibaoBuyDialogWin:initSlider()
if self.config and self.config.buyLimit then
self.max=self.config.buyLimit-self.buyCount>0 and self.config.buyLimit-self.buyCount or 1
if self.maxSelectCount and self.max>self.maxSelectCount then
self.max=self.maxSelectCount
end
else
self.max=1
end

self.min=1
self.selectCnt=self.min
if not self.max or self.max<=1 then
self.buyLimit:setText(FMT.fmt('限购：{0}/{1}',self.buyCount,self.config.buyLimit))
self.buyLimit:setActive(true)
self.selectCntSlider:setActive(false)
else
self.buyLimit:setActive(false)
self.selectCntSlider:setActive(true)
local func=function(...)
self:onSliderChange(...)
end
self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.max>1)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,self.min,self.max,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)

self.selectCntText:setText(self.selectCnt)
end
end

function UISevenDayLibaoBuyDialogWin:refresh()
local moneyType=self.buyParam.id
local price=self.buyParam.price*self.selectCnt
if price then
local moneyName=itemsConfig.getItemName(moneyType)
self.selectCntText:setText(self.selectCnt)
local enough=moneyModel.checkEnoughMoney(moneyType,price)
if enough then
self.costCount:setText(FMT.fmt("{0}{1}",price,moneyName))
else
self.costCount:setText(FMT.cfmt(FONT_COLOR.eRedColor,"{0}{1}",price,moneyName))
end
else
self.costCount:setText("购买")
end

self:refreshItem()
end

function UISevenDayLibaoBuyDialogWin:refreshItem()
local rewards=self.config.items
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
item:SetChildPropData(0,prop)
end
end
end

function UISevenDayLibaoBuyDialogWin:onSliderChange(value)
if value==self.selectCnt then
return
end

self.selectCnt=value
self:refresh()
end




function UISevenDayLibaoBuyDialogWin:onSureBtn()
local moneyType=self.buyParam.id
local price=self.buyParam.price*self.selectCnt
local buyCount=self.selectCnt
local exchangeType=eMoneyType.mtXianYu
local libaoId=self.libaoId
moneySystem:useMoney(moneyType,price,function()

sevenDayGoalController:reqBuyLibao(libaoId,buyCount)
_this:closeSelf()
end,WARNING_TYPE.eWarning,exchangeType)

end



function UISevenDayLibaoBuyDialogWin:onCancelBtn()
self:closeSelf()
end



function UISevenDayLibaoBuyDialogWin:onMaxCnt()
end



function UISevenDayLibaoBuyDialogWin:onSubBtn()
if self.selectCnt<=1 then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
self:refresh()
end



function UISevenDayLibaoBuyDialogWin:onAddBtn()
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

self:refresh()
end



function UISevenDayLibaoBuyDialogWin:onClickRewardItem(clickCount,index)
local rewards=self.config.items
local itemid=rewards[index+1][1]
if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid})
end