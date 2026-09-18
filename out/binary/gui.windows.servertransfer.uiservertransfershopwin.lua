







def_class("UIServerTransferShopWin",UIWindowBase)









function UIServerTransferShopWin:bindComponents()

self.freeGift=UIButton.get(self,0)
self.giftContent=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.uiRoot=UIObject.get(self,3)

self.freeGift:setButtonClick(function()self:onFreeGift()end)



end


function UIServerTransferShopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.freeGift);self.freeGift=nil;
_UIObject_release(self.giftContent);self.giftContent=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end


















local _abName="ui/windows/servertransfer/servertransfershopspriteatlas_pak.ab"

function UIServerTransferShopWin:onLoaded(...)
self:bindComponents()
local cost=cfgHelper.get2(cfg_switchserverguildlevelcconfig_get,1,"cost")
local costItem=unpack(cost[1])
self:showWindow("UITopMoneyWin2",{{costItem}})
end


function UIServerTransferShopWin:__delete()
self:unbindComponents()
end




function UIServerTransferShopWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6)
end
local shopCfg=cfgHelper.get2(cfg_switchserverbasicconfig_get,1,"shop_conf")
local buyList=ServerTransferModel:getTransferShopDatas()
local shopIdxList={}
for index,giftCfg in ipairs(shopCfg)do
local sortVal=index
local limit=giftCfg[2]
if limit>0 then
local buyNum=buyList[index]or 0
local left=limit-buyNum
if left<=0 then
sortVal=sortVal+10000
end
end
table.insert(shopIdxList,{index=index,sortVal=sortVal})
end
table.sort(shopIdxList,function(a,b)
return a.sortVal<b.sortVal
end)
self.giftContent:setChildLayoutGroupCreateItems(#shopCfg,function(gridIndex)
local giftItem=self.giftContent:getChildLayoutGroupGridItem(gridIndex-1)
local index=shopIdxList[gridIndex].index
local giftCfg=shopCfg[index]
local rechargeid=giftCfg[1]
local limit=giftCfg[2]
local rewards=giftCfg[3]
local bgIcon=giftCfg[4]
local giftName=giftCfg[5]
giftItem:SetChildLayoutGroupCreateItems(0,#rewards,function(idx)
local rewardItem=giftItem:GetChildLayoutGroupGridItem(0,idx-1)
local reward=rewards[idx]
local itemId=reward[1]
local itemCount=reward[2]
local countStr=itemCount>1 and mathHelper.formatNumber(itemCount)or''
local conf={itemid=itemId,itemcount=countStr,showCountBG=itemCount>1,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
rewardItem:SetChildPropData(0,prop)
end)

local rconfig=cfgHelper.get(cfg_rechargeconfig_get,rechargeid)
local costStr=pfwindowslController:showDesc_ByMoneyType(rconfig)
giftItem:SetChildText(2,costStr)

local canBuy=false
if limit<=0 then
giftItem:SetChildText(3,'')
canBuy=true
else
local buyNum=buyList[index]or 0
local left=limit-buyNum
giftItem:SetChildText(3,string.format("限购次数：%d",left))
canBuy=left>0
end

giftItem:SetChildButtonClick(1,function()
if canBuy then
self:onBuyClick(rechargeid,index)
else
UIManager.info("已售罄")
end
end)

giftItem:SetChildCSImageSprite(4,_abName,bgIcon)

giftItem:SetChildText(5,giftName)

giftItem:SetChildActive(6,not canBuy)
giftItem:SetChildActive(1,canBuy)
end)
self:refreshFreeGiftReddot()
end

function UIServerTransferShopWin:onBuyClick(rechargeid,giftIdx)
payControl.reqPay(rechargeid,1)
end

function UIServerTransferShopWin:refreshFreeGiftReddot()
local reddot=ServerTransferModel:checkTransferServerShopReddot()
self.freeGift:setActive(reddot)
end

function UIServerTransferShopWin:onFreeGift()
ServerTransferModel:receiveTransferServerShopFreeGift()
end