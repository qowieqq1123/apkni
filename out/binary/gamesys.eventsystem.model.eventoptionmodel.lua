




eventOptionModel={}

local _optionData
local _timeDelay=0.5






function eventOptionModel.init()
_optionData={}
eventOptionModel:stopPianyiTime()
end


function eventOptionModel.initDoingOptionsEvent(eventInfoList)
if _optionData==nil then _optionData={}end
_optionData.unHandNum=0
for i,v in ipairs(eventInfoList)do
eventOptionModel.addDoingOptionEvent(v,false)
end
eventOptionModel.freshDoingNum()
eventOptionModel.sortByEndTime()
end


function eventOptionModel.initOption(len,array)
if _optionData==nil then _optionData={}end
if array then
for i,v in ipairs(array)do
local subType=v.decisiontype
if _optionData[subType]==nil then _optionData[subType]={}end
local info=_optionData[subType]
info.alreadyNum=v.times
info.shortStamp=v.lasttm
info.costTime=0
info.unHandNum=0
eventOptionControl.initUnhandEventNum(subType)
eventOptionControl.log('刷新数据：类型{0}上次触发时间：{1}',subType,timeHelper.getFormatByStamp(timeHelper.convertLongStamp(v.lasttm)))
eventOptionControl.log('刷新数据：类型{0}已触发{1}次',subType,v.times)
end
end

local unHandNum=0
for i,subType in ipairs(EVENT_OPTION_SUB_NUM_LIST)do
if _optionData[subType]==nil then _optionData[subType]={}end
local info=_optionData[subType]
unHandNum=(info.unHandNum or 0)+unHandNum
end
_optionData.unHandNum=unHandNum

eventOptionModel:startPianyiTime()
_optionData.isInit=true
end

function eventOptionModel.addDoingOptionEvent(eventInfo,sort)
if _optionData==nil then return end
if _optionData.doingOptions==nil then _optionData.doingOptions={}end
local doingOptions=_optionData.doingOptions
local eventid=eventInfo.eventid
local eventguid=eventInfo.eventguid

if eventOptionModel.getDoingOptionEvent(eventguid)~=nil then return end

