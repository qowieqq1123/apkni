







def_class("UIBaoLingShuPickUp_ShopWin",UIWindowBase)









function UIBaoLingShuPickUp_ShopWin:bindComponents()

self.pickUpTime=UIText.get(self,0)
self.goodsScrollview=UIObject.get(self,1)
self.gbListPanel=UIObject.get(self,2)
self.nextStartTimeTipsText=UIText.get(self,3)
self.title=UIImage.get(self,4)
self.nextStartTimeTips=UIObject.get(self,5)
self.moneyIcon=UIImage.get(self,6)
self.moneyCount=UIText.get(self,7)
self.moneyPanel=UIObject.get(self,8)
self.modelMao=UIObject.get(self,9)
self.bgModel=UIObject.get(self,10)



end


function UIBaoLingShuPickUp_ShopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.pickUpTime);self.pickUpTime=nil;
_UIObject_release(self.goodsScrollview);self.goodsScrollview=nil;
_UIObject_release(self.gbListPanel);self.gbListPanel=nil;
_UIObject_release(self.nextStartTimeTipsText);self.nextStartTimeTipsText=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.nextStartTimeTips);self.nextStartTimeTips=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyCount);self.moneyCount=nil;
_UIObject_release(self.moneyPanel);self.moneyPanel=nil;
_UIObject_release(self.modelMao);self.modelMao=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end
















local childIndex=
{
moneyTxt=0,
moneyImg=1,
sold=2,
special=6,
item=7,
limit=8,
name=9,
lock=10,
lockTxt=11,
unlock=12,
normalBg=13,
mask=14,
reddot=15,
}

local gubaoItemIndex=
{
gbImage=0,
exchangeLimitText=1,
exchangeBtn=2,
moneyText=3,
moneyIcon=4,
click=5,
sellOutText=6,
gbImageGrayMask=7,
gbModel=8,
reddot=9,
gbactiveimg=10,
}
local _this



function UIBaoLingShuPickUp_ShopWin:onLoaded(...)
_this=self
self:bindComponents()

local clickEvent=function(...)
self:onClickItemCallback(...)
end
self.goodsScrollview:setChildScrollViewInit(0,true,clickEvent,nil)
self:addNotify(notifyConfig.on_money_changed,self.onMoneyChanged)
end


function UIBaoLingShuPickUp_ShopWin:__delete()
self:unbindComponents()
_this=nil
end




function UIBaoLingShuPickUp_ShopWin:onShow(argtable,afterOnloaded)
self.shopId=eFuncShopType.eXuYuan
self.shopCfg=cfgHelper.get(cfg_shoplistconfig_get,self.shopId)

local moneyBar=self.shopCfg.moneyBar
self.showMoneyType=moneyBar and moneyBar[1]and moneyBar[1][1]or nil
if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.modelMao:getID(),4016,0.21,{},eAnimationID.stand)
if webGLHelper:isRunWebGL()then
local abName=webGLHelper:getReplaceResourceAB('baoLingShuLiBaoShangPuBG')
self.bgModel:setSprite(abName[1],abName[2])
else

self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),4859,1,{},eAnimationID.stand)
end

end

self:updateView(true)
end


function UIBaoLingShuPickUp_ShopWin:onHide()
self.gbListPanel:setActive(false)
end

function UIBaoLingShuPickUp_ShopWin:onfresh()
self:updateView()
end

function UIBaoLingShuPickUp_ShopWin:updateView(freshTime)
self.shopList=funcShopModel:get_sort_list(self.shopId)
local length=#self.shopList
self.goodsScrollview:setChildScrollViewCreateGrids(length,3)
for i=1,length do
self:flushGoods(i-1)
end


self:refreshShowGBPanel()

if freshTime then
local endtime=funcShopController:getEndTime(self.shopId)
if endtime then
self:refreshTime(endtime)
end
end


self:refreshMoneyPanel()
end

