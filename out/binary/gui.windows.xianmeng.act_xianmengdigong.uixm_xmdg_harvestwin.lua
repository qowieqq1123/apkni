







def_class("UIXM_XMDG_HarvestWin",UIWindowBase)









function UIXM_XMDG_HarvestWin:bindComponents()

self.root=UIObject.get(self,0)
self.auctionList=UIObject.get(self,1)
self.nullTips_auction=UIObject.get(self,2)
self.jumpBtnPanel_auction=UIObject.get(self,3)
self.shopGoodsList=UIObject.get(self,4)
self.nullTips_shop=UIObject.get(self,5)
self.jumpBtnPanel_shop=UIObject.get(self,6)
self.jumpBtn_auction=UIButton.get(self,7)
self.jumpBtn_shop=UIButton.get(self,8)

self.jumpBtn_auction:setButtonClick(function()self:onJumpBtn_auction()end)

self.jumpBtn_shop:setButtonClick(function()self:onJumpBtn_shop()end)
self.nullTips={
["auction"]=self.nullTips_auction,
["shop"]=self.nullTips_shop,
}
self.jumpBtnPanel={
["auction"]=self.jumpBtnPanel_auction,
["shop"]=self.jumpBtnPanel_shop,
}
self.jumpBtn={
["auction"]=self.jumpBtn_auction,
["shop"]=self.jumpBtn_shop,
}



end


function UIXM_XMDG_HarvestWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.auctionList);self.auctionList=nil;
_UIObject_release(self.nullTips_auction);self.nullTips_auction=nil;
_UIObject_release(self.jumpBtnPanel_auction);self.jumpBtnPanel_auction=nil;
_UIObject_release(self.shopGoodsList);self.shopGoodsList=nil;
_UIObject_release(self.nullTips_shop);self.nullTips_shop=nil;
_UIObject_release(self.jumpBtnPanel_shop);self.jumpBtnPanel_shop=nil;
_UIObject_release(self.jumpBtn_auction);self.jumpBtn_auction=nil;
_UIObject_release(self.jumpBtn_shop);self.jumpBtn_shop=nil;
self.nullTips=nil;
self.jumpBtnPanel=nil;
self.jumpBtn=nil;
end
















local auctionItemIndex={
item=0,
gotFlag=1,
actorName=2,
selfFlag=3,
bg=4,
selectBg=5,
}




function UIXM_XMDG_HarvestWin:onLoaded(...)
self:bindComponents()
end


function UIXM_XMDG_HarvestWin:__delete()
self:unbindComponents()
end




function UIXM_XMDG_HarvestWin:onShow(argtable,afterOnloaded)


self.itemCfg=cfg_xmdgshopitemconfig()


xianmengdigongController:reqAuctionGainList()
xianmengdigongController:reqShopGoodsList(true)


xianmengdigongController:clearAllNotReadMsgList()
xianmengdigongController:checkReadAddAuctionMsgNum()

self:onShowArgRecv(argtable,afterOnloaded)
end

function UIXM_XMDG_HarvestWin:onShowArgRecv()
self:refresh()
end

function UIXM_XMDG_HarvestWin:refresh()

self:refreshAuctionPanel()


self:refreshShopPanel()
end


function UIXM_XMDG_HarvestWin:onHide()

end


function UIXM_XMDG_HarvestWin:refreshAuctionPanel()

self.auctionGainList=xianmengdigongModel:getXMDG_auctionGainList()or{}


self:sortList_Auction()


local count=#self.auctionGainList_sort
self.auctionList:setChildLayoutGroupCreateItems(count)
if count>0 then

self.nullTips_auction:setActive(false)

self.auctionList:setActive(true)

local grids=self.auctionList:getChildLayoutGroupGridList()
for i=1,count do
local item=grids[i-1]
if item then
local auctionData=self.auctionGainList_sort[i]

local itemInfo=auctionData.itemInfo
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid
local itemCount=itemInfo.itemcount
local countStr=''
local showCountBG=false
if itemCount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemCount)
end
local graynum=auctionData.gotFlag and 2 or 0
local isShowStage=itemsConfig.isMaterials(itemid)
local conf={itemid=itemid,itemguid=itemguid,itemcount=countStr,gray=graynum,showCountBG=showCountBG,showname=false,showStage=isShowStage}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildActive(-1,true)
item:SetChildPropData(auctionItemIndex.item,prop)
item:SetBaseItemClickEvent(auctionItemIndex.item,function(...)
self:onClickRewardItem(itemInfo,...)
end)


item:SetChildActive(auctionItemIndex.bg,auctionData.gotFlag)
item:SetChildActive(auctionItemIndex.selectBg,not auctionData.gotFlag)


item:SetChildActive(auctionItemIndex.gotFlag,auctionData.gotFlag)
local isSelf=false

