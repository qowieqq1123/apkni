







def_class("UIYunZhouComponentsGainWin",UIWindowBase)









function UIYunZhouComponentsGainWin:bindComponents()

self.btnClose=UIButton.get(self,0)
self.itemScrollView=UILoopListView.new(self,1)
self.jumpText=UILinkImageText.get(self,2)
self.mask=UIButton.get(self,3)
self.root=UIObject.get(self,4)
self.suitDropdown=UIDropdownEx.get(self,5)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.itemScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.mask:setButtonClick(function()self:onMask()end)



end


function UIYunZhouComponentsGainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnClose);self.btnClose=nil;
self.itemScrollView:deleteSelf();self.itemScrollView=nil;
_UIObject_release(self.jumpText);self.jumpText=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.suitDropdown);self.suitDropdown=nil;
end



















local _colomn=1
local _bag_filter_desc={}

function UIYunZhouComponentsGainWin:onLoaded(...)
self:bindComponents()
self.suitDropdown:setChangeAction(function(...)self:onDropdownChange(ITEM_FILTER_TYPE.eItemType2,...)end)
self.suitIdList=table.toTable(1,#cfg_boatequipsuitconfig())
_bag_filter_desc[ITEM_FILTER_TYPE.eItemType2]=itemsFilterHelper.getFilterNames(self.suitIdList,function(suit)
return cfgHelper.get3(cfg_boatequipsuitconfig_get,suit,1,"name")
end,"全部套装")
end


function UIYunZhouComponentsGainWin:__delete()
self:unbindComponents()
end




function UIYunZhouComponentsGainWin:onShow(argtable,afterOnloaded)
self.selectBagType=BAG_TYPE.eYunZhou
argtable=argtable or{}
self.pos=argtable.pos or 1
self.boat_id=argtable.boat_id
self:setDropdowns()
self:freshItemGrids()
end

function UIYunZhouComponentsGainWin:onSortBag(bagList)
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

function UIYunZhouComponentsGainWin:freshItemGrids()
local filter={}
local typeList={}
if self.suitIdx==0 then
typeList=self.suitIdList
else
typeList[1]=self.suitIdx
end
filter[ITEM_FILTER_TYPE.eItemType2]={ITEM_FILTER_COMPARE.eEquals,typeList}

filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eEquals,{self.pos}}
self.bagList=bagControl.getBagItemsByFilter(self.selectBagType,filter)
self:onSortBag(self.bagList)
local rNum=math.ceil(#self.bagList/_colomn)
local createList={}
for i=1,rNum do createList[#createList+1]=i end
self.itemScrollView:initData('item',createList)

if#createList<=0 then
local defaultItems=cfgHelper.get2(cfg_boatequipbaseconfig_get,1,"defaultItems")
local itemid=defaultItems[self.pos]
local link=FMT.fmt("当前没有任何阵器可用<a;前往获取;{0};1;25,{1};/>",FONT_COLOR.eOrangeColor,itemid)
self.jumpText:setText(link)
self.jumpText:setActive(true)
else
self.jumpText:setActive(false)
end
end

function UIYunZhouComponentsGainWin:onStartAction()

end

function UIYunZhouComponentsGainWin:onFreshAction(index,widget)
local idx=(index-1)*_colomn+1

for i=0,_colomn-1 do
local itemInfo=self.bagList[idx+i]
local isTemp=itemInfo==nil
if not isTemp then
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local stage=itemConfig.stage
local iconName=itemsModel.getIconName(itemInfo)
local jinglianlv=itemInfo.itemData and(itemInfo.itemData.jinglianlv or 0)or 0
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,itemConfig.type2,color)
widget:SetChildActive(-1,true)
widgetHelper.setItemQulaity(widget,itemid,1)
widget:SetChildActive(2,true)
widget:SetChildIcon(2,iconName,false)
widget:SetChildActive(3,jinglianlv>0)
widget:SetChildText(4,jinglianlv>0 and string.format("%d级",jinglianlv)or"")
widget:SetChildIcon(5,string.format("icon_suit_%d",suitConfig.icon),false)
local starWidget=widget:GetChildWidgetBase(6)
for i=1,5 do
starWidget:SetChildActive(i-1,i<=stage)
end
widget:SetChildText(7,itemConfig.name)
widget:SetChildText(8,"")
widget:SetChildButtonClick(-1,function(...)
tipsManager.showTips({itemguid=itemguid,itemid=itemid})
end)
widget:SetChildButtonClick(9,function(...)
XianYunGangController.reqYunZhouComponentsEquip(self.boat_id,itemguid)
self:closeSelf()
end)
else
widget:SetChildActive(-1,false)
end
end
end


function UIYunZhouComponentsGainWin:setDropdowns()
local suitDescList=_bag_filter_desc[ITEM_FILTER_TYPE.eItemType2]
self.suitDropdown:setOption(suitDescList)

self.suitIdx=0

self.suitDropdown:setValue(self.suitIdx)
end


function UIYunZhouComponentsGainWin:onDropdownChange(dropidx,idx)

if dropidx==ITEM_FILTER_TYPE.eItemType2 then
if self.suitIdx~=idx then
self.suitIdx=idx
self:freshItemGrids()
end
end
end


function UIYunZhouComponentsGainWin:onBtnClose()
self:closeSelf()
end

function UIYunZhouComponentsGainWin:onMask()
self:closeSelf()
end

