







def_class("UIWanLingBaoKuWin",UIWindowBase)









function UIWanLingBaoKuWin:bindComponents()

self.level=UIText.get(self,0)
self.menuContent=UIObject.get(self,1)
self.shopContent=UIObject.get(self,2)



end


function UIWanLingBaoKuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.menuContent);self.menuContent=nil;
_UIObject_release(self.shopContent);self.shopContent=nil;
end


















local _this=nil

function UIWanLingBaoKuWin:onLoaded(...)
self:bindComponents()
_this=self
self.shopId=eFuncShopType.eWanLingBaoKu
self.const_def=cfgHelper.getdef(cfg_xumitashopconfig)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
wanLingTaModel:checkWanLingBaoKuNewLevelReddot(true)
end


function UIWanLingBaoKuWin:__delete()
self:unbindComponents()
_this=nil
end




function UIWanLingBaoKuWin:onShow(argtable,afterOnloaded)
self.selectBaoKuIdx=1
self:refreshTaLingInfo()
self:refreshBaoKuMenuPanel()
self:refreshBaoKuShopPanel()

self.shopCfg=cfgHelper.get(cfg_shoplistconfig_get,self.shopId)
local moneyBar=self.shopCfg.moneyBar
self.showMoneyType=moneyBar and moneyBar[1]and moneyBar[1][1]or nil
if self.showMoneyType then
self:showWindow('UITopMoneyWin2',{{self.showMoneyType}})
end
end

function UIWanLingBaoKuWin:refreshTaLingInfo()
local taLingLevel=wanLingTaModel:getTaLingLevel()
self.level:setText(taLingLevel)
end

function UIWanLingBaoKuWin:refreshBaoKuMenuPanel()
local baoKuCfg=self.const_def.baoKuCfg
local taLingLevel=wanLingTaModel:getTaLingLevel()
self.menuContent:setChildLayoutGroupCreateItems(#baoKuCfg,function(index)
local item=self.menuContent:getChildLayoutGroupGridItem(index-1)
local cfg=baoKuCfg[index]
local unLockLevel=cfg.cdn
local isUnlock=taLingLevel>=unLockLevel
local leftNum=self:getBaoKuLeftGoods(index)
item:SetChildActive(0,index~=self.selectBaoKuIdx)
item:SetChildActive(1,index==self.selectBaoKuIdx)
item:SetChildText(2,index)
if isUnlock then
item:SetChildActive(3,true)
item:SetChildActive(6,false)
item:SetChildText(4,leftNum)
else
item:SetChildActive(3,false)
item:SetChildActive(6,true)
item:SetChildText(5,string.format("塔灵%d级解锁",unLockLevel))
end
item:SetChildButtonClick(0,function()
self:onClickBaoKuMenu(index)
end)
end)
end

function UIWanLingBaoKuWin:getBaoKuLeftGoods(index)
local shopItemList=wanLingTaModel:getShopBaoKuItemList(index)
local leftNum=0
for i,itemData in ipairs(shopItemList)do
if itemData.buyLimit then
local maxnum=itemData.buyLimit[1][2]
local buyNum=0
local buyData=funcShopModel:get_data(self.shopId,itemData.id)
if buyData then
buyNum=buyData.buyNum
end
if maxnum>buyNum then
leftNum=leftNum+1
end
else
leftNum=leftNum+1
end
end
return leftNum
end

function UIWanLingBaoKuWin:onClickBaoKuMenu(index)
if index==self.selectBaoKuIdx then
return
end
local taLingLevel=wanLingTaModel:getTaLingLevel()
local baoKuCfg=self.const_def.baoKuCfg
local cfg=baoKuCfg[index]
local unLockLevel=cfg.cdn
local isUnlock=taLingLevel>=unLockLevel
if not isUnlock then
UIManager.info(string.format("塔灵%d级解锁",unLockLevel))
return
end
local item=self.menuContent:getChildLayoutGroupGridItem(self.selectBaoKuIdx-1)
item:SetChildActive(0,true)
item:SetChildActive(1,false)
self.selectBaoKuIdx=index
item=self.menuContent:getChildLayoutGroupGridItem(self.selectBaoKuIdx-1)
item:SetChildActive(0,false)
item:SetChildActive(1,true)
self:refreshBaoKuShopPanel()
end

