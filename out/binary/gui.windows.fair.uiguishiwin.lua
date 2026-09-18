







def_class("UIGuiShiWin",UIWindowBase)









function UIGuiShiWin:bindComponents()

self.root=UIObject.get(self,0)
self.desc=UIText.get(self,1)
self.guishiModel=UIObject.get(self,2)
self.talkObj=UIObject.get(self,3)
self.goodsScrollview=UIObject.get(self,4)
self.timeTitle=UIText.get(self,5)
self.tips=UIObject.get(self,6)
self.hulu=UIObject.get(self,7)
self.talkDesc=UIText.get(self,8)
self.biaoqing=UIImage.get(self,9)
self.timeText=UIText.get(self,10)
self.limitLv=UIText.get(self,11)
self.item_1=UIBaseItem.get(self,12)
self.item_2=UIBaseItem.get(self,13)
self.item_3=UIBaseItem.get(self,14)
self.item={
self.item_1,
self.item_2,
self.item_3,
}



end


function UIGuiShiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.guishiModel);self.guishiModel=nil;
_UIObject_release(self.talkObj);self.talkObj=nil;
_UIObject_release(self.goodsScrollview);self.goodsScrollview=nil;
_UIObject_release(self.timeTitle);self.timeTitle=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.hulu);self.hulu=nil;
_UIObject_release(self.talkDesc);self.talkDesc=nil;
_UIObject_release(self.biaoqing);self.biaoqing=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.limitLv);self.limitLv=nil;
_UIObject_release(self.item_1);self.item_1=nil;
_UIObject_release(self.item_2);self.item_2=nil;
_UIObject_release(self.item_3);self.item_3=nil;
self.item=nil;
end

















local _goods_cmp_index={
moneyImg=0,
moneyTxt=1,
discount=2,
zhekouCor=3,
image_isbuy=4,
item=5,
bg=6,
button=7,
fightup=8,
click=9,
}

local abName='ui/windows/fair/sharedtextures/fangshi.ab'
local _this


function UIGuiShiWin:onLoaded(...)
self:bindComponents()
_this=self
local clickEvent=function(...)

end
self.goodsScrollview:setChildScrollViewInit(0.5,true,clickEvent,nil)
local record=fairModel:getRecordGuiShi()
if record then
fairModel:setRecordGuiShi()
fairController:refreshBuildHud()
end
end


function UIGuiShiWin:__delete()
_this=nil
self:stopClickDelayTimer()

if MysteryModel:is_enter_Mystery()then

mysteryAIManager:update_queue()
end

self:unbindComponents()
end




function UIGuiShiWin:onShow(argtable,afterOnloaded)
if argtable==nil then return end
self.fairType=argtable and argtable.fairType or eFairType.eBlackMarket

if self.fairType==eFairType.eBlackMarket or self.fairType==eFairType.eBlackSpeGoods then
self:updateView()
else
self:refreshOtherListGoods()
end


self.guishiModel:setChildUIModelShowTarget(2032,1,nil,2051)
self.hulu:setChildUIModelShowTarget(2033,1,nil,2052)

if argtable.talkTips then
self.talkObj:setScale(Vector3(0,0,0))
self:delayDo(0.5,function(...)
self.talkObj:setActive(true)
self.talkDesc:setText(argtable.talkTips)

self.talkObj:setChildDOScale(1,0.2,nil)
end)
end
if argtable.desc then
self.desc:setText(argtable.desc)
end

self:onShowArgRecv()
end


function UIGuiShiWin:onHide()

end

function UIGuiShiWin:onShowArgRecv()

local reddot=fairModel:checkGuiShiReddot()
if reddot then
local data=fairModel:getGuiShiCheckTimeMark()
data.isOpenWin=true
fairModel:setGuiShiCheckTimeMark(data)

reddotControl.on_change_catch_type(CATCH_TYPE.eFair)

fairModel:updateGuiShiCheckTimeMark()
end
end




function UIGuiShiWin:updateView()

if fairModel:is_open_guishi()then
self.timeTitle:setActive(false)
self.tips:setActive(true)
local guishi_lv=FMT.fmt('请仙友的宗门等级达到{0}级再前来吧',fairModel.get_black_market_level())
self.limitLv:setText(guishi_lv)
return
end
self:refreshGoods()
end

function UIGuiShiWin:refreshGoods()

local fairData=fairModel:get_fair_data(self.fairType)
local goodsList=fairData.goodsList
local maxGoodsCount=#goodsList
local cols=2
self.goodsScrollview:setChildScrollViewCreateGrids(maxGoodsCount,cols)

local fairCfg
if self.fairType==eFairType.eBlackMarket then
fairCfg=fairModel.get_black_market_config(fairData.cfg_key_1,fairData.cfg_key_2)
end
self.needMoney={}
local grids=self.goodsScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local slot=grids[i]

local libIndex=goodsList[i+1].param_1
local isBuy=goodsList[i+1].param_2==1
local libType=goodsList[i+1].param_3
local item_lib=libType==1 and fairCfg.randomItem_lib or fairCfg.randomItem_lib2
local libItem=item_lib[libIndex]

