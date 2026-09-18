







def_class("UIAuctionBiddingWin",UIWindowBase)









function UIAuctionBiddingWin:bindComponents()

self.nowPriceIcon=UIImage.get(self,0)
self.nowPriceText=UIText.get(self,1)
self.biddingPriceIcon=UIImage.get(self,2)
self.biddingPriceText=UIText.get(self,3)
self.addBtn=UIButton.get(self,4)
self.addCountText=UIText.get(self,5)
self.subBtn=UIButton.get(self,6)
self.subCountText=UIText.get(self,7)
self.commitBtn=UIButton.get(self,8)
self.itemIcon=UIImage.get(self,9)
self.tips=UIText.get(self,10)
self.biddingPanel=UIObject.get(self,11)
self.title=UIText.get(self,12)
self.autoPanel=UIObject.get(self,13)
self.menuGridPanel=UIObject.get(self,14)
self.autotips=UIText.get(self,15)
self.autoBtn=UIButton.get(self,16)
self.priceInputField=UIInputField.get(self,17)
self.Placeholder=UIText.get(self,18)
self.zdbiddingPriceIcon=UIImage.get(self,19)
self.zdbiddingPriceText=UIText.get(self,20)
self.nowvalue=UIText.get(self,21)
self.firstpanel=UIObject.get(self,22)
self.secondpanel=UIObject.get(self,23)
self.fstnowvalue=UIText.get(self,24)
self.xiugaiBtn=UIButton.get(self,25)
self.autoqxBtn=UIButton.get(self,26)
self.autotips2=UIText.get(self,27)
self.fsticon=UIImage.get(self,28)
self.priicon=UIImage.get(self,29)
self.threepanel=UIObject.get(self,30)
self.priceInputField2=UIInputField.get(self,31)
self.Placeholder2=UIText.get(self,32)
self.autofistBtn=UIButton.get(self,33)
self.autotips3=UIText.get(self,34)
self.priicon2=UIImage.get(self,35)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.autoBtn:setButtonClick(function()self:onAutoBtn()end)

self.xiugaiBtn:setButtonClick(function()self:onXiugaiBtn()end)

self.autoqxBtn:setButtonClick(function()self:onAutoqxBtn()end)

self.autofistBtn:setButtonClick(function()self:onAutofistBtn()end)



end


function UIAuctionBiddingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.nowPriceIcon);self.nowPriceIcon=nil;
_UIObject_release(self.nowPriceText);self.nowPriceText=nil;
_UIObject_release(self.biddingPriceIcon);self.biddingPriceIcon=nil;
_UIObject_release(self.biddingPriceText);self.biddingPriceText=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.addCountText);self.addCountText=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.subCountText);self.subCountText=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.itemIcon);self.itemIcon=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.biddingPanel);self.biddingPanel=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.autoPanel);self.autoPanel=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
_UIObject_release(self.autotips);self.autotips=nil;
_UIObject_release(self.autoBtn);self.autoBtn=nil;
_UIObject_release(self.priceInputField);self.priceInputField=nil;
_UIObject_release(self.Placeholder);self.Placeholder=nil;
_UIObject_release(self.zdbiddingPriceIcon);self.zdbiddingPriceIcon=nil;
_UIObject_release(self.zdbiddingPriceText);self.zdbiddingPriceText=nil;
_UIObject_release(self.nowvalue);self.nowvalue=nil;
_UIObject_release(self.firstpanel);self.firstpanel=nil;
_UIObject_release(self.secondpanel);self.secondpanel=nil;
_UIObject_release(self.fstnowvalue);self.fstnowvalue=nil;
_UIObject_release(self.xiugaiBtn);self.xiugaiBtn=nil;
_UIObject_release(self.autoqxBtn);self.autoqxBtn=nil;
_UIObject_release(self.autotips2);self.autotips2=nil;
_UIObject_release(self.fsticon);self.fsticon=nil;
_UIObject_release(self.priicon);self.priicon=nil;
_UIObject_release(self.threepanel);self.threepanel=nil;
_UIObject_release(self.priceInputField2);self.priceInputField2=nil;
_UIObject_release(self.Placeholder2);self.Placeholder2=nil;
_UIObject_release(self.autofistBtn);self.autofistBtn=nil;
_UIObject_release(self.autotips3);self.autotips3=nil;
_UIObject_release(self.priicon2);self.priicon2=nil;
end
















