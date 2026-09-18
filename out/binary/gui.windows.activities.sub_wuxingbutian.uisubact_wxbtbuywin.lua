







def_class("UISubAct_wxbtBuyWin",UIWindowBase)









function UISubAct_wxbtBuyWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.handleImg=UIObject.get(self,1)
self.subBtn=UIButton.get(self,2)
self.addBtn=UIButton.get(self,3)
self.selectCntText=UIText.get(self,4)
self.titleText=UIText.get(self,5)
self.sliderRoot=UIObject.get(self,6)
self.selectCntSlider=UIObject.get(self,7)
self.lyitem=UIObject.get(self,8)
self.lynum=UIText.get(self,9)
self.lybtn=UIButton.get(self,10)
self.lycosttxt=UIText.get(self,11)
self.lytitle=UIText.get(self,12)
self.lysynum=UIText.get(self,13)
self.layout1=UIObject.get(self,14)
self.layout2=UIObject.get(self,15)
self.zgbtn=UIButton.get(self,16)
self.zgtxt=UIText.get(self,17)
self.zgsynum=UIText.get(self,18)
self.cosicon=UIImage.get(self,19)
self.fullzg=UIObject.get(self,20)
self.zgTitle=UIText.get(self,21)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.lybtn:setButtonClick(function()self:onLybtn()end)

self.zgbtn:setButtonClick(function()self:onZgbtn()end)



end


function UISubAct_wxbtBuyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.sliderRoot);self.sliderRoot=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.lyitem);self.lyitem=nil;
_UIObject_release(self.lynum);self.lynum=nil;
_UIObject_release(self.lybtn);self.lybtn=nil;
_UIObject_release(self.lycosttxt);self.lycosttxt=nil;
_UIObject_release(self.lytitle);self.lytitle=nil;
_UIObject_release(self.lysynum);self.lysynum=nil;
_UIObject_release(self.layout1);self.layout1=nil;
_UIObject_release(self.layout2);self.layout2=nil;
_UIObject_release(self.zgbtn);self.zgbtn=nil;
_UIObject_release(self.zgtxt);self.zgtxt=nil;
_UIObject_release(self.zgsynum);self.zgsynum=nil;
_UIObject_release(self.cosicon);self.cosicon=nil;
_UIObject_release(self.fullzg);self.fullzg=nil;
_UIObject_release(self.zgTitle);self.zgTitle=nil;
end















local _this




function UISubAct_wxbtBuyWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_wxbtBuyWin:__delete()
self:closeWindow('UITopMoneyWin2')
self.selectCnt=nil
self.max=nil
_this=nil
self:unbindComponents()
end




function UISubAct_wxbtBuyWin:onShow(argtable,afterOnloaded)
if argtable then
self.actID=argtable.actID
self.subType=argtable.subType
self.subid=argtable.subid
self.parentwin=argtable.parentwin
local zgTitleStr=argtable.zgTitleStr or"礼包"
self.zgTitle:setText(zgTitleStr)

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self.actHandle=get_activitiesHandle2(self.subType)
end


local buy_dice_times=self.config.buy_dice_times
local costid=buy_dice_times[1][2][1]
local iconName=iconHelper.getIconName(costid)
self.winlua:SetChildIcon(self.cosicon:getID(),iconName,false)


local buy_get_items=self.config.buy_get_items
local itemID=buy_get_items[1]
self.itemIDnum=buy_get_items[2]
if itemID then
local widget=self.lyitem:getWidgetBase()
local itemid=itemID
local countStr=''
local showCountBG=false
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end

local moneytypes={{eMoneyType.mtLingYu},{eMoneyType.mtXianYu}}
if moneytypes then

self:showWindow("UITopMoneyWin2",{moneys={{eMoneyType.mtLingYu},{eMoneyType.mtXianYu}},offsetX=90,offsetY=-25})
else
self:closeWindow('UITopMoneyWin2')
end


self:refreshInfo()


self:refreshZhigou()
end


function UISubAct_wxbtBuyWin:onHide()

end



function UISubAct_wxbtBuyWin:refreshInfo()



self.canbuy=false
local limitNum=self.config.buy_times_limit
local lynum,zgnum=self.actHandle:getBuyNum(self.actID,self.subType,self.subid)

local buy_dice_times=self.config.buy_dice_times
local costid=buy_dice_times[1][2][1]

