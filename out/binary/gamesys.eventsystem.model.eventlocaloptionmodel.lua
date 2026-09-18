





eventLocalOptionModel={}









local _storeKey='eventActionKey'
local _eventLookup=nil
local _localLookup=nil
local _tmpNpcDataList_lookup=nil

function eventLocalOptionModel.init(isLeave)
_eventLookup=nil
_localLookup=nil
if isLeave then

eventLocalOptionModel.saveAllOptionEventNpcData()
else
_tmpNpcDataList_lookup=nil
end
end



function eventLocalOptionModel.initEventData()
if _eventLookup==nil then
_eventLookup=userActorArraySetting.get(ACTOR_SETTING_TYPE.eEvent,_storeKey,{})
for i,v in pairs(_eventLookup)do
eventLocalOptionModel.transform(v)
end
_localLookup=_eventLookup
end
end

function eventLocalOptionModel.transform(eventInfo)
for k,v in pairs(eventInfo)do
if k=='paramList'then
eventInfo[k]={}
for i=1,#v do
eventLocalOptionModel.toInt64(i,v[i],eventInfo[k])
end
elseif k=='eventguid'then
eventInfo[k]=int64.new(tostring(v))
elseif k=='optionList'then
eventInfo[k]={}
for i=1,#v do
eventInfo[k][i]=tonumber(v[i])
end
else
eventInfo[k]=tonumber(tostring(v))
end
end
end


function eventLocalOptionModel.setEventData(eventInfo,store)
if not eventOptionControl.isDecision(eventInfo)then return false end
eventLocalOptionModel.initEventData()
local eventguid=eventInfo.eventguid
local guidStr=tostring(eventguid)
if _eventLookup[guidStr]and _localLookup[guidStr]==nil then
loggerUtil.logErrFMT('产生了相同的服务器guid:{0}',tostring(eventguid))
end
_eventLookup[guidStr]=eventInfo
if store~=false then
eventLocalOptionModel.store(true)
return false
end
return true
end


function eventLocalOptionModel.deleteEventData(eventguid)
eventLocalOptionModel.initEventData()
if _eventLookup[tostring(eventguid)]==nil then return end
local info=_eventLookup[tostring(eventguid)]
_eventLookup[tostring(eventguid)]=nil
eventLocalOptionModel.store(true)
return info
end

function eventLocalOptionModel.getEventData(eventguid)
eventLocalOptionModel.initEventData()
return _eventLookup[tostring(eventguid)]
end

function eventLocalOptionModel.store(canDealy)
if _eventLookup==nil then return end
local lookup={}
for k,v in pairs(_eventLookup)do
if eventLocalOptionModel.needStore(v)then

eventLocalOptionModel.toString(k,v,lookup)
end
end
eventControl.freshLocalVal(_storeKey,lookup,canDealy)
end

function eventLocalOptionModel.needStore(eventInfo)
if eventConfig.isDecision(tonumber(eventInfo.eventid))then
return false
end
return true
end

function eventLocalOptionModel.toString(k,info,lookup)
if type(info)=='table'then
lookup[k]={}
for kk,vv in pairs(info)do
eventLocalOptionModel.toString(kk,vv,lookup[k])
end
else
lookup[k]=tostring(info)
end
end

function eventLocalOptionModel.toInt64(k,info,lookup)
if type(info)=='table'then
lookup[k]={}
for kk,vv in pairs(info)do
eventLocalOptionModel.toInt64(kk,vv,lookup[k])
end
else
lookup[k]=int64.new(tostring(info))
end
end




function eventLocalOptionModel.setOptionEventNpcData(npcData,eventGuidStr)
local npcDataList_lookup=eventLocalOptionModel.getAllOptionEventNpcData()
if not npcDataList_lookup[eventGuidStr]then
npcDataList_lookup[eventGuidStr]={}
end
npcDataList_lookup[eventGuidStr].npcData=npcData
end


function eventLocalOptionModel.setOptionEventNpcInSideModel(inSideModel,eventGuidStr)
local npcDataList_lookup=eventLocalOptionModel.getAllOptionEventNpcData()
if not npcDataList_lookup[eventGuidStr]then
npcDataList_lookup[eventGuidStr]={}
end
npcDataList_lookup[eventGuidStr].inSideModel=inSideModel
end


function eventLocalOptionModel.setOptionEventNpcOutSideModel(outSideModel,eventGuidStr)
local npcDataList_lookup=eventLocalOptionModel.getAllOptionEventNpcData()
if not npcDataList_lookup[eventGuidStr]then
npcDataList_lookup[eventGuidStr]={}
end
npcDataList_lookup[eventGuidStr].outSideModel=outSideModel
end


function eventLocalOptionModel.setOptionEventNpcName(name,eventGuidStr)
local npcDataList_lookup=eventLocalOptionModel.getAllOptionEventNpcData()
if not npcDataList_lookup[eventGuidStr]then
npcDataList_lookup[eventGuidStr]={}
end
npcDataList_lookup[eventGuidStr].name=name
end


function eventLocalOptionModel.setOptionEventNpcPosIndex(posIndex,eventGuidStr)
local npcDataList_lookup=eventLocalOptionModel.getAllOptionEventNpcData()
if not npcDataList_lookup[eventGuidStr]then
npcDataList_lookup[eventGuidStr]={}
end
npcDataList_lookup[eventGuidStr].posIndex=posIndex
end


function eventLocalOptionModel.setOptionEventNpcWatchedStartStory(isWatched,eventGuidStr)
local npcDataList_lookup=eventLocalOptionModel.getAllOptionEventNpcData()
if not npcDataList_lookup[eventGuidStr]then
npcDataList_lookup[eventGuidStr]={}
end
npcDataList_lookup[eventGuidStr].isWatchedStartStory=isWatched
end


function eventLocalOptionModel.getOptionEventNpcData(eventGuidStr)
if not _tmpNpcDataList_lookup then
_tmpNpcDataList_lookup=eventLocalOptionModel.getAllOptionEventNpcData()
end
return _tmpNpcDataList_lookup[eventGuidStr]
end


function eventLocalOptionModel.getAllOptionEventNpcData()
if not _tmpNpcDataList_lookup then
_tmpNpcDataList_lookup=userActorArraySetting.get(ACTOR_SETTING_TYPE.eEvent,'randomNpcDataListLookup',{})
end
return _tmpNpcDataList_lookup
end


function eventLocalOptionModel.removeOptionEventNpcData(eventGuidStr)
local npcDataList_lookup=eventLocalOptionModel.getAllOptionEventNpcData()
if not npcDataList_lookup[eventGuidStr]then
return
end
npcDataList_lookup[eventGuidStr]=nil
end


function eventLocalOptionModel.saveAllOptionEventNpcData()
if not _tmpNpcDataList_lookup then
return
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eEvent,'randomNpcDataListLookup',_tmpNpcDataList_lookup)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eEvent)
end


function eventLocalOptionModel.test_removeAllOptionEventNpcData()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eEvent,'randomNpcDataListLookup',nil)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eEvent)
end