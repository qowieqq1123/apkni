







def_class("UITYTongXingZhengTouZiWin",UIWindowBase)









function UITYTongXingZhengTouZiWin:bindComponents()

self.modelBg=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.leftRoot=UIObject.get(self,2)
self.rightRoot=UIObject.get(self,3)



end


function UITYTongXingZhengTouZiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
end



















local abname="ui/windows/wuxingdian/wxd_touzi_atlas_pak.ab"


function UITYTongXingZhengTouZiWin:onLoaded(...)
self:bindComponents()
self:showWindow('UITopMoneyWin2',{moneys={{eMoneyType.mtLingYu},{eMoneyType.mtXianYu}}})
self.modelBg:setChildUIModelShowTarget(4883,1,{},5)
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.3,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
end)
end


function UITYTongXingZhengTouZiWin:__delete()
local widget=self.leftRoot:getChildWidgetBase()
widget:SetChildScrollViewStopGridCreate(0)
local widget=self.rightRoot:getChildWidgetBase()
widget:SetChildScrollViewStopGridCreate(0)
if self.dialog then
self.dialog:hide()
end
self:unbindComponents()
end




function UITYTongXingZhengTouZiWin:onShow(argtable,afterOnloaded)
self.txzId=argtable.txzId
self.guid=argtable.guid
self.passportId=argtable.passportId
if not self.txzId or self.txzId==1 or self.txzId==2 then
if not self.guid then
logErr(FMT.fmt("传入通行证guid：为nil，缺少通用通行证数据，前后端检查29_10"))
else
logErr(FMT.fmt("传入通行证guid：{0}，缺少通用通行证数据，前后端检查29_10",self.guid))
end
UIManager.error('通行证数据有误，暂无法购买投资')
self:closeSelf()
else
self:freshInfo()
end
end


function UITYTongXingZhengTouZiWin:onHide()

end

function UITYTongXingZhengTouZiWin:freshInfo()
local hasTouziMoney=not UITYTongXingZhengModel:hasTouziMoney(self.guid)
local hasTouziRecharge=not UITYTongXingZhengModel:hasTouziRecharge(self.guid)
self.leftRoot:setActive(hasTouziMoney)
self.rightRoot:setActive(hasTouziRecharge)
if hasTouziMoney and hasTouziRecharge then
self:freshLeft()
self:freshRight()
elseif hasTouziRecharge then
self.rightRoot:setChildAnchoredPosition(Vector2.New(0,33.6))
self:freshRight()
else
self.leftRoot:setChildAnchoredPosition(Vector2.New(0,33.6))
self:freshLeft()
end
end

function UITYTongXingZhengTouZiWin:initRewardData(itemsList)
local list={}
for k,v in ipairs(itemsList)do
v.showStage=true
local temp={itemid=v[1],data=v}
table.insert(list,temp)
end

return self:sortReward(list)
end

function UITYTongXingZhengTouZiWin:sortReward(itemsList)
local list=itemsList
self.sortConfigs=bagSortConfig.getAllSortConfig()
local sortConfig=self.sortConfigs[SHOW_BAG_TYPE.eItemBag]
local cfg=sortConfig[1]
local sortType=ITEM_SORT_COMPARE_TYPE.eDownOrder
if cfg.sortFun then
cfg.sortFun(list,sortType)
else
table.sort(list,function(a,b)
return cfg.sortTag(a,sortType)>cfg.sortTag(b,sortType)
end)
end

return list
end

function UITYTongXingZhengTouZiWin:freshLeft()
local widget=self.leftRoot:getChildWidgetBase()
local prizeList=UITYTongXingZhengModel:getPrizeCfgsByIndex(self.txzId)
local rewards={}
for _,v in ipairs(prizeList)do
local cfg=v
local itemsList=cfg.lock1Reward
rewards=attrListHelper.concatList(rewards,itemsList)
end

rewards=self:initRewardData(rewards)
local len=#rewards
widget:SetChildScrollViewInit(0,0.5,true,nil,nil)
widget:SetChildScrollViewDelayCreateGrids(0,len,0,0.02,16,false,false,function(index,item)
local data=rewards[index+1].data
widgetHelper.setNormalRewardItem(item,0,data)
end)

