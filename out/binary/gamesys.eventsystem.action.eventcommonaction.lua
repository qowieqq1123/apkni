





eventCommonAction=simple_class(eventBaseAction)

function eventCommonAction.create(...)
return refObject.getX('eventCommonAction',...)
end

function eventCommonAction:init(...)
self:onRelease()
self:start(...)
end

function eventCommonAction:onRelease()
self.actionList={}
self.nextEventid=nil
self.eventInfo=nil
end


function eventCommonAction:start(eventconfig,eventInfo)
self.eventInfo=eventInfo
self.actionList[#self.actionList+1]=eventTextAction.create(eventconfig,eventInfo)

for _,v in ipairs(eventconfig.action)do
local effectid=v[1]
local actionSrc=eventConfig.getAction(effectid)
if actionSrc then
local action=actionSrc.create(v,eventInfo)
self.actionList[#self.actionList+1]=action
end
end
self:update()
end

function eventCommonAction:update()
local hasNext=nil
for _,action in ipairs(self.actionList)do
if action:isNext()then
hasNext=true
else
if not action:update()then
return false
end
end
end
for _,action in ipairs(self.actionList)do
action:leave()
end
if not hasNext then
eventActionControl.onFinish(self.eventInfo.eventguid)
end
return true
end


