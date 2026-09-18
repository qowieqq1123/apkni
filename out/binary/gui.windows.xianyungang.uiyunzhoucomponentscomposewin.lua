







def_class("UIYunZhouComponentsComposeWin",UIWindowBase)









function UIYunZhouComponentsComposeWin:bindComponents()

self.btnCompose=UIButton.get(self,0)
self.btnHelp=UIButton.get(self,1)
self.btnPut=UIButton.get(self,2)
self.btnQuickCompose=UIButton.get(self,3)
self.colorDropdown=UIDropdownEx.get(self,4)
self.composeResultPanel=UIObject.get(self,5)
self.costItem_1=UIBaseItem.get(self,6)
self.costItem_2=UIBaseItem.get(self,7)
self.diffAttr_1=UIObject.get(self,8)
self.diffAttr_2=UIObject.get(self,9)
self.emptyTips=UIText.get(self,10)
self.equipList=UIObject.get(self,11)
self.fullTips=UIText.get(self,12)
self.itemScrollView=UILoopListView.new(self,13)
self.leftItem=UIObject.get(self,14)
self.leftPanel=UIObject.get(self,15)
self.mainItem=UIBaseItem.get(self,16)
self.putBtnReddot=UIObject.get(self,17)
self.rightItem=UIObject.get(self,18)
self.targetItem=UIBaseItem.get(self,19)
self.typeDropdown=UIDropdownEx.get(self,20)
self.yunZhouContent=UIObject.get(self,21)
self.yunZhouPanel=UIObject.get(self,22)

self.btnCompose:setButtonClick(function()self:onBtnCompose()end)

self.btnHelp:setButtonClick(function()self:onBtnHelp()end)

self.btnPut:setButtonClick(function()self:onBtnPut()end)

self.btnQuickCompose:setButtonClick(function()self:onBtnQuickCompose()end)

self.itemScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)self.costItem={
self.costItem_1,
self.costItem_2,
}
self.diffAttr={
self.diffAttr_1,
self.diffAttr_2,
}



end


function UIYunZhouComponentsComposeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnCompose);self.btnCompose=nil;
_UIObject_release(self.btnHelp);self.btnHelp=nil;
_UIObject_release(self.btnPut);self.btnPut=nil;
_UIObject_release(self.btnQuickCompose);self.btnQuickCompose=nil;
_UIObject_release(self.colorDropdown);self.colorDropdown=nil;
_UIObject_release(self.composeResultPanel);self.composeResultPanel=nil;
_UIObject_release(self.costItem_1);self.costItem_1=nil;
_UIObject_release(self.costItem_2);self.costItem_2=nil;
_UIObject_release(self.diffAttr_1);self.diffAttr_1=nil;
_UIObject_release(self.diffAttr_2);self.diffAttr_2=nil;
_UIObject_release(self.emptyTips);self.emptyTips=nil;
_UIObject_release(self.equipList);self.equipList=nil;
_UIObject_release(self.fullTips);self.fullTips=nil;
self.itemScrollView:deleteSelf();self.itemScrollView=nil;
_UIObject_release(self.leftItem);self.leftItem=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.mainItem);self.mainItem=nil;
_UIObject_release(self.putBtnReddot);self.putBtnReddot=nil;
_UIObject_release(self.rightItem);self.rightItem=nil;
_UIObject_release(self.targetItem);self.targetItem=nil;
_UIObject_release(self.typeDropdown);self.typeDropdown=nil;
_UIObject_release(self.yunZhouContent);self.yunZhouContent=nil;
_UIObject_release(self.yunZhouPanel);self.yunZhouPanel=nil;
self.costItem=nil;
self.diffAttr=nil;
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
local _colomn=5
local _row=5
local _bag_filter_desc={}

function UIYunZhouComponentsComposeWin:onLoaded(...)
self:bindComponents()















self.loopListViewCmp=self.winlua:GetChildLoopListView2(self.itemScrollView:getID())
self.needGridNum=0
self.costItemNum=0
self.itemMap={}
end


function UIYunZhouComponentsComposeWin:__delete()
self:unbindComponents()
if not self.boat_id then
timeEventController.delayDo(0.02,function()
if not oneTabScreenController:isActiveUI()then
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eYunZhouComponentsWarehouse)
end
end)
end
end




function UIYunZhouComponentsComposeWin:onShow(argtable,afterOnloaded)
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

