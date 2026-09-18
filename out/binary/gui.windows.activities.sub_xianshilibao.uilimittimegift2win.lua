







def_class("UILimitTimeGift2Win",UIWindowBase)









function UILimitTimeGift2Win:bindComponents()

self.leftImage=UIImage.get(self,0)
self.name=UIText.get(self,1)
self.packScrollerView=UIObject.get(self,2)
self.mao=UIObject.get(self,3)
self.moneyRoot=UIObject.get(self,4)
self.moneyRoot_xianyu=UIObject.get(self,5)
self.time=UIText.get(self,6)
self.Content=UIObject.get(self,7)
self.moneyBtn=UIButton.get(self,8)
self.moneyBtn_xianyu=UIButton.get(self,9)

self.moneyBtn:setButtonClick(function()self:onMoneyBtn()end)

self.moneyBtn_xianyu:setButtonClick(function()self:onMoneyBtn_xianyu()end)



end


function UILimitTimeGift2Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftImage);self.leftImage=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.packScrollerView);self.packScrollerView=nil;
_UIObject_release(self.mao);self.mao=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.moneyRoot_xianyu);self.moneyRoot_xianyu=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.moneyBtn);self.moneyBtn=nil;
_UIObject_release(self.moneyBtn_xianyu);self.moneyBtn_xianyu=nil;
self.moneyRoot=nil;
self.moneyBtn=nil;
end


















local cmpItemIndex=
{
name=0,
item1=1,
buyLimit=6,
buyBtn=7,
freeBtn=8,
buyText=9,
resetFlag=10,
got=11,
selectBtn=12,
buyIcon=13,
}

local itemIndexList={1,2,3,4,5}

local itemCIndex=
{
item=0,
addRoot=1,
button=2,
change=3,
star=4,
suitIcon=5,
}

function UILimitTimeGift2Win:onLoaded(...)
self:bindComponents()
local on_new_day=function()
if self and not self.isClose and self.onRefresh then
self:onRefresh()
end
end
notifySystem:listenNotify(notifyConfig.onNewDay,on_new_day)

self.mao:setChildUIModelShowTarget(4016,0.3,{},eAnimationID.stand)

self._onMoneyChange=function(...)self:onMoneyChange(...)end
self._onItemChange=function(...)self:onItemChange(...)end
notifySystem:listenNotify(notifyConfig.on_money_changed,self._onMoneyChange)
notifySystem:listenNotify(notifyConfig.on_item_changed,self._onItemChange)
end


function UILimitTimeGift2Win:__delete()
self:clearAllFMTweener()
self:unbindComponents()
self.isOver=nil
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
notifySystem:removelistener(notifyConfig.on_money_changed,self._onMoneyChange)
notifySystem:removelistener(notifyConfig.on_item_changed,self._onItemChange)
UIManager:closeWindow("UILimitTimeGiftSelectWin")
end




function UILimitTimeGift2Win:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
self.moneyType=eMoneyType.mtLingYu
self.isShowMoney=self.config.isShowMoney
self.fmTweenerList={}
if self.info then
local leftTime=self.info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("{0}结束",timeHelper.format_time_stamp2(leftTime)))
else
self.time:setText("活动已结束")
self.isOver=true
end
self.leftTimer=self:setTimer(1,-1,function()
local info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
if info then
local leftTime=info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("{0}结束",timeHelper.format_time_stamp2(leftTime)))
else
self.time:setText("活动已结束")
self.isOver=true
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end
else
self.time:setText("活动已结束")
self.isOver=true
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end

end)
else
self.time:setText("活动已结束")
self.isOver=true
end

self:onRefresh()
end


