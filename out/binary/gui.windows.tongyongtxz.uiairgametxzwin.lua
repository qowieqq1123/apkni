







def_class("UIAirGameTXZWin",UIWindowBase)









function UIAirGameTXZWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.currentProgressTx=UIText.get(self,1)
self.modelBg=UIObject.get(self,2)
self.multipleTx_1=UIText.get(self,3)
self.multipleTx_2=UIText.get(self,4)
self.pointActiveList=UIObject.get(self,5)
self.pointBgList=UIObject.get(self,6)
self.progressBarSp=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.tabList=UIObject.get(self,9)
self.touziBtn=UIButton.get(self,10)
self.txzList=UIObject.get(self,11)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.touziBtn:setButtonClick(function()self:onTouziBtn()end)
self.multipleTx={
self.multipleTx_1,
self.multipleTx_2,
}



end


function UIAirGameTXZWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.currentProgressTx);self.currentProgressTx=nil;
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.multipleTx_1);self.multipleTx_1=nil;
_UIObject_release(self.multipleTx_2);self.multipleTx_2=nil;
_UIObject_release(self.pointActiveList);self.pointActiveList=nil;
_UIObject_release(self.pointBgList);self.pointBgList=nil;
_UIObject_release(self.progressBarSp);self.progressBarSp=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.touziBtn);self.touziBtn=nil;
_UIObject_release(self.txzList);self.txzList=nil;
self.multipleTx=nil;
end















local _this=nil
local _tabCmp={
widget=-1,
unactive=0,
normal=1,
selected=2,
name=3,
lock=4,
}
local _itemCmp={
item=0,
reddot=1,
lock=2,
getted=3,
}
local _txzCmp={
freeItem=0,
buyItem=1,
vipItems={2,3},
}






function UIAirGameTXZWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onTYTXZRewardChange,self.onTYTXZRewardChange)
end


function UIAirGameTXZWin:__delete()
self:unbindComponents()
_this=nil
end




function UIAirGameTXZWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc
self:refreshTabList()

local defaultSelect=self:getDefaultSelect()
self:onClickTab(defaultSelect)
end


function UIAirGameTXZWin:onHide()

end




function UIAirGameTXZWin:onCloseBtn()
if self.closeFunc then
self.closeFunc()
elseif self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UIAirGameTXZWin:onTouziBtn()
local buyed_money=UITYTongXingZhengModel:hasTouziMoney(self.txzGuid)
local buyed_recharge=UITYTongXingZhengModel:hasTouziRecharge(self.txzGuid)
if buyed_recharge and buyed_money then
UIManager.info("投资已解锁完成")
return
end

UIManager:showWindow('UITYTongXingZhengTouZiWin',{guid=self.txzGuid,txzId=self.txzId,passportId=txzType.sys})
end

function UIAirGameTXZWin:refreshTabList()
local configs=cfg_airgamepushmapgroupconfig()
self.tabDatas={}
for id,config in ipairs(configs)do
if not config.isShield then
table.insert(self.tabDatas,id)
end
end
local group=airGameEnterModel:getGroup()
local level=airGameEnterModel:getLevel()
self.tabList:setChildLayoutGroupCreateItems(#self.tabDatas,function(index)
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
local id=self.tabDatas[index]
local cfg=cfgHelper.get1(cfg_airgamepushmapgroupconfig_get,id)
local condition=cfg.passport_condition
local lock=condition and(group<condition[1]or(group==condition[1]and level<condition[2]))
local select=index==self.selectTab
item:SetChildActive(_tabCmp.unactive,lock)
item:SetChildActive(_tabCmp.normal,not select)
item:SetChildActive(_tabCmp.selected,select)
item:SetChildText(_tabCmp.name,cfg.name)
item:SetChildActive(_tabCmp.lock,lock)
item:SetChildButtonClick(_tabCmp.widget,function()
self:onClickTab(index)
end)
end)
end