local num2=moneyModel.getMoney(eMoneyType.mtXianYu)
local num3=moneyModel.getMoney(costid)
local num=num2+num3

local systr=""
local remainingNum
if limitNum>0 then
remainingNum=limitNum-lynum
if remainingNum<=0 then
remainingNum=0
end
systr=FMT.fmt("剩余购买次数：{0}",remainingNum)
end
self.lysynum:setText(systr)


self.min=1
self.max=99
if remainingNum and self.max>=remainingNum then
self.max=remainingNum
end

local maxCanBuyCount=0
local remainingMoneyCount=num
local maxIdx=#buy_dice_times
for idx,cfg in ipairs(buy_dice_times)do
local isFinal=idx>=maxIdx
local maxNum=cfg[1]
local cost=cfg[2]
local costItemId=cost[1]
local costCount=cost[2]

local canBuyCount=math.floor(remainingMoneyCount/costCount)
if not isFinal and canBuyCount>=maxNum then
canBuyCount=maxNum
end
maxCanBuyCount=maxCanBuyCount+canBuyCount

if canBuyCount<=0 then
break
end
end

if self.max>maxCanBuyCount then
self.max=maxCanBuyCount
end
if self.max<self.min then
self.max=self.min
end
self.selectCnt=self.min
local func=function(...)
_this:onSliderChange(...)
end
self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.max>self.min)
self.selectCntSlider:setChildSliderInit(self.selectCnt,self.min,self.max,func)
self.selectCntSlider:setChildSliderValue(self.selectCnt)
end


function UISubAct_wxbtBuyWin:onSliderChange(value)
self.selectCnt=value
local num=self.selectCnt



self.selectCntText:setText(num)


self:ChangeNum(value)
end


function UISubAct_wxbtBuyWin:ChangeNum(value)


local lynum,zgnum=self.actHandle:getBuyNum(self.actID,self.subType,self.subid)
local buy_dice_times=self.config.buy_dice_times

local costItemNum=0
local buynum=0
local costItemId
local maxIdx=#buy_dice_times
for idx,cfg in ipairs(buy_dice_times)do
local isFinal=idx>=maxIdx
local maxNum=cfg[1]
local cost=cfg[2]
if isFinal or lynum+buynum<=maxNum then
local temp=value-buynum
local canBuyCount=isFinal and temp or maxNum-(lynum+buynum)
local costBuyCount
if temp>=canBuyCount then
costBuyCount=canBuyCount
else
costBuyCount=temp
end
buynum=buynum+costBuyCount
costItemId=cost[1]
local costCount=cost[2]
costItemNum=costItemNum+costCount*costBuyCount

if buynum>=value then
break
end
end
end


local costid=costItemId
local num=moneyModel.getMoney(costid)

self._moneyType=costid
self._moneyNum=costItemNum


local costNum=costItemNum
local str=FMT.fmt('{0}',costNum)
if num<costItemNum then
str=FMT.fmt('<color=#c82c2c>{0}</color>',costNum)
end
self.lycosttxt:setText(str)


local itemNum=buynum*self.itemIDnum
local itemstr=FMT.fmt('{0}',itemNum)
self.lynum:setText(itemstr)
end

function UISubAct_wxbtBuyWin:refreshZhigou()
local cfg=self.config.recharge_dice_times
self.zgcanbuy=false
self.rechargeid=cfg[1]
local rewards=cfg[2]
local limitnum=cfg[3]
local lynum,zgnum=self.actHandle:getBuyNum(self.actID,self.subType,self.subid)
if limitnum>0 and zgnum<=limitnum then
self.zgcanbuy=true
end
if limitnum==0 then
self.zgcanbuy=true
self.zgsynum:setText("")
end
if limitnum>0 then
local _num=limitnum-zgnum
if _num<=0 then
_num=0
end
local systr=FMT.fmt("剩余购买次数：{0}",_num)
self.zgsynum:setText(systr)
end

if limitnum>0 and zgnum>=limitnum then
self.fullzg:setActive(true)
self.zgbtn:setActive(false)
else
self.fullzg:setActive(false)
self.zgbtn:setActive(true)
end