local eventconfig=eventConfig.getEventConfig(eventid)
local subType=eventconfig.type2
if _optionData[subType]==nil then _optionData[subType]={}end
local info=_optionData[subType]
eventOptionModel.setWaitTime(eventInfo)
doingOptions[#doingOptions+1]=eventInfo

if sort~=false then
eventOptionModel.sortByEndTime()
end
end

function eventOptionModel.addWaitChoiceOptionEvent(eventInfo)
if _optionData==nil then return end
if _optionData.waitChoiceOptions==nil then _optionData.waitChoiceOptions={}end
local waitChoiceOptions=_optionData.waitChoiceOptions
local eventid=eventInfo.eventid
local eventguid=eventInfo.eventguid

if eventOptionModel.getWaitChoiceOptionEvent(eventguid)~=nil then return end

local eventconfig=eventConfig.getEventConfig(eventid)
local subType=eventconfig.type2
if _optionData[subType]==nil then _optionData[subType]={}end
local info=_optionData[subType]
eventOptionModel.setWaitTime(eventInfo)
waitChoiceOptions[#waitChoiceOptions+1]=eventInfo
end

function eventOptionModel.addWaitFinishMiJingOptionEvent(eventInfo)
if _optionData==nil then return end
if _optionData.waitFinishMiJingOptions==nil then _optionData.waitFinishMiJingOptions={}end
local waitFinishMiJingOptions=_optionData.waitFinishMiJingOptions
local eventid=eventInfo.eventid
local eventguid=eventInfo.eventguid

if eventOptionModel.getWaitFinishMiJingOptionEvent(eventguid)~=nil then return end

local optionList=eventInfo.optionList
local optionid=optionList[1]
local miJingIdList=eventConfig.getEventOptionMiJingIdList(eventid,optionid)
local miJingId=miJingIdList[1]
if not waitFinishMiJingOptions[miJingId]then
waitFinishMiJingOptions[miJingId]={}
end
table.insert(waitFinishMiJingOptions[miJingId],eventInfo)
end

function eventOptionModel.addFinishedMiJingOptionEvent(eventInfo)
if _optionData==nil then return end
if _optionData.finishedMiJingOptions==nil then _optionData.finishedMiJingOptions={}end
local finishedMiJingOptions=_optionData.finishedMiJingOptions
local eventid=eventInfo.eventid
local eventguid=eventInfo.eventguid
local eventguidStr=tostring(eventguid)
if finishedMiJingOptions[eventguidStr]~=nil then return end

finishedMiJingOptions[eventguidStr]=eventInfo
end

function eventOptionModel.timeCall(subType)
if _optionData[subType]==nil then _optionData[subType]={}end
if _optionData[subType].costTime==nil then _optionData[subType].costTime=0 end
local storeMaxNum=eventConfig.getEventOptionStoreNum(subType)
if _optionData[subType].unHandNum==nil then return end
if _optionData[subType].unHandNum>=storeMaxNum then
_optionData[subType].costTime=_optionData[subType].costTime+_timeDelay

end
end

function eventOptionModel:startPianyiTime()
if self.costTimer then return end
self.costTimer=timer.new()
self.costTimer:start(_timeDelay,function()
for i,v in ipairs(EVENT_OPTION_SUB_NUM_LIST)do
eventOptionModel.timeCall(v)
end
end)
end

function eventOptionModel:stopPianyiTime()
if self.costTimer then
self.costTimer:cancel()
end
self.costTimer=nil
end

function eventOptionModel.getDoingOptionEvent(eventguid,remove)
if _optionData==nil or _optionData.doingOptions==nil then return end
local doingOptions=_optionData.doingOptions
local guid=tostring(eventguid)
for i,v in ipairs(doingOptions)do
if tostring(v.eventguid)==guid then
if remove then
table.remove(doingOptions,i)
end
return v
end
end
end

function eventOptionModel.getWaitChoiceOptionEvent(eventguid,remove)
if _optionData==nil or _optionData.waitChoiceOptions==nil then return end
local waitChoiceOptions=_optionData.waitChoiceOptions
local guid=tostring(eventguid)
for i,v in ipairs(waitChoiceOptions)do
if tostring(v.eventguid)==guid then
if remove then
table.remove(waitChoiceOptions,i)
end
return v
end
end
end

function eventOptionModel.getWaitFinishMiJingOptionEvent(eventguid,remove)
if _optionData==nil or _optionData.waitFinishMiJingOptions==nil then return end
local waitFinishMiJingOptions=_optionData.waitFinishMiJingOptions
local guid=tostring(eventguid)
for miJingId,eventList in pairs(waitFinishMiJingOptions)do
for i,v in ipairs(eventList)do
if mathHelper.compareInt64(v.eventguid,eventguid)then
if remove then
table.remove(eventList,i)
end
return v
end
end
end
end

function eventOptionModel.getWaitFinishMiJingOptionEventList(miJingId,remove)
if _optionData==nil or _optionData.waitFinishMiJingOptions==nil then return end
local waitFinishMiJingOptions=_optionData.waitFinishMiJingOptions
if waitFinishMiJingOptions[miJingId]then
local eventList=waitFinishMiJingOptions[miJingId]
if remove then
waitFinishMiJingOptions[miJingId]=nil
end
return eventList
end
return nil
end

function eventOptionModel.getFinishedMiJingOptionEvent(eventguid,remove)
if _optionData==nil then return end
if _optionData.finishedMiJingOptions==nil then return end
local finishedMiJingOptions=_optionData.finishedMiJingOptions
local eventguidStr=tostring(eventguid)
if finishedMiJingOptions[eventguidStr]then
local eventInfo=finishedMiJingOptions[eventguidStr]
if remove then
finishedMiJingOptions[eventguidStr]=nil
end
return eventInfo
end

return nil
end

function eventOptionModel.sortByEndTime()
if _optionData==nil or _optionData.doingOptions==nil then return end
local doingOptions=_optionData.doingOptions
if#doingOptions>1 then
table.sort(doingOptions,function(a,b)
local eventId_A=a.eventid
local optionList_A=a.optionList
local optionId_A=optionList_A[1]
local isMiJingEvent_A=eventConfig.checkIsFinishMiJingEventOption(eventId_A,optionId_A)
local miJingWight_A=isMiJingEvent_A and a.eventtime or 0
local eventId_B=b.eventid
local optionList_B=b.optionList
local optionId_B=optionList_B[1]
local isMiJingEvent_B=eventConfig.checkIsFinishMiJingEventOption(eventId_B,optionId_B)
local miJingWight_B=isMiJingEvent_B and b.eventtime or 0

if miJingWight_A==0 and miJingWight_B==0 then

return a.eventtime+a.waitTime<b.eventtime+b.waitTime
else
return miJingWight_A<miJingWight_B
end
end)
end
end

function eventOptionModel.finishOptionEvent(eventguid,delete)
local eventInfo=eventOptionModel.getDoingOptionEvent(eventguid,delete)
eventOptionModel.getFinishedMiJingOptionEvent(eventguid,delete)
eventOptionModel.setOpenEventWinParam(nil,eventguid)
if eventInfo then
eventOptionModel.freshDoingNum()
end
end

function eventOptionModel.freshDoingNum()
if _optionData==nil then return end
if _optionData.doingOptions==nil then _optionData.doingOptions={}end
local doingOptions=_optionData.doingOptions
local doingNum=0
local donumList={}
for _,v in ipairs(doingOptions)do
local eventconfig=eventConfig.getEventConfig(v.eventid)
local subType=eventconfig.type2
if _optionData[subType]==nil then _optionData[subType]={}end
local info=_optionData[subType]
donumList[subType]=(donumList[subType]or 0)+1
info.doingNum=donumList[subType]
doingNum=doingNum+1
end
for i,subType in ipairs(EVENT_OPTION_SUB_NUM_LIST)do
eventOptionControl.log('刷新数据：类型{0}有{1}次事件正在进行',subType,donumList[subType]or 0)
end
_optionData.doingNum=doingNum
eventOptionControl.log('刷新数据：总共有{0}次事件正在进行',doingNum)
end


function eventOptionModel.freshWaitChoiceNum()
if _optionData==nil then return end
if _optionData.waitChoiceOptions==nil then _optionData.waitChoiceOptions={}end
local waitChoiceOptions=_optionData.waitChoiceOptions
local waitChoiceNum=0
local waitnumList={}
for _,v in ipairs(waitChoiceOptions)do
local eventconfig=eventConfig.getEventConfig(v.eventid)
local subType=eventconfig.type2
if _optionData[subType]==nil then _optionData[subType]={}end
local info=_optionData[subType]
waitnumList[subType]=(waitnumList[subType]or 0)+1
info.waitChoiceNum=waitnumList[subType]
waitChoiceNum=waitChoiceNum+1
end

_optionData.waitChoiceNum=waitChoiceNum
end

function eventOptionModel.getOneDoingOptionEvent()
if _optionData==nil or _optionData.doingOptions==nil then return end
local doingOptions=_optionData.doingOptions
return doingOptions[1]
end

function eventOptionModel.getDoingOptions()
if _optionData==nil then return end
return _optionData.doingOptions or{}
end

function eventOptionModel.getDoingOptionsEx()
if _optionData==nil then return end
return _optionData.doingOptions
end

function eventOptionModel.getSubOption(subType)
if _optionData==nil then return end
return _optionData[subType]
end

function eventOptionModel.getOption()
return _optionData
end

function eventOptionModel.getOneUnHandeOptionType()
if _optionData==nil then return end
for i,v in pairs(EVENT_OPTION_SUB_TYPE)do
if _optionData[v]and _optionData[v].unHandNum and _optionData[v].unHandNum>0 then
return{v,_optionData[v].unHandNum}
end
end
end

function eventOptionModel.getUnHandNumByOptionType(optionType)
if _optionData==nil then return 0 end
if _optionData[optionType]and _optionData[optionType].unHandNum then
return _optionData[optionType].unHandNum or 0
end
return 0
end

function eventOptionModel.getLeftTime(eventInfo)
eventOptionModel.setWaitTime(eventInfo)
return eventInfo.eventtime+eventInfo.waitTime-timeHelper.getServerShortTime()
end

function eventOptionModel.setWaitTime(eventInfo)
if eventInfo.waitTime==nil then
local index=eventInfo.optionList and eventInfo.optionList[1]or nil
eventInfo.waitTime=eventConfig.getEventOptionWaitTime(eventInfo.eventid,index)
end
end

function eventOptionModel.getOpenEventWinParamByEventGuid(eventguid)
if _optionData==nil then return end
local eventguidStr=tostring(eventguid)
return _optionData[eventguidStr]
end

function eventOptionModel.setOpenEventWinParam(args,eventguid)
if _optionData==nil then return end
local eventguidStr=tostring(eventguid)
_optionData[eventguidStr]=args
end















function eventOptionModel.addWaitOptionEvent(eventInfo)
if _optionData==nil then _optionData={}end
if not _optionData.addWaitOptionEventList then
_optionData.addWaitOptionEventList={}
end
table.insert(_optionData.addWaitOptionEventList,eventInfo)
end


function eventOptionModel.checkWaitOptionEventCount()
if _optionData==nil then return 0 end
if not _optionData.addWaitOptionEventList then
return 0
end

local count=#_optionData.addWaitOptionEventList
return count
end


function eventOptionModel.getWaitOptionEventInfo()
if _optionData==nil then return end
if not _optionData.addWaitOptionEventList or not next(_optionData.addWaitOptionEventList)then
return
end

local eventInfo=_optionData.addWaitOptionEventList[1]
table.remove(_optionData.addWaitOptionEventList,1)
return eventInfo
end

function eventOptionModel.setShowOptionEventResultFunc(showFunc)
if _optionData==nil then return end
_optionData.showOptionEventResultFunc=showFunc
end

function eventOptionModel.getShowOptionEventResultFunc(isClear)
if _optionData==nil then return end
if _optionData.showOptionEventResultFunc then
local func=_optionData.showOptionEventResultFunc
if isClear then
_optionData.showOptionEventResultFunc=nil
end
return func
end
return
end

function eventOptionModel.setShowOptionEventResultIsOpening(flag)
if _optionData==nil then return end
_optionData.showOptionEventResultIsOpening=flag
end

function eventOptionModel.getShowOptionEventResultIsOpening()
if _optionData==nil then return end
return _optionData.showOptionEventResultIsOpening
end