











rechargeModel={}




rechargeModel.data={}
local _rechargeFirst=nil

local giftType={
dayGift=1,
weekGift=2,
monthGift=3,
guanggao=4,
blueDiamondNewBieGift=9,
blueDiamondDailyGift=10,
blueDiamondGrowUpGift=11,
}

eRechargeGiftType=giftType


function rechargeModel:onAppStart()

end


function rechargeModel:onEnterState()
_rechargeFirst={}
self.data.xinagou={}
self:initXianGouLiBaoType()
self.data.cardList={}
self.data.weekCards={}
self.data.dailyTeHuiData={}
end


function rechargeModel:onLeaveState()



self.data={}
_rechargeFirst=nil
end


function rechargeModel:onServerDataInitFinish()

end



function rechargeModel:initReCharge(firstFlag,totalrecharge,dailyrecharge)
self.data.firstFlag=firstFlag
local allConfig=cfg_rechargeconfig()
for i,v in pairs(allConfig)do
if type(i)=="number"then
_rechargeFirst[v.id]=not mathHelper.getBitValue(firstFlag,i-1)
end
end
self.data.totalrecharge=totalrecharge
self.data.dailyrecharge=dailyrecharge
end

function rechargeModel:getFirstRechargeData()
return _rechargeFirst
end

function rechargeModel:getFirstRecharge(id)
return _rechargeFirst[id]or false
end

function rechargeModel:getTotalRecharge()
return self.data.totalrecharge or 0
end

function rechargeModel:getDailyRecharge()
return self.data.dailyrecharge or 0
end

function rechargeModel:setDailyRecharge(num)
if self.data and self.data.dailyrecharge then
self.data.dailyrecharge=num
end
end


function rechargeModel:initXianGouLiBao(len,array)
if len>0 then
for i,v in ipairs(array)do
self.data.xinagou[v.param_1]=v.param_2
end
end
end

function rechargeModel:getXianGouLiBaoBuyNum(id)
local _id=self.data.groupLookup[id]or id
return self.data.xinagou[_id]or 0
end

function rechargeModel:changeLiBaoBuyNum(id,num)
local _id=self.data.groupLookup[id]or id
local boughtNum=self:getXianGouLiBaoBuyNum(_id)
self.data.xinagou[_id]=boughtNum+num
end


function rechargeModel:initXianGouLiBaoType()
local config=cfg_limitedgiftconfig()
self.data.xiangouType={}
self.data.xiangouGroup={}
self.data.groupLookup={}
for i,v in pairs(config)do
local id=v.id
local group=v.group
local giftType=v.gifttype
local t1=self.data.xiangouType[giftType]
if t1==nil then
t1={}
self.data.xiangouType[giftType]=t1
end
if not group or id==group then
table.insert(t1,v)
end

if group~=nil then
self.data.groupLookup[id]=group

local t2=self.data.xiangouGroup[group]
if t2==nil then
t2={}
self.data.xiangouGroup[group]=t2
end
table.insert(t2,v)
end
end

for i,v in pairs(self.data.xiangouGroup)do
table.sort(self.data.xiangouGroup[i],function(a,b)return a.sortid<b.sortid end)
end
end

function rechargeModel:getXianGouLiBaoConfig(typo)
return self.data.xiangouType[typo]
end


function rechargeModel:getSortXianGouLiBaoList(typo)
local list=self:getXianGouLiBaoConfig(typo)
local newList={}
if list and next(list)then
for i,v in pairs(list)do
v.sortTag=v.sortid

local buyNum=self:getXianGouLiBaoBuyNum(v.id)
if buyNum>=v.maxcount then
v.sortTag=v.sortid+10000
end
if self:checkXianGouLiBaoOpen(v.conditions)then
table.insert(newList,v)
end
end
table.sort(newList,function(a,b)return a.sortTag<b.sortTag end)
end
return newList
end


function rechargeModel:getSortBlueDiamondLiBaoList(typo,isNotSort)
local list=self:getXianGouLiBaoConfig(typo)
local newList={}
if list and next(list)then
for i,v in pairs(list)do
v.sortTag=v.sortid
if not isNotSort then

local buyNum=self:getXianGouLiBaoBuyNum(v.id)
if buyNum>=v.maxcount then
v.sortTag=v.sortid+10000
end
end
if v.group then
local groupCfg
for ii,vv in ipairs(self.data.xiangouGroup[v.group])do
if self:checkXianGouLiBaoOpen(vv.conditions)then
groupCfg=vv
break
end
end
if not groupCfg then
groupCfg=self.data.xiangouGroup[v.group][1]
end
groupCfg.sortTag=v.sortid
table.insert(newList,groupCfg)
else
table.insert(newList,v)
end
end
table.sort(newList,function(a,b)return a.sortTag<b.sortTag end)
end
return newList
end


function rechargeModel:getXiangouGroupList(id)
local group=self.data.groupLookup[id]
if not group then
return nil
end
return self.data.xiangouGroup[group]
end


function rechargeModel:checkXianGouLiBaoOpen(conditions,isWarning)
if conditions==nil then
return true
end
for i,v in pairs(conditions)do
if v[1]==1 then
local zmLevel=zongmenModel:getLevel()
if zmLevel<v[2]then
if isWarning then
UIManager.error('宗门等级不足')
end
return false,"宗门等级不足"
end
elseif v[1]==2 then
local openDay=timeHelper.getServerOpenDay()
if openDay<v[2]then
if isWarning then
UIManager.error('开服天数不足')
end
return false,"开服天数不足"
end
elseif v[1]==3 then
if not systemModel.isOpen(v[2])then
if isWarning then
UIManager.error(systemModel.getOpenTips(v[2]))
end
return false,systemModel.getOpenTips(v[2])
end
elseif v[1]==4 then
local pfId=gameUtilityModel.getServerPlatform()
local result=false
for k=2,#v do
local cpfid=v[k]
if cpfid==pfId then
result=true
break
end
end

if(not result)and isWarning then
UIManager.error('不是指定平台')
return false
end
elseif v[1]==5 then
local iconInfo=playerModel:getActorIconInfo()
local info=playerModel.getBlueinfo(iconInfo.blueinfo)
if not info.isBule then
if isWarning then
UIManager.error('未开通蓝钻')
end
return false,"未开通蓝钻"
end
if info.level<v[2]then
if isWarning then
UIManager.error('蓝钻等级不足')
end
return false,"蓝钻等级不足"
end
elseif v[1]==6 then
local iconInfo=playerModel:getActorIconInfo()
local info=playerModel.getBlueinfo(iconInfo.blueinfo)
if not info.isSBule then
if isWarning then
UIManager.error('未开通豪华蓝钻')
end
return false,"未开通豪华蓝钻"
end
elseif v[1]==7 then
local iconInfo=playerModel:getActorIconInfo()
local info=playerModel.getBlueinfo(iconInfo.blueinfo)
if not info.isYear then
if isWarning then
UIManager.error('未开通年费蓝钻')
end
return false,"未开通年费蓝钻"
end
elseif v[1]==8 then
local iconInfo=playerModel:getActorIconInfo()
local info=playerModel.getBlueinfo(iconInfo.blueinfo)
if not info.isBule or info.level~=v[2]then
if isWarning then
UIManager.error(FMT.fmt('蓝钻等级不为{0}级',v[2]))
end
return false
end
elseif v[1]==9 then
local function getStartAfterTime(seasonSTime)

