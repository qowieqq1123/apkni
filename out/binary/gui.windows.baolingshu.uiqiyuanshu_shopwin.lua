







def_class("UIQiYuanShu_ShopWin",UIWindowBase)









function UIQiYuanShu_ShopWin:bindComponents()

self.pickUpTime=UIText.get(self,0)
self.goodsScrollview=UIObject.get(self,1)
self.title=UIImage.get(self,2)
self.moneyIcon=UIImage.get(self,3)
self.moneyCount=UIText.get(self,4)
self.moneyPanel=UIObject.get(self,5)
self.modelMao=UIObject.get(self,6)
self.bgModel=UIObject.get(self,7)



end


function UIQiYuanShu_ShopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.pickUpTime);self.pickUpTime=nil;
_UIObject_release(self.goodsScrollview);self.goodsScrollview=nil;
_UIObject_release(self.title);self.title=nil;
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
specialBg=16,
specialFlag=17,
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




function UIQiYuanShu_ShopWin:onLoaded(...)
_this=self
self:bindComponents()

local clickEvent=function(...)
self:onClickItemCallback(...)
end
self.goodsScrollview:setChildScrollViewInit(0,true,clickEvent,nil)
self:addNotify(notifyConfig.on_money_changed,self.onMoneyChanged)


end


function UIQiYuanShu_ShopWin:__delete()
self:unbindComponents()
_this=nil
end




function UIQiYuanShu_ShopWin:onShow(argtable,afterOnloaded)
self.shopId=eFuncShopType.eQiYuan
self.shopCfg=cfgHelper.get(cfg_shoplistconfig_get,self.shopId)

local moneyBar=self.shopCfg.moneyBar
self.showMoneyType=moneyBar and moneyBar[1]and moneyBar[1][1]or nil
if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.modelMao:getID(),4016,0.32,{},eAnimationID.stand)
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5507,1,{},eAnimationID.stand)
end

self.data=funcShopModel:GetqiyuanshuShop()
self:updateView(true)
end


function UIQiYuanShu_ShopWin:onHide()

end

function UIQiYuanShu_ShopWin:onfresh()
self:updateView()
end
function UIQiYuanShu_ShopWin:onseverfresh()
_this:updateView()
end

function UIQiYuanShu_ShopWin:updateView(freshTime)
self.shopList=self:get_sort_list(self.shopId)