local grids_up2=self.layout1:getChildCommonLayoutGroupWidgetList()
local grids_down2=self.layout2:getChildCommonLayoutGroupWidgetList()
local rewardCount2=#rewards
self.layout2:setActive(rewardCount2>2)
local gridIdxList2=self:getGridIndexList(rewardCount2)
local gridCount2=grids_up2.Count+grids_down2.Count
for i=1,gridCount2 do
local widget
local gridIdx=gridIdxList2[i]
if gridIdx<=grids_up2.Count then
widget=grids_up2[gridIdx-1]
else
widget=grids_down2[gridIdx-grids_up2.Count-1]
end
local reward=rewards[i]
if reward then
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
else
widget:SetChildActive(-1,false)
end
end


local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,self.rechargeid)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
local zhigoustr=str or'nil'
self.zgtxt:setText(zhigoustr)


end
function UISubAct_wxbtBuyWin:getGridIndexList(count)
if count==3 then
return{1,3,4,2}
else
return{1,2,3,4}
end
end





function UISubAct_wxbtBuyWin:onCloseBtn()
self:closeSelf()
end



function UISubAct_wxbtBuyWin:onSubBtn()
if self.selectCnt<=self.min then
return
end
self.selectCnt=self.selectCnt-1
self.selectCntSlider:setChildSliderValue(self.selectCnt)
end



function UISubAct_wxbtBuyWin:onAddBtn()
if self.min>=self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
self.selectCntSlider:setChildSliderValue(self.selectCnt)
end



function UISubAct_wxbtBuyWin:onLybtn()
local limitNum=self.config.buy_times_limit
local lynum,zgnum=self.actHandle:getBuyNum(self.actID,self.subType,self.subid)
if limitNum>0 and lynum>=limitNum then
UIManager.error("可购买次数已达上限")
return
end


local buyFunc=function(...)
if _this==nil then return end
_this.actHandle.sendBuy(_this.selectCnt,_this.actID,_this.subType,_this.subid)
end


local costItemId=self._moneyType
local costCount=self._moneyNum
return itemsModel:useItem(costItemId,costCount,buyFunc,WARNING_TYPE.eWarning)
end



function UISubAct_wxbtBuyWin:onZgbtn()
local cfg=self.config.recharge_dice_times
local rewards=cfg[2]
local limitnum=cfg[3]
local lynum,zgnum=self.actHandle:getBuyNum(self.actID,self.subType,self.subid)
local buyLimit=limitnum
local buyCount=zgnum
if limitnum>0 and zgnum>=limitnum then
UIManager.error("可购买次数已达上限")
end
if limitnum==0 then
buyLimit=99
buyCount=0
end

if self.zgcanbuy then
local actID=self.actID
local subType=self.subType
local subid=self.subid
local rechargeid=self.rechargeid
local rechargeAmount=payControl:getRechargeAmount(self.rechargeid)
local twoTimeCostNum=rechargeAmount*2
local titemid,voucherCount=payControl.getVoucherId(twoTimeCostNum)

local buyFunc=function(num,isItem)
local params=payControl.getActivityPayParams(actID,subType,subid)
if isItem then
local pram=jsonHelper.encode({rechargeid,params})
bagProtocolControl.req_1_21(titemid,num*rechargeAmount,pram)
else
payControl.reqPay(rechargeid,num,params)
end
end

local buyFuncNoVoucher=function()
local params=payControl.getActivityPayParams(actID,subType,subid)
payControl.reqPay(rechargeid,1,params)
end
local batchBuyFixedNum=pfwindowslController:checkPFWinState_ByWinType_DfShow(pfwindowslController.winType.batchBuyFixedNum)
if buyLimit-buyCount>1 and voucherCount>=twoTimeCostNum then
local args={
rewards=rewards,
name="礼包",
price={titemid,rechargeAmount},
leftNum=buyCount,
maxcount=buyLimit,
isCheckMaxSelectCount=true,
callback=function(num)
buyFunc(num,true)
end,
ReqPaycallback=buyFuncNoVoucher
}
UIManager:showWindow("UICommonBuyDialogWin",args)
elseif buyLimit-buyCount>=10 and batchBuyFixedNum then
local args={
rewards=rewards,
name="礼包",
leftNum=buyCount,
maxcount=buyCount+2,
numArray={1,10},
isCheckMaxSelectCount=true,
}
args.callback=function(num)
buyFunc(num,false)
end
UIManager:showWindow("UIFBuyFixedNumDialogWin",args)
else
buyFunc(1,false)
end
end


end


function UISubAct_wxbtBuyWin:onBGClick()
self:onCloseBtn()
end

