







def_class("UILingCuiShopWin",UIWindowBase)









function UILingCuiShopWin:bindComponents()

self.root=UIObject.get(self,0)
self.refreshTimeText=UIText.get(self,1)
self.goodListPanel=UIObject.get(self,2)



end


function UILingCuiShopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.refreshTimeText);self.refreshTimeText=nil;
_UIObject_release(self.goodListPanel);self.goodListPanel=nil;
end
















local _this=nil


function UILingCuiShopWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UILingCuiShopWin:__delete()
_this=nil
self:unbindComponents()
end


function UILingCuiShopWin:onHide()

end




function UILingCuiShopWin:onShow(argtable,afterOnloaded)
self.shopType=eFuncShopType.eLingCui

local flag=dzLingCuiShopController:checkNeedNewShopItems()
self.root:setActive(not flag)
if not flag then
self:initView()
else
self:clearMyTimer()
end
end

function UILingCuiShopWin:initView()
self:refreshItemList()
if self.mytimer==nil then
local func=function()
if _this==nil then return end
self:refreshMyTime()
end
self.mytimer=self:setTimer(1,0,func)
self:refreshMyTime()
end
end

function UILingCuiShopWin:refreshMyTime()
local lerp=xianmengModel:getXMShopRefreshTime()
if lerp==0 then
funcShopController.send_23_1(self.shopType)
elseif lerp<0 then
lerp=0
end


end

function UILingCuiShopWin:clearMyTimer()
if self.mytimer~=nil then
self:stopTimerByID(self.mytimer)
self.mytimer=nil
end
end

function UILingCuiShopWin:findItemIndex(buyId)
for i,v in ipairs(self.shopItemList)do
if v.cfg.id==buyId then
return i
end
end
return nil
end

function UILingCuiShopWin:refreshItemList()
self.shopItemList=funcShopModel:get_sort_list(self.shopType)
local c=#self.shopItemList
self.goodListPanel:setChildLayoutGroupCreateItems(c)
local grids=self.goodListPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
self:refreshItem(item,i)
item:SetChildButtonClick(12,function()
if _this==nil then return end
_this:onItemClick(i)
end)
end
self.root:setActive(true)
end

function UILingCuiShopWin:refreshItem(item,index)
if item==nil then
item=self.goodListPanel:getChildLayoutGroupGridItem(index-1)
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
if goodcfg.xiyouFlag==1 then
bgname1='frame_llingcuishangdian _02'
bgname2='frame_dyshangdianui_8'
else
bgname1='frame_llingcuishangdian _01'
bgname2='frame_dyshangdianui_5'
end
item:SetChildCSImageSprite(12,globalABLookup.lingcuishopicons,bgname1)
item:SetChildCSImageSprite(16,globalABLookup.lingcuishopicons,bgname2)

local itemID=goodcfg.itemId
local itemNum=goodcfg.itemNum
local itemcount=itemNum>1 and tostring(itemNum)or''
local showCountBG=itemNum>1
local grayNum=0
local isBlock=false
if not isunlock or isSellOut then
grayNum=mathHelper.setbit(grayNum,eGrayType.eGray-1)
isBlock=true
end
local conf={itemid=itemID,showCountBG=showCountBG,showStage=true,showname=false,itemcount=itemcount,gray=grayNum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(15,prop)
item:SetBaseItemClickEvent(15,function(...)
if _this==nil then return end
_this:onGoodClick(...)
end)
item:SetChildActive(17,isBlock)

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

function UILingCuiShopWin:onGoodClick(itemid,index,itemguid,attach)
itemsComponentHelper.onItemClickEx(itemid,index,itemguid,attach)
end

function UILingCuiShopWin:onItemClick(index)
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
funcShopController.send_23_2(shopType,buyId,num)
end,

showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end

function UILingCuiShopWin:refreshItemByID(buyId)
local index=self:findItemIndex(buyId)
if index then
local data=self.shopItemList[index]
local goodcfg=data.cfg
local buyId=goodcfg.id
local isSellOut=funcShopModel:checkSoldout(self.shopType,buyId)
if isSellOut then
self:refreshItemList()
else
self:refreshItem(nil,index)
end
end
end