local cfg=cfgHelper.get2(cfg_passportconfig_get,self.txzId,"investname")
local titleName=cfg[1]
local recharge_list=cfgHelper.get2(cfg_passportconfig_get,self.txzId,'recharge_list')
local rechargeId=recharge_list[2][1]
local cost=recharge_list[2][2]


local recfg
local moneyname

if rechargeId==0 then
local moneyType=cost[1]
local need=cost[2]
moneyname=moneyModel.getMoneyName(moneyType)
widget:SetChildButtonClick(1,function()

local func1=function()
local func=function()
socketManager:send_29_13(self.guid,buyFlagType.money)
UIManager:closeWindow("UITopMoneyWin2")
UIManager:closeWindow('UITYTongXingZhengTouZiWin')
end
moneySystem:useMoney(moneyType,need,func,WARNING_TYPE.eWarning)
end


if self:checkIsLianQiDaHuiActivityEnd()then
local moneyNum=need or 0
local confirmTeX=moneyNum..moneyname
self.dialog=self:showConfirmDialog3WhenActivityEnd(titleName,confirmTeX,func1)
else
local leftDay=UITYTongXingZhengModel:getCurLeftDay(self.guid)
local str=FMT.fmt('是否花费<color=#ca631d>{0}</color>{1}购买{2}？\n（本期奖励将在<color=#ca631d>{3}</color>天后重置）',need,moneyname,titleName,leftDay)
if leftDay==nil then
str=FMT.fmt('是否花费<color=#ca631d>{0}</color>{1}购买{2}？',need,moneyname,titleName)
end

self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,str,func1)
end
end)
widget:SetChildText(2,FMT.fmt('{0}{1}',need,moneyname))
else
recfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
widget:SetChildButtonClick(1,function()
local func=function()
local params=FMT.fmt('{0}-{1}',self.guid,buyFlagType.money)
payControl.reqPay(rechargeId,1,params)
UIManager:closeWindow("UITopMoneyWin2")
UIManager:closeWindow('UITYTongXingZhengTouZiWin')
end


if self:checkIsLianQiDaHuiActivityEnd()then
local rmbNum=recfg.rmb or 0
local confirmTeX=rmbNum.."元"
self.dialog=self:showConfirmDialog3WhenActivityEnd(titleName,confirmTeX,func)
else
local leftDay=UITYTongXingZhengModel:getCurLeftDay(self.guid)
local str=FMT.fmt('是否花费<color=#ca631d>{0}</color>元购买{1}？\n（本期奖励将在<color=#ca631d>{2}</color>天后重置）',recfg.rmb,titleName,leftDay)
if leftDay==nil then
str=FMT.fmt('是否花费<color=#ca631d>{0}</color>元购买{1}？',recfg.rmb,titleName)
end
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,str,func)
end

end)
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
widget:SetChildText(2,str)
end

local left=''
local rebatename=cfgHelper.get2(cfg_passportconfig_get,self.txzId,"rebateTitle")
local investname=cfgHelper.get2(cfg_passportconfig_get,self.txzId,"investTitle")
local investBg=cfgHelper.get3(cfg_passportconfig_get,self.txzId,"investBg",1)
local ratioTxt=cfgHelper.get3(cfg_passportconfig_get,self.txzId,"multiple_text",1)

local titleName1=rebatename[1]
local titleName2=investname[1]


widget:SetChildText(3,left)
widget:SetChildActive(5,false)
widget:SetChildText(6,FMT.fmt('购买{0}',titleName))
widget:SetChildCSImageSprite(8,investBg[1],investBg[2])

widget:SetChildText(10,ratioTxt)
if api_Available_SetChildCSImage()then

widget:SetChildCSImage(7,abname,titleName2,true)
else

widget:SetChildCSImageSprite(7,abname,titleName2)
end
end

