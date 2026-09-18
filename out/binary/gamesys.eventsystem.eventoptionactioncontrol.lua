





eventOptionActionControl=gameState.addListener({})





local _actionList={}
local _actionLookup={}


function eventOptionActionControl:onAppStart()
end

function eventOptionActionControl:onEnterState()
_actionList={}
_actionLookup={}
self.timer=timer.new()
self.timer:start(0.1,function()
self:update()
end)
end

function eventOptionActionControl:onLeaveState()
_actionList={}
_actionLookup={}
if self.timer then
self.timer:cancel()
end
self.timer=nil
end

function eventOptionActionControl.startEnterAction(eventconfig,eventInfo)

if eventconfig.imageLib then
local npcData
if not eventInfo.npcData then

local eventGuidStr=tostring(eventInfo.eventguid)
local localNpcData=eventLocalOptionModel.getOptionEventNpcData(eventGuidStr)
npcData=localNpcData and localNpcData.npcData or nil
if not npcData then

npcData=eventOptionControl.getOptionNpcData(eventInfo.eventid,eventInfo.eventguid)

eventLocalOptionModel.setOptionEventNpcData(npcData,eventGuidStr)
end
eventInfo.npcData=npcData
else

npcData=eventInfo.npcData
end

local canCreate=true
if npcData then
if canCreate then

local isCanFly=eventOptionControl.checkOptionNpcIsCanFly(eventInfo.npcData)
if not shanmenModel:checkOptionEventNpcHasFreePos(isCanFly)then

canCreate=false
end
end
else

canCreate=false
end

if canCreate then

local action=eventOptionAction.create(eventconfig,eventInfo)
eventOptionActionControl.addAction(action)

eventOptionModel.addWaitChoiceOptionEvent(eventInfo)
eventOptionModel.freshWaitChoiceNum()


eventOptionControl.freshDialogue()

notifySystem:postNotify(notifyConfig.onShanMenVisitChange,SHANMEN_TYPE.eOptionEvent)
else

eventOptionModel.addWaitOptionEvent(eventInfo)
end
else

logErr(FMT.fmt("找不到事件id为{0}对应的决策事件形象库配置 请检查配置是否正确",eventconfig.id))
end
end


function eventOptionActionControl.startOptionRetAction(eventguid)
local eventInfo=eventOptionModel.getDoingOptionEvent(eventguid)
local eventconfig=eventConfig.getEventConfig(eventInfo.eventid)
local action=eventOptionRetAction.create(eventconfig,eventInfo)
eventOptionActionControl.addAction(action)
end


function eventOptionActionControl.onFinish(eventInfo)
if eventOptionControl.isDecision(eventInfo)then
eventOptionControl.onFinish(eventInfo)


local eventGuidStr=tostring(eventInfo.eventguid)
eventLocalOptionModel.removeOptionEventNpcData(eventGuidStr)
end
end

function eventOptionActionControl.leaveAction(actionguid,actionKey)
local len=#_actionList
if len<=0 then return end
for i=len,1,-1 do
local action=_actionList[i]
if action:isAliveSelf(actionguid,actionKey)then
local guid=action.guid
table.remove(_actionList,i)
_actionLookup[guid]=nil
action:leave()
end
end
end

function eventOptionActionControl.addAction(action)
if action==nil then return end
local guid=action.guid

if _actionLookup[guid]then return end
_actionLookup[guid]=true
_actionList[#_actionList+1]=action
end

function eventOptionActionControl:update()
local len=#_actionList
if len<=0 then return end
local action=_actionList[1]
if action:update()then
local guid=action.guid
table.remove(_actionList,1)
_actionLookup[guid]=nil
action:leave()
end
end

