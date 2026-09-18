




local cjson=require'cjson'
eventLocalTriggerModel={}





local _saveKey='loTriEventsData'
local _data={}
local _dataEncode={}
local _dirty=false
local _isRead=false

function eventLocalTriggerModel.init()
_isRead=false
_dirty=false
_data={}
_dataEncode={}
end
function eventLocalTriggerModel.readLocalData()
if _isRead then return end
_isRead=true
local jsonTable=userActorArraySetting.get(ACTOR_SETTING_TYPE.eEvent,_saveKey,nil)
if jsonTable~=nil and#jsonTable>0 then

local tempList={}
for k,v in pairs(jsonTable)do
local info=eventLocalTriggerModel.decode(v)
if info and eventTriggerModel.verifyLocalDataOnRead(info)~=false then
tempList[#tempList+1]=info
local guid=info[7]
local handle=tostring(guid)
_data[handle]=info
end
end
eventTriggerContorl:enQueueList(tempList)
end

end

function eventLocalTriggerModel.getTableData()
return _data
end


function eventLocalTriggerModel.addTableData(info)
local guid=info[7]
local handle=tostring(guid)
if _data[handle]then return end
_data[handle]=info
_dataEncode[handle]=eventLocalTriggerModel.encode(info)
_dirty=true
eventLocalTriggerModel.store(true)
end


function eventLocalTriggerModel.deleteTableData(guid)
local handle=tostring(guid)
local info=_data[handle]
if info then
_data[handle]=nil
_dataEncode[handle]=nil
_dirty=true
eventLocalTriggerModel.store(true)
end
return info
end

function eventLocalTriggerModel.store(canDelay)
if not _dirty then return end
_dirty=false
for handle,v in pairs(_data)do
if _dataEncode[handle]==nil then
_dataEncode[handle]=eventLocalTriggerModel.encode(v)
end
end
local list={}
for k,v in pairs(_dataEncode)do
list[#list+1]=v
end
eventControl.freshLocalVal(_saveKey,list,canDelay)
end

function eventLocalTriggerModel.encode(array)
local co=table.deepCopy(array)
local len=co[4]
if len>0 then
local paramList=co[5]
local list={}
for i=1,len do
list[#list+1]=tostring(paramList[i])
end
co[5]=list
else
co[5]={}
end
return co
end

function eventLocalTriggerModel.decode(array)
local jsonTable=table.deepCopy(array)
local len=jsonTable[4]
if len and len>0 then
local paramListTable=jsonTable[5]
local list={}
for i=1,len do
list[#list+1]=int64.new(paramListTable[i])
end
jsonTable[5]=list
else
jsonTable[4]=0
jsonTable[5]={}
end
return jsonTable
end
