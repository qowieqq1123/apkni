





eventCNDOptionControl=gameState.addListener({})
eventCNDOptionControl.mainType=EVENT_TYPE.eDecision
eventCNDOptionControl.subType=EVENT_OPTION_SUB_TYPE.eCondition



function eventCNDOptionControl:onAppStart()
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)
end

function eventCNDOptionControl:onEnterState()

end

function eventCNDOptionControl:onLeaveState()

end

function eventCNDOptionControl:onSystemInit()
if self:isOpenSystem()then
eventOptionControl.reqInit()
end
end

function eventCNDOptionControl.onSystemOpen(sysid)
if sysid==SYSTEM_DEFINE.eConditionDecision then
eventOptionControl.reqInit()
end
end

function eventCNDOptionControl:update()
if not eventCNDOptionControl:isOpenSystem()then return end

end


function eventCNDOptionControl:onInitOption()

end

function eventCNDOptionControl:handleParamListToTxt(paramList)
if paramList==nil then

return
end
local temp={}
local optionType=paramList[1]
local diziLen=tonumber(tostring(paramList[3]or 0))
if diziLen>0 then
for i=1,diziLen do
local diziguid=int64.new(tostring(paramList[i+3]))
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
local name=diziInfo.disciplename
local diziStr=FMT.fmt('dizi{0}',i)
temp[diziStr]={diziguid=diziguid,diziname=name}
end
end
return temp
end

function eventCNDOptionControl:addDiziIntoEventInfo(eventInfo,diZiList,waitTime)
if eventInfo.paramList then
eventInfo.paramList[3]=#(diZiList or{})
eventInfo.paramList=table.concatTableX(eventInfo.paramList,diZiList)
end
eventInfo.waitTime=waitTime
eventInfo.eventtime=timeHelper.getServerShortTime()
end

function eventCNDOptionControl:onTriggerSucess()
end

function eventCNDOptionControl:onFinish(eventInfo)
local eventguid=eventInfo.eventguid
eventOptionModel.getFinishedMiJingOptionEvent(eventguid,true)
if eventOptionModel.getDoingOptionEvent(eventguid,true)then
eventOptionControl.freshDialogue()
end
end

function eventCNDOptionControl:onRecvOptionEventRet(eventInfo,optionid,cndid,effectidx)
local eventguid=eventInfo.eventguid
eventInfo.optionlen=3
eventInfo.optionList={}
eventInfo.optionList[1]=optionid
eventInfo.optionList[2]=cndid
eventInfo.optionList[3]=effectidx

local waitChoiceEventInfo=eventOptionModel.getWaitChoiceOptionEvent(eventguid,true)
if waitChoiceEventInfo then
eventOptionModel.freshWaitChoiceNum()
end

local hasPrize=false
local isMiJingEvent=eventConfig.checkIsFinishMiJingEventOption(eventInfo.eventid,optionid)
if eventInfo.waitTime==0 and not isMiJingEvent then

local eventId=eventInfo.eventid
local option=eventConfig.getEventConfig(eventId).option
if option then
local resultList=option[optionid]and option[optionid].result or nil
if resultList then
local cndList=resultList[cndid]and resultList[cndid][2]or nil
if cndList then
local effectList=cndList[effectidx]and cndList[effectidx][1]or nil
if effectList then
for i,effectParam in ipairs(effectList)do
if effectParam and next(effectParam)then
hasPrize=true
break
end
end
end
end
end
end

if not hasPrize then

local endFunc=function()

shanmenModel:optionEventNPCLeave(eventguid,optionid)


eventOptionControl:checkWaitOptionEventList()

eventOptionModel.finishOptionEvent(eventguid,true)
eventActionControl.onFinish(eventguid)
notifySystem:postNotify(notifyConfig.onShanMenVisitChange,SHANMEN_TYPE.eOptionEvent)
end


local storyId=eventOptionControl.checkOptionEventHasEndStory(eventInfo,optionid,cndid,effectidx,true)
if storyId then
local npcData=eventInfo.npcData
local args={

npcData=npcData,
eventguid=eventguid,


}

worldStoryController:showStoryTree(storyId,endFunc,nil,nil,args)
else

endFunc()
end
end
end

if eventInfo.waitTime~=0 or hasPrize or isMiJingEvent then
eventOptionModel.addDoingOptionEvent(table.weakCopy(eventInfo))
if isMiJingEvent then
eventOptionModel.addWaitFinishMiJingOptionEvent(eventInfo)
end
end
eventOptionModel.freshDoingNum()
eventOptionControl.freshDialogue()

if eventInfo.waitTime==0 and hasPrize then
local eventId=eventInfo.eventid

local dispatch=eventConfig.getOptionDispatch(eventId,optionid)
if dispatch then

eventProtocolControl.reqEventPrize(eventguid)
else

eventOptionControl:onRecvEventPrize(eventguid)
end
end

if eventInfo.waitTime>0 or isMiJingEvent then

local endFunc=function()

shanmenModel:optionEventNPCLeave(eventguid,optionid)


eventOptionControl:checkWaitOptionEventList()
notifySystem:postNotify(notifyConfig.onShanMenVisitChange,SHANMEN_TYPE.eOptionEvent)

if isMiJingEvent then

local eventId=eventInfo.eventid
local miJingIdList=eventConfig.getEventOptionMiJingIdList(eventId,optionid)
local miJingId=miJingIdList[1]
UIManager:showWindow('UIMiJingInfoShowWin',{miJingId=miJingId})
end
end


local storyId=eventOptionControl.checkOptionEventHasSelectStory(eventInfo,optionid,cndid)
if storyId then

local npcData=eventInfo.npcData
local args={

npcData=npcData,
eventguid=eventguid,


}

worldStoryController:showStoryTree(storyId,endFunc,nil,nil,args)
else

endFunc()
end
end
end

function eventCNDOptionControl:onRecvEventPrize(eventguid)
eventOptionActionControl.startOptionRetAction(eventguid)
eventOptionModel.finishOptionEvent(eventguid,true)
eventOptionControl.freshDialogue()
end

function eventCNDOptionControl:isOpenSystem()
return systemModel.isOpen(SYSTEM_DEFINE.eConditionDecision)
end