item:SetChildActive(auctionItemIndex.actorName,auctionData.gotFlag)
if auctionData.gotFlag then
isSelf=playerModel:checkActorId(auctionData.actorId)
if isSelf then
item:SetChildText(auctionItemIndex.actorName,FMT.fmt("<color=#7d3b17>{0}</color>",auctionData.actorName))
else
item:SetChildText(auctionItemIndex.actorName,auctionData.actorName)
end
end

item:SetChildActive(auctionItemIndex.selfFlag,auctionData.gotFlag and isSelf)
end
end


self.jumpBtnPanel_auction:setActive(true)
else

self.nullTips_auction:setActive(true)

self.jumpBtnPanel_auction:setActive(false)

self.auctionList:setActive(false)
end
end


function UIXM_XMDG_HarvestWin:refreshShopPanel()

self.goodsList=xianmengdigongModel:getXMDG_shopGoodsList()or{}


self:sortList_ShopGoods()


local count=#self.goodsList_sort
self.shopGoodsList:setChildLayoutGroupCreateItems(count)
if count>0 then

self.nullTips_shop:setActive(false)

self.shopGoodsList:setActive(true)

local grids=self.shopGoodsList:getChildLayoutGroupGridList()
for i=1,count do
local item=grids[i-1]
if item then
local goodsData=self.goodsList_sort[i]
local itemid=goodsData.itemId
local itemCount=goodsData.itemCount
local countStr=''
local showCountBG=false
local isSellOut=itemCount<=0
local isShowStage=itemsConfig.isMaterials(itemid)
local graynum=isSellOut and 2 or 0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showname=false,showStage=isShowStage}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildActive(-1,true)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(nil,...)
end)

item:SetChildActive(1,isSellOut)
end
end


self.jumpBtnPanel_shop:setActive(true)
else

self.nullTips_shop:setActive(true)

self.jumpBtnPanel_shop:setActive(false)

self.shopGoodsList:setActive(false)
end
end


function UIXM_XMDG_HarvestWin:sortList_Auction()
self.auctionGainList_sort={}
if not self.auctionGainList or not next(self.auctionGainList)then

return
end

for i,v in pairs(self.auctionGainList)do
local itemId=v.itemInfo.itemid

local cfg=self.itemCfg[itemId]
if cfg and cfg.shop_type==2 then
local item={
actorName=v.actor_name,
itemId=itemId,
itemInfo=v.itemInfo,
moneyType=cfg.cost[1],
price=cfg.cost[2],
sortId=cfg.sortId,
gotFlag=v.status==1,
actorId=v.actor_id,
}
table.insert(self.auctionGainList_sort,item)
else
logErr(FMT.fmt("仙盟地宫道具配置表中未找到道具id为 {0}且类型为拍卖的道具，请检查配置是否正确",itemId))
end
end

table.sort(self.auctionGainList_sort,function(a,b)
if a.sortId==b.sortId then
return a.itemId<b.itemId
else
return a.sortId<b.sortId
end
end)
end


function UIXM_XMDG_HarvestWin:sortList_ShopGoods()
self.goodsList_sort={}
if not self.goodsList or not next(self.goodsList)then

return
end

for i,v in pairs(self.goodsList)do
local itemId=v.itemId

local cfg=self.itemCfg[itemId]
if cfg and cfg.shop_type==1 then
local item={
itemId=itemId,
itemCount=v.itemCount,
buyCount=v.buyCount,
limit=cfg.limit_num or 0,
moneyType=cfg.cost[1],
price=cfg.cost[2],
sortId=cfg.sortId,
}
table.insert(self.goodsList_sort,item)
else
logErr(FMT.fmt("仙盟地宫道具配置表中未找到道具id为 {0}且类型为商店的道具，请检查配置是否正确",itemId))
end
end

table.sort(self.goodsList_sort,function(a,b)
if a.sortId==b.sortId then
return a.itemId<b.itemId
else
return a.sortId<b.sortId
end
end)
end





function UIXM_XMDG_HarvestWin:onJumpBtn_auction()
local panelparams={}
panelparams.isFull=false
panelparams.pageIndex=1
UIFullCommonControl:showCommonWindow('UIXM_XMDG_ShopForeWin',panelparams)


return UIFullCommonControl:closeWindow('UIXM_XMDG_NoteMainWin')
end



function UIXM_XMDG_HarvestWin:onJumpBtn_shop()
local panelparams={}
panelparams.isFull=false
panelparams.pageIndex=2
UIFullCommonControl:showCommonWindow('UIXM_XMDG_ShopForeWin',panelparams)


return UIFullCommonControl:closeWindow('UIXM_XMDG_NoteMainWin')
end



function UIXM_XMDG_HarvestWin:onClickRewardItem(itemInfo,itemId,index,guid,attach)
if itemId==-1 then
return
end

if guid and itemInfo then
local watch=watchModel.getItem(guid)
if watch==nil then
watchModel.setItem(itemInfo)
end
end

tipsManager.showTips({itemid=itemId,itemguid=guid})
end