function UIBaoLingShuPickUp_ShopWin:refreshTime(endTime)
local curTime=timeHelper.getServerShortTime()
local isInPickUpNow=baoLingShuModel:checkIsInPickUpNow()
if not isInPickUpNow then
self.nextStartTimeTipsText:setText(FMT.fmt('预计<color=#F7F7F7>{0}</color>后开启',timeHelper.format_time_stamp2(endTime-curTime)))
end
self.pickUpTime:setText(timeHelper.format_time_stamp3(endTime-curTime))
self:stopSelfTimer()
local func=function()
local serTime=timeHelper.getServerShortTime()
local dtTime=endTime-serTime
local showTime=dtTime>=0 and dtTime or 0
if not baoLingShuModel:checkIsInPickUpNow()then
self.nextStartTimeTipsText:setText(FMT.fmt('预计<color=#F7F7F7>{0}</color>后开启',timeHelper.format_time_stamp2(showTime)))
end
self.pickUpTime:setText(timeHelper.format_time_stamp3(showTime))
if dtTime<=-5 then
self:stopSelfTimer()
funcShopController.send_23_1(self.shopId)
end
end
self.timer=self:setTimer(1,0,func)
end

function UIBaoLingShuPickUp_ShopWin:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIBaoLingShuPickUp_ShopWin:refreshShowGBPanel()

self.gbExchangeList=baoLingShuModel:getPickUpShowGBList()or{}
self.gbListPanel:setActive(true)
local grids=self.gbListPanel:getChildCommonLayoutGroupWidgetList()
local isInPickUpNow=baoLingShuModel:checkIsInPickUpNow()
if not self.showModelEffectIdList then
self.showModelEffectIdList={}
end
for i=1,grids.Count do
local widget=grids[i-1]
local guBaoItem=self.gbExchangeList[i]
if guBaoItem then
widget:SetChildActive(-1,true)
local gubaoItemId=guBaoItem[1]
local moneyType=guBaoItem[3]
local price=guBaoItem[4]
local limitCount=guBaoItem[5]

local gbId=gubaoLookup:good2GuBao(gubaoItemId)
local gbCfg=cfgHelper.get1(cfg_gubaoconfig_get,gbId)



widget:SetChildButtonClick(gubaoItemIndex.click,function()
itemsComponentHelper.onItemClickEx(gubaoItemId)
end)

local isActiveGb=gubaoModel:checkActive(gbId)
widget:SetChildActive(gubaoItemIndex.gbactiveimg,isActiveGb)

local itemCfg=itemsConfig.getConfig(gbId,ITEM_CONFIG_TYPE.eGuBao)
local pram=itemCfg.relevantPram.pram
local effectId=pram.effectid

if effectId then
if self.showModelEffectIdList[i]~=effectId then
widget:SetChildShowEffect(gubaoItemIndex.gbModel,effectId,true)
self.showModelEffectIdList[i]=effectId
end
else
widget:SetChildShowEffect(gubaoItemIndex.gbModel,0,false)
end

local limitStr
if isInPickUpNow then
local exchangeNum=baoLingShuModel:getBLSPickUpShopExchangeNumByGBItemId(gubaoItemId)
local remainingExchangeCount=limitCount-exchangeNum
local isSellOut=false
if remainingExchangeCount<=0 then
remainingExchangeCount=0
isSellOut=true
limitStr=FMT.fmt("本期兑换(<color=#f36666>{0}/{1}</color>)",remainingExchangeCount,limitCount)
else
limitStr=FMT.fmt("本期兑换(<color=#aae252>{0}/{1}</color>)",remainingExchangeCount,limitCount)
end


if not isSellOut then
widget:SetChildActive(gubaoItemIndex.moneyText,true)
widget:SetChildActive(gubaoItemIndex.sellOutText,false)
widget:SetChildText(gubaoItemIndex.moneyText,price)
local icon=moneyModel.getIconNameEx(moneyType)
widget:SetChildCSImageIcon(gubaoItemIndex.moneyIcon,icon,false)
widget:SetChildButtonClick(gubaoItemIndex.exchangeBtn,function()
self:onClickGBExchangeBtn(i)
end)

local isEoughMoney=moneyModel.checkEnoughMoney(moneyType,price)
local buyReddot=isEoughMoney
widget:SetChildActive(gubaoItemIndex.reddot,buyReddot)

