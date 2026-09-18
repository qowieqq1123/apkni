







def_class("UIMER_Item_Panel",UIWindowBase)









function UIMER_Item_Panel:bindComponents()

self.itemPanel=UIObject.get(self,0)



end


function UIMER_Item_Panel:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.itemPanel);self.itemPanel=nil;
end



















local itemList

local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemBgCountIdx=2,
cmpItemTxtCountIdx=3,
cmpItemTxtStage=4,
}


function UIMER_Item_Panel:onLoaded(...)
self:bindComponents()
local _onClickItemCallback=function(...)
self:onClickItemCallback(...)
end
self.itemPanel:setChildScrollViewInit(-1,true,_onClickItemCallback,nil)
end


function UIMER_Item_Panel:__delete()
self:unbindComponents()
self.child=nil
itemList=nil
end




function UIMER_Item_Panel:onShow(argtable,afterOnloaded)
if argtable then
itemList=argtable.itemList
end
self:showItemPanel()

end

function UIMER_Item_Panel:showItemPanel()
if itemList then
self.itemPanel:setChildScrollViewCreateGrids(#itemList,4)
local grids=self.itemPanel:getChildScrollViewItemWidgets()
for i,v in ipairs(itemList)do
local item=grids[i-1]
if item then
local itemId=v[1]
local count=v[2]
local itemConfig=itemsConfig.getConfig(itemId)
self:fillItem(item,itemId,count,itemConfig)
end
end
end
end

function UIMER_Item_Panel:fillItem(grid,itemid,count,itemConfig)
if not grid then
return
end
grid:SetBaseItemClickEvent(0,function(...)self:onItemClick(...)end)
local prop={}
local color=itemConfig.color
prop[PropIndex(DataPropKey.eWidgetQuality,_itemWidgetIdx.cmpItemQualityIdx)]=color
prop[PropIndex(DataPropKey.eWidgetIcon,_itemWidgetIdx.cmpItemIconIdx)]=iconHelper.getIconName(itemid)
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemBgCountIdx)]=true
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtCountIdx)]=count
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtStage)]=itemConfig.stage and FMT.fmt('{0}阶',itemConfig.stage)or''
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=-1
grid:SetChildPropData(0,prop)
end

function UIMER_Item_Panel:onItemClick(id,index,guid,attach)

itemsComponentHelper.onItemClick(id,index,guid,attach)
end


function UIMER_Item_Panel:onHide()

end



