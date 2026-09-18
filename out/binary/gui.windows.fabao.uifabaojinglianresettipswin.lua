







def_class("UIFabaoJingLianResetTipsWin",UIWindowBase)









function UIFabaoJingLianResetTipsWin:bindComponents()

self.activeText=UIText.get(self,0)
self.Content=UIObject.get(self,1)
self.costCount=UIText.get(self,2)
self.costIcon=UIObject.get(self,3)
self.desc=UIText.get(self,4)
self.FanZhuButton=UIButton.get(self,5)
self.gou=UIObject.get(self,6)
self.ScrollView=UIObject.get(self,7)
self.YueKaButton=UIButton.get(self,8)

self.FanZhuButton:setButtonClick(function()self:onFanZhuButton()end)

self.YueKaButton:setButtonClick(function()self:onYueKaButton()end)



end


function UIFabaoJingLianResetTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.activeText);self.activeText=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.costCount);self.costCount=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.FanZhuButton);self.FanZhuButton=nil;
_UIObject_release(self.gou);self.gou=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.YueKaButton);self.YueKaButton=nil;
end
















local _this=nil




function UIFabaoJingLianResetTipsWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)
end


function UIFabaoJingLianResetTipsWin:__delete()
self:unbindComponents()
_this=nil
end

function UIFabaoJingLianResetTipsWin:onMoneyChanged(moneyType)
local cost=fabaoConfig.getJilianResetCost()
local itemid=cost[1][1]
if moneyType==itemid then
self:freshCost()
end
end




function UIFabaoJingLianResetTipsWin:onShow(argtable,afterOnloaded)
if argtable then
local itemguid=argtable.itemguid
self.equip=fabaoHelper.getFabao(itemguid)
self.isEquip=fabaoModel.isEquipedOnAnyDizi(itemguid)
end
self:freshInfo()
self:freshDesc()
self:freshCost()
end

function UIFabaoJingLianResetTipsWin:freshCost()
local cost=fabaoConfig.getJilianResetCost()
local itemid=cost[1][1]
local itemnum=cost[1][2]
local iconname=iconHelper.getIconName(itemid)

self.costIcon:setIcon(iconname)

local enough=moneyModel.checkEnoughMoney(itemid,itemnum)
if enough then
self.costCount:setText(itemnum)
else
self.costCount:setText(FMT.cfmt(FONT_COLOR.eRedColor,itemnum))
end
end

function UIFabaoJingLianResetTipsWin:freshDesc()

local isActive=false
local monthInvestorCfg=cfg_yuekaconfig()
if monthInvestorCfg[2]then
local highMonthCfg=monthInvestorCfg[2]
isActive=rechargeModel:checkCardActive(highMonthCfg.id)
end

local jlRatio=100
if not isActive then
jlRatio=fabaoConfig.getJilianLeftExpRatio()*100
end

self.desc:setText(FMT.fmt(cfgHelper.getlang('fabao_jinglian_reset_1'),jlRatio))
if isActive then
self.activeText:setText('<color=#549327>尊贵股东可100%返还精炼值（已激活）</color>')
else
self.activeText:setText('<color=#65615f>尊贵股东可100%返还精炼值（未激活）</color>')
end
self.gou:setActive(isActive)
end


function UIFabaoJingLianResetTipsWin:freshInfo()
local equip=self.equip
local itemguid=equip.itemguid
local item=itemsModel.getItem(itemguid)
local items=fabaoHelper.returnJilianResetItems(item)
self.tempRewardlist={}
if items then
for i,v in ipairs(items)do
local itemid=v[1]
local num=v[2]or 0
if itemid~=eMoneyType.mtLingShi then
showPrizeControl.insertTemp(self.tempRewardlist,nil,itemid,num)
end
end
table.sort(self.tempRewardlist,function(a,b)
return a.sortWeight>b.sortWeight
end)

local propData={}
for i,v in ipairs(self.tempRewardlist)do
local num=v.num
table.insert(propData,itemsComponentHelper.getCommonFillData({itemid=v.itemid,itemcount=num},{showname=false,showcount=num>1,showCountBG=num>1,showStageBg=true}))
end

local propDataCnt=#propData
if propDataCnt>0 then
self.gridAnim=true
end
self.propData=propData
local cnt=propDataCnt

self.ScrollView:setChildScrollViewDelayCreateGrids(propDataCnt,12,0.1,1,false,false,function(id,item)
if id+1>=propDataCnt then
self.gridAnim=nil
end
self:refreshItem(id,item,propData)
end)

if cnt<=6 then
self.winlua:SetChildSizeDelta(self.Content:getID(),cnt*90-8,82)
self.Content:setAnchors(0.5,0.5,0.5,0.5)
else
self.winlua:SetChildSizeDelta(self.Content:getID(),532,172)
end
end
end

function UIFabaoJingLianResetTipsWin:refreshItem(id,item,propData)
item:SetChildPropData(0,propData[id+1])
item:SetChildCanvasGroupDOFade(1,1,0.1)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end


function UIFabaoJingLianResetTipsWin:onHide()

end





function UIFabaoJingLianResetTipsWin:onFanZhuButton()
local equip=self.equip
local itemguid=equip.itemguid
local cost=fabaoConfig.getJilianResetCost()
local itemid=cost[1][1]
local itemnum=cost[1][2]

local callback=function()
local str=FMT.fmt('是否将法宝<color=#d4852e>{0}</color>的精炼等级和精炼属性重置为<color=#d4852e>0级</color>？',fabaoHelper.getFabaoName(equip))
local showdata=
{
type='UIDialouge',
title='提示',
content=str,
oktext='确认',
canceltext='取消',
allowclickBG=false,
okcallback=function(...)
local selectGUIDList={}
table.insert(selectGUIDList,itemguid)
if _this.isEquip then
local guid=fabaoModel.getDiziguidByItemguid(itemguid)
fabaoProtocolControl.reqFabaoJiLianReset(guid,1)
else
fabaoProtocolControl.reqFabaoJiLianReset(itemguid,0)
end

showPrizeControl.showWindow(_this.tempRewardlist)

_this:closeSelf()
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end
moneySystem:useMoney(itemid,itemnum,callback,WARNING_TYPE.eWarning)
end



function UIFabaoJingLianResetTipsWin:onYueKaButton()

self:closeSelf()
jumpManager:jump({id=JUMP_TYPE.eReCharge,args={tabType=FULL_TAB_TYPE.eMonthInvestor}})
end

function UIFabaoJingLianResetTipsWin:onCloseButton()
self:closeSelf()
end