local seasonWeekMonday0=timeHelper.getWeekZeroTime(seasonSTime)

local seasonWeekMonday10=seasonWeekMonday0+10*3600

if seasonSTime<=seasonWeekMonday10 then

return seasonWeekMonday10
else

return seasonWeekMonday10+7*86400
end
end
local moJieSaiJiID=xianjieController:getMoJieSaiJiID()
local isNotSaiJi=true
if zongmenModel:getLevel()>=45 and systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieEnough)then
for k,id in pairs(v[2])do
if moJieSaiJiID==id then
if xianjieController:CheckMoJieSaiJieActityeTime()then
local enterData=xianjieModel:getMoJieEnterData()

local nowTime=timeHelper.getServerShortTime()

local startAfterTime=getStartAfterTime(enterData.sTime)
local isInSeason=(nowTime>=enterData.sTime)and(nowTime<enterData.eTime)
local isAfterStart=(nowTime>=startAfterTime)
if isInSeason and isAfterStart then
isNotSaiJi=false
else
return false,"礼包未开放"
end
end
end
end
end
if isNotSaiJi then
return false,"礼包未开放"
end
end
end
return true
end


function rechargeModel:getXianGouLiBaoRewards(rewards)
local zmLv=zongmenModel:getLevel()
for i,v in pairs(rewards)do
if zmLv>=v[1]and zmLv<=v[2]then
return v[3]
end
end
end


function rechargeModel:checkXianGouLiBaoReddot()










return reddotClassManager.get_reddot(REDDIT_TYPE.eXianGouLiBao)
end


function rechargeModel:checkDayPackReddot()
return rechargeModel:checkXianGouLiBaoIsCanBuy(giftType.dayGift)
end


function rechargeModel:checkWeekPackReddot()
return rechargeModel:checkXianGouLiBaoIsCanBuy(giftType.weekGift)
end


function rechargeModel:checkMonthPackReddot()
return rechargeModel:checkXianGouLiBaoIsCanBuy(giftType.monthGift)
end


function rechargeModel:checkGuangGaoPackReddot()
if not adController:supportPlayAD()then return false end
return rechargeModel:checkXianGouLiBaoIsCanBuy(giftType.guanggao)
or rechargeModel:checkXianGouLiBaoIsDay(giftType.guanggao)
or rechargeModel:checkXianGouLiBaoIsGuanYinQuan(giftType.guanggao)
end

function rechargeModel:checkXianGouLiBaoIsGuanYinQuan(typo)
local curGiftConfig=rechargeModel:getSortXianGouLiBaoList(typo)
local itemid=cfg_advertconfig().const_def.itemid
local num=itemsModel.getCount(itemid)
local isopen=false
for i=1,#curGiftConfig do
local config=curGiftConfig[i]
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(config.id)
local isSellOut=buyNum>=config.maxcount
if not isSellOut and num>0 then
isopen=true
break
end
end
return isopen
end

function rechargeModel:checkXianGouLiBaoIsDay(typo)
local isday=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eGuanYingGe)
local curGiftConfig=rechargeModel:getSortXianGouLiBaoList(typo)
local isopen=false
for i=1,#curGiftConfig do
local config=curGiftConfig[i]
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(config.id)
local isSellOut=buyNum>=config.maxcount
if not isSellOut then
isopen=true
break
end
end
return not isday and isopen
end

function rechargeModel:checkXianGouLiBaoIsCanBuy(typo)
local config=cfg_limitedgiftconfig()
for i,v in pairs(config)do
if v.gifttype==typo then
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(v.id)
local sellOut=buyNum>=v.maxcount
local price=v.price
if not sellOut then
if price and price[2]==0 then
return true
end
end
end
end
return false
end


function rechargeModel:checkBlueDiamondDailyGiftReddot()
if not blueDiamondModel:checkOpen()then
return false
end
return rechargeModel:checkBlueDiamondIsCanGet(giftType.blueDiamondDailyGift)
end


function rechargeModel:checkBlueDiamondGrowUpGiftReddot()
if not blueDiamondModel:checkOpen()then
return false
end
return rechargeModel:checkBlueDiamondIsCanGet(giftType.blueDiamondGrowUpGift)
end


function rechargeModel:checkBlueDiamondNewBieGiftReddot()
if not blueDiamondModel:checkOpen()then
return false
end
return rechargeModel:checkBlueDiamondIsCanGet(giftType.blueDiamondNewBieGift)
end

function rechargeModel:checkBlueDiamondIsCanGet(typo)
local config=cfg_limitedgiftconfig()
for i,v in pairs(config)do
if v.gifttype==typo then
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(v.id)
local isOpen=self:checkXianGouLiBaoOpen(v.conditions)
local sellOut=buyNum>=v.maxcount
local price=v.price
if isOpen and not sellOut then
if price and price[2]==0 then
return true
end
end
end
end
return false
end

function rechargeModel:initZhenBaoGeData(flag)
self.data.ZhenBaoGeFlag=flag
self.data.ZhenBaoGeData={}
local allConfig=cfg_zhenbaogeconfig()
for i,v in pairs(allConfig)do
self.data.ZhenBaoGeData[v.id]=mathHelper.getBitValue(flag,i-1)
end
end

function rechargeModel:getZhenBaoGeData(id)
if self.data.ZhenBaoGeData==nil then return false end
return self.data.ZhenBaoGeData[id]or false
end

function rechargeModel:getZhenBaoGetarget(target)
local GameVersion=pfwindowslController:getGameVersion()
local target=target[GameVersion]or target[1]
local pfid=loginModel:getPfid()
target=target[pfid]or target[-1]
return target
end


function rechargeModel:getZhenBaoGeSortList()
if not self.data.ZhenBaoGeConfig then
self.data.ZhenBaoGeConfig={}
local allConfig=cfg_zhenbaogeconfig()
for i,v in pairs(allConfig)do
v.sortTag=v.sortid
table.insert(self.data.ZhenBaoGeConfig,v)
end
table.sort(self.data.ZhenBaoGeConfig,function(a,b)return a.sortTag<b.sortTag end)
end
return self.data.ZhenBaoGeConfig
end