self.mainItemData=XianYunGangModel:getYunZhouComponentsPosData(self.boat_id,self.pos)
else
self.mainItemData=bagModel.getItem(itemguid)
end

self:refreshLeftYunZhouList()
self:refreshYunZhouEquipList()

self:mainItemChangeRefresh()
end

function UIYunZhouComponentsComposeWin:onComposeCallBack(itemguid)
if itemguid then
self.mainItemData=bagModel.getItem(itemguid)
end
self:mainItemChangeRefresh()
end


function UIYunZhouComponentsComposeWin:refreshLeftYunZhouList()
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

function UIYunZhouComponentsComposeWin:onClickYunZhouListItem(index)
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
self.mainItemData=yzItem
self.pos=pos
break
end
end
local itemid=self.mainItemData.itemid
local itemguid=self.mainItemData.itemguid
oneTabScreenController:changeArgs({itemid=itemid,itemguid=itemguid,boat_id=self.boat_id,pos=self.pos},true)
item=self.yunZhouContent:getChildLayoutGroupGridItem(self.boat_idx-1)
item:SetChildActive(1,true)
self:refreshYunZhouEquipList()
self:mainItemChangeRefresh()
end

function UIYunZhouComponentsComposeWin:refreshYunZhouEquipList()
if not self.boat_idx then
self.equipList:setActive(false)
return
end
local boatid=self.boat_id
local equipListWidget=self.equipList:getChildWidgetBase()

for pos=1,3 do
local widget=equipListWidget:GetChildCSGUIBaseItem(pos-1)
local equipData=XianYunGangModel:getYunZhouComponentsPosData(boatid,pos)
equipListWidget:SetChildActive(pos-1,true)
if equipData then
local itemid=equipData.itemid
local itemguid=equipData.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local jinglianStr=''
local iconName
local stage=itemConfig.stage
local showStage=stage~=nil
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

widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
widget:SetBaseItemChildIndex(-1,pos)
widget:SetBaseItemClickEvent(-1,function(...)self:onEquipedItemClick(...)end)
widget:SetBaseItemLongTouchEvent(-1,function(...)self:onEquipedItemLongClick(...)end)
else
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
widget:SetBaseItemChildIndex(-1,-1)
widget:SetBaseItemClickEvent(-1,nil)
widget:SetBaseItemLongTouchEvent(-1,nil)
end
end
end

function UIYunZhouComponentsComposeWin:onEquipedItemClick(id,pos,guid,attach)
if self.pos==pos then
return
end
local item=XianYunGangModel:getYunZhouComponentsPosData(self.boat_id,pos)
if item then
self.mainItemData=item
local equipListWidget=self.equipList:getChildWidgetBase()
local widget=equipListWidget:GetChildCSGUIBaseItem(self.pos-1)
widget:SetChildActive(_itemWidgetIdx.cmpSelect,false)
self.pos=pos
local itemid=self.mainItemData.itemid
local itemguid=self.mainItemData.itemguid
oneTabScreenController:changeArgs({itemid=itemid,itemguid=itemguid,pos=pos},true)
widget=equipListWidget:GetChildCSGUIBaseItem(self.pos-1)
widget:SetChildActive(_itemWidgetIdx.cmpSelect,true)
self:mainItemChangeRefresh()
end
end

function UIYunZhouComponentsComposeWin:onEquipedItemLongClick(id,pos,guid,attach)
local item=XianYunGangModel:getYunZhouComponentsPosData(self.boat_id,pos)
if item then
local itemid=item.itemid
local itemguid=item.itemguid
tipsManager.showTips({itemguid=itemguid,itemid=itemid,attach={yzId=self.boat_id,pos=pos}})
end
end

function UIYunZhouComponentsComposeWin:mainItemChangeRefresh()
if self.mainItemData then
self.emptyTips:setActive(false)
self.composeResultPanel:setActive(true)
self:setDiffAttr()
else
self.emptyTips:setActive(true)
self.composeResultPanel:setActive(false)