local list={}
for k,v in ipairs(self.shopList)do
if v.unlock then
list[#list+1]=v
end
end
self.shopList=list
local length=#self.shopList
self.goodsScrollview:setChildScrollViewCreateGrids(length,2)
for i=1,length do
self:flushGoods(i-1)
end




if freshTime then
local endtime=funcShopController:getEndTime(self.shopId)
if endtime then
self:refreshTime(endtime)
end
end


self:refreshMoneyPanel()
end

function UIQiYuanShu_ShopWin:refreshTime(endTime)
local curTime=timeHelper.getServerShortTime()


self.pickUpTime:setText(timeHelper.format_time_stamp3(endTime-curTime))
self:stopSelfTimer()
local func=function()
local serTime=timeHelper.getServerShortTime()
local dtTime=endTime-serTime
local showTime=dtTime>=0 and dtTime or 0






self.pickUpTime:setText(timeHelper.format_time_stamp3(showTime))
if dtTime<=-5 then
self:stopSelfTimer()
funcShopController.send_23_1(self.shopId)
end
end
self.timer=self:setTimer(1,0,func)
end

function UIQiYuanShu_ShopWin:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIQiYuanShu_ShopWin:refreshShowGBPanel()

self.gbListPanel:setActive(true)
local grids=self.gbListPanel:getChildCommonLayoutGroupWidgetList()
local isInQiYuanNow=qiYuanShuModel:checkIsInQiYuanNow()
if not self.showModelEffectIdList then
self.showModelEffectIdList={}
end
for i=1,grids.Count do
local widget=grids[i-1]
local guBaoItem=self.shopList_special[i]
if guBaoItem then
widget:SetChildActive(-1,true)
local sold=guBaoItem.sold
local unlock=guBaoItem.unlock
local cfg=guBaoItem.cfg

local gubaoItemId=cfg.itemId
local moneyType=cfg.money[1]
local price=cfg.money[2]
local buyData=funcShopModel:get_data(self.shopId,cfg.id)
local buyNum=funcShopModel:qiyuanshu_findNum(cfg.id)
local limitCount=cfg.buyLimit[1][2]
local cfgLimit=cfgHelper.get(cfg_shoplimitconfig_get,cfg.buyLimit[1][1])

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
if isInQiYuanNow then
local remainingExchangeCount=limitCount-buyNum
local isSellOut=false
if remainingExchangeCount<=0 then
remainingExchangeCount=0
isSellOut=true
limitStr=FMT.fmt("{0}(<color=#f36666>{1}/{2}</color>)",cfgLimit.limitStr,remainingExchangeCount,limitCount)
else
limitStr=FMT.fmt("{0}(<color=#aae252>{1}/{2}</color>)",cfgLimit.limitStr,remainingExchangeCount,limitCount)
end


if not isSellOut then
widget:SetChildActive(gubaoItemIndex.moneyText,true)
widget:SetChildActive(gubaoItemIndex.sellOutText,false)
widget:SetChildText(gubaoItemIndex.moneyText,price)
local icon=moneyModel.getIconNameEx(moneyType)
widget:SetChildCSImageIcon(gubaoItemIndex.moneyIcon,icon,false)
widget:SetChildButtonClick(gubaoItemIndex.exchangeBtn,function()
self:onClickGBExchangeBtn(i)
end,true)

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
if isInQiYuanNow then

self.title:setSprite(abName,"image_xuyuanshangpuui_3")
else

self.title:setSprite(abName,"image_xuyuanshangpuui_4")
end

end

function UIQiYuanShu_ShopWin:flushGoods(index)
local cfgItem=self.shopList[index+1]
local sold=cfgItem.sold
local unlock=cfgItem.unlock
local cfg=cfgItem.cfg
local slot=self.goodsScrollview:getChildScrollViewItemWidget(index)

local buyData=funcShopModel:get_data(self.shopId,cfg.id)
local buyNum=funcShopModel:qiyuanshu_findNum(cfg.id)
local max=nil

local itemId=cfg.itemId
local itemNum=cfg.itemNum or 1
if itemNum<=1 then
itemNum=0
end
local isSpecial=cfg.specialFlag and cfg.specialFlag==1 or false
slot:SetChildActive(childIndex.normalBg,not isSpecial)
slot:SetChildActive(childIndex.specialBg,isSpecial)
slot:SetChildActive(childIndex.specialFlag,isSpecial)

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
slot:SetChildActive(childIndex.reddot,false)
slot:SetChildActive(childIndex.special,false)
else
slot:SetChildActive(childIndex.unlock,true)
slot:SetChildActive(childIndex.sold,sold)
slot:SetChildActive(childIndex.mask,sold==true)
local buyReddot=false
if cfg.buyLimit then
local cfgLimit=cfgHelper.get(cfg_shoplimitconfig_get,cfg.buyLimit[1][1])
max=cfg.buyLimit[1][2]-buyNum
slot:SetChildText(childIndex.limit,FMT.fmt("{0}{1}",cfgLimit.limitStr,max))
slot:SetChildActive(childIndex.limit,true)
end
slot:SetChildActive(childIndex.special,cfg.xiyouFlag==1)
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
slot:SetChildActive(childIndex.reddot,isSpecial and buyReddot)
end


end


function UIQiYuanShu_ShopWin:refreshBuyReddot()
local grids=self.goodsScrollview:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local slot=grids[i-1]
local cfgItem=self.shopList[i]
local sold=cfgItem.sold
local unlock=cfgItem.unlock
local cfg=cfgItem.cfg
local isSpecial=cfg.specialFlag and cfg.specialFlag==1 or false

if unlock then
local buyReddot=false
if cfg.money then

local moneyType=cfg.money[1]
local price=cfg.money[2]
local isEoughMoney=moneyModel.checkEnoughMoney(moneyType,price)
buyReddot=not sold and isEoughMoney
local moneyStr=cfg.money[2]
if not isEoughMoney then
moneyStr=FMT.cfmt(FONT_COLOR.eRedColor,"{0}",moneyStr)
end
slot:SetChildText(childIndex.moneyTxt,moneyStr)
end
slot:SetChildActive(childIndex.reddot,isSpecial and buyReddot)
else
slot:SetChildActive(childIndex.reddot,false)
end
end
end

function UIQiYuanShu_ShopWin:refreshMoneyPanel()
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


function UIQiYuanShu_ShopWin:onClickItemCallback(clickNum,index)

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
local buyNum=funcShopModel:qiyuanshu_findNum(cfg.id)
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






funcShopController.send_23_2(self.shopId,buyId,num)
end,

showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end

function UIQiYuanShu_ShopWin:onClickGBExchangeBtn(index)

if index==0 then
return
end
local cfgItem=self.shopList_special[index]
local sold=cfgItem.sold
local unlock=cfgItem.unlock
local cfg=cfgItem.cfg
local buyId=cfg.id
local buyData=funcShopModel:get_data(self.shopId,cfg.id)
local buyNum=funcShopModel:qiyuanshu_findNum(cfg.id)
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






funcShopController.send_23_2(self.shopId,buyId,num)
end,

showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end

function UIQiYuanShu_ShopWin.onMoneyChanged(moneyType,oldVal,newVal)
if _this==nil then
return
end

if _this.showMoneyType and _this.showMoneyType==moneyType then
_this:refreshMoneyPanel()

end
end

function UIQiYuanShu_ShopWin.onCommonShopData(shopId)
if _this.shopId==shopId then
_this:updateView(true)
end
end

function UIQiYuanShu_ShopWin.onCommonShopChange(shopId)
if _this.shopId==shopId then
_this:updateView()
end
end

function UIQiYuanShu_ShopWin:get_sort_list(shopId,locklimit)
local cfg=funcShopModel.get_shop_item_conf(shopId)
local list={}
local locknum=0
for i,v in pairs(cfg)do
if i~='const_def'then
local item={}
local sortId=0
local buyData=funcShopModel:get_data(shopId,v.id)
local check=true
if funcShopModel:check_item_unlock(shopId,v.id,nil,'hide')then
if funcShopModel:check_item_unlock(shopId,v.id)then
if v.sort~=nil then
sortId=v.sort
end
item.unlock=true
else
locknum=locknum+1
if v.unlockSort~=nil then
sortId=v.unlockSort
elseif v.sort~=nil then
sortId=v.sort
else
sortId=1
end
sortId=sortId*1000
if locklimit~=nil then
if locknum>locklimit then
check=false
end
end
end

if buyData then
local buyNum=funcShopModel:qiyuanshu_findNum(v.id)
if v.buyLimit and buyNum>=v.buyLimit[1][2]then
item.sold=true
sortId=sortId+1000000000
end
else
local buyNum=funcShopModel:qiyuanshu_findNum(v.id)
if v.buyLimit and buyNum>=v.buyLimit[1][2]then
item.sold=true
sortId=sortId+1000000000
end
end

item.sortId=sortId
item.cfg=v
if check then
table.insert(list,item)
end
end
end
end

table.sort(list,function(a,b)return a.sortId<b.sortId end)
return list
end