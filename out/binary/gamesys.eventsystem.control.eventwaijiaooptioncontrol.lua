





eventWaiJiaoOptionControl=gameState.addListener({})
eventWaiJiaoOptionControl.mainType=EVENT_TYPE.eDecision
eventWaiJiaoOptionControl.subType=EVENT_OPTION_SUB_TYPE.eWaiJiao



function eventWaiJiaoOptionControl:onAppStart()
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)
end

function eventWaiJiaoOptionControl:onEnterState()
end

function eventWaiJiaoOptionControl:onLeaveState()
end

function eventWaiJiaoOptionControl:onSystemInit()
if self:isOpenSystem()then
eventOptionControl.reqInit()
end
end

function eventWaiJiaoOptionControl.onSystemOpen(sysid)
if sysid==SYSTEM_DEFINE.eDiplomacyDecision then
eventOptionControl.reqInit()
end
end

function eventWaiJiaoOptionControl:update()
if not eventWaiJiaoOptionControl:isOpenSystem()then return end
eventOptionControl.updateUnHandNum(EVENT_OPTION_SUB_TYPE.eWaiJiao)
end


function eventWaiJiaoOptionControl:onInitOption()
end


function eventWaiJiaoOptionControl:triggerEvent()
local option=eventOptionModel.getOption()
if option==nil then return end
local mainType=self.mainType
local subType=self.subType
local triggerArray=eventTriggerModel.creatClientTriggerData(mainType,subType,1,nil,nil,timeHelper.getServerLongTime())
if triggerArray then
eventTriggerContorl:enQueue(triggerArray)
end
end

function eventWaiJiaoOptionControl:handleParamListToTxt(paramList)
if paramList==nil then
logErr('外交事件没有找到任何参数')
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

function eventWaiJiaoOptionControl:addDiziIntoEventInfo(eventInfo,diZiList,waitTime)
eventInfo.paramList[3]=#(diZiList or{})
eventInfo.paramList=table.concatTableX(eventInfo.paramList,diZiList)
eventInfo.waitTime=waitTime
eventInfo.eventtime=timeHelper.getServerShortTime()
end

function eventWaiJiaoOptionControl:onTriggerSucess()
eventOptionControl.updateUnHandNum(self.subType)
end

function eventWaiJiaoOptionControl:onTriggerFail(eventInfo)

eventWaiJiaoOptionControl:onTriggerSucess()

eventWaiJiaoOptionControl:onFinish(eventInfo)
end

function eventWaiJiaoOptionControl:onFinish(eventInfo)
local eventguid=eventInfo.eventguid
if eventOptionModel.getDoingOptionEvent(eventguid,true)then
eventOptionModel.freshDoingNum()
eventOptionControl.freshDialogue()
end
end

function eventWaiJiaoOptionControl:onRecvOptionEventRet(eventInfo,optionid,cndid,effectidx)
local eventguid=eventInfo.eventguid
eventInfo.optionlen=3
eventInfo.optionList={}
eventInfo.optionList[1]=optionid
eventInfo.optionList[2]=cndid
eventInfo.optionList[3]=effectidx
if eventInfo.waitTime==0 then
eventProtocolControl.reqEventPrize(eventguid)
end
eventOptionModel.addDoingOptionEvent(table.weakCopy(eventInfo))
eventOptionModel.freshDoingNum()
eventOptionControl.freshDialogue()
end

function eventWaiJiaoOptionControl:onRecvEventPrize(eventguid)
eventOptionActionControl.startOptionRetAction(eventguid)
eventOptionModel.finishOptionEvent(eventguid,true)
end

function eventWaiJiaoOptionControl:isOpenSystem()
return systemModel.isOpen(SYSTEM_DEFINE.eDiplomacyDecision)
end