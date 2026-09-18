







def_class("UIYunZhouComponentsStrengthenWin",UIWindowBase)









function UIYunZhouComponentsStrengthenWin:bindComponents()

self.attrRoot_1=UIObject.get(self,0)
self.attrRoot_2=UIObject.get(self,1)
self.attrRoot_3=UIObject.get(self,2)
self.attrRoot_4=UIObject.get(self,3)
self.attrRoot_5=UIObject.get(self,4)
self.btnJinglian=UIButton.get(self,5)
self.btnPut=UIButton.get(self,6)
self.colorDropdown=UIDropdownEx.get(self,7)
self.costItem_1=UIBaseItem.get(self,8)
self.costItem_2=UIBaseItem.get(self,9)
self.costItem_3=UIBaseItem.get(self,10)
self.costItem_4=UIBaseItem.get(self,11)
self.costItem_5=UIBaseItem.get(self,12)
self.desc=UIText.get(self,13)
self.Dropdown1=UIDropdownEx.get(self,14)
self.Dropdown2=UIDropdownEx.get(self,15)
self.effect=UIObject.get(self,16)
self.effect0=UIObject.get(self,17)
self.effect1=UIObject.get(self,18)
self.effect2=UIObject.get(self,19)
self.effect3=UIObject.get(self,20)
self.effect4=UIObject.get(self,21)
self.effect5=UIObject.get(self,22)
self.effectRoot=UIObject.get(self,23)
self.equipList=UIObject.get(self,24)
self.jinglianlevel=UIText.get(self,25)
self.leftDialogue=UIButton.get(self,26)
self.leftdialogueinfo=UIObject.get(self,27)
self.leftItem=UIObject.get(self,28)
self.leftPanel=UIObject.get(self,29)
self.progressBar=UIProgressBarAni.get(self,30)
self.progressBarReverse=UIProgressBarAni.get(self,31)
self.progressCount=UIText.get(self,32)
self.progressCountReverse=UIText.get(self,33)
self.putBtnReddot=UIObject.get(self,34)
self.rightItem=UIObject.get(self,35)
self.ScrollView=UIScrollViewSlow.get(self,36)
self.showItem=UIBaseItem.get(self,37)
self.stageDropdown=UIDropdownEx.get(self,38)
self.yunZhouContent=UIObject.get(self,39)
self.yunZhouPanel=UIObject.get(self,40)

self.btnJinglian:setButtonClick(function()self:onBtnJinglian()end)

self.btnPut:setButtonClick(function()self:onBtnPut()end)

self.leftDialogue:setButtonClick(function()self:onLeftDialogue()end)
self.attrRoot={
self.attrRoot_1,
self.attrRoot_2,
self.attrRoot_3,
self.attrRoot_4,
self.attrRoot_5,
}
self.costItem={
self.costItem_1,
self.costItem_2,
self.costItem_3,
self.costItem_4,
self.costItem_5,
}



end


function UIYunZhouComponentsStrengthenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrRoot_1);self.attrRoot_1=nil;
_UIObject_release(self.attrRoot_2);self.attrRoot_2=nil;
_UIObject_release(self.attrRoot_3);self.attrRoot_3=nil;
_UIObject_release(self.attrRoot_4);self.attrRoot_4=nil;
_UIObject_release(self.attrRoot_5);self.attrRoot_5=nil;
_UIObject_release(self.btnJinglian);self.btnJinglian=nil;
_UIObject_release(self.btnPut);self.btnPut=nil;
_UIObject_release(self.colorDropdown);self.colorDropdown=nil;
_UIObject_release(self.costItem_1);self.costItem_1=nil;
_UIObject_release(self.costItem_2);self.costItem_2=nil;
_UIObject_release(self.costItem_3);self.costItem_3=nil;
_UIObject_release(self.costItem_4);self.costItem_4=nil;
_UIObject_release(self.costItem_5);self.costItem_5=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.Dropdown2);self.Dropdown2=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effect0);self.effect0=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.effect4);self.effect4=nil;
_UIObject_release(self.effect5);self.effect5=nil;
_UIObject_release(self.effectRoot);self.effectRoot=nil;
_UIObject_release(self.equipList);self.equipList=nil;
_UIObject_release(self.jinglianlevel);self.jinglianlevel=nil;
_UIObject_release(self.leftDialogue);self.leftDialogue=nil;
_UIObject_release(self.leftdialogueinfo);self.leftdialogueinfo=nil;
_UIObject_release(self.leftItem);self.leftItem=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressBarReverse);self.progressBarReverse=nil;
_UIObject_release(self.progressCount);self.progressCount=nil;
_UIObject_release(self.progressCountReverse);self.progressCountReverse=nil;
_UIObject_release(self.putBtnReddot);self.putBtnReddot=nil;
_UIObject_release(self.rightItem);self.rightItem=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.showItem);self.showItem=nil;
_UIObject_release(self.stageDropdown);self.stageDropdown=nil;
_UIObject_release(self.yunZhouContent);self.yunZhouContent=nil;
_UIObject_release(self.yunZhouPanel);self.yunZhouPanel=nil;
self.attrRoot=nil;
self.costItem=nil;
end


















local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemTxtCount=2,
cmpItemAdd=3,
cmpItemName=4,
cmpItemStage=5,
cmpItemStageBg=6,
cmpItemReddot=7,
cmpCountBg=8,
cmpStar=9,
cmpSuitIcon=10,
cmpSelect=11,
}
local _bag_filter_desc={}
local _colomn=4
local _row=6
local _fillItemLen=5

