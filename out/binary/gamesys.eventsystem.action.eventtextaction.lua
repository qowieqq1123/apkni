




eventTextAction=simple_class(eventBaseAction)

function eventTextAction.create(...)
return refObject.getX('eventTextAction',...)
end

function eventTextAction:init(...)
self.leaveState=false
self:onRelease()
self:start(...)
end

function eventTextAction:onRelease()
self.mainType=nil
self.subType=nil
self.paramList=nil
self.eventid=nil
self.leaveState=false
end


function eventTextAction:start(eventconfig,eventInfo)
self.mainType=eventconfig.type1
self.subType=eventconfig.type2
self.paramList=eventInfo.paramList
self.eventid=eventInfo.eventid
self.eventguid=eventInfo.eventguid
self.timeStamp=eventInfo.timeStamp
self:post()
self.leaveState=true
end

function eventTextAction:update()
return self.leaveState
end

function eventTextAction:post()
local paramList=self.paramList
local eventid=self.eventid
local eventguid=self.eventguid
local mainType=self.mainType
local subType=self.subType
local timeStamp=self.timeStamp
local txt,args1=eventTextControl.getContent(eventguid,eventid,paramList)
if txt then
eventTextNotifyControl.updateText(mainType,subType,eventid,txt,paramList,timeStamp)
if paramList then
local dis_guid1,dis_guid2=eventControl.invokeEventControl(mainType,subType,'getDiziID',paramList)
if dis_guid1~=nil then
notifySystem:postNotify(notifyConfig.onDiscipleEventCreateStrory,dis_guid1,txt,timeStamp)
end
if dis_guid2~=nil then
notifySystem:postNotify(notifyConfig.onDiscipleEventCreateStrory,dis_guid2,txt,timeStamp)
end
end
end
end
