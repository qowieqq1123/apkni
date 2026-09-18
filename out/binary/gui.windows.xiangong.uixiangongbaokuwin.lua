







def_class("UIXianGongBaoKuWin",UIWindowBase)









function UIXianGongBaoKuWin:bindComponents()

self.activeFlag=UIObject.get(self,0)
self.baoKuName=UIText.get(self,1)
self.baoKuUnlock=UIText.get(self,2)
self.btnClose=UIButton.get(self,3)
self.filterBtn_1=UIObject.get(self,4)
self.filterBtn_2=UIObject.get(self,5)
self.filterBtn_3=UIObject.get(self,6)
self.filterBtn_4=UIObject.get(self,7)
self.helpBtn=UIButton.get(self,8)
self.leftTime=UIText.get(self,9)
self.menuContent=UIObject.get(self,10)
self.shopContent=UIObject.get(self,11)
self.shopContent2=UIObject.get(self,12)
self.tab_1=UIButton.get(self,13)
self.tab_2=UIButton.get(self,14)
self.tabSelect_1=UIObject.get(self,15)
self.tabSelect_2=UIObject.get(self,16)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.tab_1:setButtonClick(function()self:onTab_1()end)

self.tab_2:setButtonClick(function()self:onTab_2()end)
self.filterBtn={
self.filterBtn_1,
self.filterBtn_2,
self.filterBtn_3,
self.filterBtn_4,
}
self.tab={
self.tab_1,
self.tab_2,
}
self.tabSelect={
self.tabSelect_1,
self.tabSelect_2,
}



end


function UIXianGongBaoKuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.activeFlag);self.activeFlag=nil;
_UIObject_release(self.baoKuName);self.baoKuName=nil;
_UIObject_release(self.baoKuUnlock);self.baoKuUnlock=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.filterBtn_1);self.filterBtn_1=nil;
_UIObject_release(self.filterBtn_2);self.filterBtn_2=nil;
_UIObject_release(self.filterBtn_3);self.filterBtn_3=nil;
_UIObject_release(self.filterBtn_4);self.filterBtn_4=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.leftTime);self.leftTime=nil;
_UIObject_release(self.menuContent);self.menuContent=nil;
_UIObject_release(self.shopContent);self.shopContent=nil;
_UIObject_release(self.shopContent2);self.shopContent2=nil;
_UIObject_release(self.tab_1);self.tab_1=nil;
_UIObject_release(self.tab_2);self.tab_2=nil;
_UIObject_release(self.tabSelect_1);self.tabSelect_1=nil;
_UIObject_release(self.tabSelect_2);self.tabSelect_2=nil;
self.filterBtn=nil;
self.tab=nil;
self.tabSelect=nil;
end















local _shopItem2={
lock=0,
item=1,
itemNum=2,
arrow=3,
timesTx=4,
rechangeBtn=5,
costList=6,
lockTx=7,
}
local _this=nil



function UIXianGongBaoKuWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onCommonShopData,self.onCommonShopData)
self:addNotify(notifyConfig.onCommonShopChange,self.onCommonShopChange)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
self.filterBtnIdx=1

self.const_def=cfgHelper.getdef(cfg_fairylandshopconfig)
self.selectTab=0
end


function UIXianGongBaoKuWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianGongBaoKuWin:onShow(argtable,afterOnloaded)
local selectTab=argtable.tab or 1
self.selectBaoKuIdx=argtable.baoKuIdx or 1
self.shopId=eFuncShopType.eXianJieBaoKu
self.shopId2=eFuncShopType.eXianGongChaoGong
self.shopCfg=cfgHelper.get(cfg_shoplistconfig_get,self.shopId)
local moneyBar=self.shopCfg.moneyBar
self.showMoneyType=moneyBar and moneyBar[1]and moneyBar[1][1]or nil
if self.showMoneyType then
self:showWindow('UITopMoneyWin2',{{self.showMoneyType}})
end
if afterOnloaded then


