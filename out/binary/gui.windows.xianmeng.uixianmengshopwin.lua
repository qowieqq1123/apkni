







def_class("UIXianMengShopWin",UIWindowBase)









function UIXianMengShopWin:bindComponents()

self.titleTxt=UIText.get(self,0)
self.goodListPanel=UIObject.get(self,1)
self.refreshTimeText=UIText.get(self,2)
self.tipsText=UIText.get(self,3)



end


function UIXianMengShopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.goodListPanel);self.goodListPanel=nil;
_UIObject_release(self.refreshTimeText);self.refreshTimeText=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
end
















local _this=nil


function UIXianMengShopWin:onLoaded(...)
_this=self
self:bindComponents()

local clickEvent=function(...)
self:onItemClick(...)
end
self.goodListPanel:setChildScrollViewInit(0.5,true,clickEvent,nil)
end


function UIXianMengShopWin:__delete()
_this=nil
self:unbindComponents()
self:clearMyTimer()

end


function UIXianMengShopWin:onHide()

end




function UIXianMengShopWin:onShow(argtable,afterOnloaded)
self.shopType=eFuncShopType.eXianMeng

local shopCfg=cfgHelper.get(cfg_shoplistconfig_get,self.shopType)
local moneyBar=shopCfg.moneyBar
UIManager:showWindow('UITopMoneyWin',moneyBar)
self.titleTxt:setText(shopCfg.name)
self.shopCfg=shopCfg

self:refreshItemList(1)

self:clearMyTimer()
local func=function()
if _this==nil then return end
self:refreshMyTime()
end
self.mytimer=self:setTimer(1,0,func)
self:refreshMyTime()

if argtable and argtable.canvasIdx then
self.canvasIdx=argtable.canvasIdx
self:setCanvasIndex(-1,argtable.canvasIdx)
end



end

function UIXianMengShopWin:refreshMyTime()
local lerp=xianmengModel:getXMShopRefreshTime()
if lerp==0 then
funcShopController.send_23_1(self.shopType)
elseif lerp<0 then
lerp=0
end
local time_str=FMT.fmt('刷新时间：{0}',timeHelper.format_time_stamp(lerp,true))
self.refreshTimeText:setText(time_str)
end

function UIXianMengShopWin:clearMyTimer()
if self.mytimer~=nil then
self:stopTimerByID(self.mytimer)
self.mytimer=nil
end
end

function UIXianMengShopWin:findItemIndex(buyId)
for i,v in ipairs(self.shopItemList)do
if v.cfg.id==buyId then
return i
end
end
return nil
end

function UIXianMengShopWin:refreshItemList(jumpIdx)
self.shopItemList=funcShopModel:get_sort_list(self.shopType,2)
local c=#self.shopItemList
self.goodListPanel:setChildScrollViewCreateGrids(c,3)
local grids=self.goodListPanel:getChildScrollViewItemWidgets()
for i=1,c do
local item=grids[i-1]
self:refreshItem(item,i)
end
if jumpIdx then
self.goodListPanel:setChildScrollRectEnable(false)
self.goodListPanel:setChildScrollViewSelectItem(jumpIdx-1,false,false,false)
self.goodListPanel:setChildScrollRectEnable(true)
end
end

function UIXianMengShopWin:refreshItem(item,index)
if item==nil then
item=self.goodListPanel:getChildScrollViewItemWidget(index-1)
end

local shopType=self.shopType
local data=self.shopItemList[index]
local goodcfg=data.cfg
local buyId=goodcfg.id
local buyData=funcShopModel:get_data(shopType,buyId)
local buyNum=0
if buyData then
buyNum=buyData.buyNum
end

local maxnum=nil
local limitname
if goodcfg.buyLimit then
limitname=funcShopModel.getLimitName(goodcfg.buyLimit[1][1])
maxnum=goodcfg.buyLimit[1][2]
end
local isSellOut=funcShopModel:checkSoldout(shopType,buyId)
local costType=goodcfg.money[1]
local costNum=goodcfg.money[2]
local isunlock,lock_str=funcShopModel:check_item_unlock(shopType,buyId,false)


local bgname1,bgname2
if not isunlock then
bgname1='frame_dyshangdianui_4'
bgname2='frame_dyshangdianui_6'
else
if goodcfg.xiyouFlag==1 then
bgname1='frame_dyshangdianui_frame_dyshangdianui_7'
bgname2='frame_dyshangdianui_8'
else
bgname1='frame_dyshangdianui_3'
bgname2='frame_dyshangdianui_5'
end
end
item:SetChildCSImageSprite(12,globalABLookup.funcshopicons,bgname1)
item:SetChildCSImageSprite(16,globalABLookup.funcshopicons,bgname2)

local itemID=goodcfg.itemId
local itemNum=goodcfg.itemNum
local itemcount=itemNum>1 and tostring(itemNum)or''
local showCountBG=itemNum>1
local grayNum=0
if not isunlock or isSellOut then
grayNum=mathHelper.setbit(grayNum,eGrayType.eGray-1)
end
local conf={itemid=itemID,showCountBG=showCountBG,showStage=true,showname=false,itemcount=itemcount,gray=grayNum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(15,prop)
item:SetBaseItemClickEvent(15,function(...)
self:onGoodClick(...)
end)

item:SetChildText(8,itemsConfig.getItemName(itemID))

local showNum=isunlock and not isSellOut and maxnum~=nil
local num_str
if showNum then
local num_str=FMT.fmt('{0}{1}/{2}',limitname,buyNum,maxnum)
item:SetChildText(7,num_str)
end
item:SetChildActive(13,showNum)

item:SetChildActive(9,not isunlock)
item:SetChildActive(11,isunlock)
if not isunlock then
item:SetChildText(10,lock_str)
end

if isunlock then

item:SetChildCSImageIcon(1,iconHelper.getIconName(costType),false)
local cost_str=moneyModel.checkEnoughMoney(costType,costNum)and tostring(costNum)
or FMT.fmt('<color=#C82C2C>{0}</color>',costNum)
item:SetChildText(0,cost_str)

item:SetChildActive(2,isSellOut)



item:SetChildActive(6,goodcfg.xiyouFlag==1)
end


item:SetChildActive(14,index%3==1)
end

function UIXianMengShopWin:onGoodClick(itemid,index,itemguid,attach)
itemsComponentHelper.onItemClickEx(itemid,index,itemguid,attach)
end

function UIXianMengShopWin:onItemClick(clickNum,index)
index=index+1
local shopType=self.shopType
local data=self.shopItemList[index]
local goodcfg=data.cfg
local buyId=goodcfg.id
local buyData=funcShopModel:get_data(shopType,buyId)
local buyNum=0
if buyData then
buyNum=buyData.buyNum
end

if not funcShopModel:check_item_unlock(shopType,buyId,true)then
return
end

local isSellOut=funcShopModel:checkSoldout(shopType,buyId)
if isSellOut then
UIManager.error('商品已售罄')
return true
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
itemsModel:useItem(costType,costNum*num,function()
funcShopController.send_23_2(shopType,buyId,num)
end,WARNING_TYPE.eWarning)
end,

showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end

function UIXianMengShopWin:refreshItemByID(buyId)
local index=self:findItemIndex(buyId)
if index then
self:refreshItem(nil,index)
end
end