function rechargeModel:getZhenBaoGeNextId()
local allConfig=self:getZhenBaoGeSortList()
local len=#allConfig
for i,v in ipairs(allConfig)do
local isGet=rechargeModel:getZhenBaoGeData(v.id)
if not isGet then
return v
else

if i==len then
return v
end
end
end
end

function rechargeModel:canZhenBaoGeShow(id)
local showTarget=cfgHelper.get(cfg_zhenbaogeconfig_get,id,"showTarget")
showTarget=rechargeModel:getZhenBaoGetarget(showTarget)
if(not showTarget)or(showTarget and showTarget==0)then
return true
end
local totalRecharge=rechargeModel:getTotalRecharge()/10
return totalRecharge>=showTarget
end

function rechargeModel:checkZhenBaoGeReddot()
local allConfig=self:getZhenBaoGeSortList()
local totalRecharge=rechargeModel:getTotalRecharge()/10
for i,config in ipairs(allConfig)do
local got=rechargeModel:getZhenBaoGeData(config.id)
local target=rechargeModel:getZhenBaoGetarget(config.target)
if(not got)and totalRecharge>=target then
return true
end
end
return false
end

function rechargeModel:getZhenBaoGeGetNum()
local allConfig=self:getZhenBaoGeSortList()
local totalRecharge=rechargeModel:getTotalRecharge()/10
local num=0
for i,config in ipairs(allConfig)do
local got=rechargeModel:getZhenBaoGeData(config.id)
local target=rechargeModel:getZhenBaoGetarget(config.target)
if(not got)and totalRecharge>=target then
num=num+1
end
end
return num
end



function rechargeModel:setCardList(len,cardList)

if len>0 then
for i,v in ipairs(cardList)do
self.data.cardList[v.id]=v
end
else

self.data.cardList={}
end
end


function rechargeModel:setCardItem(cardItem)
if not self.data.cardList or next(self.data.cardList)==nil then

self.data.cardList={}

end

self.data.cardList[cardItem.id]=cardItem
pfCommonHelper.reportCardItemID(cardItem.id)
end


function rechargeModel:setCardGetReward(cardId,flag)
if not self.data.cardList or next(self.data.cardList)==nil then
return
else
if self.data.cardList[cardId]then
self.data.cardList[cardId].dayReward=flag
end
end
end


function rechargeModel:getCardList()
if not self.data.cardList or next(self.data.cardList)==nil then
return nil
end
return self.data.cardList
end


function rechargeModel:getCardItem(cardId)
if not self.data.cardList or next(self.data.cardList)==nil then
return nil
end
if self.data.cardList[cardId]then
return self.data.cardList[cardId]
end
return nil
end


function rechargeModel:checkCardActive(cardId,getTime)
if getTime==nil then getTime=true end
local cardItem=rechargeModel:getCardItem(cardId)
if cardItem then



if getTime then

local remainingTimeStr=timeHelper.getRemainingTime(cardItem.expireTime)
if remainingTimeStr then
return true,remainingTimeStr
end
else
return cardItem.expireTime>timeHelper.getServerShortTime()
end
end

return false,nil
end


function rechargeModel:getCardRemainDay(cardId)
local cardItem=rechargeModel:getCardItem(cardId)
if cardItem then




local remainingDay=timeHelper.getLeftDataNumberTwo(timeHelper.convertLongStamp(cardItem.expireTime))
if remainingDay and remainingDay>0 then

return remainingDay
end
end

return 0
end


function rechargeModel:getCardExpireTime(cardId)
local cardItem=rechargeModel:getCardItem(cardId)
if cardItem then


return timeHelper.convertLongStamp(cardItem.expireTime)
end

return nil
end


function rechargeModel:checkCardGetReward(cardId)
local cardItem=rechargeModel:getCardItem(cardId)
if cardItem then
if cardItem.dayReward==1 then
return true
end
end
return false
end


function rechargeModel:checkAllCardReddot()
if not self.data.cardList or next(self.data.cardList)==nil then
return false
end

local reddot=false

for k,v in pairs(self.data.cardList)do
local isActive=rechargeModel:checkCardActive(v.id)
if isActive and v.dayReward==0 then
reddot=true
return reddot
end
end

return reddot
end


function rechargeModel:checkHasCardActive()
local hasActiveCard=false
local allConfig=cfg_yuekaconfig()
for i,v in ipairs(allConfig)do
if rechargeModel:checkCardActive(v.id)then
hasActiveCard=true
return hasActiveCard
end
end

return hasActiveCard
end


function rechargeModel:checkMonthCardEnterReddot()
return rechargeModel:checkMonthCardSmallGiftReddot()or
rechargeModel:checkAllCardReddot()
or rechargeModel:checkMonthCardCatAccountReddot()
end


function rechargeModel:checkMonthCardSmallGiftReddot()
return not rechargeModel:getMonthCardSmallGiftGotFlag()
end


function rechargeModel:setMonthCardSmallGiftGotFlag(flag)
self.data.cardSmallGiftGotFlag=flag
end


function rechargeModel:getMonthCardSmallGiftGotFlag()
if self.data then
return self.data.cardSmallGiftGotFlag or false
end

return false
end


function rechargeModel:setMonthCardAccumulateMingSheng(msValue)
self.data.accumulateMs=msValue
end


function rechargeModel:getMonthCardAccumulateMingSheng()
if self.data then
return self.data.accumulateMs or 0
end

return 0
end


function rechargeModel:checkMonthCardCatAccountReddot()
if channelHelper.isXianLing()then return false end
local reddot=false
local accumulateMs=rechargeModel:getMonthCardAccumulateMingSheng()

if accumulateMs>0 and rechargeModel:checkCardActive(2)then
reddot=true
end

return reddot
end


function rechargeModel:checkMonthCardCatAccountBtnActive()
local isActive=false
if not systemModel.isOpen(SYSTEM_DEFINE.eYueKa)then

return false
end

local isActiveHeightCard=rechargeModel:checkCardActive(2)
local accumulateMs=rechargeModel:getMonthCardAccumulateMingSheng()

if not isActiveHeightCard or accumulateMs>0 then

isActive=true
end

return isActive
end


function rechargeModel:checkMonthCardCanRenewal(cardId)
if not systemModel.isOpen(SYSTEM_DEFINE.eYueKa)then

return false
end

local isActive=rechargeModel:checkCardActive(cardId)
if not isActive then

return true
end

local cardCfg=cfgHelper.get(cfg_yuekaconfig_get,cardId)
local canRenewal=true
if cardCfg then

if cardCfg.maxVaildTime then

local remainingDay=rechargeModel:getCardRemainDay(cardCfg.id)


local tmpDay=remainingDay+cardCfg.vaildTime
if tmpDay>cardCfg.maxVaildTime then

canRenewal=false
end
end
return canRenewal
end
end


