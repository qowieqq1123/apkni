







def_class("UIShiLianTaGuaJiRewardWin",UIWindowBase)









function UIShiLianTaGuaJiRewardWin:bindComponents()

self.layer=UIText.get(self,0)
self.nextLayer=UIText.get(self,1)
self.shoutongrewards=UIObject.get(self,2)
self.effect=UIObject.get(self,3)



end


function UIShiLianTaGuaJiRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.layer);self.layer=nil;
_UIObject_release(self.nextLayer);self.nextLayer=nil;
_UIObject_release(self.shoutongrewards);self.shoutongrewards=nil;
_UIObject_release(self.effect);self.effect=nil;
end



















function UIShiLianTaGuaJiRewardWin:onLoaded(...)
self:bindComponents()
end


function UIShiLianTaGuaJiRewardWin:__delete()
self:unbindComponents()
end




function UIShiLianTaGuaJiRewardWin:onShow(argtable,afterOnloaded)
local guajiLayer,curLayer=argtable.guajiLayer,argtable.curLayer
self.layer:setText(FMT.fmt("当前层数：{0}",curLayer-1))
self.nextLayer:setText(curLayer-argtable.guajiLayer)
local rewardList=shiLianTaModel:getGuaJIReward()
shiLianTaModel:clearGuaJIReward()
shiLianTaModel:setGuaJILayer(nil)
self.effect:setChildShowEffect(10053,true)
local list={}
local lookUp={}
for i,v in ipairs(rewardList)do
local itemId=v.itemid
local handle
if v.itemguid then
handle=tostring(v.itemguid)
else
handle=itemId
end
local data=lookUp[handle]
if not data then
lookUp[handle]=v
else
local num=data.itemcount
lookUp[handle]={itemid=itemId,itemcount=num+v.itemcount}
end
end
for i,v in pairs(lookUp)do
table.insert(list,v)
end
table.sort(list,function(a,b)
local itemida,itemidb
local isTeZhia,isTeZhib=false,false
local isGaiLva,isGaiLvb=false,false
local isActReward_a,isActReward_b=false,false
itemida=a.itemid
itemidb=b.itemid
local aConfig=itemsConfig.getConfig(itemida)
local bConfig=itemsConfig.getConfig(itemidb)
local aRareLv=itemsConfig.getRareLv(itemida)
local bRareLv=itemsConfig.getRareLv(itemidb)
local aScore=aRareLv*10000000+itemida
local bScore=bRareLv*10000000+itemidb

if not isGaiLva then
aScore=aScore+1000000
end
if not isGaiLvb then
bScore=bScore+1000000
end

aScore=aScore+aConfig.color*100000
bScore=bScore+bConfig.color*100000

if itemsConfig.isGubao(itemida)then
aScore=aScore+200000000
elseif not itemsConfig.isEquip(itemida)then
aScore=aScore+100000000
end

if itemsConfig.isGubao(itemidb)then
bScore=bScore+200000000
elseif not itemsConfig.isEquip(itemidb)then
bScore=bScore+100000000
end

if isActReward_a then
aScore=aScore+1000000000
end

if isActReward_b then
bScore=bScore+1000000000
end

return aScore>bScore
end)
self.shoutongrewards:setChildLayoutGroupCreateItems(#list)
local items=self.shoutongrewards:getChildLayoutGroupGridList()
for i=0,items.Count-1 do
local item=items[i]
local itemid=list[i+1].itemid
local num=list[i+1].itemcount
local conf={itemid=itemid,showCountBG=num>1,itemcount=num>1 and num or'',showStage=true,showname=false,itemIndex=i}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end

end


function UIShiLianTaGuaJiRewardWin:onHide()

end



