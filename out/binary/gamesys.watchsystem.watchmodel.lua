





watchModel={}

local _cache={}
local _getSpace=10*60

function watchModel.init()
_cache={}
end

function watchModel.setItem(item)
local itemguid=item.itemguid
local handle=tostring(itemguid)
local stamp=timeHelper.getServerShortTime()
_cache[handle]={item,stamp}
end

function watchModel.getItem(itemguid)
local stamp=timeHelper.getServerShortTime()
local handle=tostring(itemguid)
local info=_cache[handle]
if info then
local lastStamp=info[2]
local item=info[1]
if lastStamp and item and(stamp-lastStamp)<=_getSpace then
return item
end
end
end

function watchModel.removeItem(itemguid)
local handle=tostring(itemguid)
_cache[handle]=nil
end

function watchModel.removeItemList(itemguidList)
for i,v in ipairs(itemguidList)do
watchModel.removeItem(v)
end
end