function rechargeModel:checkIsHasMonthCardCanRenewal()
local yearCardAllCfg=cfg_yuekaconfig()
for index,yearCardCfg in ipairs(yearCardAllCfg)do
if self:checkMonthCardCanRenewal(yearCardCfg.id)then
return true
end
end
return false
end


function rechargeModel:checkIsHasWillExpireMonthCard()
local cardList=self:getCardList()
local curTime=timeHelper.getServerLongTime()

local showExpireTipsDayCount=cfgHelper.get2(cfg_yuekabaseconfig_get,1,"showExpireDayCount")
local expireTime=showExpireTipsDayCount*86400

if cardList~=nil then
for index,cardData in ipairs(cardList)do
local willExpireTime=timeHelper.convertLongStamp(cardData.expireTime)or 0
local interval=willExpireTime-curTime
if interval>0 and expireTime>=interval then
return true
end
end
end

return false
end



function rechargeModel:setDailyTeHuiData(buy_sec,gotFlag)
self.data.dailyTeHuiData={}
self:setDailyTeHuiBuyTime(buy_sec)
self:setDailyTeHuiGotFlagByBitValue(gotFlag)
end


function rechargeModel:setDailyTeHuiBuyTime(buy_sec)
if not self.data.dailyTeHuiData then
self.data.dailyTeHuiData={}
end


local buyDayZeroTime=timeHelper.getServerZeroStamp(timeHelper.convertLongStamp(buy_sec))
self.data.dailyTeHuiData.buyTime=buyDayZeroTime
if buy_sec then

local durationDayCount=cfgHelper.get2(cfg_daydiscountsbasicconfig_get,1,"day")
local onyDaySec=86400
self.data.dailyTeHuiData.endTime=buyDayZeroTime+durationDayCount*onyDaySec
else
self.data.dailyTeHuiData.endTime=nil
end
end


function rechargeModel:getDailyTeHuiBuyTime()
if self.data.dailyTeHuiData then
return self.data.dailyTeHuiData.buyTime
end

return nil
end


function rechargeModel:getDailyTeHuiEndTime()
if self.data.dailyTeHuiData then
return self.data.dailyTeHuiData.endTime
end

return nil
end


function rechargeModel:setDailyTeHuiGotFlagByBitValue(gotFlag)
if not self.data.dailyTeHuiData then
self.data.dailyTeHuiData={}
end

self.data.dailyTeHuiData.gotFlag=gotFlag
end


function rechargeModel:setDailyTeHuiGotFlagByIndex(index,flag)
if not self.data.dailyTeHuiData then
self.data.dailyTeHuiData={}
end
if not self.data.dailyTeHuiData.gotFlag then
self.data.dailyTeHuiData.gotFlag=0
end

if flag then

self.data.dailyTeHuiData.gotFlag=mathHelper.setbit(self.data.dailyTeHuiData.gotFlag,index-1)
else

self.data.dailyTeHuiData.gotFlag=mathHelper.clrbit(self.data.dailyTeHuiData.gotFlag,index-1)
end
end


function rechargeModel:checkDailyTeHuiGotByIndex(index)
if self.data.dailyTeHuiData and self.data.dailyTeHuiData.gotFlag then
return mathHelper.getBitValue(self.data.dailyTeHuiData.gotFlag,index-1)
end

return false
end


function rechargeModel:checkDailyTeHuiEnterReddot()
local reddot=false
if not systemModel.isOpen(SYSTEM_DEFINE.eDayDiscounts)then

return false
end

local isValid=rechargeController:checkDailyTeHuiTenDayIsValid()
if isValid then

local libaoCfg=cfg_daydiscountsconfig()
for i,v in ipairs(libaoCfg)do
if not rechargeModel:checkDailyTeHuiGotByIndex(v.id)then
reddot=true
break
end
end
else

reddot=not rechargeModel:checkDailyTeHuiGotByIndex(1)
end

return reddot
end


function rechargeModel:resetDataDailyTeHuiOnNewDay()
rechargeModel:setDailyTeHuiGotFlagByBitValue(0)
end



function rechargeModel:setDailyTeHuiSingleDayData(gotFlag,buyCount,exRewardGotFlag,firstBuyZmLv,dailyBuyZmLv)
self.data.dailyTeHuiSingleDayData={}
self:setDailyTeHuiSingleDayGotFlagByBitValue(gotFlag)
self.data.dailyTeHuiSingleDayData.buyCount=buyCount
self.data.dailyTeHuiSingleDayData.exRewardGotFlag=exRewardGotFlag
self.data.dailyTeHuiSingleDayData.firstBuyZmLv=firstBuyZmLv
self.data.dailyTeHuiSingleDayData.dailyBuyZmLv=dailyBuyZmLv
end


function rechargeModel:setDailyTeHuiSingleDayGotFlagByBitValue(gotFlag)
if not self.data.dailyTeHuiSingleDayData then
self.data.dailyTeHuiSingleDayData={}
end

self.data.dailyTeHuiSingleDayData.gotFlag=gotFlag
end


function rechargeModel:setDailyTeHuiSingleDayExRewardGotFlag(isGot)
if not self.data.dailyTeHuiSingleDayData then
self.data.dailyTeHuiSingleDayData={}
end

if isGot then
self.data.dailyTeHuiSingleDayData.exRewardGotFlag=1
else
self.data.dailyTeHuiSingleDayData.exRewardGotFlag=0
end
end


function rechargeModel:checkDailyTeHuiSingleDayGotByIndex(index)
if self.data.dailyTeHuiSingleDayData and self.data.dailyTeHuiSingleDayData.gotFlag then
return mathHelper.getBitValue(self.data.dailyTeHuiSingleDayData.gotFlag,index-1)
end

return false
end


function rechargeModel:checkDailyTeHuiSingleDayGotExReward()
if self.data.dailyTeHuiSingleDayData and self.data.dailyTeHuiSingleDayData.exRewardGotFlag then
return mathHelper.getBitValue(self.data.dailyTeHuiSingleDayData.exRewardGotFlag,0)
end

return false
end


function rechargeModel:getDailyTeHuiSingleDayBuyCount()
if self.data.dailyTeHuiSingleDayData and self.data.dailyTeHuiSingleDayData.buyCount then
return self.data.dailyTeHuiSingleDayData.buyCount
end

return 0
end


function rechargeModel:getDailyTeHuiSingleDayShowExRewardZmLv()
local buyCount=rechargeModel:getDailyTeHuiSingleDayBuyCount()
if buyCount>0 and self.data.dailyTeHuiSingleDayData and self.data.dailyTeHuiSingleDayData.firstBuyZmLv then

return self.data.dailyTeHuiSingleDayData.firstBuyZmLv
else

return zongmenModel:getLevel()
end
end


function rechargeModel:getDailyTeHuiSingleDayShowDailyBuyZmLv()
if self.data.dailyTeHuiSingleDayData and self.data.dailyTeHuiSingleDayData.dailyBuyZmLv then

