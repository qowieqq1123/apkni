





eventZMOptionControl=gameState.addListener({})
eventZMOptionControl.mainType=EVENT_TYPE.eDecision
eventZMOptionControl.subType=EVENT_OPTION_SUB_TYPE.eZongmen



function eventZMOptionControl:onAppStart()
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)
end

function eventZMOptionControl:onEnterState()
end

function eventZMOptionControl:onLeaveState()
end

function eventZMOptionControl:onSystemInit()
if self:isOpenSystem()then
eventOptionControl.reqInit()
end
end

function eventZMOptionControl.onSystemOpen(sysid)
if sysid==SYSTEM_DEFINE.eSectDecision then
eventOptionControl.reqInit()
end
end

function eventZMOptionControl:update()
if not eventZMOptionControl:isOpenSystem()then return end
eventOptionControl.updateUnHandNum(EVENT_OPTION_SUB_TYPE.eZongmen)
end


function eventZMOptionControl:onInitOption()
end


function eventZMOptionControl:triggerEvent()
if not eventZMOptionControl:isOpenSystem()then return false end
local option=eventOptionModel.getOption()
if option==nil then return end
local mainType=self.mainType
local subType=self.subType
local triggerArray=eventTriggerModel.creatClientTriggerData(mainType,subType,1,nil,nil,timeHelper.getServerLongTime())
if triggerArray then
eventTriggerContorl:enQueue(triggerArray)
end
end

function eventZMOptionControl:handleParamListToTxt(paramList)
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

function eventZMOptionControl:addDiziIntoEventInfo(eventInfo,diZiList,waitTime)
if eventInfo.paramList then
eventInfo.paramList[3]=#(diZiList or{})
eventInfo.paramList=table.concatTableX(eventInfo.paramList,diZiList)
end
eventInfo.waitTime=waitTime
eventInfo.eventtime=timeHelper.getServerShortTime()
end

function eventZMOptionControl:onTriggerSucess()
eventOptionControl.updateUnHandNum(self.subType)
end

function eventZMOptionControl:onTriggerFail(eventInfo)

eventZMOptionControl:onTriggerSucess()

eventZMOptionControl:onFinish(eventInfo)
end

function eventZMOptionControl:onFinish(eventInfo)
local eventguid=eventInfo.eventguid
eventOptionModel.getFinishedMiJingOptionEvent(eventguid,true)
if eventOptionModel.getDoingOptionEvent(eventguid,true)then
eventOptionModel.freshDoingNum()
eventOptionControl.freshDialogue()
end
end

function eventZMOptionControl:onRecvOptionEventRet(eventInfo,optionid,cndid,effectidx)
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

local eventId=eventInfo.eventid

local hasPrize=eventOptionControl.checkOptionEventHasPrize(eventId,optionid,cndid,effectidx)
local isMiJingEvent=eventConfig.checkIsFinishMiJingEventOption(eventInfo.eventid,optionid)
if eventInfo.waitTime==0 and not isMiJingEvent then
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

function eventZMOptionControl:onRecvEventPrize(eventguid)
eventOptionActionControl.startOptionRetAction(eventguid)
eventOptionModel.finishOptionEvent(eventguid,true)
eventOptionControl.freshDialogue()
end

function eventZMOptionControl:isOpenSystem()
return systemModel.isOpen(SYSTEM_DEFINE.eSectDecision)
end