local pageConfig=
{
[1]={
name='竞价',
checkReddot=function()
return false
end,
open=function(self_)
self_:openjjPage()
end,
close=function(self_)
self_:closejjPage()
end,
},
[2]={
name='自动竞价',
checkReddot=function()
return false
end,
open=function(self_)
self_:openzdjjPage()
end,
close=function(self_)
self_:closezdjjPage()
end,
},
}
local _this
local menu_slot_name='button_dytab'



function UIAuctionBiddingWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIAuctionBiddingWin:__delete()
self:unbindComponents()
_this=nil
end




function UIAuctionBiddingWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.auctionSeries then
self.auctionSeries=argtable.auctionSeries
end
if argtable.serverType then
self.serverType=argtable.serverType
end
if argtable.auctionType then
self.auctionType=argtable.auctionType
end
if argtable.page then
self.page=argtable.page
end
if argtable.islockjj then
self.islockjj=argtable.islockjj
end
if argtable.isopenjj then
self.isopenjj=argtable.isopenjj
end
end
local page=self.page or 1
if self.islockjj then
page=2
self.thispanel=1
else
self.thispanel=3
end

if not self.auctionType then
self.auctionType=AUCTION_AUCTION_TYPE.eXianMeng
end
self.selfid=playerModel:getActorID()
self.costMoneyType=nil
if self.auctionType==AUCTION_AUCTION_TYPE.eXianMeng then
self.costMoneyType=eMoneyType.mtLingYu
elseif self.auctionType==AUCTION_AUCTION_TYPE.ePlayer then
self.costMoneyType=eMoneyType.mtXianYu
end
self.maxyf=0






if afterOnloaded then
self.menuGridPanel:setChildCanvasGroupAlpha(0)
self.menuGridPanel:setChildCanvasGroupDOFade(1,0.5,nil)
local cnt=#pageConfig
self.menuGridPanel:setChildLayoutGroupCreateItems(cnt)
local grids=self.menuGridPanel:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
local cfg=pageConfig[i]
item:SetChildText(1,cfg.name)
local isSelected=i==page
local func=function()
if _this==nil then return end
if isSelected then
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
self:refreshMenuItemSelect(item,i,i==page)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
end
end


self:refresh()
self:onMenuItemClick(page)
end


function UIAuctionBiddingWin:onHide()

end


function UIAuctionBiddingWin:openjjPage()
self.biddingPanel:setActive(true)
self.autoPanel:setActive(false)
self.title:setText("竞价")

end

function UIAuctionBiddingWin:openzdjjPage()
self.autoPanel:setActive(true)
self.biddingPanel:setActive(false)
self.title:setText("自动竞价预付")




if self.auctionType==AUCTION_AUCTION_TYPE.eXianMeng then
self.autotips3:setText("每次以当前价格的5%，进行自动竞价\n自动竞价超过或等于一口价时，以一口价的价格成交")
self.autotips2:setText("每次以当前价格的5%，进行自动竞价\n自动竞价超过或等于一口价时，以一口价的价格成交")
end

local auctionData=auctionModel:getAuctionItemDataBySeries(self.serverType,self.auctionType,self.auctionSeries)
local maxyf=0
if auctionData.autoList then
for k,v in ipairs(auctionData.autoList)do
if mathHelper.compareInt64(v.param_1,_this.selfid)then
maxyf=v.param_2
end
end
end
self.maxyf=maxyf
if self.thispanel==1 then
self.firstpanel:setActive(true)
self.secondpanel:setActive(false)
self.threepanel:setActive(false)
self.fstnowvalue:setText(maxyf)

if self.nowPrice>=self.maxyf then

self.autoqxBtn:setActive(false)
self.winlua:SetChildLocalPosX(self.xiugaiBtn:getID(),0)
else
self.autoqxBtn:setActive(true)
self.winlua:SetChildLocalPosX(self.xiugaiBtn:getID(),108)
end
elseif self.thispanel==2 then
self.firstpanel:setActive(false)
self.secondpanel:setActive(true)
self.threepanel:setActive(false)
self.nowvalue:setText(maxyf)