function UIWanLingBaoKuWin:refreshBaoKuShopPanel()
self.shopItemList=wanLingTaModel:getShopBaoKuItemList(self.selectBaoKuIdx)
self.shopContent:setChildLayoutGroupCreateItems(#self.shopItemList,function(index)
if self and not self.isClose then
self:refreshShopItem(index)
end
end)
end

function UIWanLingBaoKuWin:refreshShopItem(index)
local item=self.shopContent:getChildLayoutGroupGridItem(index-1)
local itemData=self.shopItemList[index]
local itemId=itemData.itemId
local moneyType,price=unpack(itemData.money)
local enoughMoneyOne=moneyModel.checkEnoughMoney(moneyType,price)
local itemCfg=itemsConfig.getConfig(itemId)
local buyData=funcShopModel:get_data(self.shopId,itemData.id)
local countStr=''
local conf={itemid=itemId,itemcount=countStr,showCountBG=false,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(1,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(1,prop)

if itemData.buyLimit then
local limitName=funcShopModel.getLimitName(itemData.buyLimit[1][1])
local maxnum=itemData.buyLimit[1][2]
local buyNum=0
if buyData then
buyNum=buyData.buyNum
end
item:SetChildActive(2,true)
item:SetChildText(3,string.format("%s%s",limitName,maxnum-buyNum))
else
item:SetChildActive(2,false)
item:SetChildText(3,'')
end

item:SetChildText(4,itemData.itemNum>1 and string.format("%sx%d",itemCfg.name,itemData.itemNum)or itemCfg.name)

item:SetChildIcon(5,iconHelper.getIconName(moneyType),true)
item:SetChildText(6,enoughMoneyOne and price or FMT.cfmt(FONT_COLOR.eRedColor,price))

item:SetChildButtonClick(0,function()
if self and not self.isClose then
self:onItemBuyClick(itemData)
end
end)

local isSellOut=funcShopModel:checkSoldout(self.shopId,itemData.id)
item:SetChildActive(7,isSellOut)
end

function UIWanLingBaoKuWin:findItemIndex(buyId)
for i,v in ipairs(self.shopItemList or{})do
if v.id==buyId then
return i
end
end
return nil
end

function UIWanLingBaoKuWin:refreshItemByID(buyId)
local index=self:findItemIndex(buyId)
if index then
self:refreshShopItem(index)
self:refreshBaoKuMenuPanel()
end
end

function UIWanLingBaoKuWin:onItemBuyClick(goodcfg)
local shopType=self.shopId
local buyId=goodcfg.id
if not funcShopModel:check_item_unlock(shopType,buyId,true)then
return
end
local isSellOut=funcShopModel:checkSoldout(shopType,buyId)
if isSellOut then
UIManager.error('商品已售罄')
return true
end
local buyData=funcShopModel:get_data(shopType,buyId)
local buyNum=0
if buyData then
buyNum=buyData.buyNum
end

local costType=goodcfg.money[1]
local costNum=goodcfg.money[2]
local max=nil
if goodcfg.buyLimit then
max=goodcfg.buyLimit[1][2]-buyNum
end
local showdata=
{
type='UIUseItemDialouge',
title='提示',
canceltext='取消',
oktext='购买',
max=max,
itemId=costType,
unitPrice=costNum,
okcallback=function(num)

local need=num*costNum




local func=function()
funcShopController.send_23_2(shopType,buyId,num)
end
moneySystem:useMoney(costType,need,func,WARNING_TYPE.eWarning)
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end

function UIWanLingBaoKuWin.on_money_changed(moneyType,lastVal,haveNum)
for index,itemData in ipairs(_this.shopItemList)do
local item=_this.shopContent:getChildLayoutGroupGridItem(index-1)
local moneyType,price=unpack(itemData.money)
local enoughMoneyOne=moneyModel.checkEnoughMoney(moneyType,price)
item:SetChildText(6,enoughMoneyOne and price or FMT.cfmt(FONT_COLOR.eRedColor,price))
end
end