function UIYunZhouComponentsStrengthenWin:onLoaded(...)
self:bindComponents()
self.showItem:setBaseItemClickEvent(function(...)self:onCostItemClick(...)end)
self.Dropdown1:setChangeAction(function(...)self:onDropdownChange(ITEM_FILTER_TYPE.eStage,...)end)
self.Dropdown2:setChangeAction(function(...)self:onDropdownChange(ITEM_FILTER_TYPE.eColor,...)end)
self.stageDropdown:setChangeAction(function(...)self:onDropdownChange(ITEM_FILTER_TYPE.eStage,...)end)
self.colorDropdown:setChangeAction(function(...)self:onDropdownChange(ITEM_FILTER_TYPE.eColor,...)end)
local colorlist=table.toTable(eQualityColor.eGreen,eQualityColor.eRed)
_bag_filter_desc[ITEM_FILTER_TYPE.eColor]=itemsFilterHelper.getFilterNames(colorlist,function(color)
return FMT.fmt('{0}及以下',eQualityColorName[color])
end)

local stagelist=table.toTable(1,EQUIP_STAGE_MAX)
_bag_filter_desc[ITEM_FILTER_TYPE.eStage]=itemsFilterHelper.getFilterNames(stagelist,function(stage)
return FMT.fmt('{0}阶及以下',stage)
end)

for _,v in ipairs(self.costItem)do
v:setBaseItemClickEvent(function(...)self:onSelectItemClick(...)end)
v:setBaseItemLongTouchEvent(function(...)self:onSelectItemLongClick(...)end)
end
self.filter={}
self:resetData()
self.ScrollView:setSlowClickAction(function(...)self:onClickGrid(...)end)
self.ScrollView:setSlowLongClickAction(function(...)self:onClickLongGridButton(...)end)
self.ScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)

self.checkList={}
end


function UIYunZhouComponentsStrengthenWin:__delete()
self:unbindComponents()
if not self.boat_id then
timeEventController.delayDo(0.04,function()
if not oneTabScreenController:isActiveUI()then
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eYunZhouComponentsWarehouse)
end
end)
end
end

function UIYunZhouComponentsStrengthenWin:resetData()
self.selectItemsLookup={}
self.selectList={}
self.addExp=0
self.leftExp=0
self.overExp=0
self.addItemExp=0
self.addLastItemExp=0
self.addLv=0
self.curPageIndex=1
self.isSetZero=false
end




function UIYunZhouComponentsStrengthenWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
self.pos=argtable.pos>0 and argtable.pos or nil
self.boat_id=argtable.boat_id>0 and argtable.boat_id or nil
local itemid=argtable.itemid
local itemguid=argtable.itemguid
if self.boat_id then
self.boat_list=XianYunGangModel:getEquipdBoatList()
self.boat_idx=1
for i,v in ipairs(self.boat_list)do
if self.boat_id==v.boatid then
self.boat_idx=i
break
end
end

self.item=XianYunGangModel:getYunZhouComponentsPosData(self.boat_id,self.pos)
else
self.item=bagModel.getItem(itemguid)
end

self:refreshLeftYunZhouList()
self:refreshYunZhouEquipList()
self:setDropdowns()
self:freshInfo()
end

function UIYunZhouComponentsStrengthenWin:freshInfo()
self:resetData()
self:setShowItems()
self:setProgress()
self:setCostItems()
self:setSelectItems()
self:setAttrs()
end


function UIYunZhouComponentsStrengthenWin:refreshLeftYunZhouList()
if self.boat_idx then
self.yunZhouPanel:setActive(true)
self.yunZhouContent:setChildLayoutGroupCreateItems(#self.boat_list,function(index)
local item=self.yunZhouContent:getChildLayoutGroupGridItem(index-1)
local boatData=self.boat_list[index]
local cfg=cfgHelper.get1(cfg_fairylandboatconfig_get,boatData.boatid)

item:SetChildActive(1,self.boat_idx==index)
item:SetChildText(2,boatData.name)
item:SetChildButtonClick(3,function()
self:onClickYunZhouListItem(index)
end)
end)
else
self.yunZhouPanel:setActive(false)
end
end

function UIYunZhouComponentsStrengthenWin:onClickYunZhouListItem(index)
if self.boat_idx==index then
return
end
local item=self.yunZhouContent:getChildLayoutGroupGridItem(self.boat_idx-1)
item:SetChildActive(1,false)
self.boat_idx=index
self.boat_id=self.boat_list[index].boatid
for pos=1,3 do
local yzItem=XianYunGangModel:getYunZhouComponentsPosData(self.boat_id,pos)
if yzItem then
self.item=yzItem
self.pos=pos
break
end
end
local itemid=self.item.itemid
local itemguid=self.item.itemguid
oneTabScreenController:changeArgs({itemid=itemid,itemguid=itemguid,boat_id=self.boat_id,pos=self.pos},true)
item=self.yunZhouContent:getChildLayoutGroupGridItem(self.boat_idx-1)
item:SetChildActive(1,true)
self:refreshYunZhouEquipList()
self:freshInfo()
end

function UIYunZhouComponentsStrengthenWin:refreshYunZhouEquipList()
local boatid=self.boat_id
local equipListWidget=self.equipList:getChildWidgetBase()

for pos=1,3 do
local widget=equipListWidget:GetChildCSGUIBaseItem(pos-1)
local equipData
if self.boat_idx then
equipData=XianYunGangModel:getYunZhouComponentsPosData(boatid,pos)
equipListWidget:SetChildActive(pos-1,true)
else
local itemid=self.item.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=itemConfig.type1
if equipType==pos then
equipData=self.item
else
equipListWidget:SetChildActive(pos-1,false)
end
end
if equipData then
local itemid=equipData.itemid
local itemguid=equipData.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local jinglianStr=''
local iconName
local stage=itemConfig.stage
local showStage=stage~=nil
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=''
local reddot=false
local suitIconName=''
local jinglianlv=equipData.itemData and equipData.itemData.jinglianlv or 0
local suitid=itemConfig.type2
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,suitid,color)
jinglianStr=jinglianlv>0 and FMT.fmt('{0}级',jinglianlv)or''
iconName=iconHelper.getIconName(itemid)
suitIconName=string.format("icon_suit_%d",suitConfig.icon)
widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,reddot)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,stage)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,stage)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,suitIconName,false)
widget:SetChildActive(_itemWidgetIdx.cmpSelect,pos==self.pos or not self.boat_idx)

