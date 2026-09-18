







def_class("UIDetailDropWin",UIWindowBase)









function UIDetailDropWin:bindComponents()

self.ScrollView=UIScrollView.get(self,0)
self.TitleTx=UIText.get(self,1)
self.TipsTx=UIText.get(self,2)



end


function UIDetailDropWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.TitleTx);self.TitleTx=nil;
_UIObject_release(self.TipsTx);self.TipsTx=nil;
end



















function UIDetailDropWin:onLoaded(...)
self:bindComponents()
self.ScrollView:setClickAction(itemsComponentHelper.onItemClickEx)
end


function UIDetailDropWin:__delete()
self:unbindComponents()
end




function UIDetailDropWin:onShow(argtable,afterOnloaded)
if not argtable or not argtable.detail then return end
if argtable.title then
self.TitleTx:setText(argtable.title)
end
if argtable.tips then
self.TipsTx:setText(argtable.tips)
end
local propDatas={}

local itemsList=table.deepCopy(argtable.detail)
local actRewards=argtable.actRewards or{}


for i,v in ipairs(actRewards)do
local itemId=v[1]
local item={itemId,0,isActReward=true,range=v.range}
table.insert(itemsList,1,item)
end
if not argtable.notsort then
table.sort(itemsList,function(a,b)
local itemida,itemidb
local isTeZhia,isTeZhib=false,false
local isGaiLva,isGaiLvb=false,false
local isActReward_a,isActReward_b=false,false
if type(a)=='table'then
itemida=a[1]
itemidb=b[1]
isTeZhia=a[2]==-2
isGaiLva=a[2]==-1
isTeZhib=b[2]==-2
isGaiLvb=b[2]==-1
isActReward_a=a.isActReward
isActReward_b=b.isActReward
else
itemida=a
itemidb=b
end
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
end



for i,v in ipairs(itemsList)do
local itemid
local isTeZhi=false
local isGaiLv=false
local isActReward=false
if type(v)=='table'then
itemid=v[1]
isTeZhi=v[2]==-2
isGaiLv=v[2]==-1
isActReward=v.isActReward
else
itemid=v
end
local fillData=itemsComponentHelper.getCommonFillData({itemid=itemid},{showname=false,itemcount="",showCountBG=v.range~=nil,showStageBg=true,range=v.range})
fillData[PropIndex(DataPropKey.eWidgetActive,11)]=isGaiLv or isActReward
fillData[PropIndex(DataPropKey.eWidgetActive,12)]=isTeZhi
table.insert(propDatas,fillData)
end
local count=#propDatas
self.colomn=9
self.row=math.ceil(count,self.colomn)
self.ScrollView:freshGridsNum(count,self.row,self.colomn,false)
self.ScrollView:initPropData(propDatas)
end


function UIDetailDropWin:onHide()

end



function UIDetailDropWin:onClickClose()
self:closeSelf()
end