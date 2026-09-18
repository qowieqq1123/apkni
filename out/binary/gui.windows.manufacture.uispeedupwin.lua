







def_class("UISpeedUpWin",UIWindowBase)









function UISpeedUpWin:bindComponents()

self.progressBar=UIObject.get(self,0)
self.btnPanel=UIObject.get(self,1)
self.progressImg=UIObject.get(self,2)
self.progressText=UIText.get(self,3)
self.btnMoneySpeedup=UIButton.get(self,4)
self.btnAdsSpeedup=UIButton.get(self,5)
self.btnItemSpeedup=UIButton.get(self,6)
self.iconMoney=UIImage.get(self,7)
self.payMoney=UIText.get(self,8)
self.txtBtnPayMoney=UIText.get(self,9)
self.iconItem=UIObject.get(self,10)
self.payItem=UIText.get(self,11)
self.txtBtnPayItem=UIText.get(self,12)
self.imgAdsTimer=UIObject.get(self,13)
self.iconAds=UIImage.get(self,14)
self.payAds=UIText.get(self,15)

self.btnMoneySpeedup:setButtonClick(function()
self:onBtnMoneySpeedup()
end)

self.btnAdsSpeedup:setButtonClick(function()
self:onBtnAdsSpeedup()
end)

self.btnItemSpeedup:setButtonClick(function()
self:onBtnItemSpeedup()
end)



end


function UISpeedUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.progressBar);
self.progressBar=nil;
_UIObject_release(self.btnPanel);
self.btnPanel=nil;
_UIObject_release(self.progressImg);
self.progressImg=nil;
_UIObject_release(self.progressText);
self.progressText=nil;
_UIObject_release(self.btnMoneySpeedup);
self.btnMoneySpeedup=nil;
_UIObject_release(self.btnAdsSpeedup);
self.btnAdsSpeedup=nil;
_UIObject_release(self.btnItemSpeedup);
self.btnItemSpeedup=nil;
_UIObject_release(self.iconMoney);
self.iconMoney=nil;
_UIObject_release(self.payMoney);
self.payMoney=nil;
_UIObject_release(self.txtBtnPayMoney);
self.txtBtnPayMoney=nil;
_UIObject_release(self.iconItem);
self.iconItem=nil;
_UIObject_release(self.payItem);
self.payItem=nil;
_UIObject_release(self.txtBtnPayItem);
self.txtBtnPayItem=nil;
_UIObject_release(self.imgAdsTimer);
self.imgAdsTimer=nil;
_UIObject_release(self.iconAds);
self.iconAds=nil;
_UIObject_release(self.payAds);
self.payAds=nil;
end


















local _this
local _format=string.format


function UISpeedUpWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_change)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
end


function UISpeedUpWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_change)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
_this=nil
end




function UISpeedUpWin:onShow(argtable,afterOnloaded)
self.bdData=argtable.bdData
self.callback=argtable.callback


self.baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
self.nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)

self:refreshProgressBar()
self:refreshButtons()
end

function UISpeedUpWin:refreshProgressBar()
local beginTime=self.bdData.begintime
if beginTime>0 then
self.upgrade_need_time=self.nextLvCfg.uplevel_times
local delta_time=gameUtilityModel.getServerShortTime()-beginTime+self.bdData.reducetime
local ctime=self.upgrade_need_time-delta_time
if ctime>0 then
self:stopLevelUpTimer()
local endtime=os.time()+ctime
local tick=function()
local dtime=endtime-os.time()
if dtime>0 then
self.progressText:setText(timeHelper.format_time_stamp4(dtime))
self.progressImg:setChildIconFillAmount(1-dtime/self.upgrade_need_time)
else
self:stopLevelUpTimer()
self:refreshProgressBar()
end
end
tick()
self.levelUpTimer=self:setTimer(1,0,tick)
self.btnPanel:setActive(true)
else
self:stopLevelUpTimer()
self.progressText:setText('升级完成')
self.btnPanel:setActive(false)
self.progressImg:setChildIconFillAmount(1)
end
end
end

function UISpeedUpWin:refreshButtons()

self.money_type=self.baseCfg[1][1]
self.iconMoney:SetChildIcon(iconHelper.getIconName(self.money_type),true)
self:refreshPayMoney()

self:refreshPayItem()

if not self.can_item_speedup then
self.btnItemSpeedup:setActive(false)
self.btnAdsSpeedup:setActive(true)
self:refreshPayAds()
end
end

