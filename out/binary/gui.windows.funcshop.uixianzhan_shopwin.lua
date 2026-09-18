







def_class("UIXianZhan_ShopWin",UIWindowBase)









function UIXianZhan_ShopWin:bindComponents()

self.catBoss=UIObject.get(self,0)
self.content=UIObject.get(self,1)
self.goodsScrollview=UIObject.get(self,2)
self.npcClicker=UIButton.get(self,3)
self.Root=UIObject.get(self,4)
self.speakObj=UIObject.get(self,5)
self.speakText=UIText.get(self,6)
self.timeBg=UIObject.get(self,7)
self.timedesc=UIText.get(self,8)
self.uiRoot=UIObject.get(self,9)

self.npcClicker:setButtonClick(function()self:onNpcClicker()end)



end


function UIXianZhan_ShopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.catBoss);self.catBoss=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.goodsScrollview);self.goodsScrollview=nil;
_UIObject_release(self.npcClicker);self.npcClicker=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.timedesc);self.timedesc=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this

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
grayBg=14,
speBg=15,
limitbg=16,
}




function UIXianZhan_ShopWin:onLoaded(...)
self:bindComponents()

_this=self
notifySystem:listenNotify(notifyConfig.onCommonShopData,self.onCommonShopData)

local clickEvent=function(...)
self:clickGood(...)
end
self.goodsScrollview:setChildScrollViewInit(0.5,true,clickEvent,nil)
end


function UIXianZhan_ShopWin:__delete()
self:unbindComponents()

_this=nil
notifySystem:removelistener(notifyConfig.onCommonShopData,self.onCommonShopData)
end




function UIXianZhan_ShopWin:onShow(argtable,afterOnloaded)
self.shopId=argtable.shopId

self.shopCfg=cfgHelper.get(cfg_shoplistconfig_get,self.shopId)

self.speakContent=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'shopNPCTalk')
local shopNPCInfo=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'shopNPCInfo')
local modelParams=npcModel:getImageInfo(shopNPCInfo[1])
local scale=0.5
self.catBoss:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,eAnimationID.stand,false,true)
self:refreshTime()
local func=function(...)
self:refreshTime()
end
self.flushtimer=self:setTimer(1,0,func)

local moneyBar=self.shopCfg.moneyBar

self:updateView()

UIManager:showWindow('UITopMoneyWin',moneyBar)

if argtable and argtable.canvasIdx then
self.canvasIdx=argtable.canvasIdx
self:setCanvasIndex(-1,argtable.canvasIdx)
end

self:delayDo(0.3,function()
_this:doSpeaking(1)
end)
end


function UIXianZhan_ShopWin:onHide()

end


function UIXianZhan_ShopWin:refreshTime()
local r_time=xianzhanModel:getShopRefreshTime()
local curTime=gameUtilityModel.getServerLongTime()
local lerp=r_time-curTime
if lerp<0 then lerp=0 end
self.timedesc:setText(FMT.fmt('补货倒计时：{0}',timeHelper.format_time_stamp3(lerp)))
if lerp<=0 then
xianzhanController:req_shop_data()
end
end


function UIXianZhan_ShopWin:updateView()

self.shopDatas=xianzhanModel:getShopGoodsList()
self.subShopDatas=self.shopDatas[self.shopCfg.shopIndex]

local buffRate=homeBuffModel.getBuffAddValue(BUFF_EFFECT_TYPE.eXianZhanShopItemRebateChanged)or 0
buffRate=buffRate/100
self.itemRebate=1-buffRate

local length=#self.subShopDatas
self.goodsScrollview:setChildScrollViewCreateGrids(length,2)

for i=1,length do
self:flushGoods(i-1)
end
end

function UIXianZhan_ShopWin:flushGoods(index)
local item=self.goodsScrollview:getChildScrollViewItemWidget(index)

local itemIndex=index+1
local data=self.subShopDatas[itemIndex][1]
local isUnlock=self.subShopDatas[itemIndex][3]
local itemId=data.id

local sellout=xianzhanModel:checkGoodSellOut(itemId)

widgetHelper.setNormalRewardItem(item,childIndex.item,{itemId,0,showStage=true})
item:SetChildGraphicGray(childIndex.item,sellout,true)

local limitStr=self:getLimitStr(data,itemId)
item:SetChildText(childIndex.limit,limitStr)
item:SetChildActive(childIndex.sold,sellout)
item:SetChildActive(childIndex.grayBg,sellout)

