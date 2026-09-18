







def_class("UISystemZongMenShopWin",UIWindowBase)









function UISystemZongMenShopWin:bindComponents()

self.itemIcon=UIImage.get(self,0)
self.moneyTx=UIText.get(self,1)
self.goodsList=UIObject.get(self,2)
self.renownImg=UIImage.get(self,3)
self.discountModel=UIObject.get(self,4)
self.discount=UIText.get(self,5)



end


function UISystemZongMenShopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.itemIcon);self.itemIcon=nil;
_UIObject_release(self.moneyTx);self.moneyTx=nil;
_UIObject_release(self.goodsList);self.goodsList=nil;
_UIObject_release(self.renownImg);self.renownImg=nil;
_UIObject_release(self.discountModel);self.discountModel=nil;
_UIObject_release(self.discount);self.discount=nil;
end















local _this=nil
local _goodsCmp={
root=-1,
item=0,
name=1,
costIcon=2,
costNum=3,
limitTx=4,
discount=5,
discountTx=6,
lock=7,
lockTx=8,
limit=9,
placeholder=10,
over=11,
lockBg=12,
costRoot=13,
}
local _abName="ui/windows/systemzongmen/systemzongmen_atlas_pak.ab"



function UISystemZongMenShopWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
notifySystem:listenNotify(notifyConfig.onSystemZMMoneyNumChange,self.onSystemZMMoneyNumChange)
notifySystem:listenNotify(notifyConfig.onSystemZMShopBuyNumChange,self.onSystemZMShopBuyNumChange)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
self.costItem=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"money_show_item",systemZongMenInfoMoneyType.eZongMenGongXiang)
self.itemIcon:setImageIcon(iconHelper.getItemIconName(self.costItem),false)
end


function UISystemZongMenShopWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
notifySystem:removelistener(notifyConfig.onSystemZMMoneyNumChange,self.onSystemZMMoneyNumChange)
notifySystem:removelistener(notifyConfig.onSystemZMShopBuyNumChange,self.onSystemZMShopBuyNumChange)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)

if self.dialogTween and self.dialogTween:IsActive()then
self.dialogTween:Kill()
end
self:stopCDTick()
end




function UISystemZongMenShopWin:onShow(argtable,afterOnloaded)
self.serial=argtable.serial
if systemZongMenModel:checkDetailPartInfo(self.serial,systemZongMenDetailDataPart.eShop)then
self:refreshData()
self:refreshRenown()
self:refreshDiscount()
self:refreshList()
self:refreshMoney()
end
end


function UISystemZongMenShopWin:onHide()

end



function UISystemZongMenShopWin.onSystemZMDetailInfo(partType,serial)
if mathHelper.compareInt64(_this.serial,serial)and partType==systemZongMenDetailDataPart.eShop then
_this:refreshData()
_this:refreshRenown()
_this:refreshDiscount()
_this:refreshList()
_this:refreshMoney()
end
end

function UISystemZongMenShopWin:refreshData()
self.dataInfo=systemZongMenModel:getInfoData(self.serial)
self.detailInfo=systemZongMenModel:getDetailPartInfo(self.serial,systemZongMenDetailDataPart.eShop)
local renown=self.dataInfo.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
self.renownIdx=systemZongMenModel:getRenownIndex(self.dataInfo.id,renown)
self.discountPercent=systemZongMenModel:calculateShopDiscount(self.dataInfo)
self.zmCfg=cfgHelper.get1(cfg_syssectconfig_get,self.dataInfo.id)
self.goodsListData={}
if self.zmCfg.shop then
self.shopCfg=cfgHelper.get1(cfg_syssectshopconfig_get,self.zmCfg.shop)
for itemId,config in pairs(self.shopCfg)do
local isLock=self.renownIdx<(config.needSwLv or 0)
local isOver=(self.detailInfo.list[itemId]or 0)>=config.limitNum
local isForever=config.limitType==systemZongMenShopGoodsLimitType.eForever
local sortAdd=0
if isOver and isForever then
sortAdd=30000
elseif isLock then
sortAdd=20000
elseif isOver then
sortAdd=10000
end
self.goodsListData[config.sort]={
config=config,
itemId=itemId,
sortWeight=config.sort+sortAdd,
index=config.sort,
}
end
table.sort(self.goodsListData,self.sortData)
end
end

