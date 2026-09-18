







def_class("UIYFLTBagWin",UIWindowBase)









function UIYFLTBagWin:bindComponents()

self.List=UIObject.get(self,0)
self.Content=UIObject.get(self,1)



end


function UIYFLTBagWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.List);self.List=nil;
_UIObject_release(self.Content);self.Content=nil;
end



















function UIYFLTBagWin:onLoaded(...)
self:bindComponents()
end


function UIYFLTBagWin:__delete()
self:unbindComponents()
end




function UIYFLTBagWin:onShow(argtable,afterOnloaded)
local zzcfg=cfg_yifanglintianconfig()
local itemlist={}
for k,v in pairs(zzcfg)do
itemlist[#itemlist+1]=v.id
end

local filter={}
filter[ITEM_FILTER_TYPE.eItemid]={ITEM_FILTER_COMPARE.eEquals,itemlist}
self.itemDatas=bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,filter,false,false)
table.sort(self.itemDatas,function(a,b)
local acfg=itemsConfig.getConfig(a.itemid)
local bcfg=itemsConfig.getConfig(b.itemid)
if bcfg.color>acfg.color then
return false
elseif bcfg.color<acfg.color then
return true
else
return a.itemid<b.itemid
end
end)
if math.ceil(#self.itemDatas/5)<6 then
self.max=6
else
self.max=math.ceil(#self.itemDatas/5)+1
end

self:refreshList(true)
end


function UIYFLTBagWin:onHide()

end

function UIYFLTBagWin:refreshList(init)
self.List:setActive(true)
if init then
self.Content:setChildLayoutGroupCreateItems(self.max,function(index)
self:refreshListItem(index,true)
end)
else
for i=1,self.max do
self:refreshListItem(i)
end
end
end

function UIYFLTBagWin:refreshListItem(index,click)
local Fatheritem=self.Content:getChildLayoutGroupGridItem(index-1)

for i=1,5 do
local item=Fatheritem:GetChildWidgetBase(i-1)
local dataindex=(index-1)*5+i
local itemdata=self.itemDatas[dataindex]
if itemdata then
item:SetChildActive(10,true)
local itemid=itemdata.itemid
local itemnum=itemdata.itemcount
local item_config=itemsConfig.getConfig(itemid)
local itemName=item_config.name
local itemcount,showCountBG
if itemnum>1 then
itemcount=mathHelper.formatNumber(itemnum,false)
showCountBG=true
else
itemcount=''
showCountBG=false
end

local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
item:SetBaseItemClickEvent(-1,function(...)
tipsManager.showTips({formType=TIPS_FORM_TYPE.eYFLTBag,
itemid=itemid,
showModel=true,
backType=TIPS_BACK_TYPE.eBag,
itemguid=itemdata.itemguid,
attach={}})
end)
item:SetChildText(4,itemName)
else
item:SetChildActive(10,false)
end

end



end


function UIYFLTBagWin:onClickClose()
self:closeSelf()
end


