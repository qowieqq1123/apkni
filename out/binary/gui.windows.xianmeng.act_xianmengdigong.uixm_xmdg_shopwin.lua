







def_class("UIXM_XMDG_ShopWin",UIWindowBase)









function UIXM_XMDG_ShopWin:bindComponents()

self.content=UIObject.get(self,0)
self.goodsScrollview=UIObject.get(self,1)
self.manageBtn=UIButton.get(self,2)
self.manageReddot=UIObject.get(self,3)
self.nullTxt=UIText.get(self,4)
self.recordBtn=UIButton.get(self,5)
self.refreshBtn=UIButton.get(self,6)
self.refreshBtnText=UIText.get(self,7)
self.tips=UIObject.get(self,8)
self.tipsText=UIText.get(self,9)

self.manageBtn:setButtonClick(function()self:onManageBtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.refreshBtn:setButtonClick(function()self:onRefreshBtn()end)



end


function UIXM_XMDG_ShopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.goodsScrollview);self.goodsScrollview=nil;
_UIObject_release(self.manageBtn);self.manageBtn=nil;
_UIObject_release(self.manageReddot);self.manageReddot=nil;
_UIObject_release(self.nullTxt);self.nullTxt=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.refreshBtn);self.refreshBtn=nil;
_UIObject_release(self.refreshBtnText);self.refreshBtnText=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
end
















local goodsItemIndex={
moneyText=0,
moneyImg=1,
sellOut=2,
item=3,
count=4,
name=5,
limit=6,
bg=7,
}
local _autoRefreshCdTime=10
local _refreshBtnCdTime=2

local _this




function UIXM_XMDG_ShopWin:onLoaded(...)
self:bindComponents()
_this=self

notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
reddotClassManager.register_event(REDDIT_TYPE.eXianMengDiGong,self.refreshShopReddot)
end


function UIXM_XMDG_ShopWin:__delete()
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
reddotClassManager.unregister_event(REDDIT_TYPE.eXianMengDiGong,self.refreshShopReddot)
self:clearAutoRefreshCdTimer()
self:clearRefreshBtnCdTimer()
self:unbindComponents()
self:closeWindow("UITopMoneyWin2")
_this=nil
end


function UIXM_XMDG_ShopWin.onNewDay()

xianmengdigongController:reqShopGoodsList(true)
end




function UIXM_XMDG_ShopWin:onShow(argtable,afterOnloaded)
self.config=cfg_xmdgshopitemconfig()

xianmengdigongController:reqShopGoodsList()

self:onShowArgRecv(argtable,afterOnloaded)
end

function UIXM_XMDG_ShopWin:onShowArgRecv(argtable,afterOnloaded)

self:refresh()


self:showWindow("UITopMoneyWin2",{moneys={{eMoneyType.mtDiGongContribute}},offsetX=-372,offsetY=-31})


self:setRefreshBtnCdTimer()


self:refreshManageBtnShow()

local isreddot=reddotClassManager.get_reddot(REDDIT_TYPE.eXianMengDiGong)
self.manageReddot:setActive(isreddot)


local tipsText=cfgHelper.get2(cfg_xmdgshopconfig_get,1,'tipsText')
self.tipsText:setText(tipsText)

end

function UIXM_XMDG_ShopWin:refresh(isKeepPos)
local contentPos
if isKeepPos then

contentPos=self.content:getChildAnchoredPosition()
end

self.goodsList=xianmengdigongModel:getXMDG_shopGoodsList()or{}
self.limitList=xianmengdigongModel:getXMDG_shopLimitList()or{}

self:sortGoodsList()

local count=#self.sortList
if not isKeepPos then
self.goodsScrollview:setChildScrollRectEnable(false)

self.goodsScrollview:setChildScrollViewCreateGrids(0,0)
self.goodsScrollview:setChildScrollRectEnable(true)
end
self.goodsScrollview:setChildScrollViewCreateGrids(count,0)
if count>0 then

self.nullTxt:setActive(false)

local grids=self.goodsScrollview:getChildScrollViewItemWidgets()
for i=1,count do
self:refreshGoodsItem(grids[i-1],i)
end
else

self.nullTxt:setText("暂无物资")
self.nullTxt:setActive(true)
end

if isKeepPos then

local scrollerViewHight=self.goodsScrollview:getChildSizeDeltaY()
local contentHight=self.content:getChildSizeDeltaY()
local maxY=contentHight-scrollerViewHight
if maxY<0 then
maxY=0
end
local jumpY=contentPos.y<=maxY and contentPos.y or maxY
self.content:setChildAnchoredPosition(Vector2.New(contentPos.x,jumpY))
end
end

function UIXM_XMDG_ShopWin:refreshManageBtnShow()

self.manageBtn:setActive(lingxuwenjianModel:isLeader())
end

