







def_class("UIWeekInvestorWin",UIWindowBase)









function UIWeekInvestorWin:bindComponents()

self.arrow=UIObject.get(self,0)
self.cardList=UIObject.get(self,1)
self.cardView=UIObject.get(self,2)



end


function UIWeekInvestorWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.cardList);self.cardList=nil;
_UIObject_release(self.cardView);self.cardView=nil;
end















local _this=nil
local _itemCmp={
image=0,
name=1,
earningsBg=2,
earnings=3,
appendBtn=4,
buyBtn=5,
buyTx=6,
leastTimeBg=7,
leastTime=8,
buyRewardView=9,
dailyRewardView=10,
buyRewardList=11,
dailyRewardList=12,
helpBtn=13,
tipsBg=14,
tipsTx=15,
}



function UIWeekInvestorWin:onLoaded(...)
self:bindComponents()
_this=self
self.cdDatas={}
self:addNotify(notifyConfig.onNewDay,self.onNewDay)
self:addNotify(notifyConfig.on_system_open,self.on_system_open)
self:addNotify(notifyConfig.building_event,self.on_building_event)
self:addProNotify(14,30,self.on_14_30)
self:addProNotify(14,31,self.on_14_31)
self:addProNotify(14,32,self.on_14_32)
rechargeController:doWeekCardEnter()
end


function UIWeekInvestorWin:__delete()
self:unbindComponents()
_this=nil

self:stopCDTick()
end




function UIWeekInvestorWin:onShow(argtable,afterOnloaded)
self:refreshCardData()
self:refreshCardList()
self:scrollToItem(argtable and argtable.id or nil)
end


function UIWeekInvestorWin:onHide()

end



function UIWeekInvestorWin:onScrollChange()
local div=self.listHeight-self.viewHeight
if div>0 then
local posY=self.cardList:getChildAnchoredPosition().y
local left=self.listHeight-posY-self.viewHeight
local show=left>54
self.arrow:setActive(show)
else
self.arrow:setActive(false)
end
end

function UIWeekInvestorWin:onClickHelpBtn(id)
local config=cfgHelper.get1(cfg_zhoukaconfig_get,id)
if config.rule then
local d={}
d.title='规则'
d.mode=3
d.name=config.rule
UIManager:showWindow('UIRuleWin',d)
end
end

function UIWeekInvestorWin:onClickAppendBtn(id)
local data=rechargeModel:getWeekCardData(id)
local nowTime=timeHelper.getServerShortTime()
local buyed=data~=nil and nowTime<data.valid
if buyed then
local config=cfgHelper.get1(cfg_zhoukaconfig_get,id)
local nowTime=timeHelper.getServerShortTime()
local todayZero=timeHelper.getServerZeroShortStamp(nowTime)
local leastDay=math.floor((data.valid-todayZero)/86400+0.5)
if config.maxDay==nil or(leastDay+config.day)<=config.maxDay then
















local rechargeid=config.czId
local rechargeAmount=payControl:getRechargeAmount(rechargeid)
local twoTimeCostNum=rechargeAmount*2
local titemid,voucherCount=payControl.getVoucherId(twoTimeCostNum)

local maxDay=config.maxDay-leastDay
if maxDay<1 then maxDay=0 end
local day=config.day
local maxnum=math.floor(maxDay/day)
local djjnum=math.floor(voucherCount/rechargeAmount)
local buyNum=math.min(maxnum,djjnum)


if buyNum>1 and voucherCount>=twoTimeCostNum then
local buyFunc=function(count,isItem)
if isItem then
local pram=jsonHelper.encode({rechargeid})
bagProtocolControl.req_1_21(titemid,count*rechargeAmount,pram)
else
payControl.reqPay(rechargeid,count)
end
end
local buyFuncNoVoucher=function()
payControl.reqPayNoVoucher(rechargeid,1)
end
local freshback=function(num)
local _day=config.day*num
local contentStr=FMT.fmt('追加<color=#ca631d>{0}</color>次{1}，时长<color=#ca631d>+{2}</color>天，立得以下道具：',num,config.name,_day)
return contentStr
end

