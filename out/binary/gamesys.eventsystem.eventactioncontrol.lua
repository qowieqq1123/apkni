





eventActionControl=gameState.addListener({})





local _actionList={}
local _actionLookup={}


local _replaceKeyTable={}

function eventActionControl:onAppStart()
end

function eventActionControl:onEnterState()
_actionList={}
_actionLookup={}

end

function eventActionControl:onLeaveState()
_actionList={}
_actionLookup={}
end

function eventActionControl.doEvent(eventInfo)
local eventid=eventInfo.eventid
local eventconfig=eventConfig.getEventConfig(eventid)
eventActionControl.doEventAction(eventconfig,eventInfo)
end

function eventActionControl.doEventAction(eventconfig,eventInfo)
local mainType=eventconfig.type1
local subType=eventconfig.type2
if mainType==EVENT_TYPE.eNomal then
eventActionControl.startTextAction(eventconfig,eventInfo)
elseif mainType==EVENT_TYPE.eDecision then
eventOptionActionControl.startEnterAction(eventconfig,eventInfo)
end
end


function eventActionControl.startTextAction(eventconfig,eventInfo)
if eventconfig==nil or eventconfig.content==nil then return end
local action=eventTextAction.create(eventconfig,eventInfo)
eventActionControl.addAction(action)
end


function eventActionControl.onFinish(eventguid)
local eventInfo=eventLocalOptionModel.deleteEventData(eventguid)
eventOptionActionControl.onFinish(eventInfo)
end


function eventActionControl.addAction(action)
if action==nil then return end
local guid=action.guid

if _actionLookup[guid]then return end
_actionLookup[guid]=true
_actionList[#_actionList+1]=action
end

function eventActionControl.clearReplaceData()
for i,v in ipairs(_replaceKeyTable)do
FMT.setReplaceFunction(v,nil)
end

end

function eventActionControl.setReplace(argsKey,value)
_replaceKeyTable[#_replaceKeyTable+1]=argsKey

FMT.setReplaceFunction(argsKey,function()return value end)
end
