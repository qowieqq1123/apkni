bagEquipControl=gameState.addListener({})




function bagEquipControl:onAppStart()

end

function bagEquipControl:onEnterState()
self.equipJlList={}
end

function bagEquipControl:onLeaveState()
self.equipJlList={}
end



function bagEquipControl:initEquips()
local equipJlList={}

local equips=bagControl.getBagItems(BAG_TYPE.eEquipBag)
for i,equip in ipairs(equips)do
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
equipJlList[#equipJlList+1]=jinglianlv
end

table.sort(equipJlList,function(a,b)
return a<b
end)
self.equipJlList=equipJlList
end

function bagEquipControl:onAddEquip(equip,isInit)
if isInit then return end
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
local startIndex=table.getBiggerNumberStartIndex(self.equipJlList,jinglianlv)
if startIndex==nil then
self.equipJlList[#self.equipJlList+1]=jinglianlv
else
_insert(self.equipJlList,startIndex,jinglianlv)
end
end

function bagEquipControl:onDelEquip(equip)
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
local startIndex=table.getNumberStartIndex(self.equipJlList,jinglianlv)
if startIndex==nil then
logErr('没有找到删除装备{0}的精炼等级：{1}',equip.itemid,jinglianlv)
else
_remove(self.equipJlList,startIndex)
end
end

function bagEquipControl:onDelEquipList(len,strlookup)
if len>10 then
local delJllookup={}
for _,equip in pairs(strlookup)do
local jllv=equip.itemData and equip.itemData.jinglianlv or 0
local old=delJllookup[jllv]or 0
delJllookup[jllv]=old+1
end

local equipJlList={}
for _,jllv in ipairs(self.equipJlList)do
if delJllookup[jllv]and delJllookup[jllv]>0 then
delJllookup[jllv]=delJllookup[jllv]-1
if delJllookup[jllv]<=0 then delJllookup[jllv]=nil end
else
equipJlList[#equipJlList+1]=jllv
end
end
self.equipJlList=equipJlList
else
for _,equip in pairs(strlookup)do
bagEquipControl:onDelEquip(equip)
end
end
end

function bagEquipControl:onChangeEquipJllv(old,new)
if old==new then return end
local startIndex=table.getNumberStartIndex(self.equipJlList,old)
if startIndex==nil then
logErr('没有找到删除装备的精炼等级：{0}',old)
else
_remove(self.equipJlList,startIndex)
end
local startIndex=table.getBiggerNumberStartIndex(self.equipJlList,new)
if startIndex==nil then
self.equipJlList[#self.equipJlList+1]=new
else
_insert(self.equipJlList,startIndex,new)
end
end

function bagEquipControl:getBiggerJllvCount(jllv)
return dataControl:getBiggerListCount(self.equipJlList,jllv)
end


function bagEquipControl:getJlCount(jllv)

local bagNum=bagEquipControl:getBiggerJllvCount(jllv)

local list=dataControl:getList(DATA_TYPE.dzEquipCount2,SUB_DATA_TYPE.eDZEquipJingLianLv)
local num=dataControl:getBiggerListCount(list,jllv)
return num+bagNum
end