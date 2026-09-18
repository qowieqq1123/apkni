







def_class("UIHuiYingCangXiRepairWin",UIWindowBase)









function UIHuiYingCangXiRepairWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.fixGridPanel=UIObject.get(self,1)
self.fixScrollView=UIObject.get(self,2)
self.iconImg=UIImage.get(self,3)
self.lockItem_1=UIObject.get(self,4)
self.lockItem_2=UIObject.get(self,5)
self.lockItem_3=UIObject.get(self,6)
self.lockItem_4=UIObject.get(self,7)
self.lockItem_5=UIObject.get(self,8)
self.lockItem_6=UIObject.get(self,9)
self.mbg=UIObject.get(self,10)
self.mbg2=UIObject.get(self,11)
self.root=UIObject.get(self,12)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.lockItem={
self.lockItem_1,
self.lockItem_2,
self.lockItem_3,
self.lockItem_4,
self.lockItem_5,
self.lockItem_6,
}



end


function UIHuiYingCangXiRepairWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.fixGridPanel);self.fixGridPanel=nil;
_UIObject_release(self.fixScrollView);self.fixScrollView=nil;
_UIObject_release(self.iconImg);self.iconImg=nil;
_UIObject_release(self.lockItem_1);self.lockItem_1=nil;
_UIObject_release(self.lockItem_2);self.lockItem_2=nil;
_UIObject_release(self.lockItem_3);self.lockItem_3=nil;
_UIObject_release(self.lockItem_4);self.lockItem_4=nil;
_UIObject_release(self.lockItem_5);self.lockItem_5=nil;
_UIObject_release(self.lockItem_6);self.lockItem_6=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.mbg2);self.mbg2=nil;
_UIObject_release(self.root);self.root=nil;
self.lockItem=nil;
end
















local _this




function UIHuiYingCangXiRepairWin:onLoaded(...)
self:bindComponents()
self.selectTw={}
_this=self
end


function UIHuiYingCangXiRepairWin:__delete()
self:unbindComponents()
self:clearSelectTw()
_this=nil
end




function UIHuiYingCangXiRepairWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

self.info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self.baseCfg=self.info:getMuralFixBaseConfig()
self.selectIdxLookup={}

self:refreshView()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg2:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(6396,1,nil,eAnimationID.enter)
self.mbg2:setChildUIModelShowTarget(6395,1,nil,eAnimationID.enter)
self:delayDo(0.6,function()
if not _this then return end
return _this.root:setChildCanvasGroupDOFade(1,0.5)
end)
end
end


function UIHuiYingCangXiRepairWin:onHide()

end

function UIHuiYingCangXiRepairWin:refreshView(flag)
self:refreshLeft(flag)
self:refreshRight()
end

function UIHuiYingCangXiRepairWin:refreshLeft(flag)
if flag then
self:clearSelectTw()
end

local dissovleFunc=function(widget,i)
local ablation_effect_duration=4
_this.selectTw[i]=_DOTweenProxy.DoValueTo(
function()
return _this.tweenerVal or 0
end,
function(val)
_this.tweenerVal=val
widget:SetChildWidgetMaterialFloat(-1,'_DissovleProgress',val)
end,
1,ablation_effect_duration)

_this:delayDo(ablation_effect_duration+0.05,function()
_this.tweenerVal=0
if _this.selectTw[i]then
_this.selectTw[i]:Kill()
_this.selectTw[i]=nil
end
widget:SetChildActive(-1,false)
end)
end

local len=#self.lockItem
for i=1,len do
local index=_this.baseCfg.iconList[i]
local widget=self.lockItem[index]:getChildWidgetBase()
local rewardlist=_this.baseCfg.fixConfig[i][1]
local canUnlock=_this:getCanUnlock(rewardlist)
local isFix=_this.myData.fixListLookup[i]
if isFix then
if flag then
dissovleFunc(widget,index)
else
widget:SetChildActive(-1,false)
widget:SetChildWidgetMaterialFloat(-1,'_DissovleProgress',0)
end
widget:SetChildActive(0,false)
else
widget:SetChildWidgetMaterialFloat(-1,'_DissovleProgress',0)
widget:SetChildActive(-1,true)
widget:SetChildActive(0,canUnlock)
end
widget:SetChildButtonClick(1,function()
_this:OnEvent(i)
end)
end
end

function UIHuiYingCangXiRepairWin:refreshRight()
local list=self.baseCfg.fixConfig
local len=#list
self.fixGridPanel:setChildLayoutGroupCreateItems(len,function(index)
local widget=_this.fixGridPanel:getChildLayoutGroupGridItem(index-1)
local data=list[index]

_this:setFixSelect(widget,index)

local desc=_this.baseCfg.descConfig[index]
widget:SetChildText(2,desc)

local isFix=_this.myData.fixListLookup[index]
widget:SetChildText(6,isFix and _this.baseCfg.titleList[index]or"修复解锁")

local rewards=data[2]
widget:SetChildLayoutGroupCreateItems(4,#rewards,function(idx)
local item=widget:GetChildLayoutGroupGridItem(4,idx-1)
local itemId=rewards[idx][1]
local itemNum=rewards[idx][2]
local countStr=mathHelper.formatNumber(itemNum)
local conf={itemid=itemId,itemcount=countStr,showCountBG=true,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(-1,function(...)
if _this then
itemsComponentHelper.onItemClick(...)
end
end)
item:SetChildPropData(-1,prop)
end)

widget:SetChildButtonClick(5,function()
_this.selectIdxLookup[index]=not _this.selectIdxLookup[index]
_this:setFixSelect(widget,index)
end)
end)
end

function UIHuiYingCangXiRepairWin:setFixSelect(widget,fixIdx)
local isSelect=_this.selectIdxLookup[fixIdx]
local isFix=_this.myData.fixListLookup[fixIdx]

widget:SetChildRotation(0,0,0,isSelect and 0 or 180)
widget:SetChildActive(1,isSelect and isFix)
widget:SetChildActive(3,isSelect and not isFix)
end

function UIHuiYingCangXiRepairWin:OnEvent(fixIdx)
local itemlist={}
local rewardlist=self.baseCfg.fixConfig[fixIdx][1]

if rewardlist and next(rewardlist)then
for k,v in ipairs(rewardlist)do
local itemid=v[1]
local itemcount=v[2]
table.insert(itemlist,{itemid=itemid,itemcount=itemcount})
end
end

local show_data={
parentWin=self,
title='修复壁画',
oktext='修复',
canceltext='取消',
itemlist=itemlist,
tip="修复壁画将消耗以下道具",
showclosebtn=true,
okcallback=function()
if _this==nil then return end
if _this:getCanUnlock(rewardlist,true)then
call_activitiesHandle_func("activitiesHandle_huiyingcangxi","reqProtocol_XiuFu",_this.actID,_this.subType,_this.subid,fixIdx)
end
end,
}

self:showWindow("UIHuiYingCangXiFixTips",show_data)
end

function UIHuiYingCangXiRepairWin:getCanUnlock(costs,isWarning)
for i,v in ipairs(costs)do
local itemid=v[1]
local itemnum=v[2]
local hasnum
if itemsConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
else
hasnum=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
if hasnum<itemnum then
if isWarning then
UIManager.error('材料不足')
gainControl:showGainWin(itemid)
end
return false
end
end
return true
end

function UIHuiYingCangXiRepairWin:clearSelectTw()
for k,v in pairs(self.selectTw)do
if v then
v:Kill()
end
end
self.selectTw={}
end



function UIHuiYingCangXiRepairWin:onCloseBtn()
self:closeSelf()
end

