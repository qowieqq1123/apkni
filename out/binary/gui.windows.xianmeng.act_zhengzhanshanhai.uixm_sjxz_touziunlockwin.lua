







def_class("UIXM_SJXZ_TouziUnLockWin",UIWindowBase)









function UIXM_SJXZ_TouziUnLockWin:bindComponents()

self.leftRoot=UIObject.get(self,0)
self.rightRoot=UIObject.get(self,1)
self.modelBg=UIObject.get(self,2)
self.root=UIObject.get(self,3)



end


function UIXM_SJXZ_TouziUnLockWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.root);self.root=nil;
end















local BuyType={
eItem=1,
eRmb=2,
}



function UIXM_SJXZ_TouziUnLockWin:onLoaded(...)
self:bindComponents()
self.rightwidget=self.rightRoot:getChildWidgetBase()
self.leftwidget=self.leftRoot:getChildWidgetBase()
self:initCfg()
self.leftwidget:SetChildButtonClick(1,function()
self:onClickBuy(PASS_Reward_Type.eReward1)
end)
self.rightwidget:SetChildButtonClick(1,function()
self:onClickBuy(PASS_Reward_Type.eReward2)
end)

self:showWindow('UITopMoneyWin2',{{eMoneyType.mtLingYu},{eMoneyType.mtXianYu}})
end


function UIXM_SJXZ_TouziUnLockWin:__delete()
self:stopCDTick()
self.leftwidget:SetChildScrollViewStopGridCreate(0)
self.rightwidget:SetChildScrollViewStopGridCreate(0)
self.rightwidget=nil
self.leftwidget=nil
if self.dialog then
self.dialog:hide()
end
self:unbindComponents()
end




function UIXM_SJXZ_TouziUnLockWin:onShow(argtable,afterOnloaded)
self.modelBg:setChildUIModelShowTarget(4883,1,{},5)
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.3,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
end)
self:freshInfo()
self:startCDTick()
end


function UIXM_SJXZ_TouziUnLockWin:onHide()

end

function UIXM_SJXZ_TouziUnLockWin:initCfg()
local passport_id=zhengzhanshanhaiModel:getPassData_passport_id()
local passCfg=cfgHelper.get(cfg_zhengzhanshanhaipassportconfig_get,passport_id)
if passCfg.cost_money_1 and passCfg.recharge_id_1 then
logErr("配置错误 同时配置了货币购买奖励1和充值购买奖励1")
return
end
self.buyTypeList={}
if passCfg.cost_money_1 then
self.buyTypeList[PASS_Reward_Type.eReward1]={type=BuyType.eItem,buyCfg=passCfg.cost_money_1}
else
self.buyTypeList[PASS_Reward_Type.eReward1]={type=BuyType.eRmb,buyCfg=passCfg.recharge_id_1}
end
self.buyTypeList[PASS_Reward_Type.eReward1].obj=self.leftRoot
self.buyTypeList[PASS_Reward_Type.eReward1].widget=self.leftwidget
self.buyTypeList[PASS_Reward_Type.eReward1].beishu=passCfg.rewards_1_beishu
local lookup={}
local rewards1={}
for level,itemList in pairs(passCfg.rewards_1)do
for i,itemCfg in ipairs(itemList)do
if lookup[itemCfg[1]]then
lookup[itemCfg[1]]=lookup[itemCfg[1]]+itemCfg[2]
else
lookup[itemCfg[1]]=itemCfg[2]
end
end
end
for itemid,cnt in pairs(lookup)do
local color=itemsConfig.getItemColor(itemid)
table.insert(rewards1,{itemid,cnt,color,showStage=true})
end
table.sort(rewards1,function(a,b)
return a[3]>b[3]
end)
self.buyTypeList[PASS_Reward_Type.eReward1].rewards=rewards1
if passCfg.cost_money_2 and passCfg.recharge_id_2 then
logErr("配置错误 同时配置了货币购买奖励2和充值购买奖励2")
return
end
if passCfg.cost_money_2 then
self.buyTypeList[PASS_Reward_Type.eReward2]={type=BuyType.eItem,buyCfg=passCfg.cost_money_2}
else
self.buyTypeList[PASS_Reward_Type.eReward2]={type=BuyType.eRmb,buyCfg=passCfg.recharge_id_2}
end
self.buyTypeList[PASS_Reward_Type.eReward2].obj=self.rightRoot
self.buyTypeList[PASS_Reward_Type.eReward2].widget=self.rightwidget
self.buyTypeList[PASS_Reward_Type.eReward2].beishu=passCfg.rewards_2_beishu
lookup={}
local rewards2={}
for level,itemList in pairs(passCfg.rewards_2)do
for i,itemCfg in ipairs(itemList)do
if lookup[itemCfg[1]]then
lookup[itemCfg[1]]=lookup[itemCfg[1]]+itemCfg[2]
else
lookup[itemCfg[1]]=itemCfg[2]
end
end
end
for itemid,cnt in pairs(lookup)do
local color=itemsConfig.getItemColor(itemid)
table.insert(rewards2,{itemid,cnt,color,showStage=true})
end
table.sort(rewards2,function(a,b)
return a[3]>b[3]
end)
self.buyTypeList[PASS_Reward_Type.eReward2].rewards=rewards2

self.passCfg=passCfg
end