return self.data.dailyTeHuiSingleDayData.dailyBuyZmLv
else

return zongmenModel:getLevel()
end
end


function rechargeModel:checkDailyTeHuiSingleDayEnterReddot()
local reddot=false
if not systemModel.isOpen(SYSTEM_DEFINE.eNewDayDiscounts)then

return false
end


local baseCfg=cfgHelper.get1(cfg_daydiscountsnewbasicconfig_get,1)
local acc_reward=baseCfg.acc_reward[pfwindowslController:getGameVersion()]or baseCfg.acc_reward[1]
local targetDayCount=acc_reward[1]
local buyCount=rechargeModel:getDailyTeHuiSingleDayBuyCount()
if buyCount>=targetDayCount then

if not rechargeModel:checkDailyTeHuiSingleDayGotExReward()then

return true
end
end


reddot=not rechargeModel:checkDailyTeHuiSingleDayGotByIndex(1)

return reddot
end


function rechargeModel:resetDataDailyTeHuiSingleDayOnNewDay()
rechargeModel:setDailyTeHuiSingleDayGotFlagByBitValue(0)
self.data.dailyTeHuiSingleDayData.dailyBuyZmLv=zongmenModel:getLevel()
local baseCfg=cfgHelper.get1(cfg_daydiscountsnewbasicconfig_get,1)
local acc_reward=baseCfg.acc_reward[pfwindowslController:getGameVersion()]or baseCfg.acc_reward[1]
local targetDayCount=acc_reward[1]
local buyCount=rechargeModel:getDailyTeHuiSingleDayBuyCount()
if buyCount>=targetDayCount then

self.data.dailyTeHuiSingleDayData.buyCount=0
self.data.dailyTeHuiSingleDayData.firstBuyZmLv=0
end

rechargeModel:setDailyTeHuiSingleDayExRewardGotFlag(false)
end


function rechargeModel:getDailyTeHuiSingleDayRebateByLibaoId(libaoId,zmLv)
local cfg=cfgHelper.get(cfg_daydiscountsnewconfig_get,libaoId)
if cfg and cfg.rebate then
local level=zmLv or rechargeModel:getDailyTeHuiSingleDayShowDailyBuyZmLv()
local rebateParamList=cfg.rebate
local rebate
for _,v in ipairs(rebateParamList)do
local minLv=v[1]
local maxLv=v[2]
if level>=minLv and level<=maxLv then
rebate=v[3]
break
end
end

return rebate
end
end


function rechargeModel:checkDailyTeHuiSingleDayShowTipsWin()

local isBoughtAnyLibao=rechargeController:checkDailyTeHuiSingleDayBoughtAnyLibao()
if isBoughtAnyLibao then

return false
end


local lastZmLevel=rechargeModel:getDailyTeHuiSingleDayLastDailyBuyZmLv()

if not lastZmLevel then

return false
else

local lastRebate=rechargeModel:getDailyTeHuiSingleDayRebateByZmLevel(lastZmLevel)
local nowRebate=rechargeModel:getDailyTeHuiSingleDayRebateByZmLevel()
if nowRebate>lastRebate then
return true
end
end

return false
end

function rechargeModel:getDailyTeHuiSingleDayRebateByZmLevel(zmLv)
local libaoAllCfg=cfg_daydiscountsnewconfig()
local allPrice=0
local allWeight=0
for i,v in ipairs(libaoAllCfg)do
if v.recharge_id and v.rebate then
local rechargeId=v.recharge_id[pfwindowslController:getGameVersion()]or v.recharge_id[1]
local cfg=cfgHelper.get(cfg_rechargeconfig_get,rechargeId)
local rebate=rechargeModel:getDailyTeHuiSingleDayRebateByLibaoId(v.id,zmLv)
allPrice=allPrice+cfg.rmb
allWeight=allWeight+rebate*cfg.rmb
end
end

local averageRebate=math.ceil(allWeight/allPrice)
return averageRebate
end


function rechargeModel:getDailyTeHuiSingleDayLastDailyBuyZmLv()
if self.data.lastDailyBuyZmLv==nil then
self.data.lastDailyBuyZmLv=userActorSetting.get('dailyTeHuiSingleDayLastDailyBuyZmLv',nil)
end

return self.data.lastDailyBuyZmLv
end

function rechargeModel:saveDailyTeHuiSingleDayLastDailyBuyZmLv()
if self.data.lastDailyBuyZmLv~=nil then
userActorSetting.flushVal('dailyTeHuiSingleDayLastDailyBuyZmLv',self.data.lastDailyBuyZmLv)
end
end

function rechargeModel:setDailyTeHuiSingleDayLastDailyBuyZmLv()
self.data.lastDailyBuyZmLv=rechargeModel:getDailyTeHuiSingleDayShowDailyBuyZmLv()

rechargeModel:saveDailyTeHuiSingleDayLastDailyBuyZmLv()
end


function rechargeModel:test_setMRTHDTLocalDataLastDailyBuyZmLv(level)
userActorSetting.flushVal('dailyTeHuiSingleDayLastDailyBuyZmLv',level)
self.data.lastDailyBuyZmLv=level
end


function rechargeModel:initSelectLiBaoData(len,libaoDataList,resetDataLen,resetDataList)
if not self.data.selectLiBaoData then
self.data.selectLiBaoData={}
end

local libaoData={}
if len>0 then
for i,v in ipairs(libaoDataList)do
local libaoId=v.param_1
local buyNum=v.param_2
libaoData[libaoId]=buyNum
end
end
self.data.selectLiBaoData.libaoData=libaoData

local resetData={}
if resetDataLen>0 then
resetData.zmLevel_day=resetDataList[1]
resetData.zmLevel_week=resetDataList[2]
resetData.zmLevel_month=resetDataList[3]
end
self.data.selectLiBaoData.resetData=resetData
end


function rechargeModel:setSelectLiBaoDataByLibaoId(libaoId,buyNum)
if not self.data.selectLiBaoData then
self.data.selectLiBaoData={}
end
if not self.data.selectLiBaoData.libaoData then
self.data.selectLiBaoData.libaoData={}
end

self.data.selectLiBaoData.libaoData[libaoId]=buyNum
end


function rechargeModel:checkSelectLiBaoFreeRewardGot()
local giftid=cfgHelper.getdef1(cfg_customizedgiftconfig,'freegiftid')
return not FreeGiftController.GetFreeGift(giftid)
end


function rechargeModel:getSelectLiBaoBuyNumByLiBaoId(libaoId)
if self.data.selectLiBaoData and self.data.selectLiBaoData.libaoData then
if self.data.selectLiBaoData.libaoData[libaoId]then
return self.data.selectLiBaoData.libaoData[libaoId]
end
end

return 0
end






