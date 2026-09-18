







def_class("UIYunZhouWarehouseWin",UIWindowBase)









function UIYunZhouWarehouseWin:bindComponents()

self.composeBtn=UIButton.get(self,0)
self.filter_1=UIToggleButton.get(self,1)
self.filter_2=UIToggleButton.get(self,2)
self.filter_3=UIToggleButton.get(self,3)
self.itemScrollView=UILoopListView.new(self,4)
self.qualityDropdown=UIDropdownEx.get(self,5)

self.composeBtn:setButtonClick(function()self:onComposeBtn()end)

self.itemScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)self.filter={
self.filter_1,
self.filter_2,
self.filter_3,
}



end


function UIYunZhouWarehouseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.composeBtn);self.composeBtn=nil;
_UIObject_release(self.filter_1);self.filter_1=nil;
_UIObject_release(self.filter_2);self.filter_2=nil;
_UIObject_release(self.filter_3);self.filter_3=nil;
self.itemScrollView:deleteSelf();self.itemScrollView=nil;
_UIObject_release(self.qualityDropdown);self.qualityDropdown=nil;
self.filter=nil;
end


















local _colomn=10
local _row=5
local _bag_filter_desc={}

function UIYunZhouWarehouseWin:onLoaded(...)
self:bindComponents()
self.qualityDropdown:setChangeAction(function(...)self:onDropdownChange(ITEM_FILTER_TYPE.eColor,...)end)
local colorlist=table.toTable(eQualityColor.eGreen,eQualityColor.eRed)
_bag_filter_desc[ITEM_FILTER_TYPE.eColor]=itemsFilterHelper.getFilterNames(colorlist,function(color)
return FMT.fmt('{0}及以下',eQualityColorName[color])
end)

self.filterData=XianYunGangModel:getYunZhouComponentsWarehouseFilterData()
self.colorIdx=self.filterData[1]
self.filterType=self.filterData[2]
for i,v in ipairs(self.filterType)do
self.filter[i]:setToggle(v)
end
self.filter_1:setToggleChange(function(...)self:onfilterToggleChanged(1,...)end)
self.filter_2:setToggleChange(function(...)self:onfilterToggleChanged(2,...)end)
self.filter_3:setToggleChange(function(...)self:onfilterToggleChanged(3,...)end)

self._onItemLockChanged=function(...)self:onItemLockChanged(...)end
self:addNotify(notifyConfig.on_item_lock_changed,self._onItemLockChanged)

self.loopListViewCmp=self.winlua:GetChildLoopListView2(self.itemScrollView:getID())
end


function UIYunZhouWarehouseWin:__delete()
self.qualityDropdown:setChangeAction(nil)
self:unbindComponents()
end




function UIYunZhouWarehouseWin:onShow(argtable,afterOnloaded)
self.selectBagType=BAG_TYPE.eYunZhou

self:setDropdowns()
self:freshItemGrids()
end

function UIYunZhouWarehouseWin:onSortBag(bagList)
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
local isSelect=false
local val=0
local jinglianlv=itemData and(itemData.jinglianlv or 0)or 0
if isSelect then
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

function UIYunZhouWarehouseWin:freshItemGrids()
local filter={}
filter[ITEM_FILTER_TYPE.eColor]={ITEM_FILTER_COMPARE.eLessEqulas,{self.colorIdx}}
local typeList={}
for i,v in pairs(self.filterType)do
if v then
table.insert(typeList,i)
end
end
filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eEquals,typeList}
self.bagList=bagControl.getBagItemsByFilter(self.selectBagType,filter)
self:onSortBag(self.bagList)
local rNum=math.ceil(#self.bagList/_colomn)
local pageNum=_row
if rNum<pageNum then rNum=pageNum end
local createList={}
for i=1,rNum do createList[#createList+1]=i end
self.itemScrollView:initData('itemPanel',createList)
end

function UIYunZhouWarehouseWin:getBagItemIdx(itemguid)
local list=self.bagList or{}
for i,v in ipairs(list)do
if tostring(v.itemguid)==tostring(itemguid)then
local idx=i%_colomn
return math.ceil(i/_colomn),idx==0 and _colomn-1 or idx-1
end
end
end

function UIYunZhouWarehouseWin:onItemLockChanged(itemid,itemguid,isUnlock)
local idx,subIdx=self:getBagItemIdx(itemguid)
if idx then
local item=self.loopListViewCmp:GetShownItemByItemIndex(idx-1)
local widget=item.Widget:GetChildWidgetBase(subIdx)
widget:SetChildActive(9,not isUnlock)
end
end

function UIYunZhouWarehouseWin:onStartAction()

end

function UIYunZhouWarehouseWin:onFreshAction(index,itemWidget)
local idx=(index-1)*_colomn+1

for i=0,_colomn-1 do
local widget=itemWidget:GetChildCSGUIBaseItem(i)
local itemInfo=self.bagList[idx+i]
local isTemp=itemInfo==nil
if not isTemp then
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local stage=itemConfig.stage
local showStage=false
local iconName=itemsModel.getIconName(itemInfo)
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=''
local isSelect=false
local jinglianStr=''
local suitid=itemConfig.type2
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,suitid,color)
local suitIconName=string.format("icon_suit_%d",suitConfig.icon)
local star=stage
local item=bagModel.getItem(itemguid)
local isLock=item and bagHelper.isLock(item)
local jinglianlv=itemInfo.itemData and itemInfo.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('{0}级',jinglianlv)or''
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

widget:SetChildButtonClick(-1,function(...)
tipsManager.showTips({formType=TIPS_FORM_TYPE.eYunZhouWarehouse,itemguid=itemguid,itemid=itemid,attach={yzId=-1,pos=-1}})
end)
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
end
end
end


function UIYunZhouWarehouseWin:setDropdowns()
local colorDescList=_bag_filter_desc[ITEM_FILTER_TYPE.eColor]
self.qualityDropdown:setOption(colorDescList)

self.qualityDropdown:setValue(self.colorIdx-1)
end


function UIYunZhouWarehouseWin:onDropdownChange(dropidx,idx)

if dropidx==ITEM_FILTER_TYPE.eColor then
if self.colorIdx~=idx+1 then
self.colorIdx=idx+1
self.filterData[1]=self.colorIdx
XianYunGangModel:setYunZhouComponentsWarehouseFilterData(self.filterData)
self:freshItemGrids()
end
end
end

function UIYunZhouWarehouseWin:onfilterToggleChanged(type,name,isToggle,data)
self.filterType[type]=isToggle
self.filterData[2]=self.filterType
XianYunGangModel:setYunZhouComponentsWarehouseFilterData(self.filterData)
self:freshItemGrids()
end


function UIYunZhouWarehouseWin:onComposeBtn()

end