equipListWidget:SetBaseItemClickEvent(pos-1,function(...)self:onBaseItemClick(...)end)
equipListWidget:SetBaseItemChildIndex(pos-1,pos)

widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
else
if self.boat_idx then
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,'',false)
widget:SetChildActive(_itemWidgetIdx.cmpSelect,false)

widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
end
end
end

function UIYunZhouComponentsStrengthenWin:onBaseItemClick(id,pos,guid,attach)
if self.pos==pos then
return
end
local item=XianYunGangModel:getYunZhouComponentsPosData(self.boat_id,pos)
if item then
self.item=item
local equipListWidget=self.equipList:getChildWidgetBase()
local widget=equipListWidget:GetChildCSGUIBaseItem(self.pos-1)
widget:SetChildActive(_itemWidgetIdx.cmpSelect,false)
self.pos=pos
local itemid=self.item.itemid
local itemguid=self.item.itemguid
oneTabScreenController:changeArgs({itemid=itemid,itemguid=itemguid,pos=pos},true)
widget=equipListWidget:GetChildCSGUIBaseItem(self.pos-1)
widget:SetChildActive(_itemWidgetIdx.cmpSelect,true)
self:freshInfo()
end
end

function UIYunZhouComponentsStrengthenWin:setShowItems()
local itemid=self.item.itemid
local itemguid=self.item.itemguid
self.showItem:setChildItemDataByDataPropKey(DataPropKey.eWidgetIcon,0,iconHelper.getIconName(itemid))
self.showItem:setChildItemDataByDataPropKey(DataPropKey.eWidgetText,1,itemsConfig.getItemName(itemid))
self.showItem:setChildItemData(DataPropKey.eItemID,itemid)
self.showItem:setChildItemData(DataPropKey.eItemSeries,itemguid)

local maxlv=yunZhouEquipsConfig.getStrengthenMaxLvByItemid(itemid)
self.desc:setText(FMT.fmt('当前装备最高可强化至<color=#CA631D>{0}级</color>',maxlv))
end



function UIYunZhouComponentsStrengthenWin:setProgress()
local item=self.item
local itemid=item.itemid
local itemguid=item.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=itemConfig.type1
local maxlv=yunZhouEquipsConfig.getStrengthenMaxLvByItemid(itemid)
local jinglianlv=item.itemData and item.itemData.jinglianlv or 0
local jinglianexp=item.itemData and item.itemData.jinglianexp or 0
local duration=self.progressAni and 0.5 or 0
local durationReverse=self.progressReverseAni and 0.5 or 0
local addExp=self.addExp
local addLv=self.addLv
local curIsFull=jinglianlv>=maxlv
local lastAddExp=self.addLastItemExp
self.addLastItemExp=self.addItemExp
if curIsFull then
self.progressBar:animateThreeParams(100,100,duration)
self.progressBarReverse:animateThreeParams(0,100,durationReverse)
self.progressCount:setText('已满')
self.progressCountReverse:setText('')
else
local curExp=jinglianexp
local curShowExp=curExp
local fillExp=self.leftExp
local maxExp=0
local targetlv=addLv+jinglianlv
local isFull=targetlv>=maxlv
local addItemExp=self.addItemExp
local tExp=0
if addLv<=0 then
maxExp=yunZhouEquipsConfig.getStrengthenExp(equipType,jinglianlv)
else
if not isFull then
maxExp=yunZhouEquipsConfig.getStrengthenExp(equipType,targetlv)
else
maxExp=yunZhouEquipsConfig.getStrengthenExp(equipType,maxlv-1)
fillExp=fillExp+maxExp
end
if addLv>0 and not(addLv==1 and jinglianlv==maxlv-1)then
curShowExp=0
end
end
if addItemExp==0 then
fillExp=curShowExp
end
self.progressBar:animateThreeParams(curShowExp,maxExp,duration,false)
self.progressBarReverse:animateThreeParams(self.progressReverseAni and fillExp or curShowExp,maxExp,durationReverse)
self.progressCount:setText(FMT.fmt('{0}/{1}',mathHelper.floor(fillExp),maxExp))
self.progressCountReverse:setText(FMT.fmt('+{0}',mathHelper.floor(self.addItemExp)))
end
self.jinglianlevel:setText(addLv>0 and FMT.fmt('当前：{0}级  +{1}',jinglianlv,addLv)or FMT.fmt('当前：{0}级',jinglianlv))
self.progressAni=false
self.progressReverseAni=false
end