local rewards={}
local buyItems=defaultT
local level=zongmenModel:getLevel()
for i,v in ipairs(config.buyItems)do
if v[1]<=level and level<=v[2]then
buyItems=v[3]
break
end
end
for i,v in ipairs(buyItems)do
table.insert(rewards,{v[1],v[2]})
end
local args={
rewards=rewards,
name=config.name,
price={titemid,rechargeAmount},
leftNum=0,
maxcount=buyNum,
isCheckMaxSelectCount=true,
callback=function(num)
buyFunc(num,true)
end,
ReqPaycallback=buyFuncNoVoucher,
freshback=freshback
}
UIManager:showWindow("UICommonBuyDialogWin",args)
else
payControl.reqPay(rechargeid)
end
else
UIManager.error(FMT.fmt("最大有效时间不得超过{0}天",config.maxDay))
end
else
UIManager.error("未购买")
end
end

function UIWeekInvestorWin:onClickBuyBtn(id)
local data=rechargeModel:getWeekCardData(id)
local nowTime=timeHelper.getServerShortTime()
local buyed=data~=nil and nowTime<data.valid
if buyed then
local getted=data.daily>=nowTime or timeHelper.checkInSameDay2(data.daily,nowTime)
local todayZero=timeHelper.getServerZeroShortStamp(nowTime)
local leastDay=(data.valid-todayZero)/86400
if getted then
UIManager.error("今日已领取")
else
rechargeController:send_14_31(id)
end
else



local config=cfgHelper.get1(cfg_zhoukaconfig_get,id)
local maxDay=config.maxDay
local day=config.day
local rechargeid=config.czId
local rechargeAmount=payControl:getRechargeAmount(rechargeid)
local twoTimeCostNum=rechargeAmount*2
local titemid,voucherCount=payControl.getVoucherId(twoTimeCostNum)
local maxnum=math.floor(maxDay/day)
local djjnum=math.floor(voucherCount/rechargeAmount)
local buyNum=math.min(maxnum,djjnum)


if buyNum>1 and voucherCount>=twoTimeCostNum then
local buyFunc=function(count,isItem)
if isItem then
local pram=jsonHelper.encode({rechargeid})
bagProtocolControl.req_1_21(titemid,count*rechargeAmount,pram)
else
payControl.reqPay(rechargeid,count)
end
end
local buyFuncNoVoucher=function()
payControl.reqPayNoVoucher(rechargeid,1)
end
local freshback=function(num)
local _day=config.day*num
local contentStr=FMT.fmt('购买<color=#ca631d>{0}</color>次{1}，时长<color=#ca631d>{2}</color>天，立得以下道具：',num,config.name,_day)
return contentStr
end

local rewards={}
local buyItems=defaultT
local level=zongmenModel:getLevel()
for i,v in ipairs(config.buyItems)do
if v[1]<=level and level<=v[2]then
buyItems=v[3]
break
end
end
for i,v in ipairs(buyItems)do
table.insert(rewards,{v[1],v[2]})
end
local args={
rewards=rewards,
name=config.name,
price={titemid,rechargeAmount},
leftNum=0,
maxcount=buyNum,
isCheckMaxSelectCount=true,
callback=function(num)
buyFunc(num,true)
end,
ReqPaycallback=buyFuncNoVoucher,
freshback=freshback
}
UIManager:showWindow("UICommonBuyDialogWin",args)
else
payControl.reqPay(rechargeid)
end
end
end

function UIWeekInvestorWin:initCardItem(item,id)
local config=cfgHelper.get1(cfg_zhoukaconfig_get,id)
local czCfg=cfgHelper.get1(cfg_rechargeconfig_get,config.czId)
local data=rechargeModel:getWeekCardData(id)
local nowTime=timeHelper.getServerShortTime()
local buyed=data~=nil and nowTime<data.valid
local zmLv=zongmenModel:getLevel()
local level=buyed and data.level or zmLv

item:SetChildCSImageSprite(_itemCmp.name,config.nameImage[1],config.nameImage[2])

item:SetChildText(_itemCmp.earnings,FMT.fmt("{0}%收益",config.percent))
item:ForceLayoutRect(_itemCmp.earnings)
item:ForceLayoutRect(_itemCmp.earningsBg)
item:SetChildCSImageSprite(_itemCmp.image,config.image[1],config.image[2])

item:SetChildButtonClick(_itemCmp.appendBtn,function()
self:onClickAppendBtn(id)
end)
item:SetChildButtonClick(_itemCmp.buyBtn,function()
self:onClickBuyBtn(id)
end)
item:SetChildButtonClick(_itemCmp.helpBtn,function()
self:onClickHelpBtn(id)
end)
item:SetChildActive(_itemCmp.helpBtn,config.rule~=nil)
item:SetChildActive(_itemCmp.tipsBg,config.tips~=nil)
if config.tips then
item:SetChildText(_itemCmp.tipsTx,config.tips)
item:ForceLayoutRect(_itemCmp.tipsTx)
item:ForceLayoutRect(_itemCmp.tipsBg)
end

