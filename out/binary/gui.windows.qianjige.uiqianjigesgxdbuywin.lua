







def_class("UIQianJiGeSGXDBuyWin",UIWindowBase)









function UIQianJiGeSGXDBuyWin:bindComponents()

self.model=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.title=UIText.get(self,2)
self.tipstext=UIText.get(self,3)
self.buyBtn=UIButton.get(self,4)
self.price=UIText.get(self,5)
self.activateRewardsPanel=UIObject.get(self,6)
self.activateRewards=UIObject.get(self,7)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)



end


function UIQianJiGeSGXDBuyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.tipstext);self.tipstext=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.price);self.price=nil;
_UIObject_release(self.activateRewardsPanel);self.activateRewardsPanel=nil;
_UIObject_release(self.activateRewards);self.activateRewards=nil;
end



















function UIQianJiGeSGXDBuyWin:onLoaded(...)
self:bindComponents()
self.model:setChildUIModelShowTarget(4072,1,{},eAnimationID.stand,false,false,0,nil)
end


function UIQianJiGeSGXDBuyWin:__delete()
self:unbindComponents()
end




function UIQianJiGeSGXDBuyWin:onShow(argtable,afterOnloaded)


local baseCfg=cfgHelper.get(cfg_mijingtanxiantouzibaseconfig_get,1)
local jihuo=baseCfg.jihuo
self.jihuo=jihuo
if jihuo[1]==1 then

local rechargeId=jihuo[2]
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
local price=rechargecfg.rmb
if price then
self.price:setText(str)
else
logErr(FMT.fmt("找不到充值id: {0}对应的rmb价格配置",rechargeId))
end
elseif jihuo[1]==2 then
local name=itemsConfig.getItemName(jihuo[2])
self.price:setText(FMT.fmt("{0}{1}",jihuo[3],name))
end

self:initRewardsList()


if self.activateRewardsList and next(self.activateRewardsList)then

self.activateRewardsPanel:setActive(true)

self.activateRewards:setChildLayoutGroupCreateItems(0)
self.activateRewards:setChildLayoutGroupCreateItems(#self.activateRewardsList)
local gridlist=self.activateRewards:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
for i=1,count do
local widget=gridlist[i-1]
local reward=self.activateRewardsList[i]
local itemid=reward[1]
local itemCount=reward[2]
local countStr=''
local showCountBG=false
if itemCount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemCount)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end
else

self.activateRewardsPanel:setActive(false)
end

local endTime=mysteryWeekActivityModel:getXDTouZiMhTimeout()
local time=timeHelper.getServerShortTime()
local left=endTime-time

if endTime>0 then
endTime=timeHelper.convertLongStamp(endTime)
self.tipstext:setText(FMT.fmt("解锁上级密函档位的所有奖励获得权限\n上级密函将在<color=#ca631d>{0}</color>到期(<color=#ca631d>{1}</color>后)",timeHelper.dateServerStamp('%m月%d日',endTime),timeHelper.format_time_stamp7(left)))
else
self.tipstext:setText("解锁上级密函档位的所有奖励获得权限\n上级密函已过期")

end
end

function UIQianJiGeSGXDBuyWin:initRewardsList()

local config=cfg_mijingtanxiantouziconfig()
self.activateRewardsList={}
self.activateRewardsList_lookUp={}
for i=1,#config do
local lCfg=config[i]
if lCfg then
local feeItems=lCfg.feeItems
for _,v in ipairs(feeItems)do
local itemId=v[1]
local itemCount=v[2]

if self.activateRewardsList_lookUp[itemId]then
self.activateRewardsList_lookUp[itemId][2]=self.activateRewardsList_lookUp[itemId][2]+itemCount
else
local item={itemId,itemCount}
self.activateRewardsList_lookUp[itemId]=item
self.activateRewardsList[#self.activateRewardsList+1]=item
end
end
end
end
end
function UIQianJiGeSGXDBuyWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end


function UIQianJiGeSGXDBuyWin:onHide()

end
function UIQianJiGeSGXDBuyWin:onClickClose()
self:closeSelf()
end




function UIQianJiGeSGXDBuyWin:onBuyBtn()
if self.jihuo[1]==1 then
payControl.reqPay(self.jihuo[2])
else
mysteryWeekActivityController.send_4_74()
end
mysteryWeekActivityController.isBuySGXDTouZi=true
self:onClickClose()
end

