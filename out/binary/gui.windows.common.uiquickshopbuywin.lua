







def_class("UIQuickShopBuyWin",UIWindowBase)









function UIQuickShopBuyWin:bindComponents()

self.root=UIObject.get(self,0)
self.overTips=UIText.get(self,1)
self.costRoot=UIObject.get(self,2)
self.maxLimitTx=UIText.get(self,3)
self.selectBtn=UIButton.get(self,4)
self.shopItem=UIBaseItem.get(self,5)
self.selectCntSlider=UIObject.get(self,6)
self.numTx=UIText.get(self,7)
self.maxCnt=UIButton.get(self,8)
self.handleImg=UIObject.get(self,9)
self.addBtn=UIButton.get(self,10)
self.subBtn=UIButton.get(self,11)
self.costIcon=UIImage.get(self,12)
self.costNum=UIText.get(self,13)
self.moneyNum=UIText.get(self,14)
self.moneyIcon=UIImage.get(self,15)
self.selectCntText=UIText.get(self,16)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)



end


function UIQuickShopBuyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.overTips);self.overTips=nil;
_UIObject_release(self.costRoot);self.costRoot=nil;
_UIObject_release(self.maxLimitTx);self.maxLimitTx=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.shopItem);self.shopItem=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.numTx);self.numTx=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
end















local _this



function UIQuickShopBuyWin:onLoaded(...)
self:bindComponents()
_this=self

notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:listenNotify(notifyConfig.onCommonShopData,self.onCommonShopData)
notifySystem:listenNotify(notifyConfig.onCommonShopChange,self.onCommonShopChange)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.onNewWeek5am,self.onNewWeek5am)
notifySystem:listenNotify(notifyConfig.onNewMonth5am,self.onNewMonth5am)
end


function UIQuickShopBuyWin:__delete()
self:unbindComponents()
_this=nil
self:stopExpiredTick()
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:removelistener(notifyConfig.on_item_list_changed,self.on_item_list_changed)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:removelistener(notifyConfig.onCommonShopData,self.onCommonShopData)
notifySystem:removelistener(notifyConfig.onCommonShopChange,self.onCommonShopChange)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:removelistener(notifyConfig.onNewWeek5am,self.onNewWeek5am)
notifySystem:removelistener(notifyConfig.onNewMonth5am,self.onNewMonth5am)
end




function UIQuickShopBuyWin:onShow(argtable,afterOnloaded)
self.itemId=argtable.itemId
self.shopId=argtable.shopId
self.parentWin=argtable.parentWin
self.closeCallback=argtable.closeCallback

self.shopCfg=cfgHelper.get1(cfg_shoplistconfig_get,self.shopId)
self.shopConfig=funcShopModel.get_shop_item_conf(self.shopId)
for i,v in pairs(self.shopConfig)do
if v.itemId==self.itemId then
self.buyId=i
self.buyConfig=v
break
end
end

if self.buyId==nil then
loggerUtil.logErrFMT("商店配置没有对应货物：{0},{1}",self.shopId,self.itemId)
return
end

self:updateBuyData()
if self.buyData==nil and self.checkOpen then
funcShopController.send_23_1(self.shopId)
end

self.limitType=self.buyConfig.buyLimit[1][1]
self.costMoney=self.buyConfig.money[1]
self.costPer=self.buyConfig.money[2]

self.lockTips=funcShopModel:get_lock_tips(self.shopId,self.buyId)
self.moneyIcon:setImageIcon(iconHelper.getIconName(self.costMoney),false)
self.costIcon:setImageIcon(iconHelper.getIconName(self.costMoney),false)
self:refreshMoneyNum()

self.minCount=1
self:refreshView(true)