item:SetChildText(childIndex.name,itemsConfig.getItemName(itemId))


local attach
local cost=data.useItem
if cost then
local useItemid=cost[1]
local needCount=cost[2]*self.itemRebate
attach={shopCostArgs={costItemId=useItemid,costNum=needCount}}
local iconName=iconHelper.getIconName(useItemid)
item:SetChildIcon(childIndex.moneyImg,iconName,false)
item:SetChildText(childIndex.moneyTxt,needCount)
end
local isShowDiBan=(index+2)%2==0
item:SetChildActive(17,isShowDiBan)
if isShowDiBan then
item:SetChildSizeDelta(17,744,140.9978)
end

local special=data.special
item:SetChildActive(childIndex.special,special==1)
item:SetChildActive(childIndex.speBg,special==1)


local lockState=not isUnlock
item:SetChildActive(childIndex.lock,lockState)
item:SetChildActive(childIndex.unlock,isUnlock)
if lockState then
local locktip=FMT.fmt('宗门{0}级解锁',data.zmLevel)
item:SetChildText(childIndex.lockTxt,locktip)
end
end

function UIXianZhan_ShopWin:getLimitStr(data,itemid)
local zhouLimit=data.zhouLimit
local zsLimit=data.zsLimit
local shopData=xianzhanModel:getShopDataByItemid(itemid)
local limitStr=''
if zhouLimit then
local weekNum=zhouLimit
if shopData then
weekNum=zhouLimit-shopData.zhouBuyNum
end
limitStr=FMT.fmt('每周限购：{0}',weekNum)
elseif zsLimit then
local zsNum=zsLimit
if shopData then
zsNum=zsLimit-shopData.buyTotal
end
limitStr=FMT.fmt('限购：{0}',zsNum)
end
return limitStr
end

function UIXianZhan_ShopWin:clickGood(clickCount,index)
local data=_this.subShopDatas[index+1][1]
local shopid=data.id

local isUnlock=_this.subShopDatas[index+1][3]
if not isUnlock then
local info=FMT.fmt("宗门{0}级解锁",data.zmLevel)
UIManager.info(info)
return
end

local sellout=xianzhanModel:checkGoodSellOut(shopid)
if sellout then
UIManager.error('该商品已售罄')
return
end

local buffRate=homeBuffModel.getBuffAddValue(BUFF_EFFECT_TYPE.eXianZhanShopItemRebateChanged)or 0
buffRate=buffRate/100
local itemRebate=1-buffRate
local cost=data.useItem
local itemid=cost[1]
local unitPrice=cost[2]*itemRebate
local max=xianzhanModel:checkGoodSellNumMax(shopid)
local maxprice=max*unitPrice
local has=itemsModel.getCount(itemid)
local buymax
if has>=maxprice then
buymax=max
else
buymax=math.floor(has/unitPrice)
end
if buymax<=0 then
UIManager.error(FMT.fmt("{0}不足",moneyModel.getMoneyName(itemid)))
gainControl:showGainWin(itemid)
return
end
local showdata=
{
type='UIUseItemDialouge',
title='提示',
itemId=itemid,
unitPrice=unitPrice,
max=buymax,
oktext='购买',
canceltext='取消',
okcallback=function(selectCnt)
if _this==nil then return end
local num=selectCnt*unitPrice
if not moneyModel.checkEnoughMoney(itemid,num)then
UIManager.error(FMT.fmt("{0}不足",moneyModel.getMoneyName(itemid)))
gainControl:showGainWin(itemid)
return
end
xianzhanController:req_shop_buy(shopid,selectCnt)
_this.comfirmDialog:deleteSelf()
end,
showclosebtn=true,
}
_this.comfirmDialog=UIDialogManager.newDialog(showdata)
_this.comfirmDialog:show()
end

function UIXianZhan_ShopWin:refreshGoodItemByItemid(itemid)
self:updateView()
end

function UIXianZhan_ShopWin:doSpeaking(speakType)
local speakList=self.speakContent
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self:doTalkAnim()
end

function UIXianZhan_ShopWin:doTalkAnim()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setScale(Vector3.zero)
self:delayDo(0.2,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
end)
end)
end)
end

function UIXianZhan_ShopWin:onNpcClicker()
self:doSpeaking(1)
end