self:initInputField()

self.priceInputField:setChildInputFieldChange(true,function()
self:onInputFieldValueChange()
end)
elseif self.thispanel==3 then
self.firstpanel:setActive(false)
self.secondpanel:setActive(false)
self.threepanel:setActive(true)
self:fst_initInputField()
self.priceInputField2:setChildInputFieldChange(true,function()
self:fst_onInputFieldValueChange()
end)
end
end


function UIAuctionBiddingWin:refresh()

self.auctionItemData=auctionModel:getAuctionItemDataBySeries(self.serverType,self.auctionType,self.auctionSeries)

if not self.auctionItemData then
logErr("没有拍卖品数据 请前端检查传入参数是否正确")
self:onClickClose()
return
end

local auctionData=self.auctionItemData
local itemid=auctionData.itemid
self.itemCount=auctionData.itemcount
self.nowPrice=auctionData.auctionprice
self.thisauctionactorid=auctionData.auctionactorid


local itemConfig=itemsConfig.getConfig(itemid)
local itemAuctionParam
if self.auctionType==AUCTION_AUCTION_TYPE.eXianMeng then
itemAuctionParam=itemConfig.auction
elseif self.auctionType==AUCTION_AUCTION_TYPE.ePlayer then
itemAuctionParam=itemConfig.wbsh
end

if not itemAuctionParam then
logErr(FMT.fmt("道具{0} 没有配置拍卖参数",itemid))
return
end


local singleAddPriceMin=itemAuctionParam[2][1]
self.addPriceMin=singleAddPriceMin*self.itemCount
self.singleAddPriceRate=itemAuctionParam[2][2]
local addPriceNormal=math.ceil(self.nowPrice*self.singleAddPriceRate/100)
local addPrice=addPriceNormal<self.addPriceMin and self.addPriceMin or addPriceNormal
self.addPrice=addPrice

if self.auctionType==AUCTION_AUCTION_TYPE.eXianMeng then

local maxSinglePrice=itemAuctionParam[3]
self.maxPrice=maxSinglePrice*self.itemCount

if self.nowPrice>=self.maxPrice then
UIManager.error("此拍卖品当前竞价已达最高价，无法竞拍")
self:onClickClose()
return
end
end

self.biddingPrice=self.nowPrice+self.addPrice

if tonumber(tostring(self.thisauctionactorid))==0 then
self.biddingPrice=self.nowPrice
end
if self.maxPrice and self.biddingPrice>self.maxPrice then
self.biddingPrice=self.maxPrice
end


local iconName=itemsModel.getIconName(auctionData)
self.itemIcon:setImageIcon(iconName,true)

self:refreshPanel()
end
function UIAuctionBiddingWin:refreshPanel()
local moneyType
if self.auctionType==AUCTION_AUCTION_TYPE.eXianMeng then
moneyType=eMoneyType.mtLingYu
elseif self.auctionType==AUCTION_AUCTION_TYPE.ePlayer then
moneyType=eMoneyType.mtXianYu
end

local moneyName=moneyModel.getMoneyName(moneyType)
self.tips:setText(FMT.fmt("每次加价不能低于{0}{1}",self.addPriceMin,moneyName))
self.tips:setActive(true)


self.nowPriceIcon:setIcon(iconHelper.getIconName(moneyType),false)

self.nowPriceText:setText(self.nowPrice)




self.addCountText:setText(FMT.fmt("+{0}%",self.singleAddPriceRate))
self.subCountText:setText(FMT.fmt("-{0}%",self.singleAddPriceRate))



local enough=itemsModel:canUseItem(moneyType,self.biddingPrice)
if enough then
self.biddingPriceText:setText(self.biddingPrice)
else

self.biddingPriceText:setText(FMT.cfmt(FONT_COLOR.eRedColor,"{0}",self.biddingPrice))
end

