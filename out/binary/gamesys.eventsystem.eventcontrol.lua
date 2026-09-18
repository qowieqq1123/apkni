





eventControl=gameState.addListener({})





local _register_list={}


local _fixedNum=100000
local _cacheRetQueue={}
local _needFreshLocalFile=false

local _isRecvInitServerData=false
local _isRecvInitCustomData=false
local _isRecvAllInitData=false
local _isHandleAllInitData=false
local _settingType=ACTOR_SETTING_TYPE.eEvent

function eventControl:onAppStart()
end

function eventControl:onEnterState()
_cacheRetQueue={}
_isRecvAllInitData=false
_isRecvInitServerData=false
_isRecvInitCustomData=false
_isHandleAllInitData=false
eventConfig.init()
eventOptionModel.init()
eventControl.onEnter()
eventTriggerModel.init()
eventLocalOptionModel.init()
eventServerDataModel.init()
self.updateTimer=FrameTimer.New(function()
self:update()
end,0,-1)
self.updateTimer:Start()
self.freshLocalTimer=timer.new()
self.freshLocalTimer:start(1,function()
eventControl.freshLocalFile()
end)
end

function eventControl:onLeaveState()
_cacheRetQueue={}
_isRecvAllInitData=false
_isRecvInitServerData=false
_isRecvInitCustomData=false
_isHandleAllInitData=false
eventLocalTriggerModel.init()
eventControl.freshLocalFile()
eventConfig.init()
eventOptionModel.init()
eventControl.onLeave()
eventTriggerModel.init()
eventLocalOptionModel.init(true)
if self.updateTimer then
self.updateTimer:Stop()
end
self.updateTimer=nil
if self.freshLocalTimer then
self.freshLocalTimer:cancel()
end
self.freshLocalTimer=nil
end

function eventControl:update()

eventControl.dequeueRet()
end

function eventControl.onEnter()

end

function eventControl.onLeave()

end





function eventControl.onRecvInitEvents(eventInfoList)
local list={}
local triggerList={}
local needStore=false
local waitChoiceList={}
for _,eventInfo in ipairs(eventInfoList or{})do
eventControl.setLongStamp(eventInfo)
needStore=eventLocalOptionModel.setEventData(eventInfo,false)or needStore
local eventid=eventInfo.eventid
local eventconfig=eventConfig.getEventConfig(eventid)
local mainType=eventconfig.type1
local subType=eventconfig.type2
if mainType==EVENT_TYPE.eNomal then