function UILimitTimeGift2Win:onRefresh()
self.isGuoFu=pfwindowslController:checkIsGameVersion_guofu()
self.showList=self:sortReward(self.config.rewards,self.config.name)
self.packScrollerView:setChildScrollViewCreateGrids(#self.showList,1)
self.packScrollerView:setChildScrollViewSelectItem(0,false,false,true)
local grids=self.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
self:refreshGiftItem(item,self.showList[i],self.showList[i].listIndex,i)
end
end

self:freshMoney()
end

function UILimitTimeGift2Win:refreshGiftItemByIndex(listIndex,sortIndex)
local grid=self.packScrollerView:getChildScrollViewItemWidget(sortIndex-1)
if grid then
self:refreshGiftItem(grid,self.showList[sortIndex],listIndex,sortIndex)
end
end

function UILimitTimeGift2Win:refreshGiftItem(cmp,config,listIndex,sortIndex)

if self.isGuoFu then
cmp:SetChildText(cmpItemIndex.name,config.name)
else
local index=pfwindowslController:showDescSix_ByIndex(sortIndex)
cmp:SetChildText(cmpItemIndex.name,FMT.fmt("礼包{0}",index))
end

local itemList=config[1]

local isSelectFin=true

local giftData=activitiesHandle_xianshilibao2:getLiBaoData(self.actid,self.subid,listIndex)

local buyCount=giftData.buyCount or 0
local buyTime=giftData.buyTime

local isZeroReset=config[5]
local buyLimit=config[4]
local buyCostType=config[2]
local buyCostVal=config[3]

local isSold=buyCount>=buyLimit

for i,index in ipairs(itemIndexList)do
local itemKu=itemList[i]

if itemKu then
cmp:SetChildActive(index,true)
local itemWidget=cmp:GetChildWidgetBase(index)
local num=#itemKu

local longPressFunc=function(...)
local idx=1
if not self.isOver then
idx=activitiesHandle_xianshilibao2:getLiBaoSelectData(self.actid,self.subid,listIndex,i)
end
itemsComponentHelper.onItemClickEx(itemKu[idx][1],index)
end
if num>1 then

local selectIndex=nil
if not self.isOver then
selectIndex=activitiesHandle_xianshilibao2:getLiBaoSelectData(self.actid,self.subid,listIndex,i)
end

if selectIndex then
local isYunZhouEquip=itemsConfig.isYunZhouComponents(itemKu[selectIndex][1])
itemWidget:SetChildActive(itemCIndex.item,true)
itemWidget:SetChildActive(itemCIndex.addRoot,false)
itemWidget:SetChildActive(itemCIndex.change,true)
local conf={showname=true,showcount=true,showCountBG=itemKu[selectIndex][2]>1,itemcount=itemKu[selectIndex][2]==1 and"",nomalname=true,select=false,showStageBg=not isYunZhouEquip}
local item={itemid=itemKu[selectIndex][1],itemcount=itemKu[selectIndex][2]==1 and 0 or itemKu[selectIndex][2]}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
itemWidget:SetChildPropData(itemCIndex.item,prop)

itemWidget:SetChildActive(itemCIndex.suitIcon,isYunZhouEquip)
itemWidget:SetChildActive(itemCIndex.star,isYunZhouEquip)
if isYunZhouEquip then
local itemConfig=itemsConfig.getConfig(itemKu[selectIndex][1])
local color=itemConfig.color
local stage=itemConfig.stage or 0
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,itemConfig.type2,color)
itemWidget:SetChildIcon(itemCIndex.suitIcon,string.format("icon_suit_%d",suitConfig.icon),false)
local starWidget=itemWidget:GetChildWidgetBase(itemCIndex.star)
for i=1,5 do
starWidget:SetChildActive(i-1,i<=stage)
end
end

itemWidget:SetChildLongTouch(itemCIndex.button,i,0.5,longPressFunc)
itemWidget:SetChildButtonClick(itemCIndex.change,function()
if not isSold then
self:onAddClick(listIndex,sortIndex,itemList)
end
end)
else
isSelectFin=false

itemWidget:SetChildActive(itemCIndex.star,false)
itemWidget:SetChildActive(itemCIndex.suitIcon,false)
itemWidget:SetChildActive(itemCIndex.item,false)
itemWidget:SetChildActive(itemCIndex.addRoot,true)
itemWidget:SetChildLongTouch(itemCIndex.button,i,0.5,nil)
itemWidget:SetChildActive(itemCIndex.change,false)
end
itemWidget:SetChildActive(itemCIndex.button,true)
itemWidget:SetChildButtonClick(itemCIndex.button,function()
if not isSold then
self:onAddClick(listIndex,sortIndex,itemList)
end
end)

else
local isYunZhouEquip=itemsConfig.isYunZhouComponents(itemKu[1][1])
itemWidget:SetChildActive(itemCIndex.change,false)
itemWidget:SetChildActive(itemCIndex.item,true)
itemWidget:SetChildActive(itemCIndex.addRoot,false)
itemWidget:SetChildActive(itemCIndex.button,true)
local conf={showname=false,showcount=true,showCountBG=itemKu[1][2]>1,itemcount=itemKu[1][2]==1 and"",nomalname=true,select=false,showStageBg=not isYunZhouEquip}
local item={itemid=itemKu[1][1],itemcount=itemKu[1][2]}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
itemWidget:SetChildPropData(itemCIndex.item,prop)