if self.mainItemBagIdx then
self:onSelectBagItem(self.mainItemBagIdx,false)
self.mainItemBagIdx=nil
end
if self.costItemBagIdx1 then
self:onSelectBagItem(self.costItemBagIdx1,false)
self.costItemBagIdx1=nil
end
if self.costItemBagIdx2 then
self:onSelectBagItem(self.costItemBagIdx2,false)
self.costItemBagIdx2=nil
end
end
self.costItemData1=nil
self.costItemData2=nil
self.itemMap={}
local itemid=self.mainItemData.itemid
local cfg=cfgHelper.get1(cfg_boatequipmakeconfig_get,itemid)
if cfg then
local needitem=cfg.needitem or{}
self.needGridNum=cfg.exitem_num
self.costItemNum=#needitem
self.itemMap=cfg.exitem_map
if needitem[1]then
local needitemid,neednum=unpack(needitem[1])
self.costItemData1={itemid=needitemid,neednum=neednum}
end
if needitem[2]then
local needitemid,neednum=unpack(needitem[2])
self.costItemData2={itemid=needitemid,neednum=neednum}
end
self.fullTips:setActive(false)
else
self.fullTips:setActive(true)
end
self:freshItemGrids()
self:setCostItem()
self:setCostMoney()
self:setMainOrTargetItem(1)
self:setMainOrTargetItem(2)
self:refreshQuickCompose()
self:onBtnPut(true)
end

function UIYunZhouComponentsComposeWin:setDiffAttr()
local itemid=self.mainItemData.itemid
local cfg=cfgHelper.get1(cfg_boatequipmakeconfig_get,itemid)
if not cfg then
self.composeResultPanel:setActive(false)
return
end
local target=cfg.target
local oldItemConfig=itemsConfig.getConfig(itemid)
local newItemConfig=itemsConfig.getConfig(target)













local oldAttrs=oldItemConfig.static
local newAttrs=newItemConfig.static
for i,v in ipairs(self.diffAttr)do
if oldAttrs[i]and newAttrs[i]then
v:setActive(true)
local widget=v:getWidgetBase()
local attrType,attrValue=unpack(oldAttrs[i])
local name,valstr=equipsHelper.getAttr(attrType,attrValue,TO_INT_TYPE.eDown)
local yzAttrName=yunZhouEquipsConfig.getYunZhouSpecialAttrName(attrType)
if yzAttrName then
name=yzAttrName
end
widget:SetChildText(0,string.format("%s：",name))
widget:SetChildText(1,valstr)
attrType,attrValue=unpack(newAttrs[i])
name,valstr=equipsHelper.getAttr(attrType,attrValue,TO_INT_TYPE.eDown)
widget:SetChildText(2,valstr)
else
v:setActive(false)
end
end

end

function UIYunZhouComponentsComposeWin:setMainOrTargetItem(type)
local item=type==1 and self.mainItem or self.targetItem
local itemWidget=self:getChildCSGUIBaseItem(item:getID())
if self.mainItemData then
local itemid=self.mainItemData.itemid
if type==2 then
local cfg=cfgHelper.get1(cfg_boatequipmakeconfig_get,itemid)
itemid=cfg and cfg.target or itemid
end
local itemguid=self.mainItemData.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local iconName=iconHelper.getIconName(itemid)
local suitid=itemConfig.type2
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,suitid,itemConfig.color)
local suitIconName=string.format("icon_suit_%d",suitConfig.icon)
widgetHelper.setItemQulaity(itemWidget,itemid,0)
itemWidget:SetChildIcon(1,iconName,false)
itemWidget:SetChildText(2,'')
itemWidget:SetChildActive(3,false)
itemWidget:SetChildText(4,'')
itemWidget:SetChildActive(5,false)
itemWidget:SetChildActive(6,false)
itemWidget:SetChildGroundStarNum(7,itemConfig.stage)
itemWidget:SetChildStarNumber(7,itemConfig.stage)
itemWidget:SetChildIcon(8,suitIconName,false)
if type==1 then
itemWidget:SetBaseItemClickEvent(-1,function()
tipsManager.showTips({itemguid=itemguid,itemid=itemid,attach={yzId=self.boat_id,pos=self.pos}})
end)
itemWidget:SetBaseItemLongTouchEvent(-1,function()
tipsManager.showTips({itemguid=itemguid,itemid=itemid,attach={yzId=self.boat_id,pos=self.pos}})
end)
else
itemWidget:SetBaseItemClickEvent(-1,function()
tipsManager.showTips({itemid=itemid})
end)
itemWidget:SetBaseItemLongTouchEvent(-1,function()
tipsManager.showTips({itemid=itemid})
end)
end
else
itemWidget:SetChildActive(0,false)
itemWidget:SetChildActive(1,false)
itemWidget:SetChildText(2,'')
itemWidget:SetChildActive(3,false)
itemWidget:SetChildText(4,'')
itemWidget:SetChildActive(5,false)
itemWidget:SetChildActive(6,type==1)
itemWidget:SetChildGroundStarNum(7,0)
itemWidget:SetChildStarNumber(7,0)
itemWidget:SetChildActive(8,false)
itemWidget:SetBaseItemClickEvent(-1,nil)
itemWidget:SetBaseItemLongTouchEvent(-1,nil)
end
end