function UIAirGameTXZWin:onClickTab(index)
if self.selectTab~=index then
local group=airGameEnterModel:getGroup()
local level=airGameEnterModel:getLevel()
local condition=cfgHelper.get2(cfg_airgamepushmapgroupconfig_get,index,"passport_condition")
local lock=condition and(group<condition[1]or(group==condition[1]and level<condition[2]))
if lock then
return
end

if self.selectTab then
local item=self.tabList:getChildLayoutGroupGridItem(self.selectTab-1)
item:SetChildActive(_tabCmp.selected,false)
item:SetChildActive(_tabCmp.normal,true)
end
self.selectTab=index
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_tabCmp.selected,true)
item:SetChildActive(_tabCmp.normal,false)

local tabId=self.tabDatas[self.selectTab]
self.txzId=cfgHelper.get2(cfg_airgamepushmapgroupconfig_get,tabId,"passport_id")
self.txzGuid=UITYTongXingZhengModel:getGuidBySysID(txzType.sys,SYSTEM_DEFINE.eAirGame,tabId)

self.txzPrizes=UITYTongXingZhengModel:getPrizeCfgsByIndex(self.txzId)
self:refreshView()
end
end

function UIAirGameTXZWin:refreshView()
local count=#self.txzPrizes
local progress=UITYTongXingZhengModel:getProgress(self.txzGuid)
local last=0
local pLayer=0
local progressSpWidth=0
local percent=0
for id,cfg in ipairs(self.txzPrizes)do
local isFirst=id==1
local spWidth=isFirst and 50 or 110
if progress>=cfg.layer then
pLayer=cfg.layer
last=id
progressSpWidth=progressSpWidth+spWidth
else
progressSpWidth=progressSpWidth+(progress-pLayer)/(cfg.layer-pLayer)*spWidth
break
end
end
local listWidth=count>0 and(count*110-2)or 10
local maxOffset=math.min(0,622-listWidth)
local listX=Mathf.Clamp((last-4)*-110+7,maxOffset,0)

self.txzList:setChildAnchoredPos(listX,0)
self.txzList:setChildLayoutGroupCreateItems(count,function(index)
local item=self.txzList:getChildLayoutGroupGridItem(index-1)
local cfg=self.txzPrizes[index]
self:refreshTXZItem(item,cfg,index)
end)


self.progressBarSp:setChildSizeDelta(progressSpWidth,4)
self.pointBgList:setChildLayoutGroupCreateItems(count,function(index)
local _item=self.pointBgList:getChildLayoutGroupGridItem(index-1)
local _cfg=self.txzPrizes[index]
_item:SetChildText(0,FMT.fmt("第{0}关",_cfg.layer))
end)
self.pointActiveList:setChildLayoutGroupCreateItems(last)
self.currentProgressTx:setText(FMT.fmt("当前{0}关",progress))

local multiple_text=cfgHelper.get2(cfg_passportconfig_get,self.txzId,"multiple_text")
for i,v in ipairs(self.multipleTx)do
local text=multiple_text[i]
local str=text and FMT.fmt("{0}收获",text)or""
v:setText(str)
end
end

function UIAirGameTXZWin:refreshTXZItem(cell,cfg,dataIndex)
local layer=cfg.layer
local freeItem=cell:GetChildWidgetBase(_txzCmp.freeItem)
local getted_free=UITYTongXingZhengModel:isFreePrize(self.txzGuid,dataIndex)
local can_free=UITYTongXingZhengModel:canFreePrize(self.txzGuid,layer,dataIndex)
local reddot_free=not getted_free and can_free
local lock_free=false
local tick_free=getted_free
self:refreshItem(freeItem,cfg.freeReward[1],reddot_free,lock_free,tick_free)

local monyeItem=cell:GetChildWidgetBase(_txzCmp.buyItem)
local getted_money=UITYTongXingZhengModel:isMoneyPrize(self.txzGuid,dataIndex)
local can_money=UITYTongXingZhengModel:canMoneyPrize(self.txzGuid,layer,dataIndex)
local buyed_money=UITYTongXingZhengModel:hasTouziMoney(self.txzGuid)
local reddot_money=buyed_money and not getted_money and can_money
local lock_money=not buyed_money
local tick_money=buyed_money and getted_money
self:refreshItem(monyeItem,cfg.lock1Reward[1],reddot_money,lock_money,tick_money)