itemWidget:SetChildActive(itemCIndex.suitIcon,isYunZhouEquip)
itemWidget:SetChildActive(itemCIndex.star,isYunZhouEquip)
if isYunZhouEquip then
local itemConfig=itemsConfig.getConfig(itemKu[1][1])
local color=itemConfig.color
local stage=itemConfig.stage or 0
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,itemConfig.type2,color)
itemWidget:SetChildIcon(itemCIndex.suitIcon,string.format("icon_suit_%d",suitConfig.icon),false)
local starWidget=itemWidget:GetChildWidgetBase(itemCIndex.star)
for i=1,5 do
starWidget:SetChildActive(i-1,i<=stage)
end
end

itemWidget:SetChildButtonClick(itemCIndex.button,function()
itemsComponentHelper.onItemClickEx(itemKu[1][1],index)
end)
itemWidget:SetChildLongTouch(itemCIndex.button,i,0.5,longPressFunc)
end
else
cmp:SetChildActive(index,false)
end

end
local isActiveFreeBtn=false
local isActiveBuyBtn=false
local isActiveselectBtn=false
if isSelectFin then
isActiveselectBtn=false
isActiveBuyBtn=not isSold
isActiveFreeBtn=false

if buyCostType==-1 then

local rconfig=cfgHelper.get(cfg_rechargeconfig_get,buyCostVal)
local str=pfwindowslController:showDescFour_ByMoneyType(rconfig)
cmp:SetChildText(cmpItemIndex.buyText,str)
cmp:SetChildActive(cmpItemIndex.buyIcon,false)
cmp:SetChildLocalPosX(cmpItemIndex.buyText,0)
else
if buyCostVal==0 then
isActiveFreeBtn=not isSold
isActiveBuyBtn=false

cmp:SetChildButtonClick(cmpItemIndex.freeBtn,function()
self:onBuyClick(listIndex,buyCostType,buyCostVal,itemList,buyCount,buyLimit)
end,true)
else
isActiveFreeBtn=false
local iconName=iconHelper.getIconName(buyCostType)
cmp:SetChildLocalPosX(cmpItemIndex.buyText,10)
cmp:SetChildActive(cmpItemIndex.buyIcon,true)
cmp:SetChildIcon(cmpItemIndex.buyIcon,iconName,true)
cmp:SetChildText(cmpItemIndex.buyText,buyCostVal)
end
end
cmp:SetChildButtonClick(cmpItemIndex.buyBtn,function()
self:onBuyClick(listIndex,buyCostType,buyCostVal,itemList,buyCount,buyLimit)
end,true)

else
isActiveFreeBtn=false
isActiveBuyBtn=false
isActiveselectBtn=not isSold

cmp:SetChildButtonClick(cmpItemIndex.selectBtn,function()
self:onAddClick(listIndex,sortIndex,itemList)
end,true)
end



cmp:SetChildText(cmpItemIndex.buyLimit,(isSold or buyCostVal==0)and""or FMT.fmt("限购{0}/{1}",buyCount,buyLimit))
cmp:SetChildActive(cmpItemIndex.freeBtn,isActiveFreeBtn)
cmp:SetChildActive(cmpItemIndex.buyBtn,isActiveBuyBtn)
cmp:SetChildActive(cmpItemIndex.got,isSold)
cmp:SetChildActive(cmpItemIndex.selectBtn,isActiveselectBtn)

cmp:SetChildActive(cmpItemIndex.resetFlag,isZeroReset==1)
end

function UILimitTimeGift2Win:onBuyClick(listIndex,buyCostType,buyCostVal,itemList,buyCount,buyLimit)
if self.isOver then
UIManager.error("活动已结束")
return
end
local showItem={}
local indexList={}

for i,v in ipairs(itemList)do
local selectIndex=activitiesHandle_xianshilibao2:getLiBaoSelectData(self.actid,self.subid,listIndex,i)
if selectIndex then
indexList[i]=selectIndex
table.insert(showItem,v[selectIndex])
else
indexList[i]=1
table.insert(showItem,v[1])
end
end

local conf={}
for i,v in ipairs(showItem)do
local itemid=v[1]
local count=v[2]
table.insert(conf,{itemid=itemid,num=count})
end

