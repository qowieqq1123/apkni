







def_class("UIXM_XMDG_TouziUnLockWin",UIWindowBase)









function UIXM_XMDG_TouziUnLockWin:bindComponents()

self.leftRoot=UIObject.get(self,0)
self.modelBg=UIObject.get(self,1)
self.rightRoot=UIObject.get(self,2)
self.root=UIObject.get(self,3)



end


function UIXM_XMDG_TouziUnLockWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.root);self.root=nil;
end


















local passName={
'探令投资',
'密令投资',
}

function UIXM_XMDG_TouziUnLockWin:onLoaded(...)
self:bindComponents()
self:showWindow('UITopMoneyWin2',{{eMoneyType.mtLingYu},{eMoneyType.mtXianYu}})
end

function UIXM_XMDG_TouziUnLockWin:__delete()
self:stopCDTick()
local widget=self.leftRoot:getChildWidgetBase()
widget:SetChildScrollViewStopGridCreate(0)
local widget=self.rightRoot:getChildWidgetBase()
widget:SetChildScrollViewStopGridCreate(0)
if self.dialog then
self.dialog:hide()
end
self:unbindComponents()
end

function UIXM_XMDG_TouziUnLockWin:onShow(argtable,afterOnloaded)
self.modelBg:setChildUIModelShowTarget(4883,1,{},5)
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.3,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
end)

self.cfg=xianmengdigongModel:getPassInvestList()
self.const_def=cfgHelper.get1(cfg_xmdgtongxingzhengbaseconfig_get,1)

self:freshInfo()
end

function UIXM_XMDG_TouziUnLockWin:freshInfo()
local hasTouziMoney=not xianmengdigongModel:getPassInvestFlag(XMDG_Pass_Invest_Type.eMoney)
local hasTouziRecharge=not xianmengdigongModel:getPassInvestFlag(XMDG_Pass_Invest_Type.eRecharge)
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
self:startCDTick()
end

function UIXM_XMDG_TouziUnLockWin:freshLeft()
local widget=self.leftRoot:getChildWidgetBase()
local rewardsLookup={}
local rewards={}
for k,v in ipairs(self.cfg)do
for k1,v1 in ipairs(v.lyItems)do
local itemid,itemnum=unpack(v1)
rewardsLookup[itemid]=(rewardsLookup[itemid]or 0)+itemnum
end
end
for itemid,itemnum in pairs(rewardsLookup)do
local data={}
data[1]=itemid
data[2]=itemnum
data.showStage=true
local color=itemsConfig.getItemColor(itemid)
data.sortVal=color*1000000-itemid
rewards[#rewards+1]=data
end
table.sort(rewards,function(a,b)
return a.sortVal>b.sortVal
end)

local buyConf=self.const_def.buyConf[1]
local buyType=buyConf[1]
if buyType==1 then
local cost=buyConf[2][1]
local moneyType=cost[1]
local need=cost[2]
local moneyname=moneyModel.getMoneyName(moneyType)
widget:SetChildText(2,FMT.fmt("{0}{1}",need,moneyname))
elseif buyType==2 then
local recharge_id=buyConf[2]
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,recharge_id)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
widget:SetChildText(2,str)
end

