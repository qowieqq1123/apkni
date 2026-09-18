







def_class("UIMysteryItemDropWin",UIWindowBase)









function UIMysteryItemDropWin:bindComponents()

self.ScrollView=UIScrollView.get(self,0)



end


function UIMysteryItemDropWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ScrollView);self.ScrollView=nil;
end



















function UIMysteryItemDropWin:onLoaded(...)
self:bindComponents()
self.ScrollView:setClickAction(itemsComponentHelper.onItemClick)
end


function UIMysteryItemDropWin:__delete()
self:unbindComponents()
end




function UIMysteryItemDropWin:onShow(argtable,afterOnloaded)

local itemsList=argtable.itemsList
local list={}
local lookUp={}

for i,v in ipairs(itemsList)do
local itemId=v[1]
local handle
local guid=tostring(v[3])
if v[3]and guid~='0'and guid~='nil'then
handle=guid
else
handle=itemId
end
local data=lookUp[handle]
if not data then
lookUp[handle]=v
else
local num=data[2]
local new=data[4]or v[4]
lookUp[handle]={itemId,num+v[2],v[3],new}
end
end
for i,v in pairs(lookUp)do
table.insert(list,v)
end

local propDatas={}
table.sort(list,function(a,b)
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


for i,v in ipairs(list)do
local itemid
local isTeZhi=false
local isGaiLv=false
local itemguid=nil
local isActReward=false
if type(v)=='table'then
itemid=v[1]
isTeZhi=v[2]==-2
isGaiLv=v[2]==-1
isActReward=v.isActReward
if v[3]and type(v[3])~='string'then
itemguid=v[3]
end
else
itemid=v
end
local num=v[2]
local fillData=itemsComponentHelper.getCommonFillData({itemid=itemid,itemcount=num>1 and num or"",showCountBG=num>1,itemguid=itemguid},{showname=false,itemcount=num>1 and mathHelper.formatNumber(num)or"",showStageBg=true})
fillData[PropIndex(DataPropKey.eWidgetActive,11)]=isGaiLv or isActReward
fillData[PropIndex(DataPropKey.eWidgetActive,12)]=isTeZhi
fillData[PropIndex(DataPropKey.eWidgetActive,13)]=v[4]
table.insert(propDatas,fillData)
end
local count=#propDatas
self.colomn=9
self.row=math.ceil(count,self.colomn)
self.ScrollView:freshGridsNum(count,self.row,self.colomn,false)
self.ScrollView:initPropData(propDatas)

mysteryTreasureModel:setOld()
end


function UIMysteryItemDropWin:onHide()

end

function UIMysteryItemDropWin:onClickClose()
self:closeSelf()
end



