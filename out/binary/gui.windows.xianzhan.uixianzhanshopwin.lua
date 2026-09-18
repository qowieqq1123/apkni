







def_class("UIXianZhanShopWin",UIWindowBase)









function UIXianZhanShopWin:bindComponents()

self.bottomPanel=UIObject.get(self,0)
self.middlePanel=UIObject.get(self,1)
self.topPanel=UIObject.get(self,2)
self.topUIPanel=UIObject.get(self,3)
self.speakObj=UIObject.get(self,4)
self.npcModel=UIObject.get(self,5)
self.goodsScrollview=UIObject.get(self,6)
self.closeBtn=UIButton.get(self,7)
self.title=UIText.get(self,8)
self.moneyRoot=UIButton.get(self,9)
self.menuList=UIObject.get(self,10)
self.timeText=UIText.get(self,11)
self.mutiaoScroller=UIObject.get(self,12)
self.moneyIcon=UIObject.get(self,13)
self.moneyText=UIText.get(self,14)
self.speakText=UIText.get(self,15)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.moneyRoot:setButtonClick(function()self:onMoneyRoot()end)



end


function UIXianZhanShopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bottomPanel);self.bottomPanel=nil;
_UIObject_release(self.middlePanel);self.middlePanel=nil;
_UIObject_release(self.topPanel);self.topPanel=nil;
_UIObject_release(self.topUIPanel);self.topUIPanel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.goodsScrollview);self.goodsScrollview=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.menuList);self.menuList=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.mutiaoScroller);self.mutiaoScroller=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyText);self.moneyText=nil;
_UIObject_release(self.speakText);self.speakText=nil;
end

















local _this


function UIXianZhanShopWin:onLoaded(...)
self:bindComponents()
_this=self
self.goodsScrollview:setChildScrollViewInit(0.5,true,self.clickGood,nil)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIXianZhanShopWin:__delete()
_this=nil
self:stopTimerByName('flushtimer')
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
end




function UIXianZhanShopWin:onShow(argtable,afterOnloaded)
self.shopDatas=xianzhanModel:getShopGoodsList()
self.speakContent=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'shopNPCTalk')
local shopNPCInfo=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'shopNPCInfo')
local modelParams=npcModel:getImageInfo(shopNPCInfo[1])
local scale=0.6
self.npcModel:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,eAnimationID.stand,false,true)
self:initMenu()
self:refreshTime()
local func=function(...)
self:refreshTime()
end
self.flushtimer=self:setTimer(1,0,func)
self:refreshMoneyRoot()

self:doOpenAnim()
end

function UIXianZhanShopWin:doOpenAnim()
self.middlePanel:setChildCanvasGroupAlpha(0)
self.topUIPanel:setChildCanvasGroupAlpha(0)
self.bottomPanel:setLocalPosY(-750)
self.topPanel:setLocalPosY(-750)
self.bottomPanel:setChildDOLocalMoveY(0,0.35,nil)
self.topPanel:setChildDOLocalMoveY(0,0.35,nil)
self:delayDo(0.15,function()
self.bottomPanel:setChildDOScale(1.1,0.2,function()
if _this==nil then return end
_this.bottomPanel:setChildDOScale(1,0.1,nil)
end)
self.topPanel:setChildDOScale(1.1,0.2,function()
if _this==nil then return end
_this.topPanel:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this:onOpenAnimFinish()
end)
end)
end)
end

function UIXianZhanShopWin:onOpenAnimFinish()
self.middlePanel:setChildCanvasGroupDOFade(1,0.3)
self.topUIPanel:setChildCanvasGroupDOFade(1,0.3)
self:delayDo(0.3,function()
self:doSpeaking(1)
end)
local grids=self.goodsScrollview:getChildScrollViewItemWidgets()
local delay1=0
local count=0
for i=1,grids.Count do
local item=grids[i-1]
item:SetChildCanvasGroupAlpha(-1,0)
if delay1>0 then
self:delayDo(delay1,function()
item:SetChildCanvasGroupDOFade(-1,1,0.2)
end)
else
item:SetChildCanvasGroupDOFade(-1,1,0.2)
end
count=count+1
if count>=3 then
count=0
delay1=delay1+0.1
end
end
local grids2=self.mutiaoScroller:getChildScrollViewItemWidgets()
local delay2=0
for i=1,grids2.Count do
local item=grids2[i-1]
item:SetChildCanvasGroupAlpha(-1,0)
if delay2>0 then
self:delayDo(delay2,function()
item:SetChildCanvasGroupDOFade(-1,1,0.2)
end)
else
item:SetChildCanvasGroupDOFade(-1,1,0.2)
end
delay2=delay2+0.1
end
end


function UIXianZhanShopWin:onHide()

end

function UIXianZhanShopWin:refreshTime()
local r_time=xianzhanModel:getShopRefreshTime()
local curTime=gameUtilityModel.getServerLongTime()
local lerp=r_time-curTime
if lerp<0 then lerp=0 end
self.timeText:setText(FMT.fmt('补货倒计时：{0}',timeHelper.format_time_stamp3(lerp)))
if lerp<=0 then
xianzhanController:req_shop_data()
end
end