local len=#rewards
widget:SetChildScrollViewInit(0,0.5,true,nil,nil)
widget:SetChildScrollViewDelayCreateGrids(0,len,0,0.02,16,false,false,function(index,item)
local data=rewards[index+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)
local buyFlag_Money=xianmengdigongModel:getPassInvestFlag(XMDG_Pass_Invest_Type.eMoney)
widget:SetChildActive(1,not buyFlag_Money)
widget:SetChildText(3,"完成所有档位可累计获得")
local ratio1=self.const_def.ratio[1]
widget:SetChildText(4,string.format("%d倍",ratio1))
if buyFlag_Money then
return
end
widget:SetChildButtonClick(1,function()
self:buyPass(1)
end)
end

function UIXM_XMDG_TouziUnLockWin:buyPass(idx)
local buyConf=self.const_def.buyConf[idx]
local buyType=buyConf[1]
if buyType==1 then
local cost=buyConf[2][1]
local moneyType=cost[1]
local need=cost[2]
local moneyname=moneyModel.getMoneyName(moneyType)
local func1=function()
local func=function()
xianmengdigongController:reqPassBuyMoneyInvest(idx)
UIManager:closeWindow('UIXM_XMDG_TouziUnLockWin')
end
moneySystem:useMoney(moneyType,need,func,WARNING_TYPE.eWarning)
end
local str=FMT.fmt('是否花费<color=#ca631d>{0}</color>{1}购买{2}？',need,moneyname,passName[idx])
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,str,func1)
elseif buyType==2 then
local recharge_id=buyConf[2]
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,recharge_id)
local costStr=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
local func=function()
payControl.reqPay(recharge_id,1,tostring(idx))
UIManager:closeWindow('UIXM_XMDG_TouziUnLockWin')
end
local str=FMT.fmt('是否花费<color=#ca631d>{0}</color>购买{1}？',costStr,passName[idx])
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,str,func)
end
end

function UIXM_XMDG_TouziUnLockWin:freshRight()
local widget=self.rightRoot:getChildWidgetBase()
local rewardsLookup={}
local rewards={}
for k,v in ipairs(self.cfg)do
for k1,v1 in ipairs(v.czItems)do
local itemid,itemnum=unpack(v1)
rewardsLookup[itemid]=(rewardsLookup[itemid]or 0)+itemnum
end
end
for itemid,itemnum in pairs(rewardsLookup)do
local data={}
data[1]=itemid
data[2]=itemnum
data.showStage=true
local color=itemsConfig.getItemColor(itemid)
data.sortVal=color*1000000-itemid
rewards[#rewards+1]=data
end
table.sort(rewards,function(a,b)
return a.sortVal>b.sortVal
end)

local buyConf=self.const_def.buyConf[2]
local buyType=buyConf[1]
if buyType==1 then
local cost=buyConf[2][1]
local moneyType=cost[1]
local need=cost[2]
local moneyname=moneyModel.getMoneyName(moneyType)
widget:SetChildText(2,FMT.fmt("{0}{1}",need,moneyname))
elseif buyType==2 then
local recharge_id=buyConf[2]
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,recharge_id)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
widget:SetChildText(2,str)
end

local len=#rewards
widget:SetChildScrollViewInit(0,0.5,true,nil,nil)
widget:SetChildScrollViewDelayCreateGrids(0,len,0,0.02,16,false,false,function(index,item)
local data=rewards[index+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)
widget:SetChildText(3,"完成所有档位可累计获得")
local ratio2=self.const_def.ratio[2]
widget:SetChildText(4,string.format("%d倍",ratio2))
local buyFlag_Recharge=xianmengdigongModel:getPassInvestFlag(XMDG_Pass_Invest_Type.eRecharge)
widget:SetChildActive(1,not buyFlag_Recharge)
if buyFlag_Recharge then
return
end
widget:SetChildButtonClick(1,function()
self:buyPass(2)
end)
end

function UIXM_XMDG_TouziUnLockWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIXM_XMDG_TouziUnLockWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIXM_XMDG_TouziUnLockWin:updateCDTick()
local time=limitActivitiesModel:getActEndLeftTime(LIMIT_ACT_TYPE.eXianMengDiGong)
local rightwidget=self.rightRoot:getChildWidgetBase()
local leftwidget=self.leftRoot:getChildWidgetBase()
rightwidget:SetChildText(6,FMT.fmt("本期剩余时间：{0}",timeHelper.format_time_stamp3(time)))
leftwidget:SetChildText(6,FMT.fmt("本期剩余时间：{0}",timeHelper.format_time_stamp3(time)))
end