function UISystemZongMenShopWin.sortData(a,b)
return a.sortWeight<b.sortWeight
end

function UISystemZongMenShopWin:refreshRenown()
local imageName=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"renown_text",self.renownIdx)
self.renownImg:setSprite(_abName,imageName)
end

function UISystemZongMenShopWin:refreshDiscount()


self.discountModel:setActive(self.discountPercent<10000)
end

function UISystemZongMenShopWin:refreshList()
self.cdList={}
self.cdStrs={}
self.goodsList:setChildLayoutGroupCreateItems(#self.goodsListData,function(index)
local goodsItem=self.goodsList:getChildLayoutGroupGridItem(index-1)
local goodsData=self.goodsListData[index]
local goodsConfig=goodsData.config
local itemId=goodsData.itemId
local buyed=self.detailInfo.list[itemId]or 0

goodsItem:SetChildButtonClick(_goodsCmp.root,function()
self:onClickGoods(index)
end)

local itemNum=goodsConfig.itemNum
local showCountBG=itemNum>1
local countStr=showCountBG and itemNum or""
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
goodsItem:SetChildPropData(_goodsCmp.item,prop)
goodsItem:SetBaseItemClickEvent(_goodsCmp.item,itemsComponentHelper.onItemClickEx)
goodsItem:SetChildText(_goodsCmp.name,itemsConfig.getItemName(itemId))

local costNum=math.max(math.floor(goodsConfig.needGx*self.discountPercent/10000),1)
goodsItem:SetChildCSImageIcon(_goodsCmp.costIcon,iconHelper.getIconName(self.costItem),false)
goodsItem:SetChildText(_goodsCmp.costNum,costNum)
goodsItem:ForceLayoutRect(_goodsCmp.costRoot)








local limitType=goodsConfig.limitType
local haveLimit=limitType~=nil
local lockRenown=self.renownIdx<(goodsConfig.needSwLv or 0)
goodsItem:SetChildActive(_goodsCmp.limit,haveLimit and not lockRenown)


if haveLimit then
local limitContent=systemZongMenModel:getShopGoodsLimitContent(limitType)
goodsItem:SetChildText(_goodsCmp.limitTx,FMT.fmt(limitContent,goodsConfig.limitNum-buyed,goodsConfig.limitNum))
end

if lockRenown and(limitType~=systemZongMenShopGoodsLimitType.eForever or buyed<goodsConfig.limitNum)then
goodsItem:SetChildActive(_goodsCmp.lock,true)
goodsItem:SetChildActive(_goodsCmp.lockBg,true)
goodsItem:SetChildActive(_goodsCmp.over,false)
local lockStr=FMT.fmt("声望等级达到<color=#FD8950>{0}</color>",systemZongMenModel:getRenownName(goodsConfig.needSwLv))
goodsItem:SetChildText(_goodsCmp.lockTx,lockStr)
elseif haveLimit and buyed>=goodsConfig.limitNum then
goodsItem:SetChildActive(_goodsCmp.lock,true)
if limitType~=systemZongMenShopGoodsLimitType.eForever then
goodsItem:SetChildActive(_goodsCmp.lockBg,true)
goodsItem:SetChildActive(_goodsCmp.over,false)
local deadLine=systemZongMenModel:getShopGoodsSupplyTime(limitType)
self.cdList[index]=deadLine
self.cdStrs[index]=nil
else
goodsItem:SetChildActive(_goodsCmp.lockBg,false)
goodsItem:SetChildActive(_goodsCmp.over,true)
end
else
goodsItem:SetChildActive(_goodsCmp.lock,false)
end
end)