function UIXM_XMDG_ShopWin.refreshShopReddot(class,sub_typo,last_flag,flag)
if _this==nil then return end
_this.manageReddot:setActive(flag)
end


function UIXM_XMDG_ShopWin:onHide()
self:clearAutoRefreshCdTimer()
self:clearRefreshBtnCdTimer()
self:closeWindow("UITopMoneyWin2")
end

function UIXM_XMDG_ShopWin:sortGoodsList()
self.sortList={}
if not self.goodsList or not next(self.goodsList)then

return
end

for i,v in pairs(self.goodsList)do
local itemId=v.itemId
local cfg=self.config[itemId]
if cfg and cfg.shop_type==1 then
local sortWeight=cfg.sortId
local isSellOut=false
if v.itemCount<=0 then
isSellOut=true
end
local limit=cfg.limit_num or 0
local dayLimit=math.abs(limit)
local limitData=self.limitList[itemId]
if limitData and limitData.limit~=math.abs(limit)then
dayLimit=self.limitList[itemId].limit
end
if not isSellOut and limit~=0 then
local limitCount=math.abs(limit)
local canBuyCount=limitCount-v.buyCount
local canDayBuyCount=dayLimit-v.day_buyCount
if canBuyCount<=0 or canDayBuyCount<=0 then
isSellOut=true
end
end

if isSellOut then

isSellOut=true
sortWeight=sortWeight+100000
end

local item={
itemId=itemId,
itemCount=v.itemCount,
buyCount=v.buyCount,
day_buyCount=v.day_buyCount,
limit=limit,
dayLimit=dayLimit,
moneyType=cfg.cost[1],
price=cfg.cost[2],
sortWeight=sortWeight,
}
table.insert(self.sortList,item)
else
logErr(FMT.fmt("仙盟地宫道具配置表中未找到道具id为 {0}且类型为商店的道具，请检查配置是否正确",itemId))
end
end

table.sort(self.sortList,function(a,b)
if a.sortWeight==b.sortWeight then
return a.itemId<b.itemId
else
return a.sortWeight<b.sortWeight
end
end)
end

function UIXM_XMDG_ShopWin:refreshGoodsItem(item,index)
if item==nil then
item=self.goodsScrollview:getChildScrollViewItemWidget(index-1)
end

if item then
local goodsData=self.sortList[index]

local itemid=goodsData.itemId
local count=goodsData.itemCount
local countStr=''
local showCountBG=false
local isSellOut=true
if count>0 then
showCountBG=true
isSellOut=false

end
local isShowStage=itemsConfig.isMaterials(itemid)
local isGray=isSellOut
local graynum=isGray and 1 or 0
local conf={itemid=itemid,itemcount=countStr,showname=false,showStage=isShowStage,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
local widget=item:GetChildWidgetBase(goodsItemIndex.item)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(index)
end)


item:SetChildText(goodsItemIndex.count,FMT.fmt("剩余数量: {0}",count))


local itemConfig=itemsConfig.getConfig(itemid)
local itemName=itemConfig.name
item:SetChildText(goodsItemIndex.name,itemName)


local price=goodsData.price
local moneyType=goodsData.moneyType
local moneyCount=price

item:SetChildActive(goodsItemIndex.moneyImg,true)
item:SetChildIcon(goodsItemIndex.moneyImg,iconHelper.getIconName(moneyType),false)

local enough=moneyModel.checkEnoughMoney(moneyType,moneyCount)
if enough then
item:SetChildText(goodsItemIndex.moneyText,FMT.fmt("{0}",moneyCount))
else
item:SetChildText(goodsItemIndex.moneyText,FMT.cfmt(FONT_COLOR.eRedColor,"{0}",moneyCount))
end


item:SetChildButtonClick(goodsItemIndex.bg,function()
self:onClickRewardItem(index)
end)


if goodsData.limit==0 then

item:SetChildActive(goodsItemIndex.limit,false)
else
local limit=math.abs(goodsData.limit)
local dayLimit=goodsData.dayLimit
item:SetChildActive(goodsItemIndex.limit,true)
local buyCount=goodsData.buyCount or 0
local day_buyCount=goodsData.day_buyCount or 0
local canBuyCount=math.min(limit-buyCount,dayLimit-day_buyCount)
if canBuyCount<0 then
canBuyCount=0
if limit<buyCount then
logErr(FMT.fmt("道具{0}当前购买数量超过限制数量 请确认商品数据是否正确",itemid))
end
end
if dayLimit<limit then
item:SetChildText(goodsItemIndex.limit,FMT.fmt("今日可兑: {0}",canBuyCount))
else
item:SetChildText(goodsItemIndex.limit,FMT.fmt("兑换上限: {0}",canBuyCount))
end

if canBuyCount<=0 and not isSellOut then
isSellOut=true
end
end


