







def_class("UIXM_ZZSH_TouziUnLockWin",UIWindowBase)









function UIXM_ZZSH_TouziUnLockWin:bindComponents()

self.leftRoot=UIObject.get(self,0)
self.rightRoot=UIObject.get(self,1)
self.modelBg=UIObject.get(self,2)
self.root=UIObject.get(self,3)



end


function UIXM_ZZSH_TouziUnLockWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.root);self.root=nil;
end




















function UIXM_ZZSH_TouziUnLockWin:onLoaded(...)
self:bindComponents()
self:showWindow('UITopMoneyWin2',{{eMoneyType.mtLingYu},{eMoneyType.mtXianYu}})
end

function UIXM_ZZSH_TouziUnLockWin:__delete()
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

function UIXM_ZZSH_TouziUnLockWin:onShow(argtable,afterOnloaded)
self.modelBg:setChildUIModelShowTarget(4883,1,{},5)
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.3,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
end)

self.cfg=zhengzhanshanhaiModel:getZhanLingConfig()
self.const_def=zhengzhanshanhaiModel:getZhanLingConfig_const_def()

self:freshInfo()
end

function UIXM_ZZSH_TouziUnLockWin:onHide()

end


function UIXM_ZZSH_TouziUnLockWin:freshInfo()
local buyFlag_Money=zhengzhanshanhaiModel:getZhanLingData_buyFlag_Money()
local buyFlag_Recharge=zhengzhanshanhaiModel:getZhanLingData_buyFlag_Recharge()
local hasTouziMoney=buyFlag_Money==0
local hasTouziRecharge=buyFlag_Recharge==0
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

function UIXM_ZZSH_TouziUnLockWin:freshLeft()

local widget=self.leftRoot:getChildWidgetBase()
local rewards={}
for k,v in ipairs(self.cfg)do
for k1,v1 in ipairs(v.money_rewards[1])do

local flag=true
for k2,v2 in ipairs(rewards)do
if v2[1]==v1[1]then
rewards[k2][2]=v1[2]+v2[2]
flag=false
break
end

end
if flag then
local data={}
data[1]=v1[1]
data[2]=v1[2]
data.showStage=true
rewards[#rewards+1]=data
end
end
end
local buy_cost=self.const_def.buy_cost
local buyCfg=buy_cost[1]
local moneyType=buyCfg[1]
local need=buyCfg[2]
local moneyname=moneyModel.getMoneyName(moneyType)
widget:SetChildText(2,FMT.fmt("{0}{1}",need,moneyname))
table.sort(rewards,function(a,b)
local itemID_a=a[1]
local itemID_b=b[1]
local itemCfg_a=itemsConfig.getConfig(itemID_a)
local itemCfg_b=itemsConfig.getConfig(itemID_b)
return itemCfg_a.color>itemCfg_b.color
end)
local len=#rewards
widget:SetChildScrollViewInit(0,0.5,true,nil,nil)
widget:SetChildScrollViewDelayCreateGrids(0,len,0,0.02,16,false,false,function(index,item)
local data=rewards[index+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)
local buyFlag_Money=zhengzhanshanhaiModel:getZhanLingData_buyFlag_Money()
widget:SetChildActive(1,buyFlag_Money==0)
widget:SetChildText(3,"完成所有档位可累计获得")

if buyFlag_Money==1 then
return
end
widget:SetChildButtonClick(1,function()
local moneyType=buyCfg[1]
local need=buyCfg[2]
local moneyname=moneyModel.getMoneyName(moneyType)
local func1=function()
local func=function()
local pVEState=zhengzhanshanhaiController.checkPVEState()
if not pVEState then
return
end
zhengzhanshanhaiController.req_buyZZSHZhanLingWithMoney()
UIManager:closeWindow('UIXM_ZZSH_TouziUnLockWin')
end
moneySystem:useMoney(moneyType,need,func,WARNING_TYPE.eWarning)
end
local str=FMT.fmt('是否花费<color=#ca631d>{0}</color>{1}购买{1}投资？',need,moneyname,moneyname)
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,str,func1)






end)
end

function UIXM_ZZSH_TouziUnLockWin:freshRight()
local widget=self.rightRoot:getChildWidgetBase()
local rewards={}
for k,v in ipairs(self.cfg)do
for k1,v1 in ipairs(v.rmb_rewards[1])do

local flag=true
for k2,v2 in ipairs(rewards)do
if v2[1]==v1[1]then
rewards[k2][2]=v1[2]+v2[2]
flag=false
break
end

end
if flag then
local data={}
data[1]=v1[1]
data[2]=v1[2]
data.showStage=true
rewards[#rewards+1]=data
end
end
end


local recharge_id=self.const_def.recharge_id

local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,recharge_id)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
widget:SetChildText(2,str)
table.sort(rewards,function(a,b)
local itemID_a=a[1]
local itemID_b=b[1]
local itemCfg_a=itemsConfig.getConfig(itemID_a)
local itemCfg_b=itemsConfig.getConfig(itemID_b)
return itemCfg_a.color>itemCfg_b.color
end)
local len=#rewards
widget:SetChildScrollViewInit(0,0.5,true,nil,nil)
widget:SetChildScrollViewDelayCreateGrids(0,len,0,0.02,16,false,false,function(index,item)
local data=rewards[index+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)
widget:SetChildText(3,"完成所有档位可累计获得")
local buyFlag_Recharge=zhengzhanshanhaiModel:getZhanLingData_buyFlag_Recharge()
widget:SetChildActive(1,buyFlag_Recharge==0)
if buyFlag_Recharge==1 then
return
end
widget:SetChildButtonClick(1,function()
local func=function()
local pVEState=zhengzhanshanhaiController.checkPVEState()
if not pVEState then
return
end
payControl.reqPay(recharge_id)
UIManager:closeWindow('UIXM_ZZSH_TouziUnLockWin')
end
local str=FMT.fmt('是否花费<color=#ca631d>{0}</color>购买直购投资？',str)
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,str,func)
end)
end


function UIXM_ZZSH_TouziUnLockWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIXM_ZZSH_TouziUnLockWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIXM_ZZSH_TouziUnLockWin:updateCDTick()
local pVEState,time=zhengzhanshanhaiController.checkPVEState()
if pVEState then
local rightwidget=self.rightRoot:getChildWidgetBase()
local leftwidget=self.leftRoot:getChildWidgetBase()
rightwidget:SetChildText(6,FMT.fmt("本期剩余时间：{0}",timeHelper.format_time_stamp3(time)))
leftwidget:SetChildText(6,FMT.fmt("本期剩余时间：{0}",timeHelper.format_time_stamp3(time)))
end
end