function UISpeedUpWin:refreshPayAds()
local cfg=self.baseCfg[3]
local cur_cnt=zongmenModel:getAdsSpeedupCount()
local max_cnt=cfg[2]
self.can_ads_speedup=cur_cnt<max_cnt
if self.can_ads_speedup then
self.payAds:setText(_format('%s/%s',cur_cnt,max_cnt))
else
self.payAds:setText(_format('<color=red>%s/%s</color>',cur_cnt,max_cnt))
end
end

function UISpeedUpWin:refreshPayMoney()
local cfg=self.baseCfg[1]
local time=cfg[3]
local need=math.ceil(self.upgrade_need_time/time)
local have=moneyModel.getMoney(cfg[1])
self.needMoneyType=cfg[1]
if have>=cfg[2]then
self.can_money_speedup=true
if have>=need then
self.speedup_money_count=need
self.txtBtnPayMoney:setText('立即完成')
else
self.speedup_money_count=have
self.txtBtnPayMoney:setText(_format('加速%s',timeHelper.format_time_stamp4(time*have)))
end
else
self.can_money_speedup=false
self.txtBtnPayMoney:setText('货币加速')
end
if self.can_money_speedup then
self.payMoney:setText(_format('%s/%s',have,need))
else
self.payMoney:setText(_format('<color=red>%s/%s</color>',have,need))
end
end

function UISpeedUpWin:refreshPayItem()
local cfg=self.baseCfg[2]
for k,v in pairs(cfg)do
local item_cfg=itemsConfig.getConfig(k)
if item_cfg then
local time=v[2]
local need=math.ceil(self.upgrade_need_time/time)
local have=itemBagModel:getItemCountByItemID(item_cfg.id)
if have>=v[1]then
self.can_item_speedup=true
self.speedup_item_count=have>=need and need or have
else
self.needitemid=k
self.can_item_speedup=false
end
if self.can_item_speedup then
self.winlua:InitChildSlotItem(self.iconItem:getID(),iconHelper.getIconName(item_cfg.id),nil,item_cfg.color,item_cfg.name,-1,int64.new(0))
self.payItem:setText(_format('%s/%s',have,need))
self.speedup_item_id=item_cfg.id
return
end
end
end
end


function UISpeedUpWin:OnEnable()

end


function UISpeedUpWin:OnDisable()

end



function UISpeedUpWin:onClickClose()
self:closeSelf()
end






function UISpeedUpWin:onBtnMoneySpeedup()
if self.can_money_speedup then
self.callback(speedUpMode.eMoney,self.speedup_money_count,0)
else
UIManager.error('货币不足, 不能加速')
gainControl:showGainWin(self.needMoneyType)
end
end

function UISpeedUpWin:onBtnItemSpeedup()
if self.can_item_speedup then
self.callback(speedUpMode.eItem,self.speedup_item_count,self.speedup_item_id)
else
UIManager.error('道具不足, 不能加速')
gainControl:showGainWin(self.needitemid)
end
end

function UISpeedUpWin:onBtnAdsSpeedup()
if not self.isAdsCD and self.can_ads_speedup then
self.callback(speedUpMode.eAds,1,0)
else
if self.isAdsCD then
UIManager.error('广告加速冷却中')
else
UIManager.error('广告加速次数已用完')
end
end
end

function UISpeedUpWin:stopLevelUpTimer()
if self.levelUpTimer then
self:stopTimerByID(self.levelUpTimer)
self.levelUpTimer=nil
end
end

function UISpeedUpWin.on_building_event(etype,sfId,bdId,args)
if etype==buildingEvent.speedUpComplete then
_this:refreshProgressBar()
local type1=args.type1
if type1==speedUpMode.eAds then
local need_time=_this.baseCfg[3][1]
local end_time=os.time()+need_time
_this.isAdsCD=true
local tick=function()
local dt=end_time-os.time()
if dt<0 then
_this.imgAdsTimer:setChildIconFillAmount(1)
_this.isAdsCD=false
_this:stopAdsTimer()
end
_this.imgAdsTimer:setChildIconFillAmount(1-dt/need_time)
end
tick()
_this:stopAdsTimer()
_this.adsTimer=_this:setTimer(1,0,tick)
end
end
end

function UISpeedUpWin.on_money_change(money_type,last_val,new_val)
if _this.money_type==money_type then
_this:refreshPayMoney()
end
end

function UISpeedUpWin.on_item_changed(changeType,itemUid,itemId,oldVal,newVal)
if _this.speedup_item_id==itemId then
_this:refreshPayItem()
end
end

function UISpeedUpWin:stopAdsTimer()
if self.adsTimer then
self:stopTimerByID(self.adsTimer)
self.adsTimer=nil
end
end