else
widget:SetChildActive(gubaoItemIndex.moneyText,false)
widget:SetChildActive(gubaoItemIndex.sellOutText,true)

widget:SetChildActive(gubaoItemIndex.reddot,false)
end
widget:SetChildButtonEnable(gubaoItemIndex.exchangeBtn,not isSellOut,isSellOut)

else
limitStr="下期开启"
widget:SetChildActive(gubaoItemIndex.exchangeBtn,false)


end
widget:SetChildText(gubaoItemIndex.exchangeLimitText,limitStr)
else
widget:SetChildActive(-1,false)
end
end

local abName="ui/windows/baolingshu/baolingshu_wish_atlas_pak.ab"
if isInPickUpNow then

self.title:setSprite(abName,"image_xuyuanshangpuui_3")
else

self.title:setSprite(abName,"image_xuyuanshangpuui_4")
end
self.nextStartTimeTips:setActive(not isInPickUpNow)
end

function UIBaoLingShuPickUp_ShopWin:flushGoods(index)
local cfgItem=self.shopList[index+1]
local sold=cfgItem.sold
local unlock=cfgItem.unlock
local cfg=cfgItem.cfg
local slot=self.goodsScrollview:getChildScrollViewItemWidget(index)

local buyData=funcShopModel:get_data(self.shopId,cfg.id)
local buyNum=buyData and buyData.buyNum or 0
local max=nil

local itemId=cfg.itemId
local itemNum=cfg.itemNum or 1
if itemNum<=1 then
itemNum=0
end

widgetHelper.setNormalRewardItem(slot,childIndex.item,{itemId,itemNum,showStage=true})


slot:SetChildText(childIndex.name,itemsConfig.getItemName(itemId))
slot:SetChildActive(childIndex.lock,not unlock)


slot:SetChildText(childIndex.limit,"")
slot:SetChildText(childIndex.moneyTxt,"")
slot:SetChildActive(childIndex.limit,false)


if not unlock then
slot:SetChildText(childIndex.lockTxt,funcShopModel:get_lock_tips(self.shopId,cfg.id))
slot:SetChildActive(childIndex.unlock,false)
slot:SetChildActive(childIndex.mask,true)
else
slot:SetChildActive(childIndex.unlock,true)
slot:SetChildActive(childIndex.sold,sold)
slot:SetChildActive(childIndex.mask,sold==true)
local buyReddot=false
if sold then

else
if cfg.buyLimit then
local cfgLimit=cfgHelper.get(cfg_shoplimitconfig_get,cfg.buyLimit[1][1])
max=cfg.buyLimit[1][2]-buyNum
slot:SetChildText(childIndex.limit,FMT.fmt("{0}{1}",cfgLimit.limitStr,max))
slot:SetChildActive(childIndex.limit,true)
end
slot:SetChildActive(childIndex.special,cfg.xiyouFlag==1)
end
if cfg.money then

local moneyType=cfg.money[1]
local price=cfg.money[2]
local isEoughMoney=moneyModel.checkEnoughMoney(moneyType,price)
buyReddot=not sold and isEoughMoney

slot:SetChildIcon(childIndex.moneyImg,iconHelper.getIconName(cfg.money[1]),false)
local moneyStr=cfg.money[2]
if not isEoughMoney then
moneyStr=FMT.cfmt(FONT_COLOR.eRedColor,"{0}",moneyStr)
end
slot:SetChildText(childIndex.moneyTxt,moneyStr)

end

end


end


function UIBaoLingShuPickUp_ShopWin:refreshBuyReddot()





























local grids=self.gbListPanel:getChildCommonLayoutGroupWidgetList()
local isInPickUpNow=baoLingShuModel:checkIsInPickUpNow()
for i=1,grids.Count do
local widget=grids[i-1]
local guBaoItem=self.gbExchangeList[i]
if guBaoItem then
local gubaoItemId=guBaoItem[1]
local moneyType=guBaoItem[3]
local price=guBaoItem[4]
local limitCount=guBaoItem[5]
if isInPickUpNow then
local exchangeNum=baoLingShuModel:getBLSPickUpShopExchangeNumByGBItemId(gubaoItemId)
local remainingExchangeCount=limitCount-exchangeNum
local isSellOut=false
if remainingExchangeCount<=0 then
remainingExchangeCount=0
isSellOut=true
end