function UIYunZhouComponentsComposeWin:setCostItem(refreshIdx)
local costItemDatas={self.costItemData1,self.costItemData2}
local refreshCostItem=function(idx)
local item=self.costItem[idx]
local itemWidget=self:getChildCSGUIBaseItem(item:getID())
local costItemData=costItemDatas[idx]
if costItemData then
local itemid=costItemData.itemid
local itemguid=costItemData.itemguid
local neednum=costItemData.neednum
local itemConfig=itemsConfig.getConfig(itemid)
local iconName=iconHelper.getIconName(itemid)
local isEquip=itemsConfig.isYunZhouComponents(itemid)
local star=isEquip and itemConfig.stage or 0
local suitIconName=''
if isEquip then
local suitid=itemConfig.type2
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,suitid,itemConfig.color)
suitIconName=string.format("icon_suit_%d",suitConfig.icon)
end
local countStr=''
if neednum then
local has=itemsModel.getCount(itemid)
countStr=has>=neednum and string.format("%d/%d",has,neednum)or string.format("<color=#c82c2c>%d</color>/%d",has,neednum)
end
widgetHelper.setItemQulaity(itemWidget,itemid,0)
itemWidget:SetChildIcon(1,iconName,false)
itemWidget:SetChildText(2,countStr)
itemWidget:SetChildActive(3,countStr~='')
itemWidget:SetChildText(4,'')
itemWidget:SetChildActive(5,false)
itemWidget:SetChildActive(6,false)
itemWidget:SetChildActive(7,false)
itemWidget:SetChildGroundStarNum(8,star)
itemWidget:SetChildStarNumber(8,star)
itemWidget:SetChildIcon(9,suitIconName,false)
itemWidget:SetBaseItemClickEvent(-1,function()
tipsManager.showTips({itemguid=itemguid,itemid=itemid})
end)
itemWidget:SetBaseItemLongTouchEvent(-1,function()
tipsManager.showTips({itemguid=itemguid,itemid=itemid})
end)
else
itemWidget:SetChildActive(0,false)
itemWidget:SetChildActive(1,false)
itemWidget:SetChildText(2,'')
itemWidget:SetChildActive(3,false)
itemWidget:SetChildText(4,'')
itemWidget:SetChildActive(5,false)
itemWidget:SetChildActive(6,idx<=self.needGridNum+self.costItemNum)
itemWidget:SetChildActive(7,idx>self.needGridNum+self.costItemNum)
itemWidget:SetChildGroundStarNum(8,0)
itemWidget:SetChildStarNumber(8,0)
itemWidget:SetChildActive(9,false)
itemWidget:SetBaseItemClickEvent(-1,nil)
itemWidget:SetBaseItemLongTouchEvent(-1,nil)
end
end
if refreshIdx then
refreshCostItem(refreshIdx)
else
for idx=1,#self.costItem do
refreshCostItem(idx)
end
end
end