end
if self.const_def.filterCfg and#self.const_def.filterCfg>0 then
local filterCfg=self.const_def.filterCfg[self.filterBtnIdx]
self.filterType=filterCfg.filterType
else
self.filterType={[-1]=1}
end
self:refreshBaoKuMenuPanel()
self:refreshFilterBtnPanel()
self:refreshBaoKuShopPanel()
self:refreshChaoGongList()
self:onClickTab(selectTab)







end

function UIXianGongBaoKuWin:refreshLeftTimePanel()
if not self.MonthleftTime then
local nextMonthZeroStamp5=timeHelper.getNextMonthDateStamp(1,5,0,0)
self.MonthleftTime=nextMonthZeroStamp5-timeHelper.getServerLongTime()
else
self.MonthleftTime=self.MonthleftTime-1
end
self.leftTime:setText(string.format("刷新倒计时：%s",timeHelper.format_time_stamp11(self.MonthleftTime,true)))
end

function UIXianGongBaoKuWin:refreshBaoKuMenuPanel()
local baoKuCfg=self.const_def.baoKuCfg
local xianZhiLevel=xianzhiController.getXianZhiChongTian()or 0
self.menuContent:setChildLayoutGroupCreateItems(#baoKuCfg,function(index)
local item=self.menuContent:getChildLayoutGroupGridItem(index-1)
local cfg=baoKuCfg[index]
item:SetChildActive(0,index==self.selectBaoKuIdx)
item:SetChildText(1,cfg.name)
item:SetChildActive(2,xianZhiLevel<cfg.cdn)
item:SetChildButtonClick(3,function()
self:onClickBaoKuMenu(index)
end)
end)
end

function UIXianGongBaoKuWin:onClickBaoKuMenu(index)
if index==self.selectBaoKuIdx then
return
end
local baoKuCfg=self.const_def.baoKuCfg[index]
local item=self.menuContent:getChildLayoutGroupGridItem(self.selectBaoKuIdx-1)
item:SetChildActive(0,false)
self.selectBaoKuIdx=index
item=self.menuContent:getChildLayoutGroupGridItem(self.selectBaoKuIdx-1)
item:SetChildActive(0,true)
self:refreshBaoKuShopPanel()
end

function UIXianGongBaoKuWin:refreshFilterBtnPanel()
local filterCfg=self.const_def.filterCfg or{}
for i,v in ipairs(self.filterBtn)do
local cfg=filterCfg[i]
if cfg then
v:setActive(true)
local widget=v:getWidgetBase()
widget:SetChildActive(0,i==self.filterBtnIdx)
widget:SetChildText(1,i==self.filterBtnIdx and string.format("<color=#7d3b17>%s</color>",cfg.name)or cfg.name)
widget:SetChildButtonClick(2,function()
if self and not self.isClose then
self:onClickFilterBtn(i)
end
end)
else
v:setActive(false)
end
end
end

function UIXianGongBaoKuWin:onClickFilterBtn(idx)
if idx==self.filterBtnIdx then
return
end
local filterCfg=self.const_def.filterCfg[self.filterBtnIdx]
local filterBtn=self.filterBtn[self.filterBtnIdx]:getWidgetBase()
filterBtn:SetChildActive(0,false)
filterBtn:SetChildText(1,filterCfg.name)
self.filterBtnIdx=idx
filterCfg=self.const_def.filterCfg[self.filterBtnIdx]
filterBtn=self.filterBtn[self.filterBtnIdx]:getWidgetBase()
filterBtn:SetChildActive(0,true)
filterBtn:SetChildText(1,string.format("<color=#7d3b17>%s</color>",filterCfg.name))
self.filterType=filterCfg.filterType
for index=1,#self.shopItemList do
self:refreshShopItem(index)
end
end

function UIXianGongBaoKuWin:refreshBaoKuShopPanel()
local baoKuCfg=self.const_def.baoKuCfg[self.selectBaoKuIdx]
local xianZhiLevel=xianzhiController.getXianZhiChongTian()or 0
self.activeFlag:setActive(xianZhiLevel>=baoKuCfg.cdn)
self.baoKuUnlock:setActive(xianZhiLevel<baoKuCfg.cdn)
self.baoKuName:setText(baoKuCfg.name)
self.baoKuUnlock:setText(string.format("仙职达到%s重天解锁",mathHelper.numberToChinese(baoKuCfg.cdn)))



