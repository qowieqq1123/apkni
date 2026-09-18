





eventServerDataModel={}





local _data={}
local _store={}
local _lookup={}

function eventServerDataModel.init()
_data={}
_store={}
_lookup={}
end

function eventServerDataModel.getData(eventguid,clear)
local guid=tostring(eventguid)
local data=_data[guid]
if clear then
_data[guid]=nil
end
return data
end

function eventServerDataModel.clearData(eventguid)
local guid=tostring(eventguid)
_data[guid]=nil
end

function eventServerDataModel.setData(eventguid,rewardList)
if rewardList==nil or#rewardList==0 then return end
local guid=tostring(eventguid)
local data=rewardList
_data[guid]=data
end

function eventServerDataModel.addItem(eventguid,itemid,num)
local guid=tostring(eventguid)
local typo=EVENT_STORE_TYPE.eItem
if _store[typo]==nil then _store[typo]={}end
if _store[typo][guid]==nil then _store[typo][guid]={}end
local list=_store[typo][guid]
local lastNum=0
for i,v in ipairs(list)do
if v[1]==itemid then
lastNum=v[2]
table.remove(list,i)
break
end
end

list[#list+1]={itemid,num+lastNum}
end

function eventServerDataModel.getItem(eventguid)
local guid=tostring(eventguid)
local typo=EVENT_STORE_TYPE.eItem
if _store[typo]==nil then _store[typo]={}end
return _store[typo][guid]or{}
end

function eventServerDataModel.getItemByParam(mainType,subType,...)
local eventguid=eventControl.invokeEventControl(mainType,subType,'getEventguid',...)
return eventServerDataModel.getItem(eventguid)
end


local _getTypeKey=function(mainType,subType)
return mainType*10000+subType
end


function eventServerDataModel.saveEventInfo(eventInfo)
local eventid=eventInfo.eventid
local eventconfig=eventConfig.getEventConfig(eventid)
local mainType=eventconfig.type1
local subType=eventconfig.type2
local key=_getTypeKey(mainType,subType)
if _lookup[key]==nil then _lookup[key]={}end
local lookup=_lookup[key]
lookup[#lookup+1]=eventInfo
end


function eventServerDataModel.getRecentRewards(mainType,subType,...)
local key=_getTypeKey(mainType,subType)
if _lookup[key]==nil then return end
local lookup=_lookup[key]
local temp={}
for _,eventInfo in ipairs(lookup)do
if eventControl.invokeEventControl(mainType,subType,'checkRewardParams',eventInfo,...)then
temp[#temp+1]=eventInfo
end
end
if#temp>1 then
table.sort(temp,function(a,b)
return a.eventtime>b.eventtime
end)
end
local eventInfo=temp[1]
if eventInfo then
local eventguid=eventInfo.eventguid
return eventServerDataModel.getItem(eventguid)
end
end
