bagNewHelper={}
local _remove=table.remove
local _data={}

function bagNewHelper.reset()
_data={}
_data.list={}
_data.lookup={}
end

function bagNewHelper.setItemNewFlag(item,flag)
if flag==nil then flag=false end
local itemguid=item.itemguid
local guidStr=item.guidStr
local hasFlag=_data.lookup[guidStr]==true
if hasFlag==flag then return end

_data.lookup[guidStr]=flag

local itemid=item.itemid
local bagType=itemsConfig.getBagType(itemid)
if _data.list[bagType]==nil then _data.list[bagType]={}end
local lookup=_data.list[bagType]
if flag then
lookup[guidStr]=true
else
lookup[guidStr]=nil
end
end

function bagNewHelper.setNewFlag(itemguid,flag)
local item=bagModel.getItem(itemguid)
if item==nil then return end
bagNewHelper.setItemNewFlag(item,flag)
end

function bagNewHelper.getNewFlag(itemguid)
local guidStr=tostring(itemguid)
return _data.lookup[guidStr]or false
end

function bagNewHelper.clearBagNewFlag(bagType)
if _data.list[bagType]==nil then return end
local lookup=_data.list[bagType]
for guidStr,_ in pairs(lookup)do
_data.lookup[guidStr]=nil
end
_data.list[bagType]={}
end