if buyCostVal==0 then

local info={listIndex,1}
for i,v in ipairs(indexList)do
table.insert(info,v)
end
local jsonStr=jsonHelper.encode(info)
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actid,self.subType,self.subid,jsonStr)
self.showRewardFunc=function()
if next(conf)then
showPrizeControl.showWindowNow(conf)
end
end
end

if buyCostType==-1 then
if self.payTimer then
return
end

local rechargeAmount=payControl:getRechargeAmount(buyCostVal)
local twoTimeCostNum=rechargeAmount*2
local tenTimeCostNum=rechargeAmount*10
local titemid,voucherCount=payControl.getVoucherId(twoTimeCostNum)

local buyFunc=function(count,isItem)
local info={listIndex,count}
for i,v in ipairs(indexList)do
table.insert(info,v)
end
local params=payControl.getActivityPayParams(self.actid,self.subType,self.subid,info)
if isItem then
local pram=jsonHelper.encode({buyCostVal,params})
bagProtocolControl.req_1_21(titemid,count*rechargeAmount,pram)
else
local batch_buy=self.config.batch_buy or{}
if batch_buy[buyCostVal]and batch_buy[buyCostVal][count]then
buyCostVal=batch_buy[buyCostVal][count]
end

payControl.reqPay(buyCostVal,count,params)
end
self.showRewardFunc=function()
if next(conf)then
showPrizeControl.showWindowNow(conf)
end
end
if not self.payTimer then
self.payTimer=self:setTimer(1,1,function()
self.payTimer=nil
end)
end
end
local batchBuyFixedNum=pfwindowslController:checkPFWinState_ByWinType_DfShow(pfwindowslController.winType.batchBuyFixedNum)
if buyLimit-buyCount>1 and voucherCount>=twoTimeCostNum then
local args={
rewards=showItem,
name="礼包",
price={titemid,rechargeAmount},
leftNum=buyCount,
maxcount=buyLimit,
isCheckMaxSelectCount=true,
callback=function(num)
buyFunc(num,true)
end
}
UIManager:showWindow("UICommonBuyDialogWin",args)
elseif buyLimit-buyCount>=10 and batchBuyFixedNum then
local args={
rewards=showItem,
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
else
if buyLimit-buyCount>1 then
UIManager:showWindow("UICommonBuyDialogWin",{rewards=showItem,name="礼包",price={buyCostType,buyCostVal},leftNum=buyCount,maxcount=buyLimit,isCheckMaxSelectCount=true,callback=function(num)
if self.isOver then
UIManager.error("活动已结束")
return
end
local info={listIndex,num}
for i,v in ipairs(indexList)do
table.insert(info,v)
end
local jsonStr=jsonHelper.encode(info)
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actid,self.subType,self.subid,jsonStr)
self.showRewardFunc=function()
local conf={}
for i,v in ipairs(showItem)do
local itemid=v[1]
local count=v[2]*num
table.insert(conf,{itemid=itemid,num=count})
end
if next(conf)then
showPrizeControl.showWindowNow(conf)
end
end
end})
else
local info={listIndex,1}
for i,v in ipairs(indexList)do
table.insert(info,v)
end
local flag=moneySystem:useMoney(buyCostType,buyCostVal,function(...)
local jsonStr=jsonHelper.encode(info)
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actid,self.subType,self.subid,jsonStr)
self.showRewardFunc=function()
if next(conf)then
showPrizeControl.showWindowNow(conf)
end
end
end,WARNING_TYPE.eWarning)
end
end


end

function UILimitTimeGift2Win:showReward()





end

function UILimitTimeGift2Win:onAddClick(listIndex,sortIndex,itemList)
UIManager:showWindow("UILimitTimeGiftSelectWin",{actid=self.actid,subid=self.subid,subType=self.subType,perentWin=self,rewardIndex=listIndex,sortIndex=sortIndex,itemList=itemList})
end

function UILimitTimeGift2Win:sortReward(rewards,names)
local showList={}

local pfOpen_yiyuanlibao=pfwindowslController:checkPFWinState_ByWinType_DfShow(pfwindowslController.winType.yiyuanlibao)
for i,v in ipairs(rewards)do
local sortId=i
local item=v
item.listIndex=i
item.sortId=sortId
if names then
item.name=names[i]or''
end
local giftData=activitiesHandle_xianshilibao2:getLiBaoData(self.actid,self.subid,i)
if giftData then
local buyCount=giftData.buyCount or 0
local buyLimit=item[4]
local isZeroReset=item[5]
local buyTime=giftData.buyTime