function rechargeModel:getSelectLiBaoRewardByLiBaoId(libaoId)
local cfg=cfgHelper.get(cfg_customizedgiftconfig_get,libaoId)
if not cfg then
return nil
end

local rewardParam=cfg.rewards
local defaultReward={}
local canSelectReward={}
local resetType=cfg.reset_type
local zmLevel=rechargeModel:getSelectLiBaoResetZmLevelByResetType(resetType)

for gridIdx,paramList in ipairs(rewardParam)do
local rewardList
for _,param in ipairs(paramList)do
local minLv=param[1]
local maxLv=param[2]
if zmLevel>=minLv and zmLevel<=maxLv then
rewardList=param[3]
break
end
end

if rewardList then
local tmpList={}
for idx,rewardParam in ipairs(rewardList)do
local itemId=rewardParam[1]
local itemCount=rewardParam[2]
local isUnlock=true
local unlockCdn=rewardParam[3]
if unlockCdn then
for _,v in ipairs(unlockCdn)do
local cdnType=v[1]
if cdnType==1 then

local minLevel=v[2]
local maxLevel=v[3]
if zmLevel<minLevel or(maxLevel and zmLevel>maxLevel)then
isUnlock=false
break
end
elseif cdnType==2 then
local sysId=v[2]

if not systemModel.isOpen(sysId)then
isUnlock=false
break
end
end
end
end

if isUnlock then
tmpList[#tmpList+1]={
idx=idx,
itemId=itemId,
itemCount=itemCount,
gridIdx=gridIdx,
}
end
end
canSelectReward[gridIdx]=tmpList
if#tmpList==1 then
local itemData=tmpList[1]
defaultReward[#defaultReward+1]=itemData
end
end
end

local selectReward={}
if not self.data.selectLiBaoData or not self.data.selectLiBaoData.selectRewardData or not next(self.data.selectLiBaoData.selectRewardData)then
rechargeModel:loadSelectLiBaoSelectRewardData()
end
if self.data.selectLiBaoData.selectRewardData[libaoId]then

local dataList=self.data.selectLiBaoData.selectRewardData[libaoId]
local tmpDataList={}
local defaultCount=#defaultReward
for idx,data in pairs(dataList)do
local isCanUseData=true
local gridIdx=data.gridIdx or defaultCount+idx
local selectGridIdx=gridIdx-defaultCount
if not canSelectReward[gridIdx]then
isCanUseData=false
else
local canSelectList=canSelectReward[gridIdx]
local selectIdx=data.idx
isCanUseData=false
for _,v in ipairs(canSelectList)do
if v.idx==selectIdx and v.itemId==data.itemId and v.itemCount==data.itemCount then
isCanUseData=true
tmpDataList[selectGridIdx]=data
break
end
end
end

if not isCanUseData then

self.data.selectLiBaoData.selectRewardData[libaoId][idx]=nil
end
end
self.data.selectLiBaoData.selectRewardData[libaoId]=tmpDataList
selectReward=self.data.selectLiBaoData.selectRewardData[libaoId]or{}
end
return defaultReward,selectReward,canSelectReward
end


function rechargeModel:getSelectLiBaoResetZmLevelByResetType(resetType)
if self.data.selectLiBaoData and self.data.selectLiBaoData.resetData then
if resetType==1 then

if self.data.selectLiBaoData.resetData.zmLevel_day then
return self.data.selectLiBaoData.resetData.zmLevel_day
end
elseif resetType==2 then

if self.data.selectLiBaoData.resetData.zmLevel_week then
return self.data.selectLiBaoData.resetData.zmLevel_week
end
elseif resetType==3 then

if self.data.selectLiBaoData.resetData.zmLevel_month then
return self.data.selectLiBaoData.resetData.zmLevel_month
end
end
end

return zongmenModel:getLevel()
end


function rechargeModel:resetSelectLiBaoResetZmLevelByResetType(resetType)
local zmLevel=zongmenModel:getLevel()
if self.data.selectLiBaoData and self.data.selectLiBaoData.resetData then
if resetType==1 then

if self.data.selectLiBaoData.resetData.zmLevel_day then
self.data.selectLiBaoData.resetData.zmLevel_day=zmLevel
end
elseif resetType==2 then

if self.data.selectLiBaoData.resetData.zmLevel_week then
self.data.selectLiBaoData.resetData.zmLevel_week=zmLevel
end
elseif resetType==3 then

if self.data.selectLiBaoData.resetData.zmLevel_month then
self.data.selectLiBaoData.resetData.zmLevel_month=zmLevel
end
end
end
end


function rechargeModel:resetSelectLiBaoBuyNumDataByResetType(resetType)

if not self.data or not self.data.selectLiBaoData or not self.data.selectLiBaoData.libaoData then
return
end

for libaoId,buyNum in pairs(self.data.selectLiBaoData.libaoData)do

local cfg=cfgHelper.get(cfg_customizedgiftconfig_get,libaoId)
if cfg then
local libaoResetType=cfg.reset_type
if resetType==libaoResetType then

self.data.selectLiBaoData.libaoData[libaoId]=nil
end
end

end
end


function rechargeModel:setSelectLiBaoSelectReward(libaoId,index,data)
if not self.data.selectLiBaoData then
self.data.selectLiBaoData={}
end

if not self.data.selectLiBaoData.selectRewardData then
self.data.selectLiBaoData.selectRewardData={}
end

if not self.data.selectLiBaoData.selectRewardData[libaoId]then
self.data.selectLiBaoData.selectRewardData[libaoId]={}
end

self.data.selectLiBaoData.selectRewardData[libaoId][index]=data
end


function rechargeModel:loadSelectLiBaoSelectRewardData()
if not self.data.selectLiBaoData then
self.data.selectLiBaoData={}
end

if not self.data.selectLiBaoData.selectRewardData then
self.data.selectLiBaoData.selectRewardData={}
end

local saveData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eSelectLiBao,'selectRewardData',{})
local rewardData=self.data.selectLiBaoData.selectRewardData
for libaoIdStr,dataList in pairs(saveData)do
local libaoId=tonumber(libaoIdStr)
if not rewardData[libaoId]then
rewardData[libaoId]={}
end
for idxStr,data in pairs(dataList)do
local idx=tonumber(idxStr)
rewardData[libaoId][idx]=data
end
end
self.data.selectLiBaoData.selectRewardData=rewardData
end


function rechargeModel:test_clearSelectLiBaoSelectRewardData()
self.data.selectLiBaoData.selectRewardData=nil
userActorArraySetting.set(ACTOR_SETTING_TYPE.eSelectLiBao,'selectRewardData',nil)

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSelectLiBao)
end


function rechargeModel:getSelectLiBaoCanSelectRewardsData(libaoId,index)
if not self.data.selectLiBaoData or not self.data.selectLiBaoData.canSelectRewardsData or not next(self.data.selectLiBaoData.canSelectRewardsData)then
rechargeModel:loadSelectLiBaoCanSelectRewardsData()
end