self.biddingPriceIcon:setIcon(iconHelper.getIconName(moneyType),false)
self.zdbiddingPriceIcon:setIcon(iconHelper.getIconName(moneyType),false)
self.fsticon:setIcon(iconHelper.getIconName(moneyType),false)
self.priicon:setIcon(iconHelper.getIconName(moneyType),false)
self.priicon2:setIcon(iconHelper.getIconName(moneyType),false)
end


function UIAuctionBiddingWin:setEewPrice(nowPrice)
_this.nowPrice=nowPrice
_this.nowPriceText:setText(_this.nowPrice)
if _this.thispanel==2 then
_this:initInputField()
_this.priceInputField:setChildInputFieldChange(true,function()
_this:onInputFieldValueChange()
end)
elseif _this.thispanel==3 then
_this:fst_initInputField()
_this.priceInputField2:setChildInputFieldChange(true,function()
_this:fst_onInputFieldValueChange()
end)
end
end





function UIAuctionBiddingWin:onAddBtn()
if self.maxPrice and self.biddingPrice+self.addPrice>self.maxPrice then
UIManager.error("不可高于一口价")
return
end


local price=self.biddingPrice+self.addPrice

if self.auctionType==AUCTION_AUCTION_TYPE.eXianMeng then

local isEnough=auctionController:isEnoughBidding(self.serverType,self.auctionType,price)
if not isEnough then
UIManager.error("可用额度不足")
return
end
end

self.biddingPrice=price

self:refreshPanel()
end

function UIAuctionBiddingWin:onSubBtn()
local minPrice=self.nowPrice+self.addPrice

if tonumber(tostring(self.thisauctionactorid))==0 then
minPrice=self.nowPrice
end
if self.biddingPrice-self.addPrice<minPrice then
UIManager.error("不可低于加价最小值")
return
end

self.biddingPrice=self.biddingPrice-self.addPrice

self:refreshPanel()
end

function UIAuctionBiddingWin:onCommitBtn()
local price=self.biddingPrice

if self.auctionType==AUCTION_AUCTION_TYPE.eXianMeng then

local isEnough=auctionController:isEnoughBidding(self.serverType,self.auctionType,price)
if not isEnough then
UIManager.error("可用额度不足")
return
end
end

local moneyType=eMoneyType.mtLingYu
local exchangeType=eMoneyType.mtXianYu
if self.auctionType==AUCTION_AUCTION_TYPE.ePlayer then
moneyType=eMoneyType.mtXianYu
exchangeType=nil
end

local enoughMoneyCallBack=function()

if self.auctionType~=AUCTION_AUCTION_TYPE.ePlayer and self.serverType==AUCTION_SERVER_TYPE.eLocal then

local endTime=self.auctionItemData.auctionsec
local nowTime=gameUtilityModel.getServerShortTime()
local isEnd=false
if endTime then
local lerp=endTime-nowTime
if lerp<=0 then
isEnd=true
end
end

if isEnd then

UIManager.error("此拍卖品已经结束竞拍了")

self:onClickClose()
else

auctionController:reqAuctionBidding(self.serverType,self.auctionType,self.auctionSeries,price)
end
else

if self.auctionType==AUCTION_AUCTION_TYPE.ePlayer and not auctionModel:checkPersonAuctionIsCrossModel()then

auctionController:reqAuctionBidding(self.serverType,self.auctionType,self.auctionSeries,price)
else

auctionController:reqCrossAuctionBidding(self.serverType,self.auctionType,self.auctionSeries,price)
end
end
end
moneySystem:useMoney(moneyType,price,function()
enoughMoneyCallBack()
end,WARNING_TYPE.eWarning,exchangeType)

end

function UIAuctionBiddingWin:onClickClose()
self:closeSelf()
end

function UIAuctionBiddingWin:onCommitCallBack(resultFlag,isClose)
if resultFlag==0 then

UIManager.info("竞价成功")

self:onClickClose()
else

if isClose then

self:onClickClose()
else
self:refresh()
end

end
end


function UIAuctionBiddingWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
if flag then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,flag and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UIAuctionBiddingWin:refreshMenuPage(page,flag)
local cfg=pageConfig[page]
if flag then
cfg.open(self)
else
cfg.close(self)
end
end