if isZeroReset==1 and buyTime~=nil then





if not timeHelper.isTodayStamp(timeHelper.convertLongStamp(buyTime))then

buyCount=0
activitiesHandle_xianshilibao2:setLiBaoData(self.actid,self.subid,i,{buyCount=0,buyTime=nil})
end
end
local isSold=buyCount>=buyLimit
if isSold then
item.sortId=sortId+10000
end
end

local isCanShow=true
if item[6]then
local sysid=item[6]
local sysCfg=cfgHelper.get1(cfg_systemopenconfig_get,sysid)
if sysCfg then
isCanShow=systemModel.isOpen(sysid)
else
logErr(FMT.fmt("系统id配置错误，id::{0}",sysid))
end
end
if pfOpen_yiyuanlibao then
if item[2]==-1 then
local amount=payControl:getRechargeAmountDefault(item[3])
if amount==1 then
isCanShow=false
end
end
end

if isCanShow then
table.insert(showList,item)
end
end
table.sort(showList,function(a,b)
return a.sortId<b.sortId
end)

return showList
end


function UILimitTimeGift2Win:onHide()
self:clearAllFMTweener()
end

function UILimitTimeGift2Win:onMoneyChange(moneyType,lastVal,val)
if self.isShowMoney and self.moneyType==moneyType and UIManager:isActive("UILimitTimeGift2Win")then
self:freshMoneyValue(self.moneyType,lastVal)
end

if self.isShowMoney and moneyType==eMoneyType.mtXianYu and UIManager:isActive("UILimitTimeGift2Win")then
self:freshMoneyValue_xianyu(lastVal)
end
end

function UILimitTimeGift2Win:onItemChange(changeType,itemguid,itemid,lastcount,itemcount)
if self.isShowMoney and self.moneyType==itemid and UIManager:isActive("UILimitTimeGift2Win")then
self:freshMoneyValue(self.moneyType,lastcount)
end
if self.isShowMoney and itemid==eMoneyType.mtXianYu and UIManager:isActive("UILimitTimeGift2Win")then
self:freshMoneyValue_xianyu(lastcount)
end
end

function UILimitTimeGift2Win:freshMoneyValue(moneyType,lastVal)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot:getID())
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
self:clearFMTweenerByIndex(1)
self.fmTweenerList[1]=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
widget:SetChildText(1,moneyStr)
end,moneyVal,1)
end

function UILimitTimeGift2Win:freshMoneyValue_xianyu(lastVal)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot_xianyu:getID())
local moneyVal=0
local moneyType=eMoneyType.mtXianYu
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
self:clearFMTweenerByIndex(2)
self.fmTweenerList[2]=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
widget:SetChildText(1,moneyStr)
end,moneyVal,1)
end

function UILimitTimeGift2Win:clearFMTweenerByIndex(index)
if self.fmTweenerList[index]then
self.fmTweenerList[index]:Kill()
self.fmTweenerList[index]=nil
end
end

function UILimitTimeGift2Win:clearAllFMTweener()
for index,tweener in pairs(self.fmTweenerList)do
tweener:Kill()
self.fmTweenerList[index]=nil
end
end

function UILimitTimeGift2Win:freshMoney()
if not self.isShowMoney then
self.moneyRoot:setActive(false)
self.moneyRoot_xianyu:setActive(false)
return
end

self.moneyRoot:setActive(true)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot:getID())
local moneyType=self.moneyType
local isAdd=true
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(0,iconHelper.getIconName(moneyType),false)
widget:SetChildText(1,moneyStr)
widget:SetChildActive(2,isAdd)
widget:SetChildButtonClick(2,function()self:onAddClick(moneyType)end,true)

self.moneyRoot_xianyu:setActive(true)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot_xianyu:getID())
local moneyType=eMoneyType.mtXianYu
local isAdd=true
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(0,iconHelper.getIconName(moneyType),false)
widget:SetChildText(1,moneyStr)
widget:SetChildActive(2,isAdd)
widget:SetChildButtonClick(2,function()self:onAddClick(moneyType)end,true)
end



function UILimitTimeGift2Win:onMoneyBtn()
if self.moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(self.moneyType)
end
end



function UILimitTimeGift2Win:onMoneyBtn_xianyu()
UIFullRechargeController:showRechargeWindow()
end