if not self.data.selectLiBaoData.canSelectRewardsData[libaoId]then
return
end

return self.data.selectLiBaoData.canSelectRewardsData[libaoId][index]
end


function rechargeModel:setSelectLiBaoCanSelectRewardsData(libaoId,index,rewardsList)
if not self.data.selectLiBaoData then
self.data.selectLiBaoData={}
end

if not self.data.selectLiBaoData.canSelectRewardsData then
self.data.selectLiBaoData.canSelectRewardsData={}
end

if not self.data.selectLiBaoData.canSelectRewardsData[libaoId]then
self.data.selectLiBaoData.canSelectRewardsData[libaoId]={}
end

local rewardsList_lookup={}
for i,v in ipairs(rewardsList)do
local itemid=v.itemId
rewardsList_lookup[itemid]=v
end

self.data.selectLiBaoData.canSelectRewardsData[libaoId][index]=rewardsList_lookup
rechargeModel:saveSelectLiBaoLocalData()
end


function rechargeModel:loadSelectLiBaoCanSelectRewardsData()
if not self.data.selectLiBaoData then
self.data.selectLiBaoData={}
end

if not self.data.selectLiBaoData.canSelectRewardsData then
self.data.selectLiBaoData.canSelectRewardsData={}
end
local saveData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eSelectLiBao,'canSelectRewardsData',{})
local rewardsData=self.data.selectLiBaoData.canSelectRewardsData
for libaoIdStr,dataList in pairs(saveData)do
local libaoId=tonumber(libaoIdStr)
if not rewardsData[libaoId]then
rewardsData[libaoId]={}
end
for idxStr,rewardsList in pairs(dataList)do
local idx=tonumber(idxStr)
local tmpList={}
for itemIdStr,v in pairs(rewardsList)do
local itemId=tonumber(itemIdStr)
tmpList[itemId]=v
end
rewardsData[libaoId][idx]=tmpList
end
end
self.data.selectLiBaoData.canSelectRewardsData=rewardsData
end

function rechargeModel:saveSelectLiBaoLocalData()
if self.data and self.data.selectLiBaoData then

local needSave=false
if self.data.selectLiBaoData.selectRewardData then
local selectRewardData=self.data.selectLiBaoData.selectRewardData
local saveData={}
for libaoId,dataList in pairs(selectRewardData)do
local libaoIdStr=tostring(libaoId)
if not saveData[libaoIdStr]then
saveData[libaoIdStr]={}
end
for idx,data in pairs(dataList)do
local idxStr=tostring(idx)
saveData[libaoIdStr][idxStr]=data
end
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eSelectLiBao,'selectRewardData',saveData)
needSave=true
end

if self.data.selectLiBaoData.canSelectRewardsData then

local canSelectRewardsData=self.data.selectLiBaoData.canSelectRewardsData
local saveData={}
for libaoId,dataList in pairs(canSelectRewardsData)do
local libaoIdStr=tostring(libaoId)
if not saveData[libaoIdStr]then
saveData[libaoIdStr]={}
end
for idx,rewardsList in pairs(dataList)do
local idxStr=tostring(idx)
local tmpList={}
for itemId,v in pairs(rewardsList)do
local itemIdStr=tostring(itemId)
tmpList[itemIdStr]=v
end
saveData[libaoIdStr][idxStr]=tmpList
end
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eSelectLiBao,'canSelectRewardsData',saveData)
needSave=true
end

if needSave then

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSelectLiBao)
end
end
end


function rechargeModel:test_clearSelectLiBaoCanSelectRewardsData()
self.data.selectLiBaoData.canSelectRewardsData=nil
userActorArraySetting.set(ACTOR_SETTING_TYPE.eSelectLiBao,'canSelectRewardsData',nil)

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSelectLiBao)
end

function rechargeModel:checkSelectLiBaoIsSellOut(libaoId)
local cfg=cfgHelper.get(cfg_customizedgiftconfig_get,libaoId)
if cfg then
local buyNum=rechargeModel:getSelectLiBaoBuyNumByLiBaoId(libaoId)
if cfg.maxcount and cfg.maxcount>0 then

if buyNum>=cfg.maxcount then
return true
end
end
end
return false
end


function rechargeModel:checkSelectLiBaoGridReddot(libaoId,index)
local isSellOut=rechargeModel:checkSelectLiBaoIsSellOut(libaoId)
if isSellOut then

return false
end

local defaultReward,selectReward,canSelectReward=rechargeModel:getSelectLiBaoRewardByLiBaoId(libaoId)
local defaultCount=#defaultReward
local data=selectReward[index]
local isEmptyGrid=data==nil
if isEmptyGrid then
return false
end
local gridIdx=data.gridIdx or defaultCount+index
local originalList_lookup=rechargeModel:getSelectLiBaoCanSelectRewardsData(libaoId,gridIdx)
local hasOriginal=originalList_lookup~=nil and next(originalList_lookup)~=nil
if not hasOriginal then
return false
end

local rewardList=canSelectReward[gridIdx]
if not isEmptyGrid and hasOriginal and rewardList then
for _,item in ipairs(rewardList)do
local itemid=item.itemId
local itemcount=item.itemCount
if not originalList_lookup[itemid]then
return true
else
local originalItem=originalList_lookup[itemid]
if originalItem.itemCount~=itemcount then
return true
end
end
end
end
return false
end


function rechargeModel:checkSelectLiBaoNewSelectReddot()
local allCfg=cfg_customizedgiftconfig()
for _,cfg in pairs(allCfg)do
local libaoId=cfg.id
if libaoId then
local isHide=rechargeModel:isSelectLiBaoHide(libaoId)
local isSellOut=rechargeModel:checkSelectLiBaoIsSellOut(libaoId)
if not isHide and not isSellOut then
local defaultReward,selectReward,canSelectReward=rechargeModel:getSelectLiBaoRewardByLiBaoId(libaoId)
for idx,data in pairs(selectReward)do
local gridIdx=data.gridIdx
local rewardList=canSelectReward[gridIdx]
local originalList_lookup=rechargeModel:getSelectLiBaoCanSelectRewardsData(libaoId,gridIdx)
local hasOriginal=originalList_lookup~=nil and next(originalList_lookup)~=nil
if rewardList and next(rewardList)~=nil and hasOriginal then
for _,item in ipairs(rewardList)do
local itemid=item.itemId
local itemcount=item.itemCount
if not originalList_lookup[itemid]then
return true
else
local originalItem=originalList_lookup[itemid]
if originalItem.itemCount~=itemcount then
return true
end
end
end
end
end
end
end
end
return false
end


function rechargeModel:checkSelectLiBaoEnterReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eCustomizedGift)then

return false
end

