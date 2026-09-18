







def_class("UIWorldRewardDetailWin",UIWindowBase)









function UIWorldRewardDetailWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.itemPanel=UIObject.get(self,1)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIWorldRewardDetailWin")end)



end


function UIWorldRewardDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
end


















local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemBgCountIdx=2,
cmpItemTxtCountIdx=3,
cmpItemTxtStage=4,
}


function UIWorldRewardDetailWin:onLoaded(...)
self:bindComponents()
end


function UIWorldRewardDetailWin:__delete()
self:unbindComponents()
end




function UIWorldRewardDetailWin:onShow(argtable,afterOnloaded)
if argtable then
local rewardList=argtable
self.itemPanel:setChildScrollViewCreateGrids(#rewardList,#rewardList)
local gridlist=self.itemPanel:getChildScrollViewItemWidgets()
local gridNum=gridlist.Count
if gridNum>0 then
for i=1,gridNum do
local item=gridlist[i-1]
local itemValue=rewardList[i]
if item and itemValue then
local itemId=itemValue[1]
local count=itemValue[2]
local itemConfig=itemsConfig.getConfig(itemId)
self:fillItem(item,itemId,count,itemConfig)
end
end
end
end
end


function UIWorldRewardDetailWin:onHide()

end

function UIWorldRewardDetailWin:fillItem(grid,itemid,count,itemConfig)
if not grid then
return
end
grid:SetBaseItemClickEvent(0,function(...)self:onItemClick(...)end)
local prop={}
local color=itemConfig.color
prop[PropIndex(DataPropKey.eWidgetQuality,_itemWidgetIdx.cmpItemQualityIdx)]=color
prop[PropIndex(DataPropKey.eWidgetIcon,_itemWidgetIdx.cmpItemIconIdx)]=iconHelper.getIconName(itemid)
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemBgCountIdx)]=true
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtCountIdx)]=count==-1 and'概率'or count
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtStage)]=itemConfig.stage and FMT.fmt('{0}阶',itemConfig.stage)or''
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=-1
grid:SetChildPropData(0,prop)
end

function UIWorldRewardDetailWin:onItemClick(id,index,guid,attach)
itemsComponentHelper.onItemClick(id,index,guid,attach)
end