item:SetChildActive(goodsItemIndex.sellOut,isSellOut)
end
end


function UIXM_XMDG_ShopWin:refreshByAutoCd()

if self.autoRefreshCdTimer then
return
end

self:clearAutoRefreshCdTimer()
self.autoRefreshCdTimer=self:delayDo(_autoRefreshCdTime,function()
if xianmengdigongController:checkXMDGIsActive()then

self:refresh(true)
end

return self:clearAutoRefreshCdTimer()
end)
self:refresh(true)
end



function UIXM_XMDG_ShopWin:onClickRewardItem(index)
local goodsData=self.sortList[index]
local itemId=goodsData.itemId
if itemId==-1 then
return
end
local attach=nil

local formType=nil
if xianmengdigongController:checkXMDGIsActive()then

formType=TIPS_FORM_TYPE.eXMDG_shop
attach={}
local itemCount=goodsData.itemCount
local tips
local tips2
local tipsTitle2
local maxNum=itemCount
if goodsData.limit~=0 then
local limit=math.abs(goodsData.limit)
local dayLimit=goodsData.dayLimit
local buyCount=goodsData.buyCount or 0
local day_buyCount=goodsData.day_buyCount or 0
local canBuyCount=limit-buyCount
maxNum=math.min(itemCount,canBuyCount)
if dayLimit~=limit then
local canDayBuyCount=math.max(dayLimit-day_buyCount,0)
maxNum=math.min(itemCount,canDayBuyCount,canBuyCount)

tipsTitle2="兑换详情"
if canBuyCount==0 then
tips2=FMT.fmt("(本期地宫剩余兑换{0}次)",canBuyCount)
else
tips2=FMT.fmt("(今日剩余兑换{0}次)\n(本期地宫剩余兑换{1}次)",canDayBuyCount,canBuyCount)
end
else
tips=FMT.fmt("(剩余限兑{0}个)",canBuyCount)
end
end
local cost=goodsData.price
local moneyType=goodsData.moneyType
local minNum=maxNum>0 and 1 or 0
local val=maxNum>0 and 1 or 0
local numText=maxNum>0 and'数量：<color=#f1ce78>{0}/{1}</color>'or'数量：<color=#c82c2c>{0}/{1}</color>'
attach.selectNumCmpArgs={
numFormat=numText,
min=minNum,
max=maxNum,
val=val,
tips=tips,
tips2=tips2,
tipsTitle2=tipsTitle2,
moneyData={
moneyType=moneyType,
cost=cost,
isCheck=true,
},
isOverZero=true,
}
attach.cannotClickGray=true
end

tipsManager.showTips({itemid=itemId,formType=formType,attach=attach})
end


function UIXM_XMDG_ShopWin:onRefreshBtn()
local cur=xianmengdigongModel:getXMDG_shopRefreshBtnCd()
local isInCd=cur>0
if isInCd then


UIManager.error("刷新过于频繁，请稍候重试")
return
end

if not xianmengdigongController:checkXMDGIsActive(true)then

return
end


xianmengdigongController:reqShopGoodsList()


local cdEndTime=gameUtilityModel.getServerShortTime()+_refreshBtnCdTime
xianmengdigongModel:setXMDG_shopRefreshBtnCdEndTime(cdEndTime)
self:setRefreshBtnCdTimer()
end

function UIXM_XMDG_ShopWin:onRecordBtn()
if not xianmengdigongController:checkXMDGIsActive(true)then

return
end


self:showWindow("UIXM_XMDG_RecordWin",{recordType=XMDG_Shop_Record_Type.eShop})
end


function UIXM_XMDG_ShopWin:onManageBtn()
if not xianmengdigongController:checkXMDGIsActive(true)then

return
end


self:showWindow("UIXM_XMDG_ShopManageWin")
end


function UIXM_XMDG_ShopWin:clearAutoRefreshCdTimer()
if self.autoRefreshCdTimer then
self:stopTimerByID(self.autoRefreshCdTimer)
self.autoRefreshCdTimer=nil
end
end

function UIXM_XMDG_ShopWin:setRefreshBtnCdTimer()
self:clearRefreshBtnCdTimer()
local func=function()
local cur=xianmengdigongModel:getXMDG_shopRefreshBtnCd()
local isInCd=cur>0
if isInCd then
self.refreshBtnText:setText(FMT.fmt("刷新({0})",cur))
else
self.refreshBtnText:setText("刷新")
return self:clearRefreshBtnCdTimer()
end
end

self.refreshBtnCdTimer=self:setTimer(1,0,func)

func()
end

function UIXM_XMDG_ShopWin:clearRefreshBtnCdTimer()
if self.refreshBtnCdTimer then
self:stopTimerByID(self.refreshBtnCdTimer)
self.refreshBtnCdTimer=nil
end
end