







def_class("UIFabaoLianhuaResetTipsWin",UIWindowBase)









function UIFabaoLianhuaResetTipsWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.costItem=UIObject.get(self,1)
self.frame=UIButton.get(self,2)
self.helpBtn=UIButton.get(self,3)
self.leftAttrDesc=UIText.get(self,4)
self.leftText=UIText.get(self,5)
self.resetBtn=UIButton.get(self,6)
self.rightAttrDesc=UIText.get(self,7)
self.rightText=UIText.get(self,8)
self.showItem=UIBaseItem.get(self,9)
self.tipsPanel=UIObject.get(self,10)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIFabaoLianhuaResetTipsWin")end)

self.frame:setButtonClick(function()self:onFrame()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)



end


function UIFabaoLianhuaResetTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.costItem);self.costItem=nil;
_UIObject_release(self.frame);self.frame=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.leftAttrDesc);self.leftAttrDesc=nil;
_UIObject_release(self.leftText);self.leftText=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
_UIObject_release(self.rightAttrDesc);self.rightAttrDesc=nil;
_UIObject_release(self.rightText);self.rightText=nil;
_UIObject_release(self.showItem);self.showItem=nil;
_UIObject_release(self.tipsPanel);self.tipsPanel=nil;
end
















local _this



function UIFabaoLianhuaResetTipsWin:onLoaded(...)
self:bindComponents()
_this=self

notifySystem:listenNotify(notifyConfig.on_money_changed,self.onMoneyChanged)
self.showItem:setBaseItemClickEvent(function(...)self:onItemClick(...)end)

end


function UIFabaoLianhuaResetTipsWin:__delete()
self:unbindComponents()
_this=nil
end

function UIFabaoLianhuaResetTipsWin:onMoneyChanged(moneyType)
local lianhuareset=cfg_disciplefabaoconfig_get(1).lianhuareset
local itemid=lianhuareset[1][1]
if moneyType==itemid then
self:ShowCostItem()
end
end




function UIFabaoLianhuaResetTipsWin:onShow(argtable,afterOnloaded)
local itemguid=argtable.itemguid
self.item=fabaoHelper.getFabao(itemguid)
self.isEquip=fabaoModel.isEquipedOnAnyDizi(itemguid)
local stage=itemsConfig.getConfig(self.item.itemid).stage
self.stage=stage

self:freshAllPanel()
end


function UIFabaoLianhuaResetTipsWin:onHide()

end



function UIFabaoLianhuaResetTipsWin:freshAllPanel()
self:freshLeftPanel()
self:freshRightPanel()
self:freshShowItem()
self:ShowCostItem()
end

function UIFabaoLianhuaResetTipsWin:freshLeftPanel()
local item=self.item
local leftNum,tNum=fabaoHelper.getLianhuaLeftNum(item.itemguid)
local costNum=tNum-leftNum
self.leftText:setText(FMT.fmt("已炼化材料数量：{0}/{1}",costNum,tNum))

local list=fabaoHelper.getLianhuaAttrsList(item)or{}
local attrList=attrListHelper.sortByList(list)or{}
local has=#attrList>0
self.leftAttrDesc:setActive(has)
if has then
local desc=nil
for i,attr in pairs(attrList)do
local name,valstr,ifMod=equipsHelper.getAttr(attr[1],attr[2],TO_INT_TYPE.eDown)
local txt=FMT.fmt('{0}：{1}',name,valstr)
if desc==nil then
desc=txt
else
desc=FMT.fmt('{0}\n{1}',desc,txt)
end
end
self.leftAttrDesc:setText(desc)
end
end

function UIFabaoLianhuaResetTipsWin:freshRightPanel()
local item=self.item
local leftNum,tNum=fabaoHelper.getLianhuaLeftNum(item.itemguid)
self.rightText:setText(FMT.fmt("已炼化材料数量：{0}/{1}",0,tNum))

local list=fabaoHelper.getInitLianhuaAttrsList(item)or nil
local hasInit=list~=nil and#list>0

self.tipsPanel:setActive(not hasInit)
if hasInit then
local attrList=attrListHelper.sortByList(list)or{}

