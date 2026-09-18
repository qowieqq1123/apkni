







def_class("UIShowPrizeChildItem",UICloneObject)





UIShowPrizeChildItem.abName="ui/windows/showprize/uishowprizechilditem.ab"

UIShowPrizeChildItem.assetName="UIShowPrizeChildItem"


function UIShowPrizeChildItem:bindComponents()

self.UIBaseItem=UIBaseItem.get(self,0)

end


function UIShowPrizeChildItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.UIBaseItem);self.UIBaseItem=nil;
end






function UIShowPrizeChildItem:onLoaded(...)
self:bindComponents()
self.UIBaseItem:setBaseItemClickEvent(function(...)itemsComponentHelper.onItemClick(...)end)

end

function UIShowPrizeChildItem:__delete()
self:unbindComponents()
end

function UIShowPrizeChildItem:onShow(argtable)
local itemguid=argtable.itemguid
local itemid=argtable.itemid
local num=argtable.num or 1
local limit=argtable.conf or{}
local item
if itemguid then
item=itemsModel.getItem(itemguid)
if not item then
item={itemid=itemid}
end
else
item={itemid=itemid}
end
limit.itemcount=num<=1 and''or num
if item==nil then
loggerUtil.logErrFMT('没有找到显示的道具信息！itemid：{0} itemguid:{1}',itemid,tostring(itemguid))
end
local itemid=item.itemid
if limit.nomalname==nil then
limit.nomalname=true
end
limit.showCountBG=num>1
local porp=itemsComponentHelper.getCommonFillData(item,limit)
local stage=porp[PropIndex(DataPropKey.eWidgetText,6)]
porp[PropIndex(DataPropKey.eWidgetActive,8)]=stage~=nil and stage~=''
self.UIBaseItem:setChildPropData(porp)
end

function UIShowPrizeChildItem:onFreshed()


self.widget:SetChildCanvasGroupDOFade(self.UIBaseItem:getID(),1,0.5)
end