






waitNode=simple_class(baseNode)

function waitNode:init()
self.isWaiting=false
self.bComplete=false
self.waitingId=nil
end

function waitNode:broke()
self:cancelWaiting()
end

function waitNode:cancelWaiting()
if self.waitingId then
behaviorManager:removeWaiting(self.waitingId)
self.waitingId=nil
end
end

function waitNode:update(interval)
if self.isWaiting then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local waitTime=self:getData('waitTime')
if not waitTime then
local min=self:getData('minTime')
local max=self:getData('maxTime')



waitTime=math.random()*(max-min)+min
end

if waitTime<=0 then
return nodeState.success
end

self.isWaiting=true
self.waitingId=behaviorManager:addWaiting(waitTime,function()
self.isWaiting=false
self.bComplete=true
self:quicklyTick()
end,self:isUseUnscaledTime())

return nodeState.running
end

function waitNode:skip()
self:cancelWaiting()
return nodeState.success
end