local buyItems=defaultT
for i,v in ipairs(config.buyItems)do
if v[1]<=zmLv and zmLv<=v[2]then
buyItems=v[3]
break
end
end
item:SetChildLayoutGroupCreateItems(_itemCmp.buyRewardList,#buyItems,function(index)
local _item=item:GetChildLayoutGroupGridItem(_itemCmp.buyRewardList,index-1)
local itemData=buyItems[index]
local itemId=itemData[1]
local itemNum=itemData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
_item:SetChildPropData(-1,itemProp)
_item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
item:SetChildScrollRectEnable(_itemCmp.buyRewardView,#buyItems>=7)

local dayItems=defaultT
for i,v in ipairs(config.dayItems)do
if v[1]<=level and level<=v[2]then
dayItems=v[3]
break
end
end
item:SetChildLayoutGroupCreateItems(_itemCmp.dailyRewardList,#dayItems,function(index)
local _item=item:GetChildLayoutGroupGridItem(_itemCmp.dailyRewardList,index-1)
local itemData=dayItems[index]
local itemId=itemData[1]
local itemNum=itemData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
_item:SetChildPropData(-1,itemProp)
_item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
item:SetChildScrollRectEnable(_itemCmp.dailyRewardView,#config.dayItems>=7)

local buyStr=FMT.fmt("{0}购买",pfwindowslController:showDesc_ByMoneyType(czCfg))
if buyed then
local getted=data.daily>=nowTime or timeHelper.checkInSameDay2(data.daily,nowTime)
local todayZero=timeHelper.getServerZeroShortStamp(nowTime)
local leastDay=(data.valid-todayZero)/86400
if getted then
buyStr="今日已领取"
else
buyStr="领取"
end
item:SetChildActive(_itemCmp.leastTimeBg,true)
item:SetChildText(_itemCmp.leastTime,FMT.fmt("剩余{0}",timeHelper.formatSimpleTime(math.max(data.valid-nowTime,3600))))

item:SetChildActive(_itemCmp.appendBtn,config.maxDay==nil or(leastDay+config.day)<=config.maxDay)
item:SetChildGraphicGray(_itemCmp.buyBtn,getted)
item:SetChildText(_itemCmp.buyTx,buyStr)
self.cdDatas[id]=data.valid
else
item:SetChildActive(_itemCmp.leastTimeBg,false)
item:SetChildText(_itemCmp.leastTime,"")
item:SetChildActive(_itemCmp.appendBtn,false)
item:SetChildGraphicGray(_itemCmp.buyBtn,false)
item:SetChildText(_itemCmp.buyTx,buyStr)
self.cdDatas[id]=nil
end
end

function UIWeekInvestorWin:refreshCardItem(id)
local index=table.findValue(self.listData,id)
if index==nil then return end
local item=self.cardList:getChildLayoutGroupGridItem(index-1)
self:initCardItem(item,id)
end

function UIWeekInvestorWin:refreshCardState(id)
local index=table.findValue(self.listData,id)
if index==nil then return end
self:refreshCardStateImp(index,id)
end

function UIWeekInvestorWin:refreshCardStateImp(index,id)
local item=self.cardList:getChildLayoutGroupGridItem(index-1)
local config=cfgHelper.get1(cfg_zhoukaconfig_get,id)
local czCfg=cfgHelper.get1(cfg_rechargeconfig_get,config.czId)
local data=rechargeModel:getWeekCardData(id)
local nowTime=timeHelper.getServerShortTime()
local buyed=data~=nil and nowTime<data.valid
local buyStr=FMT.fmt("{0}购买",pfwindowslController:showDesc_ByMoneyType(czCfg))
if buyed then
local getted=data.daily>=nowTime or timeHelper.checkInSameDay2(data.daily,nowTime)
local todayZero=timeHelper.getServerZeroShortStamp(nowTime)
local leastDay=(data.valid-todayZero)/86400
if getted then
buyStr="今日已领取"
else
buyStr="领取"
end
item:SetChildActive(_itemCmp.leastTimeBg,true)
item:SetChildText(_itemCmp.leastTime,FMT.fmt("剩余{0}",timeHelper.formatSimpleTime(math.max(data.valid-nowTime,3600))))

item:SetChildActive(_itemCmp.appendBtn,config.maxDay==nil or(leastDay+config.day)<=config.maxDay)
item:SetChildGraphicGray(_itemCmp.buyBtn,getted)
item:SetChildText(_itemCmp.buyTx,buyStr)
self.cdDatas[id]=data.valid
else
item:SetChildActive(_itemCmp.leastTimeBg,false)
item:SetChildText(_itemCmp.leastTime,"")
item:SetChildActive(_itemCmp.appendBtn,false)
item:SetChildGraphicGray(_itemCmp.buyBtn,false)
item:SetChildText(_itemCmp.buyTx,buyStr)
self.cdDatas[id]=nil
end
end

function UIWeekInvestorWin:refreshCardListState()
for index,id in ipairs(self.listData)do
self:refreshCardStateImp(index,id)
end
end

function UIWeekInvestorWin:refreshCardList()
table.clear(self.cdDatas)
self.cardList:setChildLayoutGroupCreateItems(#self.listData,function(index)
local item=self.cardList:getChildLayoutGroupGridItem(index-1)
local id=self.listData[index]
self:initCardItem(item,id)
end)
self.winlua:ForceLayoutRect(self.cardList:getID())
self.cardView:setChildScrollRectEnable(#self.listData>1)
self.listHeight=self.cardList:getChildSizeDeltaY()
self.viewHeight=self.cardView:getChildSizeDeltaY()
self:onScrollChange()
end

function UIWeekInvestorWin:refreshCardData()
self.listData={}
self.hideData={}
local configs=cfg_zhoukaconfig()
for id,cfg in pairs(configs)do
local show,fType,fParam=rechargeModel:checkWeekCardShow(id)
if show then
table.insert(self.listData,id)
else
table.insert(self.hideData,{id,fType,fParam})
end
end
if#self.listData>1 then
table.sort(self.listData,self.sortListFunc)
end
end

function UIWeekInvestorWin.sortListFunc(a,b)
local _a=rechargeModel:getWeekCardData(a)and 1 or 0
local _b=rechargeModel:getWeekCardData(b)and 1 or 0
if _a~=_b then
return _a<_b
else
return a<b
end
end

function UIWeekInvestorWin:checkHideData(tType,tParam,compare)
for i,v in ipairs(self.hideData)do
if v[2]==tType and v[3]~=nil then
if compare==1 and tParam>=v[3]then
return true
elseif compare==0 and tParam==v[3]then
return true
end
end
end
return false
end

function UIWeekInvestorWin:scrollToItem(id)
if id==nil then return end
local index=table.findValue(self.listData,id)
if index==nil then return end
local y=Mathf.Clamp((index-1)*(524+5),0,self.cardList:getChildSizeDeltaY()-586)
self.cardList:setChildAnchoredPos(0,y)
end

function UIWeekInvestorWin:startCDTick()
if self.cdTimer==nil then
self.cdTimer=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIWeekInvestorWin:stopCDTick()
if self.cdTimer then
self:stopTimerByID(self.cdTimer)
self.cdTimer=nil
end
end

function UIWeekInvestorWin:updateCDTick()
if next(self.cdDatas)then
local nowTime=timeHelper.getServerShortTime()
for id,time in pairs(self.cdDatas)do
local index=table.findValue(self.listData,id)
local data=rechargeModel:getWeekCardData(id)
local item=self.cardList:getChildLayoutGroupGridItem(index-1)
item:SetChildText(_itemCmp.leastTime,FMT.fmt("剩余{0}",timeHelper.formatSimpleTime(math.max(data.valid-nowTime,3600))))
end
end
end

function UIWeekInvestorWin.onNewDay()
local openDay=timeHelper.getServerOpenDay()
if _this:checkHideData(1,openDay,1)then
_this:refreshCardData()
_this:refreshCardList()
else
_this:refreshCardListState()
end
end

function UIWeekInvestorWin.on_system_open(sysId)
if _this:checkHideData(3,sysId,0)then
_this:refreshCardData()
_this:refreshCardList()
end
end

function UIWeekInvestorWin.on_building_event(etype,param1,param2,param3)
if etype==buildingEvent.zongmenLevelUp then
if _this:checkHideData(2,param1,1)then
_this:refreshCardData()
_this:refreshCardList()
end
end
end

function UIWeekInvestorWin.on_14_30()
_this:refreshCardData()
_this:refreshCardList()
end

function UIWeekInvestorWin.on_14_31(len,list)
if list then
for i,v in ipairs(list)do
_this:refreshCardState(v.zkid)
end
end
end

function UIWeekInvestorWin.on_14_32(card)
_this:refreshCardItem(card.zkid)
end