local getted_recharge=UITYTongXingZhengModel:isRechargePrize(self.txzGuid,dataIndex)
local can_recharge=UITYTongXingZhengModel:canRechargePrize(self.txzGuid,layer,dataIndex)
local buyed_recharge=UITYTongXingZhengModel:hasTouziRecharge(self.txzGuid)
local reddot_recharge=buyed_recharge and not getted_recharge and can_recharge
local lock_recharge=not buyed_recharge
local tick_recharge=buyed_recharge and getted_recharge
for i,v in ipairs(_txzCmp.vipItems)do
local vipItem=cell:GetChildWidgetBase(v)
self:refreshItem(vipItem,cfg.lock2Reward[i],reddot_recharge,lock_recharge,tick_recharge)
end
end

function UIAirGameTXZWin:refreshItem(item,data,reddot,lock,getted)
item:SetChildActive(_itemCmp.item,data~=nil)
if data then
local itemId=data[1]
local itemNum=data[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(itemConf)
item:SetChildPropData(_itemCmp.item,prop)
item:SetBaseItemClickEvent(_itemCmp.item,function(...)
if reddot then
local idx=UITYTongXingZhengModel:getMaxPizeLayer(self.txzGuid)
socketManager:send_29_12(self.txzGuid,idx)
else
itemsComponentHelper.onItemClickEx(...)
end
end)
item:SetChildActive(_itemCmp.reddot,reddot)
item:SetChildActive(_itemCmp.lock,lock)
item:SetChildActive(_itemCmp.getted,getted)
end
end

function UIAirGameTXZWin.onTYTXZRewardChange(txzGuid)
if mathHelper.compareInt64(txzGuid,_this.txzGuid)then
local items=_this.txzList:getChildLayoutGroupGridList()
for index=1,items.Count do
local item=items[index-1]
local cfg=_this.txzPrizes[index]
_this:refreshTXZItem(item,cfg,index)
end
end
end

function UIAirGameTXZWin:getDefaultSelect()
local group=airGameEnterModel:getGroup()
local level=airGameEnterModel:getLevel()
local max=1
for index=#self.tabDatas,1,-1 do
local id=self.tabDatas[index]
local cfg=cfgHelper.get1(cfg_airgamepushmapgroupconfig_get,id)
local condition=cfg.passport_condition
local lock=condition and(group<condition[1]or(group==condition[1]and level<condition[2]))
if not lock then
max=math.max(max,index)
local txzId=cfg.passport_id
local prizes=UITYTongXingZhengModel:getPrizeCfgsByIndex(txzId)
local txzGuid=UITYTongXingZhengModel:getGuidBySysID(txzType.sys,SYSTEM_DEFINE.eAirGame,id)
for dataIndex,cfg in ipairs(prizes)do
local getted_free=UITYTongXingZhengModel:isFreePrize(txzGuid,dataIndex)
local can_free=UITYTongXingZhengModel:canFreePrize(txzGuid,cfg.layer,dataIndex)
if not getted_free and can_free then
return index
end

local getted_money=UITYTongXingZhengModel:isMoneyPrize(txzGuid,dataIndex)
local can_money=UITYTongXingZhengModel:canMoneyPrize(txzGuid,cfg.layer,dataIndex)
local buyed_money=UITYTongXingZhengModel:hasTouziMoney(txzGuid)
if buyed_money and not getted_money and can_money then
return index
end

local getted_recharge=UITYTongXingZhengModel:isRechargePrize(txzGuid,dataIndex)
local can_recharge=UITYTongXingZhengModel:canRechargePrize(txzGuid,cfg.layer,dataIndex)
local buyed_recharge=UITYTongXingZhengModel:hasTouziRecharge(txzGuid)
if buyed_recharge and not getted_recharge and can_recharge then
return index
end
end
end
end
return max
end