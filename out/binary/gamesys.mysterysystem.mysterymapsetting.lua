





mysteryMapSetting={}

local mapConfig=nil
local roomMapConfig=nil

function mysteryMapSetting.initMap()
local filename='mysteryMap.json'
local e,s=pcall(function()mapConfig=jsonHelper.readFile(filename,{})end)
if not e then

mapConfig={}
end
end

function mysteryMapSetting.initRoomMap()
local filename='mysteryRoomMap.json'
local e,s=pcall(function()roomMapConfig=jsonHelper.readFile(filename,{})end)
if not e then

roomMapConfig={}
end
end

function mysteryMapSetting:saveMapData(fbId,index,mapData)
local id=tostring(fbId)
local idx=tostring(index)
mapConfig[id]=mapConfig[id]or{}
mapConfig[id][idx]=mapData
end

function mysteryMapSetting:saveRoomMapData(doorId,index,mapData)
local id=tostring(doorId)
local idx=tostring(index)
roomMapConfig[id]=roomMapConfig[id]or{}
roomMapConfig[id][idx]=mapData
end

function mysteryMapSetting:readMapConfig(fbId,index)
if not mapConfig then
mysteryMapSetting.initMap()
end
local id=tostring(fbId)
local idx=tostring(index)
if mapConfig[id]then
return mapConfig[id][idx]
end
end

function mysteryMapSetting:readRoomMapConfig(doorId,index)
if not roomMapConfig then
mysteryMapSetting.initRoomMap()
end
local id=tostring(doorId)
local idx=tostring(index)
if roomMapConfig[id]then
return roomMapConfig[id][idx]
end
end


function mysteryMapSetting.flushMapConfig()
jsonHelper.writeFile('mysteryMap.json',mapConfig)
end

function mysteryMapSetting.flushRoomMapConfig()
jsonHelper.writeFile('mysteryRoomMap.json',roomMapConfig)
end