local has=#attrList>0
self.rightAttrDesc:setActive(has)
if has then
local desc=nil
for i,attr in pairs(attrList)do
local name,valstr,ifMod=equipsHelper.getAttr(attr[1],attr[2],TO_INT_TYPE.eDown)
local txt=FMT.fmt('{0}：{1}',name,valstr)
if desc==nil then
desc=txt
else
desc=FMT.fmt('{0}\n{1}',desc,txt)
end
end
self.rightAttrDesc:setText(toColorString(FONT_COLOR.eNomalBlackColor,desc))
end
else
local itemid=fabaoHelper.getType3Itemid(item)
local baseLianhuaRangeLookupAttrs=fabaoHelper.getAddLianhuaAttrsListByLianzhi({itemid,itemid,itemid,itemid,itemid})
local attrTypeList={}
for attrType,_ in pairs(baseLianhuaRangeLookupAttrs)do
attrTypeList[#attrTypeList+1]=attrType
end
if#attrTypeList>1 then
table.sort(attrTypeList,function(a,b)
return a<b
end)
end
local has=#attrTypeList>0
self.rightAttrDesc:setActive(has)
if has then
local desc=nil
for i,attrType in pairs(attrTypeList)do
local valTable=baseLianhuaRangeLookupAttrs[attrType]
local min=valTable[1]
local max=valTable[2]
local name,minstr=equipsHelper.getAttr(attrType,min)
local _,maxstr=equipsHelper.getAttr(attrType,max)
local txt=FMT.fmt('{0}：{1}~{2}',name,minstr,maxstr)
if desc==nil then
desc=txt
else
desc=FMT.fmt('{0}\n{1}',desc,txt)
end
end
self.rightAttrDesc:setText(toColorString(FONT_COLOR.eOrangeColor,desc))
end
end
end

function UIFabaoLianhuaResetTipsWin:freshShowItem()
local item=self.item
local itemid=item.itemid
local itemguid=item.itemguid
local iconName=itemsModel.getIconName(item)
self.showItem:setChildItemDataByDataPropKey(DataPropKey.eWidgetIcon,0,iconName)
self.showItem:setChildItemDataByDataPropKey(DataPropKey.eWidgetText,1,fabaoHelper.getFabaoName(item))
self.showItem:setChildItemData(DataPropKey.eItemID,itemid)
self.showItem:setChildItemData(DataPropKey.eItemSeries,itemguid)
end

function UIFabaoLianhuaResetTipsWin:ShowCostItem()
local costItem=self.costItem:getWidgetBase()

local lianhuareset=cfg_disciplefabaoconfig_get(1).lianhuareset
local itemid=lianhuareset[1][1]
local itemnum=lianhuareset[1][2]

local itemcount,showCountBG
if itemnum>=1 then
local enough=moneyModel.checkEnoughMoney(itemid,itemnum)
if enough then
itemcount=tostring(itemnum)
else
itemcount=FMT.cfmt(FONT_COLOR.eRedColor,tostring(itemnum))
end
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
costItem:SetChildPropData(0,prop)
costItem:SetChildActive(0,true)
costItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end

function UIFabaoLianhuaResetTipsWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,})
end

function UIFabaoLianhuaResetTipsWin:onItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end
end




function UIFabaoLianhuaResetTipsWin:onFrame()
UIManager:closeWindow("UIFabaoLianhuaResetTipsWin")
end



function UIFabaoLianhuaResetTipsWin:onResetBtn()
if _this==nil then
return
end
local lianhuareset=cfg_disciplefabaoconfig_get(1).lianhuareset
local itemid=lianhuareset[1][1]
local itemnum=lianhuareset[1][2]

local itemguid=self.item.itemguid
local callback=function()
local name=fabaoHelper.getFabaoName(_this.item)
local contentStr=FMT.fmt('是否将<color=#ca631d>【{0}】</color>的炼化属性\n重置为初始值？',name)
local show_data={
type='UIDialouge',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
okcallback=function()
if _this==nil then return end
if _this.isEquip then
local guid=fabaoModel.getDiziguidByItemguid(itemguid)
fabaoProtocolControl.reqFabaoLianhuaReset(guid,1)
else
fabaoProtocolControl.reqFabaoLianhuaReset(itemguid,0)
end
UIManager:closeWindow("UIFabaoLianhuaResetTipsWin")
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
moneySystem:useMoney(itemid,itemnum,callback,WARNING_TYPE.eWarning)
end



function UIFabaoLianhuaResetTipsWin:onHelpBtn()
local d={}
d.title='规则'
d.mode=3
d.name='fabao_lianhua_reset_help_%d'
UIManager:showWindow('UIRuleWin',d)
end
