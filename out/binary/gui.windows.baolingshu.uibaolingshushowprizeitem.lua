







def_class("UIBaoLingShuShowPrizeItem",UICloneObject)





UIBaoLingShuShowPrizeItem.abName="ui/windows/baolingshu/uibaolingshushowprizeitem.ab"

UIBaoLingShuShowPrizeItem.assetName="UIBaoLingShuShowPrizeItem"


function UIBaoLingShuShowPrizeItem:bindComponents()

self.UIBaseItem=UIBaseItem.get(self,0)

end


function UIBaoLingShuShowPrizeItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.UIBaseItem);self.UIBaseItem=nil;
end






function UIBaoLingShuShowPrizeItem:onLoaded(...)
self:bindComponents()
end

function UIBaoLingShuShowPrizeItem:__delete()
self:unbindComponents()
end

function UIBaoLingShuShowPrizeItem:onShow(argtable)
local itemguid=argtable.itemguid
local itemid=argtable.itemid
local num=argtable.num or 1
local limit=argtable.conf or{}
local item
if itemguid then
item=bagModel.getItem(itemguid)
else
item={itemid=itemid}
end
limit.itemcount=num
limit.showname=false
limit.showcount=num>1
limit.showCountBG=num>1
limit.colorEffect=itemsComponentHelper:checkItemShowColorEffect(itemid)
local porp=itemsComponentHelper.getCommonFillData(item,limit)
local itemConfig=itemsConfig.getConfig(itemid)
porp[PropIndex(DataPropKey.eWidgetActive,8)]=itemConfig.stage~=nil
self.UIBaseItem:setChildPropData(porp)
local itemWidget=self.UIBaseItem:getChildWidgetBase()
itemsComponentHelper.setUIBaseItemSign(itemWidget,{itemid=item.itemid})

self.UIBaseItem:setBaseItemClickEvent(function(...)self:onItemClick(...)end)
end

function UIBaoLingShuShowPrizeItem:onFreshed()


local twneer=self.widget:SetChildCanvasGroupDOFade(-1,1,0.5)
twneer:SetDelay(0.5)
end

function UIBaoLingShuShowPrizeItem:onItemClick(itemid,index,itemguid,attach)
if itemid==-1 then
return
end
if itemsConfig.isGubao(itemid)then
gubaoController:gubaoShowTips(itemid)
return
end
itemsComponentHelper.onItemClick(itemid,index,itemguid,attach)
end