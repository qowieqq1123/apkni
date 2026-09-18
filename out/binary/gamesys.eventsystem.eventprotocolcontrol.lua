




eventProtocolControl=gameState.addListener({})

function eventProtocolControl:onAppStart()
socketManager:register_receiver(11,1,self.onRecvInitEvents)
socketManager:register_receiver(11,2,self.onRecvTriggerEvent)
socketManager:register_receiver(11,3,self.onRecvOptionEvent)
socketManager:register_receiver(11,4,self.onRecvEventPrize)
socketManager:register_receiver(11,5,self.onRecvNextEvent)
socketManager:register_receiver(11,6,self.onRecvServerData)
socketManager:register_receiver(11,7,self.onInitTriggerEventList)
socketManager:register_receiver(11,8,self.onRecvTriggerEventList)

socketManager:register_receiver(11,22,self.onInitOption)
end






function eventProtocolControl:onLeaveState()
end





function eventProtocolControl.onRecvInitEvents(len,eventInfoList)
eventControl.onRecvInitEvents(eventInfoList)
eventOptionControl.onInitEvents()
end


function eventProtocolControl.onRecvTriggerEvent(triggerInfo)
local guid=triggerInfo.guid
local ret=triggerInfo.res
local eventInfo=triggerInfo.eventInfo
local canEnqueue=true
if eventInfo then
local eventguid=eventInfo.eventguid
local rewardList=triggerInfo.paramList
eventServerDataModel.setData(eventguid,rewardList)
eventControl.setLongStamp(eventInfo)

local eventId=eventInfo.eventid
if eventConfig.isDecision(eventId)then

local isInCd=eventOptionControl:checkIsInRefreshNewOptionEventCd()
if isInCd then
canEnqueue=false

eventOptionModel.addWaitOptionEvent(eventInfo)






end
end
end
if canEnqueue then
eventControl.enqueueRet(guid,ret,eventInfo)
end
end


function eventProtocolControl.onRecvOptionEvent(eventguid,optionid,cndid,effectidx)
eventOptionControl:onRecvOptionEventRet(eventguid,optionid,cndid,effectidx)
end


function eventProtocolControl.onRecvEventPrize(eventguid)
eventOptionControl:onRecvEventPrize(eventguid)
end


function eventProtocolControl.onRecvNextEvent(eventguid,eventInfo)
eventControl.setLongStamp(eventInfo)
eventOptionControl.onRecvNextEvent(eventguid,eventInfo)
end


function eventProtocolControl.onRecvServerData(eventguid,len,rewardList)
eventServerDataModel.setData(eventguid,rewardList)
end


function eventProtocolControl.onInitTriggerEventList(len,array)
eventControl.onHandleServerTriggerEvent(len,array)
end

function eventProtocolControl.onRecvTriggerEventList(len,array)
eventControl.onTriggerEventList(len,array)
end


function eventProtocolControl.onInitOption(len,array)
eventOptionControl.onInitOption(len,array)
end






function eventProtocolControl.reqInitEvents()
socketManager:send_11_1()
end


function eventProtocolControl.reqTriggerEvent(triggerInfo)
if eventControl.invokeEventControl(triggerInfo[1],triggerInfo[2],'checkParamsOnReq',triggerInfo[5])==false then
eventTriggerContorl.onTriggerFail(triggerInfo)
return
end
socketManager:send_11_2(triggerInfo)
end


function eventProtocolControl.reqOptionEvent(eventguid,optionid,diziarray)
diziarray=diziarray or{}
socketManager:send_11_3(eventguid,optionid,#diziarray,diziarray)
end


function eventProtocolControl.reqEventPrize(eventguid)
socketManager:send_11_4(eventguid)
end


function eventProtocolControl.reqNextEvent(eventguid)
socketManager:send_11_5(eventguid)
end

function eventProtocolControl.reqTriggerEventList(triggerList)
local temp={}
local failTemp={}
for i,v in ipairs(triggerList)do
if eventControl.invokeEventControl(v[1],v[2],'checkParamsOnReq',v[5])~=false then
temp[#temp+1]=v
else
failTemp[#failTemp+1]=v
end
end
eventTriggerContorl.onTriggerListFail(failTemp)
if#temp>0 then
socketManager:send_11_8(#temp,temp)
end
end






