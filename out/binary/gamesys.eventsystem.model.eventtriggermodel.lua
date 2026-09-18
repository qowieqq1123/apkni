




eventTriggerModel={}






local _eventTimeLookup={}
local _guidLookup={}

function eventTriggerModel.init()
_eventTimeLookup={}
_guidLookup={}
end

function eventTriggerModel.initList(mainType,subType)
if _eventTimeLookup[mainType]==nil then _eventTimeLookup[mainType]={}end
if _eventTimeLookup[mainType][subType]==nil then _eventTimeLookup[mainType][subType]={}end
end


function eventTriggerModel.creatClientTriggerData(mainType,subType,triggerid,paramList,duration,longtimeStamp,store)
if triggerid==nil then
loggerUtil.logErrFMT("传入触发id:{0}错误：",triggerid)
return
end
eventTriggerModel.initList(mainType,subType)
local triggerArray={}
triggerArray[1]=mainType
triggerArray[2]=subType
triggerArray[3]=triggerid
triggerArray[4]=paramList and#paramList or 0
local temp={}
for i,v in ipairs(paramList or{})do
temp[i]=int64.new(tostring(v))
end
triggerArray[5]=temp
local stamp=longtimeStamp or eventTriggerModel.getRandomTime(mainType,subType,duration)
triggerArray[6]=timeHelper.convertShortStamp(stamp)
triggerArray[7]=eventTriggerModel.getGUID()
if store then
eventLocalTriggerModel.addTableData(triggerArray)
end
return triggerArray
end


function eventTriggerModel.getRandomTime(mainType,subType,duration)
local lookup=_eventTimeLookup[mainType][subType]
local stamp=timeHelper.getServerLongTime()
local randomLongStamp=nil
local randomNum=0
local num=0
while randomLongStamp==nil or lookup[tostring(randomLongStamp)]do
randomNum=math.random(math.floor(duration/2),duration)
randomLongStamp=randomNum+stamp
num=num+1
if num>20 then
break
end
end
lookup[tostring(randomLongStamp)]=true
return randomLongStamp
end

function eventTriggerModel.verifyLocalDataOnRead(info)
local mainType=info[1]
local subType=info[2]
local ret=eventControl.invokeEventControl(mainType,subType,'verifyLocalDataOnRead',info)
if ret==false then
return false
end
return eventTriggerModel.addLocalGUID(info)
end


function eventTriggerModel.addLocalGUID(info)
local stamp=tonumber(info[7])
local guid=stamp
if _guidLookup[tostring(guid)]then
loggerUtil.logErrFMT('本地存储事件触发失败!重复guid:{0}',tostring(guid))
return false
end
local handle=tostring(guid)
_guidLookup[handle]=true
return true
end


function eventTriggerModel.getGUID()
local stamp=timeHelper.getServerShortTime()
local guid=stamp
while _guidLookup[tostring(guid)]do
guid=guid+0.0001
end
local handle=tostring(guid)
_guidLookup[handle]=true

return handle
end