self:updateCDTick()
if next(self.cdList)then
self:startCDTick()
else
self:stopCDTick()
end
end

function UISystemZongMenShopWin:refreshItem(index)
local goodsItem=self.goodsList:getChildLayoutGroupGridItem(index-1)
local goodsData=self.goodsListData[index]
local goodsConfig=goodsData.config
local itemId=goodsData.itemId
local buyed=self.detailInfo.list[itemId]or 0
local limitType=goodsConfig.limitType
local haveLimit=limitType~=nil
if haveLimit then
local limitContent=systemZongMenModel:getShopGoodsLimitContent(limitType)
goodsItem:SetChildText(_goodsCmp.limitTx,FMT.fmt(limitContent,goodsConfig.limitNum-buyed,goodsConfig.limitNum))
end
local lockRenown=self.renownIdx<(goodsConfig.needSwLv or 0)
if not lockRenown and limitType~=systemZongMenShopGoodsLimitType.eForever and buyed>=goodsConfig.limitNum then
goodsItem:SetChildActive(_goodsCmp.lock,true)
local deadLine=systemZongMenModel:getShopGoodsSupplyTime(limitType)
local nowTime=timeHelper.getServerLongTime()
local delta=deadLine-nowTime
local newStr=FMT.fmt("<color=#F36666>{0}后补货</color>",delta>0 and timeHelper.formatSimpleTime(delta)or"————")
self.cdList[index]=deadLine
self.cdStrs[index]=newStr
goodsItem:SetChildText(_goodsCmp.lockTx,newStr)
end

if next(self.cdList)then
self:startCDTick()
end
end