function UITYTongXingZhengTouZiWin:freshRight()
local widget=self.rightRoot:getChildWidgetBase()
local prizeList=UITYTongXingZhengModel:getPrizeCfgsByIndex(self.txzId)
local rewards={}
for _,v in ipairs(prizeList)do
local cfg=v
local itemsList=cfg.lock2Reward
rewards=attrListHelper.concatList(rewards,itemsList)
end
rewards=self:initRewardData(rewards)
local len=#rewards
widget:SetChildScrollViewInit(0,0.5,true,nil,nil)
widget:SetChildScrollViewDelayCreateGrids(0,len,0,0.02,16,false,false,function(index,item)
local data=rewards[index+1].data
widgetHelper.setNormalRewardItem(item,0,data)
end)
local investname=cfgHelper.get2(cfg_passportconfig_get,self.txzId,"investname")
local titleName=investname[2]
local recharge_list=cfgHelper.get2(cfg_passportconfig_get,self.txzId,'recharge_list')
local rechargeId=recharge_list[3][1]
local recfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
widget:SetChildButtonClick(1,function()
local func=function()
local params=FMT.fmt('{0}-{1}',self.guid,buyFlagType.recharge)
payControl.reqPay(rechargeId,1,params)
UIManager:closeWindow("UITopMoneyWin2")
UIManager:closeWindow('UITYTongXingZhengTouZiWin')
end


if self:checkIsLianQiDaHuiActivityEnd()then
local rmbNum=recfg.rmb or 0
local confirmTeX=rmbNum.."元"
self.dialog=self:showConfirmDialog3WhenActivityEnd(titleName,confirmTeX,func)
else
local leftDay=UITYTongXingZhengModel:getCurLeftDay(self.guid)
local str=FMT.fmt('是否花费<color=#ca631d>{0}</color>元购买{1}？\n（本期奖励将在<color=#ca631d>{2}</color>天后重置）',recfg.rmb,titleName,leftDay)
if leftDay==nil then
str=FMT.fmt('是否花费<color=#ca631d>{0}</color>元购买{1}？',recfg.rmb,titleName)
end
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,str,func)
end
end)
local left=''
local rebatename=cfgHelper.get2(cfg_passportconfig_get,self.txzId,"rebateTitle")
local investtitle=cfgHelper.get2(cfg_passportconfig_get,self.txzId,"investTitle")
local investBg=cfgHelper.get3(cfg_passportconfig_get,self.txzId,"investBg",2)
local ratioTxt=cfgHelper.get3(cfg_passportconfig_get,self.txzId,"multiple_text",2)

local titleName1=rebatename[2]
local titleName2=investtitle[2]

local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)

widget:SetChildText(2,str)
widget:SetChildText(3,left)
widget:SetChildActive(5,false)
widget:SetChildText(6,FMT.fmt('购买{0}',titleName))
widget:SetChildCSImageSprite(8,investBg[1],investBg[2])

widget:SetChildText(10,ratioTxt)
if api_Available_SetChildCSImage()then

widget:SetChildCSImage(7,abname,titleName2,true)
else

widget:SetChildCSImageSprite(7,abname,titleName2)
end
end

function UITYTongXingZhengTouZiWin:showConfirmDialog3WhenActivityEnd(titleName,confirmText,confirmCallback)
local content=FMT.fmt("炼器大会活动已结束，无法获得积分，是否购买{0}？",titleName)
self.dialog=UIDialogManager.getConfirmDialogEx(self.dialog,{
content=content,
oktext=confirmText,
okcb=confirmCallback
})
self.dialog.show()
end

function UITYTongXingZhengTouZiWin:checkIsLianQiDaHuiActivityEnd()
local activityData=activitiesModel:getAnyOpenActInfoBySubtype(SUB_ACTIVITY_TYPE.eLianQiDaHui)

if activityData==nil then
return false
end

local subId,info=next(activityData.sublist_lp[SUB_ACTIVITY_TYPE.eLianQiDaHui])
local config=cfgHelper.get1(cfg_artifactrefineconfig_get,subId)
local remainTime=info.end_time-gameUtilityModel.getServerShortTime()
return remainTime<config.earlyEndTime
end