function UIXM_SJXZ_TouziUnLockWin:checkTime(isWring)
local startTime,endTime,settleTime,settleEndTime=zhengzhanshanhaiModel:getSeasonTime()
local curTime=timeHelper.getServerLongTime()
local lerp=settleEndTime-curTime
if lerp<0 then
if isWring then
UIManager.info("本期已结束")
end
return false
end
return true
end

function UIXM_SJXZ_TouziUnLockWin:freshInfo()

local hasReward1=false
local hasReward2=false
for rw_type,v in pairs(self.buyTypeList)do
local buyFlag=zhengzhanshanhaiModel:getPassData_rewardBuyFlag(rw_type)
v.obj:setActive(not buyFlag)
if not buyFlag then
self:freshWidget(v,rw_type)
end
if not buyFlag and rw_type==PASS_Reward_Type.eReward1 then
hasReward1=true
elseif not buyFlag and rw_type==PASS_Reward_Type.eReward2 then
hasReward2=true
end
end

if hasReward1 and hasReward2 then

elseif hasReward2 then
self.rightRoot:setChildAnchoredPosition(Vector2.New(0,33.6))
else
self.leftRoot:setChildAnchoredPosition(Vector2.New(0,33.6))
end
end


function UIXM_SJXZ_TouziUnLockWin:freshWidget(temp,rw_type)
local widget=temp.widget

widget:SetChildText(4,FMT.fmt("{0}倍",temp.beishu))
widget:SetChildText(5,"完成所有档位可累计获得")
local buyFlag=zhengzhanshanhaiModel:getPassData_rewardBuyFlag(rw_type)
widget:SetChildActive(1,not buyFlag)
local buyType=temp.type
local buyCfg=temp.buyCfg
if not buyFlag then
local str
if buyType==BuyType.eItem then
local moneyType=buyCfg[1][1]
local need=buyCfg[1][2]
local moneyname=moneyModel.getMoneyName(moneyType)
str=FMT.fmt("{0}{1}",need,moneyname)
elseif buyType==BuyType.eRmb then
local recharge_id=buyCfg
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,recharge_id)
str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
end
widget:SetChildText(2,str)
end
local rewards=temp.rewards
local len=#rewards
widget:SetChildScrollViewInit(0,0.5,true,nil,nil)
widget:SetChildScrollViewDelayCreateGrids(0,len,0,0.02,16,false,false,function(index,item)
local data=rewards[index+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)
end


function UIXM_SJXZ_TouziUnLockWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIXM_SJXZ_TouziUnLockWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIXM_SJXZ_TouziUnLockWin:updateCDTick()
local startTime,endTime,settleTime,settleEndTime=zhengzhanshanhaiModel:getSeasonTime()
local curTime=timeHelper.getServerLongTime()
local lerp=settleTime-curTime
local lerpEx=settleEndTime-curTime
if lerp>=0 then
self.rightwidget:SetChildText(3,FMT.fmt("本期剩余时间：<color=#CA631D>{0}</color>",timeHelper.format_time_stamp3(lerp,true)))
self.leftwidget:SetChildText(3,FMT.fmt("本期剩余时间：<color=#CA631D>{0}</color>",timeHelper.format_time_stamp3(lerp,true)))
elseif lerpEx>=0 then
self.rightwidget:SetChildText(3,FMT.fmt("关闭剩余时间：<color=#CA631D>{0}</color>",timeHelper.format_time_stamp3(lerpEx,true)))
self.leftwidget:SetChildText(3,FMT.fmt("关闭剩余时间：<color=#CA631D>{0}</color>",timeHelper.format_time_stamp3(lerpEx,true)))
else
self.rightwidget:SetChildText(3,"本期已结束")
self.leftwidget:SetChildText(3,"本期已结束")
end
end
function UIXM_SJXZ_TouziUnLockWin:onClickBuy(rw_type)
local buyType=self.buyTypeList[rw_type].type
local buyCfg=self.buyTypeList[rw_type].buyCfg
local func=function()
if not self:checkTime(true)then
return
end
if buyType==BuyType.eItem then
local moneyType=buyCfg[1][1]
local need=buyCfg[1][2]
local moneyname=moneyModel.getMoneyName(moneyType)
local func1=function()
if not self:checkTime(true)then
return
end
zhengzhanshanhaiController.req_44_14(rw_type)
UIManager:closeWindow('UIXM_SJXZ_TouziUnLockWin')
end
moneySystem:useMoney(moneyType,need,func1,WARNING_TYPE.eWarning)
elseif buyType==BuyType.eRmb then
local recharge_id=buyCfg
payControl.reqPay(recharge_id)
UIManager:closeWindow('UIXM_SJXZ_TouziUnLockWin')
end
end
local str
if buyType==BuyType.eItem then
local moneyType=buyCfg[1][1]
local need=buyCfg[1][2]
local moneyname=moneyModel.getMoneyName(moneyType)
str=FMT.fmt('是否花费<color=#ca631d>{0}</color>{1}购买{2}投资？',need,moneyname,moneyname)
elseif buyType==BuyType.eRmb then
local recharge_id=buyCfg
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,recharge_id)
str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
str=FMT.fmt('是否花费<color=#ca631d>{0}</color>购买直购投资？',str)
end
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,str,func)
end