function UIAuctionBiddingWin:onMenuItemClick(page)
if _this.islockjj then
if page==1 then
UIManager.info("当前商品已经开启自动竞价")
return
end
end
if page==self.curPage then
return
end
local old=self.curPage
self.curPage=page
if old~=nil then
self:refreshMenuItemSelect(nil,old,false)
self:refreshMenuPage(old,false)
end
self:refreshMenuItemSelect(nil,page,true)
self:refreshMenuPage(page,true)
end
function UIAuctionBiddingWin:closejjPage()
self.biddingPanel:setActive(false)
end
function UIAuctionBiddingWin:closezdjjPage()
self.autoPanel:setActive(false)
end




function UIAuctionBiddingWin:initInputField()

self.frontClickMask=false
self.Placeholder:setActive(true)
self.priceInputField:setInputFieldValue('')
self.price=nil
self.iszdlock=false
self.isminlock=false
self.isMaxlock=false
end
function UIAuctionBiddingWin:onClickInput()
self.Placeholder:setActive(false)
end
function UIAuctionBiddingWin:onExitInput()

self.frontClickMask=false
local str=self.priceInputField:getInputFieldValue()
if str~=''then
self.price=tonumber(str)
else
self.price=nil
end



local nowpice=math.ceil(self.nowPrice*1.05)
local addmin=math.ceil(self.nowPrice*0.05)
if addmin<10 then
nowpice=self.nowPrice+10
end






local flagvalue=math.max(nowpice,self.maxyf)

if self.price then
if self.price<=flagvalue then
_this.isminlock=false



else
_this.isminlock=true
end
if self.maxPrice and self.price>self.maxPrice then
_this.isMaxlock=false
else
_this.isMaxlock=true
end

else
self.Placeholder:setActive(true)
end
end
function UIAuctionBiddingWin:onInputFieldValueChange()
local str=self.priceInputField:getInputFieldValue()
if str~=''then
if str=='-'then
return self.priceInputField:setInputFieldValue('')
else
local price=tonumber(str)
if price and price<0 then
return self.priceInputField:setInputFieldValue(0)
end
end
end
self:refreshSellPanel()
local isShowMask=false
if self.price then
local minPrice=math.ceil(self.nowPrice*1.05)
isShowMask=self.price<minPrice
end
self.frontClickMask=true

end
function UIAuctionBiddingWin:refreshSellPanel()
local str=self.priceInputField:getInputFieldValue()
if str~=''then
self.price=tonumber(str)
else
self.price=nil
end
if self.price then
local enough=itemsModel:canUseItem(self.costMoneyType,self.nowPrice)
if enough then


self.iszdlock=true
else

self.iszdlock=false
end
end
end


function UIAuctionBiddingWin:fst_initInputField()
self.Placeholder2:setActive(true)
self.priceInputField2:setInputFieldValue('')
self.fst_price=nil
self.fst_iszdlock=false
end
function UIAuctionBiddingWin:fst_onClickInput()
self.Placeholder2:setActive(false)
end
function UIAuctionBiddingWin:fst_onExitInput()
local str=self.priceInputField2:getInputFieldValue()
if str~=''then
self.fst_price=tonumber(str)
else
self.fst_price=nil
end
end
function UIAuctionBiddingWin:fst_onInputFieldValueChange()
local str=self.priceInputField2:getInputFieldValue()
if str~=''then
if str=='-'then
return self.priceInputField2:setInputFieldValue('')
else
local price=tonumber(str)
if price and price<0 then
return self.priceInputField2:setInputFieldValue(0)
end
end
end
self:fst_refreshSellPanel()
local isShowMask=false
if self.fst_price then
local minPrice=math.ceil(self.nowPrice*1.05)
isShowMask=self.fst_price<minPrice
end
end
function UIAuctionBiddingWin:fst_refreshSellPanel()
local str=self.priceInputField2:getInputFieldValue()
if str~=''then
self.fst_price=tonumber(str)
else
self.fst_price=nil
end
if self.fst_price then
local enough=itemsModel:canUseItem(self.costMoneyType,self.nowPrice)
if enough then
self.fst_iszdlock=true
else
self.fst_iszdlock=false
end
end
end


function UIAuctionBiddingWin:onAutofistBtn()