local shopItemId=libIndex
libItem=cfgHelper.get(cfg_fangshishopitemconfig_get,shopItemId,"Item_conf")

local itemId=libItem[1]
local itemCount=libItem[2]
local moneyType=libItem[3]
local moneyValue=libItem[4]
local distance=(100-libItem[5])
local israre=libItem[6]
local candistance=libItem[7]
self.dizi_zhekou=self.dizi_zhekou or 0


local curMoney=itemsModel.getCount(moneyType)
local attach=nil
if not isBuy then
attach={insertBtnList={TIPS_BTNS_TYPE.eBuy},buycallBack=function()
self:onClickItemCallback(1,i)
end}
end

slot:SetChildIcon(_goods_cmp_index.moneyImg,iconHelper.getMoneyIconName(moneyType),false)

slot:SetChildActive(_goods_cmp_index.image_isbuy,isBuy)
local bgImgName=israre==1 and'frame_heishispkuang_2'or'frame_heishispkuang_1'
slot:SetChildCSImageSprite(_goods_cmp_index.bg,abName,bgImgName)

local showCount=itemCount>1 and itemCount or''



local item=fairData.itemList[i+1]
local conf={itemcount=showCount,showcount=itemCount>1,showCountBG=itemCount>1,nomalname=true,showStageBg=true}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
slot:SetChildPropData(_goods_cmp_index.item,prop)
local widget=slot:GetChildWidgetBase(_goods_cmp_index.item)
local suitIconName=equipsHelper.getEquipSuitIcon(item)
widget:SetChildIcon(10,suitIconName,false)
slot:SetChildActive(_goods_cmp_index.button,self.fairType==eFairType.eMysteryMarket)
if self.fairType==eFairType.eMysteryMarket then
slot:SetChildButtonClick(_goods_cmp_index.button,function()
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchItem,itemid=itemId,attach=attach})
end)
end


local zhekouprice=math.floor((moneyValue*(distance/100))+0.5)
slot:SetChildActive(_goods_cmp_index.discount,zhekouprice~=moneyValue)
slot:SetChildText(_goods_cmp_index.discount,pfwindowslController:convertDiscount_yuenan(FMT.fmt('{0}折',distance/10)))

slot:SetChildText(_goods_cmp_index.moneyTxt,curMoney<zhekouprice and FMT.cfmt(FONT_COLOR.eRedColor,mathHelper.formatNumber(zhekouprice))or mathHelper.formatNumber(zhekouprice))
slot:SetChildActive(_goods_cmp_index.zhekouCor,zhekouprice~=moneyValue)

self.needMoney[i+1]={moneyType=moneyType,price=zhekouprice}

slot:SetBaseItemClickEvent(_goods_cmp_index.item,function(itemid,index,itemguid)

self:onClickBlackBaseItem(itemid,index,itemguid,attach)
end)


local showUp=fairModel:checkEquipFightUp(item)
slot:SetChildActive(_goods_cmp_index.fightup,showUp)

slot:SetChildButtonClick(_goods_cmp_index.click,function()
self:onClickItemCallback(1,i)
end)
end






















self:refreshTime()
end

function UIGuiShiWin:refreshOtherListGoods()
self.needMoney={}
local fairData=fairModel:get_fair_data(self.fairType)
local goodsList=fairData.goodsList
local maxGoodsCount=#goodsList
local cols=2
self.goodsScrollview:setChildScrollViewCreateGrids(maxGoodsCount,cols)
local grids=self.goodsScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local slot=grids[i]
local libItem=goodsList[i+1]
if libItem then
local itemId=libItem[1]
local itemCount=libItem[2]
local moneyType=libItem[3]
local moneyValue=libItem[4]
local distance=libItem[5]or 100
local israre=libItem[6]
slot:SetChildIcon(_goods_cmp_index.moneyImg,iconHelper.getMoneyIconName(moneyType),false)
local showCount=itemCount>1 and mathHelper.formatNumber(itemCount)or''
local item={itemid=itemId,itemcount=showCount,showCountBG=itemCount>1,}
local conf={itemcount=showCount,showbg=showCount~=nil,showcount=showCount~=nil,showCountBG=showCount~='',nomalname=true,showStageBg=true}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
local attach=nil
local curMoney=itemsModel.getCount(moneyType)
if libItem.buyFlag~=1 then
attach={insertBtnList={TIPS_BTNS_TYPE.eBuy},buycallBack=function()
self:onClickItemCallback(1,i)
end}
end
slot:SetChildActive(_goods_cmp_index.button,self.fairType==eFairType.eMysteryMarket)
if self.fairType==eFairType.eMysteryMarket then
slot:SetChildButtonClick(_goods_cmp_index.button,function()
tipsManager.showTips({formType=TIPS_FORM_TYPE.eNone,itemid=itemId,attach=attach})
end)
end