function UISystemZongMenShopWin:onClickGoods(index)
local goodsData=self.goodsListData[index]
local goodsConfig=goodsData.config
local itemId=goodsData.itemId
local buyed=self.detailInfo.list[itemId]or 0
local limitType=goodsConfig.limitType
local haveLimit=limitType~=nil
if haveLimit and goodsConfig.limitNum<=buyed then
return UIManager.error("购买次数已达上限")
end
local lockRenown=self.renownIdx<(goodsConfig.needSwLv or 0)
if lockRenown then
local lockStr=FMT.fmt("需要声望等级达到{0}",systemZongMenModel:getRenownName(goodsConfig.needSwLv))
return UIManager.error(lockStr)
end
local costPrice=math.max(math.floor(goodsConfig.needGx*self.discountPercent/10000),1)
local haveNum=self.dataInfo.moneyLookup[systemZongMenInfoMoneyType.eZongMenGongXiang]
local buyMax=math.floor(haveNum/costPrice)
if haveLimit then
buyMax=math.min(buyMax,goodsConfig.limitNum-buyed)
end
if buyMax>0 then
local itemIcon=iconHelper.getItemIconName(itemId)
local costIcon=iconHelper.getItemIconName(self.costItem)
if buyMax>1 then
local refresh=function(num)
local contentStr=FMT.fmt('是否确认花费quad-icon={1}-quad{0}购买？',costPrice*num,costIcon,num,itemIcon)
return contentStr
end
local show_data={
type='UIDialougeBuyCount',
title='提示',
refreshcallback=refresh,
max=buyMax,
tips=FMT.fmt("（剩余购买次数：{0}）",buyMax),
oktext='购买',
canceltext='取消',
okcallback=function(num)
systemZongMenController:req_buy_goods(self.serial,itemId,num)
end,
closecallback=function()
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
local contentStr=FMT.fmt("是否确认花费quad-icon={1}-quad{0}购买",costPrice,costIcon,1,itemIcon)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function()
systemZongMenController:req_buy_goods(self.serial,itemId,1)
end,
showclosebtn=true,
closecallback=function()
end,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end
else
UIManager.error('贡献值不足')
end
end

function UISystemZongMenShopWin:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISystemZongMenShopWin:updateCDTick()
if next(self.cdList)then
local nowTime=timeHelper.getServerLongTime()
local resetList={}
for index,deadLine in pairs(self.cdList)do
local delta=deadLine-nowTime
if delta<=0 then
self.cdList[index]=nil
table.insert(resetList,index)
else
local oldStr=self.cdStrs[index]
local newStr=FMT.fmt("<color=#F36666>{0}后补货</color>",timeHelper.formatSimpleTime(delta))
if newStr~=oldStr then
self.cdStrs[index]=newStr
local goodsItem=self.goodsList:getChildLayoutGroupGridItem(index-1)
goodsItem:SetChildText(_goodsCmp.lockTx,newStr)
end
end
end
if#resetList>0 then
for index,itemIndex in ipairs(resetList)do
local goodsData=self.goodsListData[itemIndex]
systemZongMenModel:resetShopNum(self.serial,goodsData.itemId)
end
_this:refreshData()
_this:refreshList()
end
end

if next(self.cdList)==nil then
self:stopCDTick()
end
end

function UISystemZongMenShopWin:stopCDTick()
if self.cdTick then
self.supplyStr=nil
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISystemZongMenShopWin:refreshMoney()
local num=self.dataInfo.moneyLookup[systemZongMenInfoMoneyType.eZongMenGongXiang]
self.moneyTx:setText(mathHelper.formatNumber(num))
end

function UISystemZongMenShopWin.onSystemZMMoneyNumChange(serial,money_type,val,oldVal)
if mathHelper.compareInt64(_this.serial,serial)then
if money_type==systemZongMenInfoMoneyType.eShengWang then
local newIdx=systemZongMenModel:getRenownIndex(_this.dataInfo.id,val)
if _this.renownIdx~=newIdx then
_this.renownIdx=newIdx
_this.discountPercent=systemZongMenModel:calculateShopDiscount(_this.dataInfo)
_this:refreshRenown()
_this:refreshData()
_this:refreshList()
_this:refreshDiscount()
end
elseif money_type==systemZongMenInfoMoneyType.eZongMenGongXiang then
_this:refreshMoney()
end
end
end

function UISystemZongMenShopWin.onSystemZMShopBuyNumChange(serial,itemId,newTimes,oldTimes)

if mathHelper.compareInt64(_this.serial,serial)then
local idx=nil
for index,goodsData in ipairs(_this.goodsListData)do
if goodsData.itemId==itemId then
idx=index
break
end
end
if idx then
local goodsData=_this.goodsListData[idx]
local goodsConfig=goodsData.config
local itemId=goodsData.itemId
if goodsConfig.limitNum<=newTimes then
local isForever=goodsConfig.limitType==systemZongMenShopGoodsLimitType.eForever
local isLock=goodsConfig.needSwLv>_this.renownIdx
local sortAdd=10000
if isForever then
sortAdd=30000
elseif isLock then
sortAdd=20000
end
goodsData.sortWeight=goodsData.index+sortAdd
table.sort(_this.goodsListData,_this.sortData)
_this:refreshList()
else
_this:refreshItem(idx)
end

UIManager.info(FMT.fmt("成功购买{0}*{1}",itemsConfig.getTipsColorName(itemId),goodsConfig.itemNum*(newTimes-oldTimes)))
end
end
end

function UISystemZongMenShopWin.onNewDay5am()
for index,goodsData in ipairs(_this.goodsListData)do
local goodsConfig=goodsData.config
local limitType=goodsConfig.limitType
if limitType then
if limitType==systemZongMenShopGoodsLimitType.eDay then
systemZongMenController:req_detailInfo(systemZongMenDetailDataPart.eShop,_this.serial)
return
elseif limitType==systemZongMenShopGoodsLimitType.eWeek and timeHelper.getWeakDateEx()==1 then
systemZongMenController:req_detailInfo(systemZongMenDetailDataPart.eShop,_this.serial)
return
elseif limitType==systemZongMenShopGoodsLimitType.eMonth and timeHelper.dateServer("%d")==1 then
systemZongMenController:req_detailInfo(systemZongMenDetailDataPart.eShop,_this.serial)
return
end
end
end
end