local costMoneyType=self.costMoneyType
local fst_price=self.fst_price
local nowPrice=self.nowPrice
local nowPrice2=self.nowPrice
local auctionSeries=self.auctionSeries

local qxfunc=function()

_this.priceInputField2:setInputFieldValue("")
_this.Placeholder2:setActive(true)
end


local _flag=0
if not fst_price then
_flag=1
else
local minPrice=math.ceil(nowPrice2*1.05)
local addmin=math.ceil(nowPrice2*0.05)
if addmin<10 then
minPrice=nowPrice2+10
end
if fst_price<minPrice then
_flag=2
else
local enough=itemsModel:canUseItem(costMoneyType,fst_price)
if enough then
_flag=3
else
_flag=4
end
if self.maxPrice and fst_price>self.maxPrice then
_flag=5
end
end
end

if _flag==1 or _flag==2 then
local _func=function()

local func=function()
local minPrice=math.ceil(nowPrice*1.05)
local addmin=math.ceil(nowPrice*0.05)
if addmin<10 then
minPrice=nowPrice+10
end


_this.priceInputField2:setInputFieldValue(minPrice)
local enough=itemsModel:canUseItem(costMoneyType,minPrice)
if enough then
UIManager.error("自动竞拍底价过低，已为您调整")
else
gainControl:showGainWin(costMoneyType)
end
end
local moneyName=moneyModel.getMoneyName(self.costMoneyType)
local tips=FMT.fmt("最低预付金额需要大于当前竞价5%\n加价金额不低于10{0}\n现将预付竞价调整至最低金额",moneyName)
local show_data=
{
title='提示',
_okText="确定",
_cancelText="取消",
tipsText=tips,
closetopbtn=true,
cellcallback=func,
cellcallback2=qxfunc,
cellcallback3=func,
}
UIManager:showWindow('UIDialougeNomSpeTip',show_data)
end

if self.auctionType==AUCTION_AUCTION_TYPE.eXianMeng then
local minPrice=math.ceil(nowPrice*1.05)
local addmin=math.ceil(nowPrice*0.05)
if addmin<10 then
minPrice=nowPrice+10
end

local isEnough=auctionController:isEnoughBidding(self.serverType,self.auctionType,minPrice)
if not isEnough then
UIManager.error("可用额度不足")
return
end
_func()
else
_func()
end

elseif _flag==4 then
gainControl:showGainWin(costMoneyType)
elseif _flag==3 then
if self.auctionType==AUCTION_AUCTION_TYPE.ePlayer then
itemsModel:useItem(self.costMoneyType,fst_price,function()
auctionController:send_21_35(auctionSeries,fst_price,-1)
end)
elseif self.auctionType==AUCTION_AUCTION_TYPE.eXianMeng then

local isEnough=auctionController:isEnoughBidding(self.serverType,self.auctionType,fst_price)
if not isEnough then
UIManager.error("可用额度不足")
return
end
itemsModel:useItem(self.costMoneyType,fst_price,function()
auctionController:send_21_15(self.serverType,self.auctionType,auctionSeries,fst_price,-1)
end)
end
elseif _flag==5 then





















local _func=function()
_this.priceInputField2:setInputFieldValue(_this.maxPrice)
UIManager.error("预付过高，已为您修改为最高预付金额")
end
if self.auctionType==AUCTION_AUCTION_TYPE.eXianMeng then

local isEnough=auctionController:isEnoughBidding(self.serverType,self.auctionType,_this.maxPrice)
if not isEnough then
UIManager.error("可用额度不足")
return
end
_func()
else
_func()
end
end
end

function UIAuctionBiddingWin:onAutoBtn()
if _this.iszdlock and _this.price and _this.isminlock and _this.isMaxlock then
local nowPrice=self.price

if self.auctionType==AUCTION_AUCTION_TYPE.eXianMeng then

local isEnough=auctionController:isEnoughBidding(self.serverType,self.auctionType,nowPrice-self.maxyf)
if not isEnough then
UIManager.error("可用额度不足")
return
end
end