slot:SetChildActive(_goods_cmp_index.image_isbuy,libItem.buyFlag==1)
local bgImgName=israre==1 and'frame_heishispkuang_2'or'frame_heishispkuang_1'
slot:SetChildCSImageSprite(_goods_cmp_index.bg,abName,bgImgName)

slot:SetChildPropData(_goods_cmp_index.item,prop)

self.needMoney[i+1]={moneyType=moneyType,price=moneyValue}
if distance~=0 then
local zhekouprice=math.floor((moneyValue*(distance/100))+0.5)
self.needMoney[i+1]={moneyType=moneyType,price=zhekouprice}
slot:SetChildActive(_goods_cmp_index.discount,zhekouprice~=moneyValue)
slot:SetChildText(_goods_cmp_index.discount,pfwindowslController:convertDiscount_yuenan(FMT.fmt('{0}折',distance/10)))

slot:SetChildText(_goods_cmp_index.moneyTxt,curMoney<zhekouprice and FMT.cfmt(FONT_COLOR.eRedColor,mathHelper.formatNumber(zhekouprice))or mathHelper.formatNumber(zhekouprice))
slot:SetChildActive(_goods_cmp_index.zhekouCor,zhekouprice~=moneyValue)
end

slot:SetBaseItemClickEvent(_goods_cmp_index.item,function(...)

tipsManager.showTips({formType=TIPS_FORM_TYPE.eNone,itemid=itemId,attach=attach})
end)
end
end
self.timeTitle:setActive(false)
self.timeText:setText("")







end

function UIGuiShiWin:checkBought(index)
if self.fairType==eFairType.eBlackMarket then
local fairData=fairModel:get_fair_data(self.fairType)
local goodsList=fairData.goodsList
if goodsList[index].param_2==1 then
UIManager.error("商品已被购买")
return true
end
end
return false
end

function UIGuiShiWin:onClickItemCallback(clickNum,index)

index=index+1
if index==0 then
return
end
if self:checkBought(index)then
return
end

local needMoney=_this.needMoney[index]
local moneyType=needMoney.moneyType
local needValue=needMoney.price
if self.fairType==eFairType.eMysteryMarket then
local flag=moneySystem:useMoney(moneyType,needValue,function(...)
mysteryShopController.send_4_41(index)
end,WARNING_TYPE.eWarning)
if not flag then

UIDiscipleController.doTriggerSomething(dzTriggerDoSomething.ePrivateMoney,{moneyType,needValue})
end
else
local iconname=iconHelper.getIconName(moneyType)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,52)
local str=FMT.fmt('是否确认花费{0}{1} 购买此商品？',iconStr,needValue)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=str,
oktext='购买',
canceltext='取消',
allowclickBG=false,
okcallback=function(...)
moneySystem:useMoney(moneyType,needValue,function(...)
fairController:req_buy(_this.fairType,index)
_this.comfirmDialog:deleteSelf()
end,WARNING_TYPE.eWarning)
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end
end

function UIGuiShiWin:onClickBlackBaseItem(itemid,index,itemguid,attach)
if itemsConfig.isGubao(itemid)then
gubaoController:gubaoShowTips(itemid,nil,nil,attach)
return
end
itemsComponentHelper.onItemClick(itemid,index,itemguid,attach)
end


function UIGuiShiWin:onClickSpeItem(index)

if index<=0 then
return
end

local buyClickfun=function(fairType,index)
fairController:req_buy(fairType,index)
end
local btClickfun=function()end
UIManager:showWindow("UIFairTipsWin",{index=index,fairtype=eFairType.eBlackSpeGoods,func1=buyClickfun})
end

function UIGuiShiWin:refreshTime()


local flushTimeList=fairModel.get_black_market_flush_time_list()
self.timeText:setText(FMT.fmt("每天的<color=#259307>{0}时</color>和<color=#259307>{1}时</color>补货",flushTimeList[1],flushTimeList[2]))




end


function UIGuiShiWin:stopFairTimer()
if self.fairTimer then
self:stopTimerByID(self.fairTimer)
self.fairTimer=nil
end
end

function UIGuiShiWin:onClickNPC()
if not self.isClickNpc then
self.isClickNpc=true
self.guishiModel:setChildModelAnimationState(2059)
self:stopClickDelayTimer()
self.delayClickTimer=self:delayDo(4.67,function(...)
self.isClickNpc=nil
end)
self:playTalkTween()
if self.fairType==eFairType.eBlackMarket then
self:randomSpeakStr()
end
end
end

function UIGuiShiWin:randomSpeakStr()
local speakStr=fairModel:get_tips_config(self.fairType)
self.talkDesc:setText(speakStr)
end

function UIGuiShiWin:stopClickDelayTimer()
if self.delayClickTimer then
self:stopTimerByID(self.delayClickTimer)
self.delayClickTimer=nil
end
end

function UIGuiShiWin:playTalkTween()
self.talkObj:setScale(Vector3(0,0,0))
local tweener=self.talkObj:setChildDOScale(1,0.2,nil)
tweener:SetDelay(0.1)
end
