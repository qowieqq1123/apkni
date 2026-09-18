







def_class("SubAct_TeHuiLiBaoWin",UIWindowBase)









function SubAct_TeHuiLiBaoWin:bindComponents()

self.baoXiang=UIButton.get(self,0)
self.baoXiangOpen=UIButton.get(self,1)
self.hejiRoot=UIObject.get(self,2)
self.time=UIText.get(self,3)
self.name=UIText.get(self,4)
self.limitTimeGiftItem1=UIObject.get(self,5)
self.limitTimeGiftItem2=UIObject.get(self,6)
self.limitTimeGiftItem3=UIObject.get(self,7)
self.baoXiangReddot=UIObject.get(self,8)
self.allBuyButton=UIButton.get(self,9)
self.zheBg=UIObject.get(self,10)
self.allBuyText=UIText.get(self,11)
self.zhe=UIText.get(self,12)

self.baoXiang:setButtonClick(function()self:onBaoXiang()end)

self.baoXiangOpen:setButtonClick(function()self:onBaoXiangOpen()end)

self.allBuyButton:setButtonClick(function()self:onAllBuyButton()end)



end


function SubAct_TeHuiLiBaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.baoXiang);self.baoXiang=nil;
_UIObject_release(self.baoXiangOpen);self.baoXiangOpen=nil;
_UIObject_release(self.hejiRoot);self.hejiRoot=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.limitTimeGiftItem1);self.limitTimeGiftItem1=nil;
_UIObject_release(self.limitTimeGiftItem2);self.limitTimeGiftItem2=nil;
_UIObject_release(self.limitTimeGiftItem3);self.limitTimeGiftItem3=nil;
_UIObject_release(self.baoXiangReddot);self.baoXiangReddot=nil;
_UIObject_release(self.allBuyButton);self.allBuyButton=nil;
_UIObject_release(self.zheBg);self.zheBg=nil;
_UIObject_release(self.allBuyText);self.allBuyText=nil;
_UIObject_release(self.zhe);self.zhe=nil;
end


















local widgetIndex=
{
name=0,
itemScorllView=1,
buyLimit=2,
buyBtn=3,
reddot=4,
buyText=5,
icon=6,
got=7,
buyIcon=8,
HwNameImage=9,
}



function SubAct_TeHuiLiBaoWin:onLoaded(...)
self:bindComponents()

self.limitTimeGiftItem=
{
self.limitTimeGiftItem1,
self.limitTimeGiftItem2,
self.limitTimeGiftItem3,
}
local on_new_day=function()
if self and not self.isClose then
self:updateData()
self:refreshWin()
end
end
notifySystem:listenNotify(notifyConfig.onNewDay,on_new_day)
end


function SubAct_TeHuiLiBaoWin:__delete()
self:clearTimer()
self:unbindComponents()
end




function SubAct_TeHuiLiBaoWin:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eTeHuiLiBao
self.subid=argtable.sub_act_id

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self.libaoConfig=self.config.recharge_info
self.libaoConfig=self.libaoConfig[pfwindowslController:getGameVersion()]or self.libaoConfig[1]

self.baoXiangConfig=self.config.gift_box

self:updateData()

self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)

self.opendays=self.info.openDays
self.startday=self.info.start_day_idx
self.endday=self.info.end_day_idx
self.start_time=self.info.start_time
self.end_time=self.info.end_time








self:refreshWin()
end

function SubAct_TeHuiLiBaoWin:updateData()
local data=activitiesModel:getSubActInfoData(self.actid,SUB_ACTIVITY_TYPE.eTeHuiLiBao,self.subid)
if data then
local resetData=data
local isSet=false
if data.last_time~=0 and not timeHelper.isTodayStamp(timeHelper.convertLongStamp(data.last_time))then
resetData.info={}
resetData.last_time=0
isSet=true

end
if data.last_box_time~=0 and not timeHelper.isTodayStamp(timeHelper.convertLongStamp(data.last_box_time))then
resetData.last_box_time=0
isSet=true
end
if isSet then

activitiesModel:setSubActInfoData(self.actid,SUB_ACTIVITY_TYPE.eTeHuiLiBao,self.subid,resetData)
end
end
end

function SubAct_TeHuiLiBaoWin:refreshWin()
local longTime=timeHelper.getServerShortTime()
local y1,m1,d1=timeHelper.getDate(timeHelper.getFormatByStamp(self.start_time))
local y2,m2,d2=timeHelper.getDate(timeHelper.getFormatByStamp(longTime))



local day=self.info:getStart2NowDay()