local isGotFreeReward=rechargeModel:checkSelectLiBaoFreeRewardGot()
if not isGotFreeReward then
return true
end
return rechargeModel:checkSelectLiBaoNewSelectReddot()
end


function rechargeModel:isSelectLiBaoHide(libaoId)
local cfg=cfgHelper.get(cfg_customizedgiftconfig_get,libaoId)
if cfg and cfg.hideFlag then
return true
end

return false
end


function rechargeModel:checkSelectLiBaoHasItemId(item_id)
local list=rechargeModel:getSelectLiBaoByItemIdLookup(item_id)
if not list then
return false
end
local zmLevel=zongmenModel:getLevel()
for _,v in pairs(list)do
local libaoId=v[1]
local gridIdx=v[2]
local idx1=v[3]
local idx2=v[4]
if libaoId then
local isHide=rechargeModel:isSelectLiBaoHide(libaoId)
local isSellOut=rechargeModel:checkSelectLiBaoIsSellOut(libaoId)
if not isHide and not isSellOut then
local cfg=cfgHelper.get(cfg_customizedgiftconfig_get,libaoId)
local param=cfg.rewards[gridIdx][idx1]
local minLv=param[1]
local maxLv=param[2]
if zmLevel>=minLv and zmLevel<=maxLv then
local rewardParam=param[3][idx2]
local isUnlock=true
local unlockCdn=rewardParam[3]
if unlockCdn then
for _,v in ipairs(unlockCdn)do
local cdnType=v[1]
if cdnType==1 then

local minLevel=v[2]
local maxLevel=v[3]
if zmLevel<minLevel or(maxLevel and zmLevel>maxLevel)then
isUnlock=false
break
end
elseif cdnType==2 then
local sysId=v[2]

if not systemModel.isOpen(sysId)then
isUnlock=false
break
end
end
end
end
if isUnlock then
return true,libaoId,gridIdx
end
end
end
end
end
return false
end

function rechargeModel:getSelectLiBaoByItemIdLookup(item_id)
local allCfg=cfg_customizedgiftconfig()
if not self.data.selectLiBaoByItemIdLookup then
self.data.selectLiBaoByItemIdLookup={}
for _,cfg in pairs(allCfg)do
local libaoId=cfg.id
if libaoId then
local rewardParam=cfg.rewards
for gridIdx,paramList in ipairs(rewardParam)do
for idx1,param in ipairs(paramList)do
local rewardList=param[3]
if rewardList and#rewardList>1 then
for idx2,rewardParam in ipairs(rewardList)do
local itemId=rewardParam[1]
if not self.data.selectLiBaoByItemIdLookup[itemId]then
self.data.selectLiBaoByItemIdLookup[itemId]={}
end
table.insert(self.data.selectLiBaoByItemIdLookup[itemId],{libaoId,gridIdx,idx1,idx2})
end
end
end
end
end
end
end
return self.data.selectLiBaoByItemIdLookup[item_id]
end




function rechargeModel:setGuanYinGeOneKeyBuy(flag)
self.data.setGuanYinGeOneKeyBuyFlag=flag
end
function rechargeModel:getGuanYinGeOneKeyBuy()
return self.data.setGuanYinGeOneKeyBuyFlag or false
end


function rechargeModel:checkWeekCardReddot()
if self:checkWeekCardTabShow()then
return self:checkWeekCardEnterFlag()or self:getWeekCardDailyReddot()
end
return false
end

function rechargeModel:checkWeekCardEnterFlag()
local check=userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,'rechargeWeekCardEnterFlag',0)
return check==0
end

function rechargeModel:markWeekCardEnterFlag()
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eOneTimeReddot,'rechargeWeekCardEnterFlag',1,0)
end

function rechargeModel:getWeekCardDailyReddot()
if not self.data.weekCards then
return false
end
local nowTime=timeHelper.getServerShortTime()
for i,v in pairs(self.data.weekCards)do
if v.valid>nowTime and not(v.daily>=nowTime or timeHelper.checkInSameDay2(v.daily,nowTime))then
return true
end
end
return false
end

function rechargeModel:checkWeekCardTabShow()
local cfgs=cfg_zhoukaconfig()
for i,v in pairs(cfgs)do
local show=self:checkWeekCardShow(v.id)
if show then
return true
end
end
return false
end

function rechargeModel:checkWeekCardShow(id)
local cfg=cfgHelper.get1(cfg_zhoukaconfig_get,id)
if cfg.kfDays and timeHelper.getServerOpenDay()<cfg.kfDays then
return false,1,cfg.kfDays
end
if cfg.sysid and not systemModel.isOpen(cfg.sysid)then
return false,3,cfg.sysid
end

local version=pfwindowslController:getGameVersion()
local serverPlatform=gameUtilityModel.getServerPlatform()
local level=zongmenModel:getLevel()
if cfg.level==nil or cfg.level[version]==nil or(cfg.level[version][serverPlatform]==nil and cfg.level[version][-1]==nil)then
return false,2
elseif cfg.level[version][serverPlatform]~=nil and level<cfg.level[version][serverPlatform]then
return false,2,cfg.level[version][serverPlatform]
elseif cfg.level[version][-1]~=nil and level<cfg.level[version][-1]then
return false,2,cfg.level[version][-1]
end

return true
end

function rechargeModel:initWeekCardData(datas)
if self.data.weekCards then
table.clear(self.data.weekCards)
else
self.data.weekCards={}
end

if datas then
for i,v in ipairs(datas)do
self:setWeakCardData(v)
end
end
end

function rechargeModel:setWeakCardData(data)
if not self.data.weekCards then
self.data.weekCards={}
end

local _data={
id=data.zkid,
valid=data.endTime,
daily=data.dayRewardTime,
level=data.rewardLevel,
}
self.data.weekCards[data.zkid]=_data
end

function rechargeModel:getWeekCardData(id)
if self.data.weekCards then
return self.data.weekCards[id]
end
end

function rechargeModel:getWeekCardDatas()
return self.data.weekCards
end

function rechargeModel:setWeekCardDailyTime(id,time)
local data=self:getWeekCardData(id)
if data then
data.daily=time
end
end

function rechargeModel:setWeekCardDailyTimeEx(time)
if self.data.weekCards then
for i,v in ipairs(self.data.weekCards)do
v.daily=time
end
end
end


function rechargeModel:checkIsHasWillExpireWeekCard()
if self.data.weekCards then
local nowTime=timeHelper.getServerShortTime()
local todayZero=timeHelper.getServerZeroShortStamp(nowTime)
local expireDay=cfgHelper.get2(cfg_zhoukabaseconfig_get,1,"appendDay")
for i,v in ipairs(self.data.weekCards)do
local isValid=nowTime<v.valid
if isValid then
local leastDay=math.floor((v.valid-todayZero)/86400+0.5)
if leastDay<=expireDay then
return true
end
end
end
end

return false
end