function UIYunZhouComponentsStrengthenWin:setAttrs()
local item=self.item
local itemguid=item.itemguid
local itemid=item.itemid
local addLv=self.addLv
local jinglianlv=item.itemData and item.itemData.jinglianlv or 0
local baseAttrsLookup=yunZhouEquipsConfig.getStrengthenBaseAttrs(itemid,jinglianlv)
local nextBaseAttrsLookup=addLv>0 and yunZhouEquipsConfig.getStrengthenBaseAttrs(itemid,jinglianlv+addLv)or{}
local temp={}
for attrType,attrValue in pairs(baseAttrsLookup)do
local addValue=(nextBaseAttrsLookup[attrType]or attrValue)-attrValue
temp[#temp+1]={attrType,attrValue,addValue}
end
if#temp>1 then
table.sort(temp,function(a,b)
return cfg_attributesconfig_get(a[1]).priority<cfg_attributesconfig_get(b[1]).priority
end)
end
for i,v in ipairs(self.attrRoot)do
local attrs=temp[i]
if attrs then
v:setActive(true)
local widget=v:getWidgetBase()
local attrType,attrValue,addValue=unpack(attrs)
local name,valstr,ifMod=equipsHelper.getAttr(attrType,attrValue,TO_INT_TYPE.eDown)
local yzAttrName=yunZhouEquipsConfig.getYunZhouSpecialAttrName(attrType)
if yzAttrName then
name=yzAttrName
end
local handleValue=ifMod and mathHelper.decimal(addValue)or mathHelper.floor(addValue)
local hasAdd=handleValue and handleValue>0 or false
widget:SetChildText(0,FMT.fmt('<color=#7d3b17>{0}：</color>{1}',name,valstr))
widget:SetChildActive(1,hasAdd)
if hasAdd then
local addValStr=ifMod and FMT.fmt('{0}%',mathHelper.decimal(addValue))or FMT.fmt('{0}',mathHelper.floor(addValue))
widget:SetChildText(2,addValStr)
else
widget:SetChildText(2,'')
end
else
v:setActive(false)
end
end
end

function UIYunZhouComponentsStrengthenWin:setCostItems()
local components={}
components[#components+1]=self.leftItem
components[#components+1]=self.rightItem

local item=self.item
local itemguid=item.itemguid
local maxlv=yunZhouEquipsConfig.getStrengthenMaxLvByItemid(item.itemid)
local curlv=item.itemData and item.itemData.jinglianlv or 0
local targetlv=self.addLv+curlv
if targetlv>maxlv then targetlv=maxlv end
local consumelist=yunZhouEquipsConfig.getJinglianCost(item,self.addItemExp-self.overExp,targetlv)
for i,v in ipairs(components)do
local costInfo=consumelist[i]
v:setActive(costInfo~=nil)
if costInfo then
local itemid=costInfo[1]
self.checkList[itemid]=true
local cost=costInfo[2]
local has=moneyModel.getMoney(itemid)
local costStr=has>=cost and cost or FMT.cfmt(FONT_COLOR.eRedColor,cost)

local widget=self.winlua:GetChildWidgetBase(v:getID())
widget:SetChildIcon(0,iconHelper.getIconName(itemid),false)
widget:SetChildText(1,costStr)
end
end
end



function UIYunZhouComponentsStrengthenWin:setSelectItems()
local selectList=self.selectList or{}
local itemsList=self.costItem
for i,v in ipairs(itemsList)do
local selectInfo=selectList[i]or{}
local itemguid=selectInfo[1]
local num=selectInfo[2]or 0
local item=bagModel.getItem(itemguid)

local showCountBG=false
local jinglianlv=item and item.itemData and item.itemData.jinglianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('{0}级',jinglianlv)or''
local countStr=jinglianlv>0 and jinglianStr or num>1 and num or''
local conf={showname=false,itemcount=countStr,showcount=countStr~='',showCountBG=countStr~=''}
v:setChildPropData(self:getSelectFillData(item,conf))
local widget=self:getChildCSGUIBaseItem(v:getID())
if item then
local itemConfig=itemsConfig.getConfig(item.itemid)
local isEquip=itemsConfig.isYunZhouComponents(item.itemid)
if isEquip then
widget:SetChildGroundStarNum(10,itemConfig.stage)
widget:SetChildStarNumber(10,itemConfig.stage)
else
widget:SetChildGroundStarNum(10,0)
widget:SetChildStarNumber(10,0)
end
else
widget:SetChildGroundStarNum(10,0)
widget:SetChildStarNumber(10,0)
end
end
end


function UIYunZhouComponentsStrengthenWin:getSelectFillData(item,conf)
if item==nil then
return self:getSelectTempFillData()
end
local prop=itemsComponentHelper.getCommonFillData(item,conf)
local itemConfig=itemsConfig.getConfig(item.itemid)
prop[PropIndex(DataPropKey.eWidgetText,6)]=''
prop[PropIndex(DataPropKey.eWidgetActive,8)]=false
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
return prop
end


function UIYunZhouComponentsStrengthenWin:getSelectTempFillData()
local conf={}
conf.showbg=true
local prop=itemsComponentHelper.getTempFillData(conf)
prop[PropIndex(DataPropKey.eWidgetActive,8)]=false
prop[PropIndex(DataPropKey.eWidgetActive,9)]=true
return prop
end


function UIYunZhouComponentsStrengthenWin:setDropdowns()
local stageDescList=_bag_filter_desc[ITEM_FILTER_TYPE.eStage]
local colorDescList=_bag_filter_desc[ITEM_FILTER_TYPE.eColor]
self.stageDropdown:setOption(stageDescList)
self.colorDropdown:setOption(colorDescList)
self.Dropdown1:setOption(stageDescList)
self.Dropdown2:setOption(colorDescList)

self.stageIdx=EQUIP_STAGE_MAX
self.colorIdx=eQualityColor.eRed

self.Dropdown1:setValue(self.stageIdx)
self.Dropdown2:setValue(self.colorIdx)
self.stageDropdown:setValue(self.stageIdx)
self.colorDropdown:setValue(self.colorIdx)

self:selectFilterStage(self.stageIdx)
self:selectFilterColor(self.colorIdx)
end


function UIYunZhouComponentsStrengthenWin:onDropdownChange(dropidx,idx)

if dropidx==ITEM_FILTER_TYPE.eColor then
self:selectFilterColor(idx)
self.colorIdx=idx
elseif dropidx==ITEM_FILTER_TYPE.eStage then
self:selectFilterStage(idx)
self.stageIdx=idx
end



end


function UIYunZhouComponentsStrengthenWin:selectFilterColor(val)
local filtertype=ITEM_FILTER_TYPE.eColor
self:onFilter(filtertype,val)
end


function UIYunZhouComponentsStrengthenWin:selectFilterStage(val)
local filtertype=ITEM_FILTER_TYPE.eStage
self:onFilter(filtertype,val)
end

function UIYunZhouComponentsStrengthenWin:onFilter(filtertype,val)
if self.filter[filtertype]==val then return end
self.filter[filtertype]=val

end

function UIYunZhouComponentsStrengthenWin:onEdgeEvent()

if self.curPageIndex>=self.tPage then return end
self.curPageIndex=self.curPageIndex+1
self:freshProvideSelectGrids()
end

function UIYunZhouComponentsStrengthenWin:showProvideSelectGrids()
if self.showDialogue then return end
self.showDialogue=true
self.leftDialogue:setActive(true)
self.winlua:SetChildDOLocalMoveX(self.leftdialogueinfo:getID(),-320,0.5)
self.Dropdown1:setValue(self.stageIdx)
self.Dropdown2:setValue(self.colorIdx)
self:freshProvideSelectGrids(true)
end

function UIYunZhouComponentsStrengthenWin:closeProvideSelectGrids()
if not self.showDialogue then return end
self.showDialogue=false
self.curPageIndex=1
self.isSetZero=false
self.ScrollView:clearSlowItems()
local func=function(...)
self.leftDialogue:setActive(false)
self.stageDropdown:setValue(self.stageIdx)
self.colorDropdown:setValue(self.colorIdx)
end
self.winlua:SetChildDOLocalMoveX(self.leftdialogueinfo:getID(),-890,0.1,func)
end

function UIYunZhouComponentsStrengthenWin:freshBagList()
local bagList=yunZhouEquipsConfig.getMateriasOnBag(self.item.itemguid,nil,nil)or{}

local isPutItem=function(itemguid)
for i=1,_fillItemLen do
local info=self.selectList[i]
if info and tostring(info[1])==tostring(itemguid)and info[2]and info[2]>0 then
return true
end
end
end

local list={}
local looupup={}
if#bagList>0 then
for i=#bagList,1,-1 do
local item=bagList[i]
if not looupup[tostring(item.itemguid)]and isPutItem(item.itemguid)then
list[#list+1]=item
looupup[tostring(item.itemguid)]=true
table.remove(bagList,i)
end
end

for i,v in ipairs(list)do
table.insert(bagList,1,v)
end
end

self.bagList=bagList
end

function UIYunZhouComponentsStrengthenWin:freshProvideSelectGrids(freshData)
if not self.showDialogue then return end
if freshData then
self:freshBagList()
end
local list=self.bagList
local rNum=#list
local pageNum=_row*_colomn
if rNum<pageNum then rNum=pageNum end
local tRow=math.ceil(rNum/_colomn)
local tPage=math.ceil(rNum/pageNum)
self.tPage=tPage
local curPageIndex=self.curPageIndex
local showNum=curPageIndex*pageNum
local showRow=math.ceil(showNum/_colomn)
if curPageIndex==1 then
self.ScrollView:clearSlowItems()
end
self.ScrollView:freshSlowGrids(showNum,showRow,_colomn,not self.isSetZero)
self.isSetZero=true
end

function UIYunZhouComponentsStrengthenWin:bindGrid(index,widget)
local itemInfo=self.bagList[index]
local isTemp=itemInfo==nil
if not isTemp then
local count=itemInfo.itemcount
local itemcount=itemInfo.itemcount or 0
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=itemsModel.getIconName(itemInfo)
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=''
local num=self:getSelectNum(itemguid)
local jinglianlv=itemInfo.itemData and itemInfo.itemData.jinglianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('{0}级',jinglianlv)or''
local countStr=jinglianlv>0 and jinglianStr or num>0 and FMT.fmt('{0}/{1}',itemcount,num)or itemcount>1 and itemcount or''
local has=num>0
local showbg=true
local isLock=bagHelper.isLock(itemInfo)
local isFabao=itemsConfig.isFabao(itemid)
local showStage=false
local isSelect=tostring(self.selectItemguid)==tostring(itemguid)
widget:SetChildActive(0,true)
widget:SetChildActive(1,isSelect)
widget:SetChildQulaity(2,color)
widget:SetChildIcon(3,iconName,false)
widget:SetChildText(4,countStr)
widget:SetChildActive(5,countStr~='')
widget:SetChildText(6,stageStr)
widget:SetChildText(7,'')
widget:SetChildActive(8,showStage)
widget:SetChildActive(9,isLock)
widget:SetChildActive(10,has)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
widget:SetChildLongPress(10,index,function(idx)self:longPressAction(idx)end,function(idx)self:finishlongPressAction(idx)end)
widget:SetChildLongPress(11,index,function(idx)self:longPressAction(idx,true)end,function(idx)self:finishlongPressAction(idx,true)end)
else
widget:SetChildActive(0,true)
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
widget:SetChildText(4,'')
widget:SetChildActive(5,false)
widget:SetChildText(6,'')
widget:SetChildText(7,'')
widget:SetChildActive(8,false)
widget:SetChildActive(9,false)
widget:SetChildActive(10,false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
widget:SetChildLongPress(11,index,nil,nil)
widget:SetChildLongPress(10,index,nil,nil)
end
end

function UIYunZhouComponentsStrengthenWin:freshProvideSelectSingleGirid(itemguid,flag)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(10,flag)
if not flag then
widget:SetChildLongPressStop(10)
self.useGoodTime=nil
end
end
end
end

function UIYunZhouComponentsStrengthenWin:freshProvideSingleGiridText(itemguid)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
local num=self:getSelectNum(itemguid)
local info=self.bagList[idx]
local itemcount=info.itemcount or 0
local jinglianlv=info.itemData and info.itemData.jinglianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('{0}级',jinglianlv)or''
local countStr=jinglianlv>0 and jinglianStr or num>0 and FMT.fmt('{0}/{1}',itemcount,num)or itemcount>1 and itemcount or''
widget:SetChildText(4,countStr)
widget:SetChildActive(5,countStr~='')
end
end
end

function UIYunZhouComponentsStrengthenWin:getBagItemIdx(itemguid)
local list=self.bagList or{}
for i,v in ipairs(list)do
if tostring(v.itemguid)==tostring(itemguid)then
return i,v
end
end
end

function UIYunZhouComponentsStrengthenWin:freshAddExp()
local selectItems=self.selectList or{}
local addItemExp,addExp,addLv,leftExp,overExp=self:getJinglianData(selectItems)
self.addItemExp=addItemExp
self.addExp=addExp
self.addLv=addLv
self.leftExp=leftExp
self.overExp=overExp
end

function UIYunZhouComponentsStrengthenWin:getJinglianData(selectItems)
local addItemExp=0
if selectItems then
for k,v in pairs(selectItems)do
local itemguid=v[1]
local num=v[2]
local item=bagModel.getItem(itemguid)
if item then
addItemExp=addItemExp+yunZhouEquipsConfig.getJinglianValue(item,num)
end
end
end
local item=self.item
local itemid=item.itemid
local jinglianlv=item.itemData and item.itemData.jinglianlv or 0
local jinglianexp=item.itemData and item.itemData.jinglianexp or 0
local addLv,leftExp,overExp=yunZhouEquipsConfig.getAddJinglianLv(itemid,jinglianlv,jinglianexp,addItemExp)
local addExp=addItemExp-leftExp
return addItemExp,addExp,addLv,leftExp,overExp
end

function UIYunZhouComponentsStrengthenWin:setSelectNum(itemguid,index,num)
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
if self.selectList==nil then self.selectList={}end
if num==0 then
self.selectList[index]=nil
self.selectItemsLookup[tostring(itemguid)]=nil
else
self.selectList[index]={itemguid,num}
self.selectItemsLookup[tostring(itemguid)]=index
end
self:freshAddExp()
self.progressReverseAni=true
self.progressAni=false
end

function UIYunZhouComponentsStrengthenWin:getSelectIndex(itemguid)
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
if self.selectList==nil then self.selectList={}end
return self.selectItemsLookup[tostring(itemguid)]
end

function UIYunZhouComponentsStrengthenWin:getNextFillIdx(itemguid)
if self.selectList==nil then self.selectList={}end
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
local selectItemsLookup=self.selectItemsLookup
local selectList=self.selectList
local index=selectItemsLookup[tostring(itemguid)]
if index then return index end
for i=1,_fillItemLen do
local info=selectList[i]
if not info then
return i
end
end
end

function UIYunZhouComponentsStrengthenWin:getSelectNum(itemguid)
if self.selectList==nil then self.selectList={}end
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
local selectItemsLookup=self.selectItemsLookup
local selectList=self.selectList
local index=selectItemsLookup[tostring(itemguid)]
if index then
local selectTable=selectList[index]or{}
return selectTable[2]or 0
end
return 0
end

function UIYunZhouComponentsStrengthenWin:checkMaxLv()
local upItem=self.item
local jinglianlv=upItem.itemData and upItem.itemData.jinglianlv or 0
local maxlv=yunZhouEquipsConfig.getStrengthenMaxLvByItemid(upItem.itemid)
if jinglianlv>=maxlv then
UIManager.error('装备强化等级达到上限')
return false
end
return true
end

function UIYunZhouComponentsStrengthenWin:putItem(itemguid,addnum)
local num=self:getSelectNum(itemguid)
local item=bagModel.getItem(itemguid)
local itemcount=item.itemcount
if not self:checkMaxLv()then
return
end
if num>=itemcount then
UIManager.error('物品已达上限')
return
end
local fillIdx=self:getNextFillIdx(itemguid)
if fillIdx==nil then
UIManager.error('当前无空位可放入')
return
end
if bagHelper.isLock(item)then








UIManager.error('物品已锁定')
return
end
if not self:tryPutItem(item,true)then
return
end
self.onJinglianFinish=false
local lastNum=num
if lastNum==0 then
self:freshProvideSelectSingleGirid(itemguid,true)
end
addnum=addnum or 1
num=num+addnum
self:setSelectNum(itemguid,fillIdx,num)
self:freshProvideSingleGiridText(itemguid)
self:setCostItems()
self:setSelectItems()
self:setProgress()
self:setAttrs()
return true
end


function UIYunZhouComponentsStrengthenWin:tryPutItem(item,canOverExp)
local addExp=yunZhouEquipsConfig.getJinglianValue(item,1)
local addTExp=self.addItemExp or 0
local needMaxExp=yunZhouEquipsConfig.getJinglianValueToMaxLevelOnItem(self.item)
local lastIsFull=addTExp>=needMaxExp
if lastIsFull then
UIManager.error('已达到最大经验，无法添加')
return false
end
addTExp=addTExp+addExp
local leftExp=addTExp-needMaxExp
if leftExp>0 then
if not canOverExp then
UIManager.error('已达到最大经验，无法添加')
return false
end
end
return true
end

function UIYunZhouComponentsStrengthenWin:onClickGridButton(itemid,index,itemguid,attach,delnum)
if itemid==-1 then return end
local num=self:getSelectNum(itemguid)
if num<=0 then
UIManager.error('物品已达下限')
return
end
self.onJinglianFinish=false
delnum=delnum or 1
num=num-delnum
local selectIdx=self:getSelectIndex(itemguid)
self:setSelectNum(itemguid,selectIdx,num)
if num<=0 then
self:freshProvideSelectSingleGirid(itemguid,false)
end
self:freshProvideSingleGiridText(itemguid)
self:setSelectItems()
self:setCostItems()
self:setProgress()
self:setAttrs()
return true
end


function UIYunZhouComponentsStrengthenWin:longPressAction(idx,isAdd)
if isAdd and not self.islong then
return
end
local info=self.bagList[idx]
if not info then
self:StopItemLongPress(idx,isAdd and 11 or 10)
self.useGoodTime=nil
return
end
local num=1
if self.useGoodTime~=nil then
local cur=Time.realtimeSinceStartup
local lerp=cur-self.useGoodTime
if lerp>=10 then
num=100
elseif lerp>=6 then
num=50
elseif lerp>=3 then

num=10
elseif lerp>=2 then

num=5
end
else
self.useGoodTime=Time.realtimeSinceStartup
end
local maxNum=isAdd and info.itemcount or self:getSelectNum(info.itemguid)
if num>maxNum then
num=maxNum
end
if isAdd then
if not self:putItem(info.itemguid,num)then
self:StopItemLongPress(idx,11)
self.useGoodTime=nil
end
else
if not self:onClickGridButton(info.itemid,idx,info.itemguid,nil,num)then
self:StopItemLongPress(idx,10)
self.useGoodTime=nil
end
end
end


function UIYunZhouComponentsStrengthenWin:finishlongPressAction(idx,isAdd)
if isAdd then
self.islong=false
end
self.useGoodTime=nil
end

function UIYunZhouComponentsStrengthenWin:StopItemLongPress(idx,index)
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildLongPressStop(index)
end
end

function UIYunZhouComponentsStrengthenWin:onClickGrid(itemid,index,itemguid,attach)
if itemid==-1 then return end
if itemsConfig.isYunZhouComponents(itemid)then
self:putItem(itemguid)
else
local item=bagModel.getItem(itemguid)
local has=itemsModel.getCount(itemid)
local selectedNum=self:getSelectNum(itemguid)
local canSelectNum=has-selectedNum
local addExp=yunZhouEquipsConfig.getJinglianValue(item,1)
local addTExp=self.addItemExp or 0
local needMaxExp=yunZhouEquipsConfig.getJinglianValueToMaxLevelOnItem(self.item)
local lastIsFull=addTExp>=needMaxExp
if lastIsFull then
UIManager.error('已达到最大经验，无法添加')
return
end
local leftExp=needMaxExp-addTExp
local maxPutNum=math.ceil(leftExp/addExp)
canSelectNum=math.min(canSelectNum,maxPutNum)
local selectNumCmpArgs={numFormat='放入：<color=#f1ce78>{0}/{1}</color>',min=1,max=canSelectNum,val=canSelectNum}
local argstable={
formType=TIPS_FORM_TYPE.eYunZhouComposeBag,
itemid=itemid,
itemguid=itemguid,

attach={formType=TIPS_FORM_TYPE.eYunZhouComposeBag,index=index,selectNumCmpArgs=selectNumCmpArgs,},
move=TIPS_MOVE_POS.eCenter
}
tipsBtnManager.insertBtn(argstable,{TIPS_BTNS_TYPE.ePutAnyItem})
tipsManager.showTips(argstable)
end
end

function UIYunZhouComponentsStrengthenWin:onClickLongGridButton(itemid,index,itemguid,attach)
if itemid~=-1 then

self.islong=true
end
end


function UIYunZhouComponentsStrengthenWin:resetSelectItems()
self:freshInfo()
self:freshProvideSelectGrids(true)



end


function UIYunZhouComponentsStrengthenWin:onPutClick(hideError)
if not self:checkMaxLv()then
return
end
local stageDropIdx=self.filter[ITEM_FILTER_TYPE.eStage]
local colorDropIdx=self.filter[ITEM_FILTER_TYPE.eColor]
local filterStage=nil
local filterColor=nil
local filterList=yunZhouEquipsConfig.getMateriasOnBag(self.item.itemguid,filterStage,filterColor,true)or{}

local insertList=self.selectList or{}
local list,errType,errArgs=self:getJinglianMetrials(self.item,filterList,insertList,_fillItemLen)
if list and#list>0 then
self.onJinglianFinish=false
for _,v in ipairs(list)do
local itemguid=v[1]
local num=v[2]
local idx=self:getNextFillIdx(itemguid)
self:setSelectNum(itemguid,idx,num)
self:freshProvideSelectSingleGirid(itemguid,true)
end
self:setSelectItems()
self:setCostItems()
self:setProgress()
self:setAttrs()
else
if hideError then
return
end
if errType==equipsHelper.jinglianErr.eNotMaterials then
UIManager.error('没有材料可放入')


elseif errType==equipsHelper.jinglianErr.eNotPos then
UIManager.error('当前无空位可放入')
elseif errType==equipsHelper.jinglianErr.eExpOver then
UIManager.error('已达到最大经验，无法添加')
elseif errType==equipsHelper.jinglianErr.eNotEnoughMoney then
local moneyType=errArgs
local moneyName=moneyModel.getMoneyName(moneyType)
UIManager.error(FMT.fmt('{0}不足，不可强化',moneyName))
gainControl:showGainWin(moneyType)
end
end
end


function UIYunZhouComponentsStrengthenWin:getJinglianMetrials(item,list,insertlist,maxLen)

if list==nil or#list<=0 then
return false,equipsHelper.jinglianErr.eNotMaterials
end



local tempList={}
for i=1,maxLen do
if insertlist[i]==nil then
tempList[#tempList+1]=i
end
end
local inertLen=#tempList
if inertLen==0 then
return false,equipsHelper.jinglianErr.eNotPos
end


local outlist={}
local fillList={}
local idxList={}
local totalExp=0
local useHoleLen=0
local holeIdxList={}
local needMoneyType
local itemLen=#list

for i,v in pairs(insertlist)do
local itemguid=v[1]
local guidStr=tostring(itemguid)
local num=v[2]
local insertItem=bagModel.getItem(itemguid)
local hasExp=yunZhouEquipsConfig.getJinglianValue(insertItem,num)
totalExp=totalExp+hasExp
outlist[tostring(itemguid)]=true
useHoleLen=useHoleLen+1
idxList[guidStr]=i
holeIdxList[i]=true
fillList[guidStr]={itemguid,v[2]}
end

local needMaxExp=yunZhouEquipsConfig.getJinglianValueToMaxLevelOnItem(item)
if totalExp>=needMaxExp then
return false,equipsHelper.jinglianErr.eExpOver
end

local itemguid1=item.itemguid
local ret,moneyType=yunZhouEquipsConfig.isCanJinglianByCostMoney(item,totalExp)
if not ret then
return false,equipsHelper.jinglianErr.eNotEnoughMoney,moneyType
end

local sortTag={}
local temp=table.deepCopy(list)
for i,v in ipairs(temp)do
local tempItem=bagModel.getItem(v.itemguid)
local exp=yunZhouEquipsConfig.getJinglianValue(tempItem,1)
sortTag[tostring(v.itemguid)]=itemsConfig.getMainType(v.itemid)*-10000000+exp*100-i
end


table.sort(temp,function(a,b)
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
end)

local _getNextHole=function()
for i=1,maxLen do
if not holeIdxList[i]then
return i
end
end
end
local _putItem=function(itemguid,hasExp,holeIdx)
local guidStr=tostring(itemguid)
local targetExp=totalExp+hasExp
local targetlv=yunZhouEquipsConfig.getJinglianTargetLv(item,targetExp)
local ret,moneyType=yunZhouEquipsConfig.isCanJinglianByCostMoney(item,targetExp,targetlv)
if not ret then
needMoneyType=moneyType
return false
end
if holeIdxList[holeIdx]==nil then
holeIdxList[holeIdx]=true
idxList[guidStr]=holeIdx
useHoleLen=useHoleLen+1
end
local lastNum=(fillList[guidStr]or{})[2]or 0
lastNum=lastNum+1
fillList[guidStr]={itemguid,lastNum}
totalExp=totalExp+hasExp
return true
end

local compelementInfo={}
for i,v in ipairs(temp)do
local itemid=v.itemid
local count=v.itemcount
local itemguid=v.itemguid
local guidStr=tostring(itemguid)
if totalExp>=needMaxExp then break end
local lastNum=(fillList[guidStr]or{})[2]or 0
local alreadyPut=lastNum>0
local isNew=not alreadyPut
local leftCount=count-lastNum
local holeIdx=idxList[guidStr]
local isEquip=itemsConfig.isYunZhouComponents(itemid)
if isEquip or isNew then
if(useHoleLen+1)>maxLen then break end
holeIdx=_getNextHole()
end
if leftCount>0 and holeIdx then
local tempItem=bagModel.getItem(itemguid)
local hasExp=yunZhouEquipsConfig.getJinglianValue(tempItem,1)
local canPutExp=needMaxExp-totalExp
local max=math.floor(canPutExp/hasExp)
local cnt=math.min(max,leftCount)
for j=1,cnt do
if totalExp>=needMaxExp then break end
if _putItem(itemguid,hasExp,holeIdx)then
leftCount=leftCount-1
else
break
end
end
if leftCount>0 and totalExp<needMaxExp then
if(useHoleLen==maxLen or useHoleLen==itemLen)then
_putItem(itemguid,hasExp,holeIdx)
else
local lastExp=compelementInfo[1]
if lastExp==nil or lastExp>hasExp then
compelementInfo={hasExp,itemguid}
end
end
end
end
end
if totalExp<needMaxExp and#compelementInfo>0 then
local itemguid=compelementInfo[2]
local hasExp=compelementInfo[1]
local guidStr=tostring(itemguid)
local holeIdx=idxList[guidStr]
if holeIdx==nil then
holeIdx=_getNextHole()
end
if holeIdx then
_putItem(itemguid,hasExp,holeIdx)
end
end
if useHoleLen==0 then
if needMoneyType then
return false,equipsHelper.jinglianErr.eNotEnoughMoney,needMoneyType
end
return false,equipsHelper.jinglianErr.eNotMaterials
end
local finalList={}
for key,v in pairs(fillList)do
finalList[idxList[key]]=v
end

return finalList
end

function UIYunZhouComponentsStrengthenWin:onJinglian(oldlv,newlv)
if oldlv and newlv and newlv~=oldlv and self.overExp==0 then
self.winlua:SetChildShowEffect(self.effect:getID(),10060,true)
end
self.onJinglianFinish=true
self.progressAni=true
self.progressReverseAni=false

self:resetData()
self:freshInfo()
self:freshProvideSelectGrids(true)









end


function UIYunZhouComponentsStrengthenWin:onBtnJinglian()
local item=self.item
local itemguid=item.itemguid
local itemid=item.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local jinglianlv=item.itemData and item.itemData.jinglianlv or 0
local selectItems=self.selectList
local itemsTemp={}
local equipsTemp={}
local flag=false
for k,v in pairs(selectItems)do
local _itemguid=v[1]
local num=v[2]
local selectItem=bagModel.getItem(_itemguid)
if selectItem then
if itemsConfig.isItem(selectItem.itemid)then
itemsTemp[#itemsTemp+1]={selectItem.itemid,num}
else
equipsTemp[#equipsTemp+1]=_itemguid
end
flag=true
end
end
if flag==false then
UIManager.error('请放入强化材料')
return
end
local maxlv=yunZhouEquipsConfig.getStrengthenMaxLvByItemid(itemid)
local curlv=item.itemData and item.itemData.jinglianlv or 0
if curlv>=maxlv then
UIManager.error('装备强化等级达到上限')
return
end
local targetlv=self.addLv+curlv
if targetlv>maxlv then targetlv=maxlv end
local ret,moneyType,needMoney=yunZhouEquipsConfig.isCanJinglianByCostMoney(item,self.addItemExp,targetlv)
if not ret then
local moneyName=moneyModel.getMoneyName(moneyType)
UIManager.error(FMT.fmt('{0}不足，不可强化',moneyName))
gainControl:showGainWin(moneyType)
return
end

local itemslen=#itemsTemp
local equipslen=#equipsTemp
local pos=0
local guid=itemguid
if self.boat_id then
guid=int64.new(self.boat_id)
pos=self.pos
end

XianYunGangController.reqYunZhouComponentsStrengthen(guid,pos,itemslen,itemsTemp,equipslen,equipsTemp)
end

function UIYunZhouComponentsStrengthenWin:onBtnPut()
self:onPutClick()
end

function UIYunZhouComponentsStrengthenWin:onLeftDialogue()
self:closeProvideSelectGrids()
end

function UIYunZhouComponentsStrengthenWin:onSelectItemClick(itemid,index,itemguid,attach)
self:showProvideSelectGrids()
end

function UIYunZhouComponentsStrengthenWin:onSelectItemLongClick(itemid,index,itemguid,attach)
if itemid>0 then
tipsManager.showTips({itemguid=itemguid,itemid=itemid})
end
end

function UIYunZhouComponentsStrengthenWin:onCostItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end
end
