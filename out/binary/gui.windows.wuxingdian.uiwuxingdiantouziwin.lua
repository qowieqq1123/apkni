







def_class("UIWuXingDianTouZiWin",UIWindowBase)









function UIWuXingDianTouZiWin:bindComponents()

self.leftRoot=UIObject.get(self,0)
self.rightRoot=UIObject.get(self,1)
self.modelBg=UIObject.get(self,2)
self.root=UIObject.get(self,3)



end


function UIWuXingDianTouZiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.root);self.root=nil;
end


















function UIWuXingDianTouZiWin:onLoaded(...)
self:bindComponents()
self:showWindow('UITopMoneyWin2',{{eMoneyType.mtLingYu}})
self.modelBg:setChildUIModelShowTarget(4883,1,{},5)
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.3,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
end)
end

function UIWuXingDianTouZiWin:__delete()
local widget=self.leftRoot:getChildWidgetBase()
widget:SetChildScrollViewStopGridCreate(0)
local widget=self.rightRoot:getChildWidgetBase()
widget:SetChildScrollViewStopGridCreate(0)
if self.dialog then
self.dialog:hide()
end
self:unbindComponents()
end

function UIWuXingDianTouZiWin:onShow(argtable,afterOnloaded)
local wxdId=argtable.wxdId
self.wxdId=wxdId
self:freshInfo()
end

function UIWuXingDianTouZiWin:onHide()

end


function UIWuXingDianTouZiWin:freshInfo()
local hasTouziMoney=not wuXingDianModel:hasTouziMoney(self.wxdId)
local hasTouziRecharge=not wuXingDianModel:hasTouziRecharge(self.wxdId)
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

function UIWuXingDianTouZiWin:freshLeft()
local wxdId=self.wxdId
local widget=self.leftRoot:getChildWidgetBase()
local data=wuXingDianModel:getData()
local level=data.drop_lv
local prizeList=wuXingDianModel:getPrizeCfgs(wxdId)
local rewards={}
for _,v in ipairs(prizeList)do
local cfg=v
local drop_id=cfg.drop_id
local rewardCfg=itemsAwardConfig:getAwardInConfigByLevel(drop_id,level)
local itemsList=rewardCfg.showItems
rewards=attrListHelper.concatList(rewards,itemsList)
end
local len=#rewards
widget:SetChildScrollViewInit(0,0.5,true,nil,nil)
widget:SetChildScrollViewDelayCreateGrids(0,len,0,0.02,16,false,false,function(index,item)
local data=rewards[index+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)
local isSD=wuXingDianConfig.isSD(wxdId)
local cost
if isSD then
cost=cfgHelper.get2(cfg_fiveelementsholytempleconfig_get,0,'cost_items')
else
cost=cfgHelper.getdef1(cfg_fiveelementstempleconfig,'cost_items')
end
local moneyType=cost[1]
local need=cost[2]
local moneyname=moneyModel.getMoneyName(moneyType)
widget:SetChildButtonClick(1,function()
local func1=function()
local func=function()
local id=2
if wuXingDianConfig.isSD(wxdId)then id=1 end
socketManager:send_25_17(id)
UIManager:closeWindow('UIWuXingDianTouZiWin')
end
moneySystem:useMoney(moneyType,need,func,WARNING_TYPE.eWarning)
end
if isSD then
local leftDay=wuXingDianModel:getCurJieLeftDay()
local str=FMT.fmt('是否花费<color=#ca631d>{0}</color>{1}购买灵玉投资？\n（本期奖励将在<color=#ca631d>{2}</color>天后重置）',need,moneyname,leftDay)
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,str,func1)
else
local str=FMT.fmt('是否花费<color=#ca631d>{0}</color>{1}购买灵玉投资？',need,moneyname)
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,str,func1)
end
end)
local left=''
if isSD then
local leftDay=wuXingDianModel:getCurJieLeftDay()
left=FMT.fmt('本期奖励将在<color=#ca631d>{0}</color>天后重置',leftDay)
end
widget:SetChildText(2,FMT.fmt('{0}{1}',need,moneyname))
widget:SetChildText(3,left)
widget:SetChildActive(5,isSD)
end

function UIWuXingDianTouZiWin:freshRight()
local wxdId=self.wxdId
local widget=self.rightRoot:getChildWidgetBase()
local data=wuXingDianModel:getData()
local level=data.drop_lv
local prizeList=wuXingDianModel:getPrizeCfgs(wxdId)
local rewards={}
for _,v in ipairs(prizeList)do
local cfg=v
local drop_id=cfg.recharge_drop_id
local rewardCfg=itemsAwardConfig:getAwardInConfigByLevel(drop_id,level)
local itemsList=rewardCfg.showItems
rewards=attrListHelper.concatList(rewards,itemsList)
end
local len=#rewards
widget:SetChildScrollViewInit(0,0.5,true,nil,nil)
widget:SetChildScrollViewDelayCreateGrids(0,len,0,0.02,16,false,false,function(index,item)
local data=rewards[index+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)
local titleName=wuXingDianConfig.isSD(wxdId)and'圣殿'or'五行'

local rechargeId=cfg_fiveelementsholytempleconfig_get(0).recharge_id
if not wuXingDianConfig.isSD(wxdId)then
rechargeId=cfgHelper.getdef1(cfg_fiveelementstempleconfig,'recharge_id')
end
local recfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(recfg)

local isSD=wuXingDianConfig.isSD(wxdId)
widget:SetChildButtonClick(1,function()
local func=function()
local id=2
if wuXingDianConfig.isSD(wxdId)then id=1 end
local params=FMT.fmt('{0}',id)
payControl.reqPay(rechargeId,1,params)
UIManager:closeWindow('UIWuXingDianTouZiWin')
end
if isSD then
local leftDay=wuXingDianModel:getCurJieLeftDay()
local str=FMT.fmt('是否花费<color=#ca631d>{0}</color>购买{1}投资？\n（本期奖励将在<color=#ca631d>{2}</color>天后重置）',str,titleName,leftDay)
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,str,func)
else
func()
end
end)
local left=''
if isSD then
local leftDay=wuXingDianModel:getCurJieLeftDay()
left=FMT.fmt('本期奖励将在<color=#ca631d>{0}</color>天后重置',leftDay)
end


widget:SetChildText(2,str)
widget:SetChildText(3,left)
widget:SetChildActive(5,isSD)
widget:SetChildText(6,FMT.fmt('购买{0}投资',titleName))
end