function UIXianZhanShopWin:initMenu()
local pageList=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'shopTab')
local c=#pageList
self.menuList:setChildLayoutGroupCreateItems(c)
local gridlist=self.menuList:getChildLayoutGroupGridList()
for i=1,c do
local item=gridlist[i-1]
local pageTab=pageList[i]
item:SetChildCSImageSprite(0,globalABLookup.global,pageTab[2])
item:SetChildButtonClickWithID(0,self.clickMenu,pageTab[1])
end
self.clickMenu(1)
end

function UIXianZhanShopWin.clickMenu(index)
if _this.selectPageId==index then return end
if _this.selectPageId then
local lastItem=_this.menuList:getChildLayoutGroupGridItem(_this.selectPageId-1)
lastItem:SetChildActive(1,false)
end
_this.selectPageId=index
local item=_this.menuList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(1,true)

_this.goodDatas=_this.shopDatas[index]
_this:refreshGoods()
end

function UIXianZhanShopWin:refreshGoods()
local goodsCount=#self.goodDatas
self.goodsScrollview:setChildScrollViewCreateGrids(goodsCount,3)
self.mutiaoScroller:setChildScrollViewCreateGrids(math.ceil(goodsCount/3),1)
local grids=self.goodsScrollview:getChildScrollViewItemWidgets()
local buffRate=homeBuffModel.getBuffAddValue(BUFF_EFFECT_TYPE.eXianZhanShopItemRebateChanged)or 0
buffRate=buffRate/100
local itemRebate=1-buffRate
for i=1,grids.Count do
local item=grids[i-1]
local data=self.goodDatas[i][1]
local isUnlock=self.goodDatas[i][3]
local itemid=data.id

local sellout=xianzhanModel:checkGoodSellOut(itemid)
item:SetChildActive(3,sellout)
local alpha=sellout and 0.7 or 1
item:SetChildDoBrightness(-1,alpha,0,nil)
local limitStr=self:getLimitStr(data,itemid)
item:SetChildText(5,limitStr)


local attach
local cost=data.useItem
if cost then
local useItemid=cost[1]
local needCount=cost[2]*itemRebate
attach={shopCostArgs={costItemId=useItemid,costNum=needCount}}
local iconName=iconHelper.getIconName(useItemid)
item:SetChildIcon(2,iconName,false)
item:SetChildText(1,needCount)
end

local getCount=data.buyNum
local conf={itemid=itemid,itemcount=getCount,showCountBG=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(itemid_,index_,itemguid_)
self:onClickBaseItem(itemid_,index_,itemguid_,attach)
end)

local special=data.special
item:SetChildActive(6,special==1)

local lockState=not isUnlock
item:SetChildActive(7,lockState)
if lockState then
local locktip=FMT.fmt('宗门{0}级解锁',data.zmLevel)
item:SetChildText(8,locktip)
end
end
end

function UIXianZhanShopWin:getLimitStr(data,itemid)
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

function UIXianZhanShopWin:refreshGoodItemByItemid(itemid)
local index
local data
for i,v in ipairs(self.goodDatas)do
local cfg=v[1]
if cfg.id==itemid then
index=i
data=cfg
break
end
end
local item=self.goodsScrollview:getChildScrollViewItemWidget(index-1)
local sellout=xianzhanModel:checkGoodSellOut(itemid)
item:SetChildActive(3,sellout)
local alpha=sellout and 0.7 or 1
item:SetChildDoBrightness(-1,alpha,0,nil)
local getCount=data.buyNum
item:SetChildItemData(0,PropIndex(DataPropKey.eWidgetText,3),getCount)
local limitStr=self:getLimitStr(data,itemid)
item:SetChildText(5,limitStr)
end

function UIXianZhanShopWin.clickGood(clickCount,index)
local data=_this.goodDatas[index+1][1]
local shopid=data.id

local isUnlock=_this.goodDatas[index+1][3]
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

function UIXianZhanShopWin:onClickBaseItem(itemid,index,itemguid,attach)
itemsComponentHelper.onItemClickEx(itemid,index,itemguid,attach)
end

function UIXianZhanShopWin:refreshMoneyRoot()
local iconName=iconHelper.getIconName(eMoneyType.mtManYiDu)
self.moneyIcon:setChildIcon(iconName,false)
self.moneyText:setText(moneyModel.getMoney(eMoneyType.mtManYiDu))
end

function UIXianZhanShopWin:doSpeaking(speakType)
local speakList=self.speakContent
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self:doTalkAnim()
end

function UIXianZhanShopWin:doTalkAnim()
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


function UIXianZhanShopWin:onCloseBtn()
self:closeSelf()
end

function UIXianZhanShopWin:onMoneyRoot()
local moneyType=eMoneyType.mtManYiDu
gainControl:showGainWin(moneyType)
end

function UIXianZhanShopWin:onNPCClick()
self:doSpeaking(1)
end

function UIXianZhanShopWin.on_money_changed(moneyType,lastVal,val)
if moneyType==eMoneyType.mtManYiDu then
_this:refreshMoneyRoot()
end
end
