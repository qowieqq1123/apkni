





function equipsModel:saveChongZhuEquipByEquip(equip,flag,randattrList,suitid)
if not self.chongZhuData then
self.chongZhuData={}
end

local handle=tostring(equip.itemguid)
self.chongZhuData[handle]={flag=flag,randattrList=randattrList,suitid=suitid}
equipsHelper.setEquipAttrsDirty(equip,true)
end

function equipsModel:getChongZhuEquipData(itemguid)
if not self.chongZhuData then
self.chongZhuData={}
end
local handle=tostring(itemguid)
return self.chongZhuData[handle]
end

function equipsModel:onChongZhuEquipByEquip(equip,flag)
local handle=tostring(equip.itemguid)

if flag==0 then
self.chongZhuData[handle]=nil
return
end

local data=self.chongZhuData[handle]
if not data then
logErr("没有重铸数据")
return
end

if equip then
if equip.itemData==nil then
equip.itemData={}
equip.itemData.itemtype=ITEM_MAIN_TYPE.eEquip
equip.itemData.len=0
equip.itemData.suitid=0
equip.itemData.jinglianexp=0
equip.itemData.jinglianlv=0
end
local itemData=equip.itemData
local selectAttr=bitHelper.check_pos(flag,0)
local selectSuit=bitHelper.check_pos(flag,1)
if selectAttr then

local list=data.randattrList or{}
local randattrList=itemData.randattrList or{}
if list and#list>0 then
local temp={}
for i,v in ipairs(list)do
for ii,vv in ipairs(randattrList)do
if v.param_1==vv.param_1 then
table.remove(randattrList,ii)
break
end
end
temp[#temp+1]=v
end
itemData.randattrList=temp
end
itemData.len=#(itemData.randattrList or{})
end
if selectSuit then
itemData.suitid=data.suitid
end
equip.itemData=itemData

end
self.chongZhuData[handle]=nil
end


function equipsModel:isEquipChongzhu(itemguid)
local data=equipsModel:getChongZhuEquipData(itemguid)
if data then
return data.flag~=0
end
return false
end