local conf={itemid=self.itemId,itemcount="",showCountBG=false,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.shopItem:setChildPropData(prop)

self.numTx:setText(FMT.fmt("<color=#73401D>数量：</color>{0}",self.buyConfig.itemNum*self.selectCnt))

if argtable.showCallback then
argtable.showCallback(self)
end
end


function UIQuickShopBuyWin:onHide()

end



function UIQuickShopBuyWin:updateBuyData()
self.buyData=funcShopModel:get_data(self.shopId,self.buyId)
self.checkOpen=funcShopModel:checkFuncShopTypeFuncOpen(self.shopCfg.shopType)
end

function UIQuickShopBuyWin:checkBuyDataExpired()
if self.checkOpen then
if self.limitType==eFuncShopLimitType.eSeason or self.limitType==eFuncShopLimitType.ePeriod then
self.expiredTime=funcShopModel:getFuncShopTypeFuncEndTime(self.shopCfg.shopType)
else
self.expiredTime=nil
end
if self.expiredTime then
self:startExpiredTick()
end
end
end

function UIQuickShopBuyWin:startExpiredTick()
if not self.expiredTick then
self.expiredTick=self:setTimer(1,0,function()
local nowTime=timeHelper.getServerShortTime()
if nowTime>self.expiredTime then
if self.checkOpen then
funcShopController.send_23_1(self.shopId)
end
self:stopExpiredTick()
end
end)
end
end

function UIQuickShopBuyWin:stopExpiredTick()
if self.expiredTick then
self:stopTimerByID(self.expiredTick)
self.expiredTick=nil
end
end

function UIQuickShopBuyWin:refreshMoneyNum()
local value=itemsModel.getCount(self.costMoney)
self.moneyNum:setText(mathHelper.formatNumber(value))
end

function UIQuickShopBuyWin:refreshCostNum()
local haveNum=itemsModel.getCount(self.costMoney)
local needNum=self.costPer*self.selectCnt
local costNumStr=mathHelper.formatNumber(needNum)
if haveNum<needNum then
costNumStr=FMT.cfmt(FONT_COLOR.eRedColor,costNumStr)
end
self.costNum:setText(costNumStr)
end

function UIQuickShopBuyWin:refreshView(reset)
if reset then
self.selectCnt=self.minCount
end

self.maxCount=self.buyConfig.buyLimit[1][2]-(self.buyData and self.buyData.buyNum or 0)
self.enabled=self.minCount<=self.maxCount

self.overTipsStr=nil
if not self.checkOpen then
self.overTipsStr="系统未开放"
elseif self.lockTips~=""then
self.overTipsStr=self.lockTips
elseif not self.enabled then
self.overTipsStr="兑换次数已用完"
end
local haveTips=self.overTipsStr~=nil
self.selectBtn:setActive(not haveTips)
self.costRoot:setActive(not haveTips)
self.overTips:setText(self.overTipsStr or"")

local limitName=funcShopModel.getLimitStr(self.limitType)
limitName=string.replace(limitName,"限购：","")
self.maxLimitTx:setText(FMT.fmt("（{0}剩余兑换次数：{1}）",limitName,self.maxCount))

if self.enabled then
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,self.minCount,self.maxCount,function(...)
self:onSliderChange(...)
end)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
else
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),0,0,0,nil)
self:onSliderChange(0)
end
end



function UIQuickShopBuyWin:onSelectBtn()
if self.overTipsStr then
UIManager.error(self.overTipsStr)
return
end

if self.selectCnt>self.maxCount and self.selectCnt<self.minCount then
UIManager.error("选择数量错误")
return
end

local haveNum=itemsModel.getCount(self.costMoney)
local needNum=self.costPer*self.selectCnt
if haveNum<needNum then
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(self.costMoney)))
end

funcShopController.send_23_2(self.shopId,self.buyId,self.selectCnt)
end



function UIQuickShopBuyWin:onMaxCnt()
if not self.enabled then return end
self.selectCnt=self.maxCount
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UIQuickShopBuyWin:onAddBtn()
if not self.enabled then return end
self.selectCnt=self.selectCnt+1
if self.selectCnt>self.maxCount then
self.selectCnt=self.maxCount
end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UIQuickShopBuyWin:onSubBtn()
if not self.enabled then return end
self.selectCnt=self.selectCnt-1
if self.selectCnt<self.minCount then
self.selectCnt=self.minCount
end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIQuickShopBuyWin:onSliderChange(value)
self.selectCnt=value
self.selectCntText:setText(self.selectCnt)




self.numTx:setText(FMT.fmt("<color=#73401D>数量：</color>{0}",self.buyConfig.itemNum*self.selectCnt))

self:refreshCostNum()
end

function UIQuickShopBuyWin:onCloseBtn()
if self.closeCallback then
self:closeCallback()
elseif self.parentWin then
self.parentWin:onCloseClick()
end
end

function UIQuickShopBuyWin.on_money_changed(moneyType,lastVal,val,changeType)
if moneyType==_this.costMoney then
_this:refreshMoneyNum()
_this:refreshCostNum()
end
end

function UIQuickShopBuyWin.on_item_list_changed(argsTable)
for i,v in ipairs(argsTable)do
local itemid=v[3]
local newVal=v[5]
if itemid==_this.costMoney then
_this:refreshMoneyNum()
_this:refreshCostNum()
end
end
end

function UIQuickShopBuyWin.on_item_changed(changeType,itemguid,itemid,oldVal,newVal)
if itemid==_this.costMoney then
_this:refreshMoneyNum()
end
end

function UIQuickShopBuyWin.onCommonShopData(shopId)
if shopId==_this.shopId then
_this:updateBuyData()
_this:checkBuyDataExpired()
_this:refreshView(false)
end
end

function UIQuickShopBuyWin.onCommonShopChange(shopId,buyId,buyNum)
if shopId==_this.shopId and buyId==_this.buyId then
local num=_this.buyConfig.itemNum*buyNum
local itemid=_this.itemId
UIManager:invokeUIMethod("UICommonMoneyGainWin","onCloseClick")
showPrizeControl.showWindow({{itemid=itemid,num=num}})



end
end

function UIQuickShopBuyWin.onNewDay5am()
if _this.limitType==eFuncShopLimitType.eDay and _this.checkOpen then
funcShopController.send_23_1(_this.shopId)
end
end

function UIQuickShopBuyWin.onNewWeek5am()
if _this.limitType==eFuncShopLimitType.eWeek and _this.checkOpen then
funcShopController.send_23_1(_this.shopId)
end
end

function UIQuickShopBuyWin.onNewMonth5am()
if _this.limitType==eFuncShopLimitType.eMonth and _this.checkOpen then
funcShopController.send_23_1(_this.shopId)
end
end