







def_class("UIFabaoBenMingFanZhuTips",UIWindowBase)









function UIFabaoBenMingFanZhuTips:bindComponents()

self.desc=UIText.get(self,0)
self.FanZhuButton=UIButton.get(self,1)
self.YueKaButton=UIButton.get(self,2)
self.activeText=UIText.get(self,3)
self.Content=UIObject.get(self,4)
self.ScrollView=UIObject.get(self,5)
self.gou=UIObject.get(self,6)

self.FanZhuButton:setButtonClick(function()self:onFanZhuButton()end)

self.YueKaButton:setButtonClick(function()self:onYueKaButton()end)



end


function UIFabaoBenMingFanZhuTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.FanZhuButton);self.FanZhuButton=nil;
_UIObject_release(self.YueKaButton);self.YueKaButton=nil;
_UIObject_release(self.activeText);self.activeText=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.gou);self.gou=nil;
end


















local _this=nil


function UIFabaoBenMingFanZhuTips:onLoaded(...)
self:bindComponents()
end


function UIFabaoBenMingFanZhuTips:__delete()
self:unbindComponents()
end




function UIFabaoBenMingFanZhuTips:onShow(argtable,afterOnloaded)
_this=self
if argtable then
local itemguid=argtable.itemguid
self.equip=fabaoHelper.getFabao(itemguid)
end
self:freshInfo()
self:freshDesc()
end

function UIFabaoBenMingFanZhuTips:freshDesc()

local isActive=false
local monthInvestorCfg=cfg_yuekaconfig()
if monthInvestorCfg[2]then
local highMonthCfg=monthInvestorCfg[2]
isActive=rechargeModel:checkCardActive(highMonthCfg.id)
end

local cfg=cfgHelper.get(cfg_bagualuaconfig_get,1,"bmfabao")
local jlRatio=100
local lxRatio=100
if not isActive and cfg[2]then
jlRatio=fabaoConfig.getJilianLeftExpRatio()*100
lxRatio=cfg[1][1]*100
end

self.desc:setText(FMT.fmt(cfgHelper.getlang('fabao_bm_fanzhu_1'),jlRatio,lxRatio))
if isActive then
self.activeText:setText('<color=#549327>尊贵股东可100%返还精炼值、蕴养灵性值和灵石（已激活）</color>')
else
self.activeText:setText('<color=#65615f>尊贵股东可100%返还精炼值、蕴养灵性值和灵石（未激活）</color>')
end
self.gou:setActive(isActive)
end


function UIFabaoBenMingFanZhuTips:freshInfo()
local equip=self.equip
local itemguid=equip.itemguid
local item=itemsModel.getItem(itemguid)
local items=fabaoHelper.returnRonglianItems_FaBaoBenMing(item)
self.tempRewardlist={}
if items then
for i,v in ipairs(items)do
local itemid=v[1]
local num=v[2]or 0
showPrizeControl.insertTemp(self.tempRewardlist,nil,itemid,num)
end
table.sort(self.tempRewardlist,function(a,b)
return a.sortWeight>b.sortWeight
end)

local propData={}
for i,v in ipairs(self.tempRewardlist)do
local itemid=v.itemid
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

function UIFabaoBenMingFanZhuTips:refreshItem(id,item,propData)
item:SetChildPropData(0,propData[id+1])
item:SetChildCanvasGroupDOFade(1,1,0.1)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end


function UIFabaoBenMingFanZhuTips:onHide()

end





function UIFabaoBenMingFanZhuTips:onFanZhuButton()
local equip=self.equip
local itemguid=equip.itemguid
local diziguid=fabaoModel.getDiziguidByItemguid(itemguid)

local str=FMT.fmt('是否确认分解本命法宝<color=#d4852e>{0}</color>？',fabaoHelper.getFabaoName(equip))
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
local len=#selectGUIDList

if diziguid then
fabaoProtocolControl.reqTakeoffFabao(diziguid)
end
UIFullBaGuaLuControl:send_3_241(len,selectGUIDList)

showPrizeControl.showWindow(_this.tempRewardlist)

local win=UIManager:findActiveWindow("UIBackgroundComponent")
if win then
win:onCloseButton()
end
_this:closeSelf()
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end



function UIFabaoBenMingFanZhuTips:onYueKaButton()

self:closeSelf()
jumpManager:jump({id=JUMP_TYPE.eReCharge,args={tabType=FULL_TAB_TYPE.eMonthInvestor}})
end

function UIFabaoBenMingFanZhuTips:onCloseButton()
self:closeSelf()
end