self.rechargeDayCfg=self.libaoConfig[day]
if not self.rechargeDayCfg then
if longTime>=self.end_time then
self.rechargeDayCfg=self.libaoConfig[#self.libaoConfig]
else
error(FMT.fmt("无当天礼包{0}",day))
return
end
end
local total=0
local allRmb
for i,v in ipairs(self.rechargeDayCfg)do
if v[2]==1 then
self.buyAllCfg=v
local rechargeCfg=cfgHelper.get(cfg_rechargeconfig_get,v[1])
allRmb=rechargeCfg.rmb
else
local rechargeCfg=cfgHelper.get(cfg_rechargeconfig_get,v[1])
total=total+rechargeCfg.rmb
end
end

self.zheVal=math.floor(allRmb/total*100)/10

local index=1
for i,v in ipairs(self.rechargeDayCfg)do
if v[2]==0 then
local cfg=v
local giftItem=self.limitTimeGiftItem[index]
if giftItem then
self:refreshItem(giftItem,cfg)
end
index=index+1
elseif v[2]==1 then
self:refreshAllBuy(v)
end

end

local canGetBaoXiang=activitiesHandle_tehuilibao.canGetBaoXiang(self.actid,self.subid)
self:showBaoXiang(canGetBaoXiang)
self.baoXiang:setActive(canGetBaoXiang)



self:setRemainingTimeTimer()
end

function SubAct_TeHuiLiBaoWin:showBaoXiang(isreddot)
if isreddot then
if self.reddotTweener==nil then
self.baoXiangReddot:setRotation(0,0,0)
local tweener=self.baoXiangReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.baoXiangReddot:setRotation(0,0,0)
end
end
end

function SubAct_TeHuiLiBaoWin:refreshItem(giftItem,cfg)
local rewardList=cfg[3]
local rechargeId=cfg[1]
local giftType=cfg[2]
local name=cfg.name

local widget=giftItem:getChildWidgetBase()

self.isGuoFu=pfwindowslController:checkIsGameVersion_guofu()
widget:SetChildScrollViewCreateGrids(widgetIndex.itemScorllView,#rewardList,#rewardList)
local grids=widget:GetChildScrollViewItemWidgets(widgetIndex.itemScorllView)
local count=grids.Count
for i=1,count do
local grid=grids[i-1]
local item=rewardList[i]
if item then
local itemid=item[1]
local itemcount=item[2]
local countStr=''
local showCountBG=false
if itemcount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemcount)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
grid:SetChildPropData(0,propData)
local func=function(...)
tipsManager.showTips({itemid=itemid})
end
grid:SetBaseItemClickEvent(0,func)
end
end


local rechargeCfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargeCfg)
widget:SetChildText(widgetIndex.buyText,FMT.fmt("{0}购",str))

if self.isGuoFu then
widget:SetChildText(widgetIndex.name,name or rechargeCfg.name)
else
widget:SetChildActive(widgetIndex.name,false)
widget:SetChildActive(widgetIndex.HwNameImage,true)
end

local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local isBuyAll=false
if self.buyAllCfg then
local allId=self.buyAllCfg[1]
isBuyAll=data.info[allId]~=nil
end

local isGot=isBuyAll or data.info[rechargeId]~=nil

widget:SetChildActive(widgetIndex.buyBtn,not isBuyAll and data.info[rechargeId]==nil)
widget:SetChildActive(widgetIndex.got,isGot)








widget:SetChildButtonClick(widgetIndex.buyBtn,function()
if self.payTimer then
return
end
if self.end_time then
local shortTime=timeHelper.getServerShortTime()
if shortTime>=self.end_time then
UIManager.error("活动已结束")
return
end
end
local buydata=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
if buydata.info[rechargeId]~=nil then
return
end
local params=payControl.getActivityPayParams(self.actid,self.subType,self.subid)
payControl.reqPay(rechargeId,1,params)
if not self.payTimer then
self.payTimer=self:setTimer(1,1,function()
self.payTimer=nil
end)
end
end)
end

function SubAct_TeHuiLiBaoWin:refreshAllBuy()
local buydata=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
if next(buydata.info)then
self.hejiRoot:setActive(false)
return
else
self.hejiRoot:setActive(true)
end

local rechargeCfg=cfgHelper.get(cfg_rechargeconfig_get,self.buyAllCfg[1])
local str=pfwindowslController:showDescFour_ByMoneyType(rechargeCfg)
self.allBuyText:setText(str)

local str=pfwindowslController:showDescSix(self.buyAllCfg.sale)
self.zhe:setText(str)
end


function SubAct_TeHuiLiBaoWin:onHide()
self:clearTimer()
end






function SubAct_TeHuiLiBaoWin:onAllBuyButton()
local buydata=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
if next(buydata.info)then
return
end
if self.payTimer then
return
end

if self.end_time then
local shortTime=timeHelper.getServerShortTime()
if shortTime>=self.end_time then
UIManager.error("活动已结束")
return
end
end

local params=payControl.getActivityPayParams(self.actid,self.subType,self.subid)
payControl.reqPay(self.buyAllCfg[1],1,params)
if not self.payTimer then
self.payTimer=self:setTimer(1,1,function()
self.payTimer=nil
end)
end
end

function SubAct_TeHuiLiBaoWin:onBaoXiang()
if self.getBoxTimer then
return
end
if self.end_time then
local shortTime=timeHelper.getServerShortTime()
if shortTime>=self.end_time then
UIManager.error("活动已结束")
return
end
end
local canGetBaoXiang=activitiesHandle_tehuilibao.canGetBaoXiang(self.actid,self.subid)
if canGetBaoXiang then
local is_assistant=0
local jsonStr=jsonHelper.encode({is_assistant})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actid,self.subType,self.subid,jsonStr)
end

if not self.getBoxTimer then
self.getBoxTimer=self:setTimer(1,1,function()
self.getBoxTimer=nil
end)
end
end

function SubAct_TeHuiLiBaoWin:onBaoXiangOpen()

end


function SubAct_TeHuiLiBaoWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.end_time and self.end_time-nowTime or 0
if lerp>0 then

self.time:setText(FMT.fmt("{0}后结束",timeHelper.format_time_stamp11(lerp,true)))
else
self.time:setText("活动已结束")

UIManager.error("活动已结束")
self:clearTimer()
end
end

self.timer=self:setTimer(1,0,func)

func()
end


function SubAct_TeHuiLiBaoWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end