if not isSellOut then
local isEoughMoney=moneyModel.checkEnoughMoney(moneyType,price)
local buyReddot=isEoughMoney
widget:SetChildActive(gubaoItemIndex.reddot,buyReddot)
else
widget:SetChildActive(gubaoItemIndex.reddot,false)
end
end
end
end

end

function UIBaoLingShuPickUp_ShopWin:refreshMoneyPanel()
if not self.showMoneyType then
self.moneyPanel:setActive(false)
return
end

self.moneyPanel:setActive(true)
local icon=moneyModel.getIconNameEx(self.showMoneyType)
self.moneyIcon:setImageIcon(icon,false)
local moneyVal=moneyModel.getMoney(self.showMoneyType)
self.moneyCount:setText(moneyVal)
end


function UIBaoLingShuPickUp_ShopWin:onClickItemCallback(clickNum,index)

index=index+1
if index==0 then
return
end
local cfgItem=self.shopList[index]
local sold=cfgItem.sold
local unlock=cfgItem.unlock
local cfg=cfgItem.cfg
local buyId=cfg.id
local buyData=funcShopModel:get_data(self.shopId,cfg.id)
local buyNum=buyData and buyData.buyNum or 0
local max=nil
if unlock then
if not sold then
if cfg.buyLimit then
max=cfg.buyLimit[1][2]-buyNum
end
end
end

if sold then
UIManager.error("已售罄")
return
end
if not unlock then
UIManager.error("未解锁")
return
end

local moneyType=cfg.money[1]
local singlePrice=cfg.money[2]
local isEoughMoney=moneyModel.checkEnoughMoney(moneyType,singlePrice)
if not isEoughMoney then
local moneyName=moneyModel.getMoneyName(moneyType)
local err=FMT.fmt('{0}不足',moneyName)
UIManager.error(err)
gainControl:showGainWin(moneyType)
return
end

local showdata=
{
type='UIUseItemDialouge',
title='提示',
canceltext='取消',
oktext='购买',
max=max,
itemId=cfg.money[1],
unitPrice=cfg.money[2],
okcallback=function(num)
if not baoLingShuModel:checkIsInPickUpNow()then
UIManager.error("本期许愿商铺已结束")
return
end
funcShopController.send_23_2(self.shopId,buyId,num)
end,

showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end

function UIBaoLingShuPickUp_ShopWin:onClickGBExchangeBtn(index)

if not index then
return
end
local guBaoItem=self.gbExchangeList and self.gbExchangeList[index]or nil
if not guBaoItem then
return
end
local showGBListIndex=baoLingShuModel:getPickUpShowGBListIndex()
local gubaoItemId=guBaoItem[1]
local limitCount=guBaoItem[5]
local exchangeNum=baoLingShuModel:getBLSPickUpShopExchangeNumByGBItemId(gubaoItemId)

if exchangeNum>=limitCount then
UIManager.error("已售罄")
return
end

local maxExchangeNum=limitCount-exchangeNum
local moneyType=guBaoItem[3]
local price=guBaoItem[4]
local showdata=
{
type='UIUseItemDialouge',
title='提示',
canceltext='取消',
oktext='购买',
max=maxExchangeNum,
itemId=moneyType,
unitPrice=price,
okcallback=function(num)
if not baoLingShuModel:checkIsInPickUpNow()then
UIManager.error("本期许愿商铺已结束")
return
end
baoLingShuController:req_getBLSPickUpExchangeGB(showGBListIndex,index,num)
end,

showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end

function UIBaoLingShuPickUp_ShopWin.onMoneyChanged(moneyType,oldVal,newVal)
if _this==nil then
return
end

if _this.showMoneyType and _this.showMoneyType==moneyType then
_this:refreshMoneyPanel()
_this:refreshBuyReddot()
end
end