elseif mainType==EVENT_TYPE.eDecision then
local eventstate=eventInfo.eventstate
if eventstate==EVENT_STATE.eWaitChoice then
eventControl.enqueueRet("nil",0,eventInfo)
elseif eventstate==EVENT_STATE.eWaitReward then
eventOptionModel.setWaitTime(eventInfo)
list[#list+1]=eventInfo
elseif eventstate==EVENT_STATE.eFinish then

elseif eventstate==EVENT_STATE.eWaitNext then

end
end
end
if needStore then
eventLocalOptionModel.store()
end
eventOptionModel.initDoingOptionsEvent(list)
end







function eventControl.dequeueEventRet(guid,ret,eventInfo)
if ret==0 then
if eventInfo then
local eventid=eventInfo.eventid
local eventconfig=eventConfig.getEventConfig(eventid)
local mainType=eventconfig.type1
local subType=eventconfig.type2
eventLocalOptionModel.setEventData(eventInfo)
eventControl.onTriggerSucess(eventInfo)
eventActionControl.doEvent(eventInfo)
eventServerDataModel.saveEventInfo(eventInfo)
end
else









end
end







function eventControl.onHandleServerTriggerEvent(len,array)
if len>0 then
for i=1,len do
local info=array[i]
local guid=info.guid
local ret=info.res
local eventInfo=info.eventInfo
local paramlen=info.paramlistlen
local rewardList=info.paramList
if ret==0 and eventInfo then
eventControl.setLongStamp(eventInfo)
local eventguid=eventInfo.eventguid
eventServerDataModel.setData(eventguid,rewardList)
eventServerDataModel.saveEventInfo(eventInfo)
end
eventControl.enqueueRet(guid,ret,eventInfo)
end
end
eventControl.setRecvAllServerInitData()
end

function eventControl.onTriggerEventList(len,array)
if len>0 then
for i,v in ipairs(array)do
local eventInfo=v.eventInfo
local ret=v.res
local guid=v.guid
local paramlen=v.paramlistlen
local rewardList=v.paramList
if ret==0 and eventInfo then
local eventguid=eventInfo.eventguid
eventControl.setLongStamp(eventInfo)
eventServerDataModel.setData(eventguid,rewardList)
eventServerDataModel.saveEventInfo(eventInfo)
end
eventControl.enqueueRet(guid,ret,eventInfo)
end
end
eventControl.setRecvAllCustomInitData()
end

function eventControl.freshRecvAllInitFlag()
if not _isRecvAllInitData and _isRecvInitServerData and _isRecvInitCustomData then
_isRecvAllInitData=true
end
eventControl.dequeueRet()
end




function eventControl.enqueueRet(guid,ret,eventInfo)
eventLocalTriggerModel.deleteTableData(guid)
if eventInfo then

else

return
end
local info={guid,ret,eventInfo}
local eventType,subType=eventConfig.getEventTypeById(eventInfo.eventid)
if _cacheRetQueue==nil then _cacheRetQueue={}end
local queue=_cacheRetQueue
queue[#queue+1]=info
if#queue>1 then
table.sort(queue,function(a,b)
return a[3].eventtime<b[3].eventtime
end)
end
end


function eventControl.dequeueRet()
if _isRecvAllInitData then
if#_cacheRetQueue<=0 then
if not _isHandleAllInitData then
_isHandleAllInitData=true
notifySystem:postNotify(notifyConfig.onEventInitFinish)
end
return
end
for _,v in ipairs(_cacheRetQueue)do
local info=v
if info then
eventControl.dequeueEventRet(info[1],info[2],info[3])
end
end
_cacheRetQueue={}
if not _isHandleAllInitData then
_isHandleAllInitData=true
notifySystem:postNotify(notifyConfig.onEventInitFinish)
end
end
end





local function _getEventControl(mainType,subType)
if _register_list[mainType]==nil then return end
return _register_list[mainType][subType]
end


function eventControl.loadEventControl(name)
require(FMT.fmt('lua.gamesys/eventSystem/control/{0}',name))
local control=_G[name]
local mainType=control.mainType
local subType=control.subType
if _register_list[mainType]==nil then _register_list[mainType]={}end
if _register_list[mainType][subType]then return end
_register_list[mainType][subType]=control
end






function eventControl.invokeEventControl(mainType,subType,name,...)
local control=_getEventControl(mainType,subType)
if control and control[name]then
return control[name](control,...)
end
end

function eventControl.setLongStamp(eventInfo)
if eventInfo==nil then return end
eventInfo.timeStamp=timeHelper.convertLongStamp(eventInfo.eventtime)

end

function eventControl.getLocalVal(key)
return userActorArraySetting.get(ACTOR_SETTING_TYPE.eEvent,key)
end


function eventControl.freshLocalVal(key,val,canDelay)

userActorArraySetting.set(_settingType,key,val)
if not canDelay then
userActorArraySetting.flush(_settingType)
else
_needFreshLocalFile=true
end
end


function eventControl.freshLocalFile()
if _needFreshLocalFile then
_needFreshLocalFile=false
userActorArraySetting.flush(_settingType,true)
end
end

function eventControl.onTriggerSucess(eventInfo)
local mainType,subType=eventConfig.getEventTypeById(eventInfo.eventid)
eventControl.invokeEventControl(mainType,subType,'onTriggerSucess',eventInfo)
end

function eventControl.setRecvAllCustomInitData()
_isRecvInitCustomData=true
eventControl.freshRecvAllInitFlag()
end

function eventControl.setRecvAllServerInitData()
_isRecvInitServerData=true
eventControl.freshRecvAllInitFlag()
end

function eventControl.isRecvInitCustomData()
return _isRecvInitCustomData==true
end

function printTable(a,index)
if type(a)=='table'then
for i,v in pairs(a)do
printTable(v,i)
end
else

end
end

function eventControl.test()
local cjson=require'cjson'
local paramList={int64.new('1'),int64.new('2')}
local list={}
for i,v in ipairs(paramList)do
list[#list+1]=tostring(v)
end
local a={
{1,2,3,2,list,timeHelper.getServerLongTime(),1}
}

local t=cjson.encode(a)

userActorArraySetting.set(_settingType,'eventtest',t)
userActorArraySetting.flush(_settingType)
end

function eventControl.read()
local cjson=require'cjson'
local t=userActorArraySetting.get(_settingType,'eventtest','')
local t1=cjson.decode(t)
printTable(t1)
end
