








bwUnitSpeakWordNode=simple_class(baseNode)

function bwUnitSpeakWordNode:init()
self.isPlaying=false
self.bComplete=false
end

function bwUnitSpeakWordNode:update(interval)
if self.bComplete then
return nodeState.success
end
if self.isPlaying then
return nodeState.running
end

local unitKey=self:getData('unitKey')
local word=self:getData('word')or""
local duration=self:getData('duration')or 1
local wait=self:getData('wait')or false

if unitKey==nil then
return nodeState.failure
end

self.isPlaying=true
if wait then

behaviorManager:addWaiting(duration,function()
self.bComplete=true
self.isPlaying=false
self:quicklyTick()
end,self:isUseUnscaledTime())
return nodeState.running
else
self.bComplete=true
self.isPlaying=false
worldUnitModel:unitEmot(unitKey,word,duration)
return nodeState.success
end
end