local enough=itemsModel:canUseItem(self.costMoneyType,nowPrice-self.maxyf)
if enough then
local isPlayer=self.auctionType==AUCTION_AUCTION_TYPE.ePlayer
if nowPrice>=5000 then
local auctionSeries=self.auctionSeries
local rType=isPlayer and REPEAT_TYPE.eWanBaoShangHuiAutoJJ or REPEAT_TYPE.eXianmengPaimai
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,rType)
if not check then

local moneyName=moneyModel.getMoneyName(self.costMoneyType)
local tips1=FMT.fmt('当前预付为：<color=#CA631D>{0}{1}</color>',self.maxyf,moneyName)
local tips2=FMT.fmt('修改后预付为：<color=#CA631D>{0}{1}</color>',nowPrice,moneyName)
local tips3=FMT.fmt('您是否需要补交<color=#CA631D>{0}{1}</color>修改预付？',nowPrice-self.maxyf,moneyName)
local show_data=
{
title='提示',
_okText="确定",
_cancelText="取消",
tipsText="",
paneltipsatxt=tips1,
paneltipsbtxt=tips2,
paneltipsctxt=tips3,
closetopbtn=true,
choosecallback=function(flag)

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,rType,flag)
end,
cellcallback=function()
if nowPrice then
if isPlayer then
itemsModel:useItem(self.costMoneyType,nowPrice-self.maxyf,function()
auctionController:send_21_36(auctionSeries,nowPrice)
end)
else
itemsModel:useItem(self.costMoneyType,nowPrice-self.maxyf,function()
auctionController:send_21_16(self.serverType,self.auctionType,auctionSeries,nowPrice)
end)

end
end
end,
}
UIManager:showWindow('UIDialougeNomSpeTip',show_data)
else
if isPlayer then
itemsModel:useItem(self.costMoneyType,nowPrice-self.maxyf,function()
auctionController:send_21_36(self.auctionSeries,self.price)
end)
else
itemsModel:useItem(self.costMoneyType,nowPrice-self.maxyf,function()
auctionController:send_21_16(self.serverType,self.auctionType,self.auctionSeries,self.price)
end)
end
end
else
if isPlayer then
itemsModel:useItem(self.costMoneyType,nowPrice-self.maxyf,function()
auctionController:send_21_36(self.auctionSeries,self.price)
end)
else
itemsModel:useItem(self.costMoneyType,nowPrice-self.maxyf,function()
auctionController:send_21_16(self.serverType,self.auctionType,self.auctionSeries,self.price)
end)
end
end
else
gainControl:showGainWin(self.costMoneyType)
end
end
if not _this.price then
UIManager.info("请输入价格")
elseif not _this.iszdlock then
gainControl:showGainWin(self.costMoneyType)
elseif not _this.isminlock then
self.Placeholder:setActive(true)
self.priceInputField:setInputFieldValue('')
UIManager.info("自动竞拍底价过低，请重新输入")
elseif not _this.isMaxlock then
self.Placeholder:setActive(false)
self.priceInputField:setInputFieldValue(self.maxPrice)
self:onExitInput()
UIManager.info("预付过高，已为您修改为最高预付金额")
end
end

function UIAuctionBiddingWin:onXiugaiBtn()
self.thispanel=2
self:openzdjjPage()
end

function UIAuctionBiddingWin:onAutoqxBtn()

local nowPrice=self.nowPrice
local auctionSeries=self.auctionSeries
local moneyName=moneyModel.getMoneyName(self.costMoneyType)
local tips=FMT.fmt("您是否取消当前商品的自动竞价托管？\n取消托管后，该商品仍在竞拍中，\n但会退还部分未参与竞拍的{0}。",moneyName)
local show_data=
{
title='提示',
_okText="确定",
_cancelText="取消",
tipsText=tips,
closetopbtn=true,
cellcallback=function()
if nowPrice then
auctionModel:setAutoflag(true)
if self.auctionType==AUCTION_AUCTION_TYPE.ePlayer then
auctionController:send_21_36(auctionSeries,nowPrice)
else
auctionController:send_21_16(self.serverType,self.auctionType,auctionSeries,nowPrice)
end
end
end,
}
UIManager:showWindow('UIDialougeNormalTip',show_data)
return
end