function UIYunZhouComponentsComposeWin:setCostMoney()
local components={}
components[#components+1]=self.leftItem
components[#components+1]=self.rightItem

local item=self.mainItemData
local itemid=item.itemid
local cfg=cfgHelper.get1(cfg_boatequipmakeconfig_get,itemid)
local consume=cfg and cfg.consume or{}
for i,v in ipairs(components)do
local costInfo=consume[i]
v:setActive(costInfo~=nil)
if costInfo then
local itemid=costInfo[1]
local cost=costInfo[2]
local has=moneyModel.getMoney(itemid)
local costStr=has>=cost and cost or FMT.cfmt(FONT_COLOR.eRedColor,cost)

local widget=self.winlua:GetChildWidgetBase(v:getID())
widget:SetChildIcon(0,iconHelper.getIconName(itemid),false)
widget:SetChildText(1,costStr)
end
end
end

function UIYunZhouComponentsComposeWin:refreshQuickCompose()
local itemList=self:putBagItem(2)
local isShowQuickBtn=#itemList<self.needGridNum
self.btnQuickCompose:setActive(isShowQuickBtn)
end

function UIYunZhouComponentsComposeWin:onStartAction()

end

function UIYunZhouComponentsComposeWin:onSortBag(bagList)
local sortTag={}
for i,v in ipairs(bagList)do
local guidStr=tostring(v.itemguid)
local len=string.len(guidStr)
local numStr=string.sub(guidStr,len-3,len)
local guidNum=tonumber(numStr)
local itemid=v.itemid
local itemData=v.itemData
local cfg=itemsConfig.getConfig(itemid)
local color=cfg.color
local stage=cfg.stage or 0
local isMap=self.itemMap[itemid]~=nil
local val=0
local jinglianlv=itemData and(itemData.jinglianlv or 0)or 0
if not isMap then
val=val-1000000000
end
val=val+10000000*color+1000000*stage+0.0001*itemid-guidNum+jinglianlv*10000
sortTag[guidStr]=val
end

table.sort(bagList,function(a,b)
local itemguid_a=tostring(a.itemguid)
local itemguid_b=tostring(b.itemguid)
return sortTag[itemguid_a]>sortTag[itemguid_b]
end)
end

function UIYunZhouComponentsComposeWin:freshItemGrids()
local filter={}
local itemid=self.mainItemData.itemid
local itemguid=self.mainItemData.itemguid
local itemConfig=itemsConfig.getConfig(itemid)


filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eEquals,{itemConfig.type1}}
filter[ITEM_FILTER_TYPE.eItemType2]={ITEM_FILTER_COMPARE.eEquals,{itemConfig.type2}}



filter[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eNot,{itemguid}}
filter[ITEM_FILTER_TYPE.eIsLock]=false

self.bagList=bagControl.getBagItemsByFilter(BAG_TYPE.eYunZhou,filter)
self:onSortBag(self.bagList)
local rNum=math.ceil(#self.bagList/_colomn)
local pageNum=_row
if rNum<pageNum then rNum=pageNum end
local createList={}
for i=1,rNum do createList[#createList+1]=i end
self.itemScrollView:initData('itemPanel',createList)
end

function UIYunZhouComponentsComposeWin:getBagItemIdx(itemguid)
local list=self.bagList or{}
for i,v in ipairs(list)do
if tostring(v.itemguid)==tostring(itemguid)then
local idx=i%_colomn
return math.ceil(i/_colomn),idx==0 and _colomn-1 or idx-1
end
end
end

function UIYunZhouComponentsComposeWin:onFreshAction(index,itemWidget)
local idx=(index-1)*_colomn+1

for i=0,_colomn-1 do
local widget=itemWidget:GetChildCSGUIBaseItem(i)
local bagIdx=idx+i
local itemInfo=self.bagList[bagIdx]
local isTemp=itemInfo==nil
if not isTemp then
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local stage=itemConfig.stage
local showStage=false
local iconName=itemsModel.getIconName(itemInfo)
local stageStr=''
local isSelect=self:checkContainBagItem(itemguid)
local suitid=itemConfig.type2
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,suitid,color)
local suitIconName=string.format("icon_suit_%d",suitConfig.icon)
local star=stage
local item=bagModel.getItem(itemguid)
local isLock=item and bagHelper.isLock(item)
local jinglianlv=itemInfo.itemData and itemInfo.itemData.jinglianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('{0}级',jinglianlv)or''
local isMap=self.itemMap[itemid]~=nil
widgetHelper.setItemQulaity(widget,itemid,1)
widget:SetChildActive(2,true)
widget:SetChildIcon(2,iconName,false)
widget:SetChildActive(3,isSelect)
widget:SetChildActive(4,showStage)
widget:SetChildText(5,stageStr)
widget:SetChildActive(6,jinglianStr~='')
widget:SetChildText(7,jinglianStr)
widget:SetChildIcon(8,suitIconName,false)
widget:SetChildActive(9,isLock)
widget:SetChildGroundStarNum(10,star)
widget:SetChildStarNumber(10,star)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
widget:SetBaseItemChildIndex(-1,bagIdx)
widget:SetBaseItemClickEvent(-1,function(...)self:onBagItemClick(...)end)
widget:SetBaseItemLongTouchEvent(-1,function(...)self:onBagItemLongClick(...)end)
widget:SetChildGray(2,not isMap)
else
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
widget:SetChildActive(4,false)
widget:SetChildText(5,'')
widget:SetChildActive(6,false)
widget:SetChildText(7,'')
widget:SetChildIcon(8,'',false)
widget:SetChildActive(9,false)
widget:SetChildGroundStarNum(10,0)
widget:SetChildStarNumber(10,0)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
widget:SetBaseItemChildIndex(-1,-1)
widget:SetBaseItemClickEvent(-1,nil)
widget:SetBaseItemLongTouchEvent(-1,nil)
end
end
end


function UIYunZhouComponentsComposeWin:onBagItemClick(itemid,bagIdx,itemguid,attach)
if not self.mainItemData then
self.mainItemData=bagModel.getItem(itemguid)
self.mainItemBagIdx=bagIdx
self:onSelectBagItem(bagIdx,true)
self:mainItemChangeRefresh()
else
if tostring(self.mainItemData.itemguid)==tostring(itemguid)then
self.mainItemData=nil
self:mainItemChangeRefresh()
else
if self.costItemNum<2 then
if self.costItemData1 and tostring(self.costItemData1.itemguid)==tostring(itemguid)then
self.costItemData1=nil
self.costItemBagIdx1=nil
self:onSelectBagItem(bagIdx,false)
self:setCostItem(1)
elseif self.costItemData2 and tostring(self.costItemData2.itemguid)==tostring(itemguid)then
self.costItemData2=nil
self.costItemBagIdx2=nil
self:onSelectBagItem(bagIdx,false)
self:setCostItem(2)
elseif self.itemMap[itemid]==nil then
return
elseif not self.costItemData1 and self.needGridNum>=1 then
self.costItemData1=bagModel.getItem(itemguid)
self.costItemBagIdx1=bagIdx
self:onSelectBagItem(bagIdx,true)
self:setCostItem(1)
elseif not self.costItemData2 and self.needGridNum+self.costItemNum>=2 then
self.costItemData2=bagModel.getItem(itemguid)
self.costItemBagIdx2=bagIdx
self:onSelectBagItem(bagIdx,true)
self:setCostItem(2)
else

return
end
end
end
end
end

function UIYunZhouComponentsComposeWin:onBagItemLongClick(itemid,bagIdx,itemguid,attach)
local item=bagModel.getItem(itemguid)
if item then
tipsManager.showTips({itemguid=itemguid,itemid=itemid})
end
end


function UIYunZhouComponentsComposeWin:checkContainBagItem(itemguid)
if self.costItemData1 and self.costItemData1.itemguid and tostring(self.costItemData1.itemguid)==tostring(itemguid)then
return true
end
if self.costItemData2 and self.costItemData2.itemguid and tostring(self.costItemData2.itemguid)==tostring(itemguid)then
return true
end
return false
end


function UIYunZhouComponentsComposeWin:putBagItem(num)
num=num or 1
local list=self.bagList or{}
local temp={}
for idx,v in ipairs(list)do
if not self:checkContainBagItem(v.itemguid)and self.itemMap[v.itemid]~=nil then
table.insert(temp,{v,idx})
if#temp>=num then
break
end
end
end
return temp
end


function UIYunZhouComponentsComposeWin:onSelectBagItem(bagIdx,flag)
local idx=math.ceil(bagIdx/_colomn)
local rIdx=bagIdx%_colomn
local subIdx=rIdx==0 and _colomn-1 or rIdx-1
local item=self.loopListViewCmp:GetShownItemByIndex(idx-1)
if item then
local widget=item.Widget:GetChildWidgetBase(subIdx)
widget:SetChildActive(3,flag)
end
end


function UIYunZhouComponentsComposeWin:setDropdowns()
local typeDescList=_bag_filter_desc[ITEM_FILTER_TYPE.eItemType1]
self.typeDropdown:setOption(typeDescList)
self.typeIdx=0
self.typeDropdown:setValue(self.typeIdx)

local colorDescList=_bag_filter_desc[ITEM_FILTER_TYPE.eColor]
self.colorDropdown:setOption(colorDescList)
self.colorIdx=eQualityColor.eRed
self.colorDropdown:setValue(self.colorIdx)
end


function UIYunZhouComponentsComposeWin:onDropdownChange(dropidx,idx)

if dropidx==ITEM_FILTER_TYPE.eItemType1 then
if self.typeIdx~=idx then
self.typeIdx=idx
self:freshItemGrids()
end
elseif dropidx==ITEM_FILTER_TYPE.eColor then
if self.colorIdx~=idx+1 then
self.colorIdx=idx+1
self:freshItemGrids()
end
end
end


function UIYunZhouComponentsComposeWin:onBtnPut(noTips)
local putFlag=noTips or false
if self.needGridNum>=2 then
local itemList=self:putBagItem(2)
if not self.costItemData1 and itemList[1]then
putFlag=true
local data,bagIdx=unpack(itemList[1])
table.remove(itemList,1)
self.costItemData1=data
self.costItemBagIdx1=bagIdx
self:onSelectBagItem(bagIdx,true)
self:setCostItem(1)
end
if not self.costItemData2 and itemList[1]then
putFlag=true
local data,bagIdx=unpack(itemList[1])
self.costItemData2=data
self.costItemBagIdx2=bagIdx
self:onSelectBagItem(bagIdx,true)
self:setCostItem(2)
end
if not putFlag and(not self.costItemData1 or not self.costItemData2)then
UIManager.info("没有合适副阵器合成")
end
elseif self.needGridNum>=1 then
local itemList=self:putBagItem(1)
if#itemList>0 then
if not self.costItemData1 then
putFlag=true
local data,bagIdx=unpack(itemList[1])
self.costItemData1=data
self.costItemBagIdx1=bagIdx
self:onSelectBagItem(bagIdx,true)
self:setCostItem(1)
elseif not self.costItemData2 and self.costItemNum==1 then
putFlag=true
local data,bagIdx=unpack(itemList[1])
self.costItemData2=data
self.costItemBagIdx2=bagIdx
self:onSelectBagItem(bagIdx,true)
self:setCostItem(2)
end
end
if not putFlag and(not self.costItemData1 or(not self.costItemData2 and self.costItemNum==1))then
UIManager.info("没有合适副阵器合成")
end
end
end

function UIYunZhouComponentsComposeWin:onBtnCompose()
local item=self.mainItemData
local itemguid=item.itemguid
local itemid=item.itemid
local cfg=cfgHelper.get1(cfg_boatequipmakeconfig_get,itemid)
if not cfg then
return
end
local consume=cfg.consume or{}
for i,v in ipairs(consume)do
local itemid=v[1]
local cost=v[2]
local has=itemsModel.getCount(itemid)
if has<cost then
local itemName=itemsConfig.getItemName(itemid)
UIManager.error(FMT.fmt('{0}不足，不可合成',itemName))
gainControl:showGainWin(itemid)
return
end
end
local needitem=cfg.needitem or{}
for i,v in ipairs(needitem)do
local itemid=v[1]
local cost=v[2]
local has=itemsModel.getCount(itemid)
if has<cost then
local itemName=itemsConfig.getItemName(itemid)
UIManager.error(FMT.fmt('{0}不足，不可合成',itemName))
gainControl:showGainWin(itemid)
return
end
end

local equipsTemp={}
local costItemDatas={self.costItemData1,self.costItemData2}
for i,costItemData in ipairs(costItemDatas)do
if costItemData then
local itemguid=costItemData.itemguid
local itemid=costItemData.itemid
if itemsConfig.isYunZhouComponents(itemid)then
equipsTemp[#equipsTemp+1]=itemguid
end
end
end
if#equipsTemp<self.needGridNum then
UIManager.error('材料不足，不可合成')
return
end

if#equipsTemp>self.needGridNum then
loggerUtil.logErrFMT("消耗阵器数量大于合成所需数量")
return
end

local pos=0
local guid=itemguid
if self.boat_id then
guid=int64.new(self.boat_id)
pos=self.pos
end
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eYunZhouComponentsComposeTips)
if needitem[1]and not check then
local itemid=needitem[1][1]
local itemnum=needitem[1][2]
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local costStr=FMT.cfmt(color,string.format("%s*%d",itemConfig.name,itemnum))
local content=string.format('是否消耗%s进行阵器合成?',costStr)
local showdata=
{
type='UIDialouge',
title='阵器合成',
content=content,
oktext='确认',
canceltext='取消',
choosetext='今日不再提示',
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eYunZhouComponentsComposeTips,flag)
end,
okcallback=function()
XianYunGangController.reqYunZhouComponentsCompose(guid,pos,#equipsTemp,equipsTemp)
end,
showclosebtn=true,
}
self.tipsDialog=UIDialogManager.newDialog(showdata)
self.tipsDialog:show()
else
XianYunGangController.reqYunZhouComponentsCompose(guid,pos,#equipsTemp,equipsTemp)
end
end

function UIYunZhouComponentsComposeWin:onBtnQuickCompose()
local target_id
local costNum=0
for itemid,_ in pairs(self.itemMap)do
local flag,qCost=yunZhouEquipsConfig.checkEquipQuickCompose(itemid)
if flag then
target_id=itemid
costNum=qCost
break
end
end
if not target_id then
local mainItemid=self.mainItemData.itemid
local quick_make_list=cfgHelper.get2(cfg_boatequipmakeconfig_get,mainItemid,"quick_make_list")or{}
for i,v in ipairs(quick_make_list)do
local flag,qCost=yunZhouEquipsConfig.checkEquipQuickCompose(v)
if flag then
target_id=v
costNum=qCost
break
end
end
if not target_id then
local quick_make_itemid=cfgHelper.get2(cfg_boatequipmakeconfig_get,mainItemid,"quick_make_itemid")
if quick_make_itemid then
local flag,qCost=yunZhouEquipsConfig.checkEquipQuickCompose(quick_make_itemid)
if flag then
target_id=quick_make_itemid
costNum=qCost
else
local quick_make_list=cfgHelper.get2(cfg_boatequipmakeconfig_get,quick_make_itemid,"quick_make_list")or{}
for i,v in ipairs(quick_make_list)do
local flag,qCost=yunZhouEquipsConfig.checkEquipQuickCompose(v)
if flag then
target_id=v
costNum=qCost
break
end
end
end
end
end
end

if target_id then
local itemConfig=itemsConfig.getConfig(target_id)
local make_itemid_config=cfgHelper.get1(cfg_boatequipmakeconfig_get,target_id)
local costType=make_itemid_config.consume[1][1]
local itemName=toColorString(itemConfig.color,string.format("%d星%s",itemConfig.stage,itemConfig.name))
local args={
itemid=target_id,
cost={costType,costNum},
desc=string.format('当前阵库中可快速合成1个[%s]',itemName),
okfunc=function()
local has=itemsModel.getCount(costType)
if has<costNum then
gainControl:showGainWin(costType)
return
end
XianYunGangController.reqYunZhouComponentsQuickCompose(target_id)
end,
}
self:showWindow("UIYunZhouComponentsQuickComposeWin",args)
else
local mainItemid=self.mainItemData.itemid
local quick_make_itemid=cfgHelper.get2(cfg_boatequipmakeconfig_get,mainItemid,"quick_make_itemid")
if quick_make_itemid then
local item=yunZhouBagModel:getItemByItemID(quick_make_itemid)
if item then
local make_itemid_config=cfgHelper.get1(cfg_boatequipmakeconfig_get,quick_make_itemid)
local costType,costNum=unpack(make_itemid_config.consume[1])
local target_id=make_itemid_config.target
local itemConfig=itemsConfig.getConfig(target_id)
local needitemId,needitemNum=unpack(make_itemid_config.needitem[1])
local needItemConfig=itemsConfig.getConfig(needitemId)
local needItemName=toColorString(needItemConfig.color,needItemConfig.name)
local itemName=toColorString(itemConfig.color,string.format("%d星%s",itemConfig.stage,itemConfig.name))
local args={
itemid=target_id,
cost={costType,costNum},
desc=string.format('是否消耗%d个[%s]合成至[%s]',needitemNum,needItemName,itemName),
okfunc=function()
local has=itemsModel.getCount(needitemId)
if has<needitemNum then
UIManager.info(string.format("%s不足，无法合成",needItemConfig.name))
gainControl:showGainWin(needitemId)
return
end
local has=itemsModel.getCount(costType)
if has<costNum then
UIManager.info(string.format("%s不足，无法合成",moneyModel.getMoneyName(costType)))
gainControl:showGainWin(costType)
return
end
XianYunGangController.reqYunZhouComponentsCompose(item.itemguid,0,0,{},true)
end,
}
self:showWindow("UIYunZhouComponentsQuickComposeWin",args)
else
UIManager.info("当前阵器数量不足")
end
else
UIManager.info("当前阵器数量不足")
end
end
end

function UIYunZhouComponentsComposeWin:onBtnHelp()
local d={}
d.title='规则'
d.mode=3
d.name='yzzqhc_help_%d'
UIManager:showWindow('UIRuleWin',d)
end