local allList=XianGongModel:getShopBaoKuItemList(self.selectBaoKuIdx)
self.shopItemList={}
for _,v in ipairs(allList)do
if self:isItemHidePassed(v)then
table.insert(self.shopItemList,v)
end
end
self.shopContent:setChildLayoutGroupCreateItems(#self.shopItemList,function(index)
if self and not self.isClose then
self:refreshShopItem(index)
end
end)
end

function UIXianGongBaoKuWin:refreshShopItem(index)
local item=self.shopContent:getChildLayoutGroupGridItem(index-1)
if index==1 then
item:SetChildNewBieComponentId(6,'UIXianGongBaoKuWin.shopItem'..index)
elseif index==2 then
item:SetChildWeakGuideComponentId(-1,'UIXianGongBaoKuWin.shopItem'..index)
end
local itemData=self.shopItemList[index]
local itemId=itemData.itemId
local moneyType,price=unpack(itemData.money)
local enoughMoneyOne=moneyModel.checkEnoughMoney(moneyType,price)
local itemCfg=itemsConfig.getConfig(itemId)
local buyData=funcShopModel:get_data(self.shopId,itemData.id)
if self.filterType[-1]or self.filterType[itemCfg.type1]then
item:SetChildActive(-1,true)
local countStr=''
local conf={itemid=itemId,itemcount=countStr,showCountBG=false,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(0,prop)
item:SetChildText(1,itemCfg.name)

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

item:SetChildIcon(4,iconHelper.getIconName(moneyType),true)
item:SetChildText(5,enoughMoneyOne and price or FMT.cfmt(FONT_COLOR.eRedColor,price))

item:SetChildButtonClick(6,function()
if self and not self.isClose then
self:onItemBuyClick(itemData)
end
end)

local isSellOut=funcShopModel:checkSoldout(self.shopId,itemData.id)
item:SetChildGray(7,isSellOut)
item:SetChildActive(8,isSellOut)
else
item:SetChildActive(-1,false)
end
end

function UIXianGongBaoKuWin:findItemIndex(buyId)
for i,v in ipairs(self.shopItemList or{})do
if v.id==buyId then
return i
end
end
return nil
end

function UIXianGongBaoKuWin:refreshItemByID(buyId)
local index=self:findItemIndex(buyId)
if index then
self:refreshShopItem(index)
end
end

function UIXianGongBaoKuWin:onItemBuyClick(goodcfg)
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
itemsModel:useItem(costType,costNum*num,function()
funcShopController.send_23_2(shopType,buyId,num)
end,WARNING_TYPE.eWarning)
end,

showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end


function UIXianGongBaoKuWin:onBtnClose()
self:closeSelf()
end

function UIXianGongBaoKuWin:onHelpBtn()
local d={}
d.title='规则'
d.mode=3
d.name=self.selectTab==1 and'xgbk_help_%d'or"xgcg_help_%d"
UIManager:showWindow('UIRuleWin',d)
end

function UIXianGongBaoKuWin:onTab_1()
self:onClickTab(1)
end

function UIXianGongBaoKuWin:onTab_2()
self:onClickTab(2)
end

function UIXianGongBaoKuWin:refreshTabList()
for i,v in ipairs(self.tabSelect)do
self:refreshTabSelect(i,self.selectTab==i)
end
end

function UIXianGongBaoKuWin:refreshTabSelect(index,select)
self.tabSelect[index]:setActive(select)
end

function UIXianGongBaoKuWin:onClickTab(index)
if self.changeTab then return end
if self.selectTab~=index then
local animParam=self.selectTab*10+index
if self.tabSelect[self.selectTab]then
self:refreshTabSelect(self.selectTab,false)
end
self.selectTab=index
self:refreshTabSelect(self.selectTab,true)
self.winlua:SetChildAnimatorInteger(-1,"tParam",animParam,true)
self.changeTab=true
end
end

function UIXianGongBaoKuWin:ChangeTabFinish()
self.changeTab=false
end

function UIXianGongBaoKuWin:refreshChaoGongList()
if not funcShopModel:checkInit(self.shopId2)then return end

self.shopData2=funcShopModel:get_sort_list(self.shopId2)
self.shopContent2:setChildLayoutGroupCreateItems(#self.shopData2,function(index)
local item=self.shopContent2:getChildLayoutGroupGridItem(index-1)
local data=self.shopData2[index]
local cfg=data.cfg
local sold=data.sold or false
local unlock=data.unlock or false
local itemConf={itemid=cfg.itemId,itemcount="",showCountBG=false,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
item:SetChildActive(_shopItem2.lock,not unlock)
item:SetChildPropData(_shopItem2.item,itemProp)
item:SetBaseItemClickEvent(_shopItem2.item,itemsComponentHelper.onItemClickEx)
item:SetChildText(_shopItem2.itemNum,cfg.itemNum)
local lockStr=""
local timesTx=""
if not unlock then
local lockTips,lockProgressValue,lockProgressMax=funcShopModel:get_lock_status(self.shopId2,cfg.id,1)
lockStr=FMT.fmt("{0}兑换\n{1}/{2}",lockTips,lockProgressValue,lockProgressMax)
else
local limitStr=funcShopModel.getLimitStr2(cfg.buyLimit[1][1])
local limitNum=cfg.buyLimit[1][2]
local buyData=funcShopModel:get_data(self.shopId2,cfg.id)
local buyNum=buyData and buyData.buyNum or 0
local color=sold and"#C82C2C"or"#549327"
timesTx=FMT.fmt("{0}限兑<color={3}>{1}/{2}</color>次",limitStr,buyNum,limitNum,color)
end
item:SetChildText(_shopItem2.lockTx,lockStr)
item:SetChildText(_shopItem2.timesTx,timesTx)
item:SetChildActive(_shopItem2.rechangeBtn,unlock)
local rewards=cfg.consume or{cfg.money}
item:SetChildLayoutGroupCreateItems(_shopItem2.costList,#rewards,function(_index)
local _item=item:GetChildLayoutGroupGridItem(_shopItem2.costList,_index-1)
local reward=rewards[_index]
local itemid=reward[1]
local itemnum=reward[2]
local haveNum=itemsModel.getCount(itemid)
local numStr=haveNum>=itemnum and FMT.fmt("{0}/{1}",haveNum,itemnum)or FMT.cfmt(FONT_COLOR.eRedColor,"{0}/{1}",haveNum,itemnum)
local _itemConf={itemid=itemid,itemcount="",showCountBG=false,showname=false,showStage=true}
local _itemProp=itemsComponentHelper.getCommonFillDataSmall(_itemConf)
_item:SetChildPropData(0,_itemProp)
_item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
_item:SetChildText(1,numStr)
end)
item:SetChildButtonClick(_shopItem2.rechangeBtn,function()
self:onClickRechange(index)
end)
end)
end

function UIXianGongBaoKuWin:onClickRechange(index)
local data=self.shopData2[index]
local cfg=data.cfg
local buyData=funcShopModel:get_data(self.shopId2,cfg.id)
local buyNum=buyData and buyData.buyNum or 0
local maxCount=cfg.buyLimit[1][2]
local leastNum=maxCount-buyNum
if leastNum<=0 then
local limitStr=funcShopModel.getLimitStr2(cfg.buyLimit[1][1])
UIManager.info(FMT.fmt("{0}兑换次数已用完",limitStr))
return
end

local rewards=cfg.consume or{cfg.money}
local count=leastNum
for i,v in ipairs(rewards)do
local itemid=v[1]
local itemnum=v[2]
local haveNum=itemsModel.getCount(itemid)
if itemnum>haveNum then
UIManager.info(FMT.fmt("{0}不足",itemsConfig.getItemName(itemid)))
gainControl:showGainWin(itemid,itemnum)
return
else
local _count=math.floor(haveNum/itemnum)
count=math.min(count,_count)
end
end

local params={
title='批量兑换',
oktext='兑换',
canceltext='取消',
max=count,
buyGoods={{cfg.itemId,cfg.itemNum}},
costGoods=rewards,
okcallback=function(selectNum)
funcShopController.send_23_2(self.shopId2,cfg.id,selectNum)
end,
}
self:showWindow('UICommonUseItem_goods2goods_Win',params)








end

function UIXianGongBaoKuWin.onCommonShopData(shopId)
if shopId==_this.shopId2 then
_this:refreshChaoGongList()
end
end

function UIXianGongBaoKuWin.onCommonShopChange(shopId,buyId)
if shopId==_this.shopId2 and _this.shopData2 then
for i,v in ipairs(_this.shopData2)do
if v.cfg.id==buyId then
local buyData=funcShopModel:get_data(shopId,buyId)
local buyNum=buyData and buyData.buyNum or 0
if buyNum>=v.cfg.buyLimit[1][2]then
_this:refreshChaoGongList()
return
end
if v.unlock then
local limitStr=funcShopModel.getLimitStr2(v.cfg.buyLimit[1][1])
local limitNum=v.cfg.buyLimit[1][2]
local color=v.sold and"#C82C2C"or"#549327"
local timesTx=FMT.fmt("{0}限兑<color={3}>{1}/{2}</color>次",limitStr,buyNum,limitNum,color)
local item=_this.shopContent2:getChildLayoutGroupGridItem(i-1)
item:SetChildText(_shopItem2.timesTx,timesTx)
end
return
end
end
end
end

function UIXianGongBaoKuWin.on_money_changed(moneyType,lastVal,haveNum)
for i,v in ipairs(_this.shopData2)do
local rewards=v.cfg.consume or{v.cfg.money}
for j,k in ipairs(rewards)do
local itemid=k[1]
if itemid==moneyType then
local item1=_this.shopContent2:getChildLayoutGroupGridItem(i-1)
local item2=item1:GetChildLayoutGroupGridItem(_shopItem2.costList,j-1)
local itemnum=k[2]
local numStr=haveNum>=itemnum and FMT.fmt("{0}/{1}",haveNum,itemnum)or FMT.cfmt(FONT_COLOR.eRedColor,"{0}/{1}",haveNum,itemnum)
item2:SetChildText(1,numStr)
end
end
end
for index,itemData in ipairs(_this.shopItemList)do
local item=_this.shopContent:getChildLayoutGroupGridItem(index-1)
local moneyType,price=unpack(itemData.money)
local enoughMoneyOne=moneyModel.checkEnoughMoney(moneyType,price)
item:SetChildText(5,enoughMoneyOne and price or FMT.cfmt(FONT_COLOR.eRedColor,price))
end
end

function UIXianGongBaoKuWin.on_item_list_changed(changeList)
local lookup={}
for i,v in ipairs(changeList)do
local itemid=v[3]
lookup[itemid]=v[5]
end

for i,v in ipairs(_this.shopData2)do
local rewards=v.cfg.consume or{v.cfg.money}
for j,k in ipairs(rewards)do
local itemid=k[1]
local haveNum=lookup[itemid]
if haveNum then
local item1=_this.shopContent2:getChildLayoutGroupGridItem(i-1)
local item2=item1:GetChildLayoutGroupGridItem(_shopItem2.costList,j-1)
local itemnum=k[2]
local numStr=haveNum>=itemnum and FMT.fmt("{0}/{1}",haveNum,itemnum)or FMT.cfmt(FONT_COLOR.eRedColor,"{0}/{1}",haveNum,itemnum)
item2:SetChildText(1,numStr)
end
end
end
end

function UIXianGongBaoKuWin:isItemHidePassed(itemData)
local hideCfg=itemData.hide
if not hideCfg or not hideCfg[1]then
return true
end

local condType=hideCfg[1][1]
local condVal=hideCfg[1][2]
if condType==7 then
local xianZhiLevel=xianzhiController.getXianZhiChongTian()or 0
return xianZhiLevel>=condVal
end
return true
end