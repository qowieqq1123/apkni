






bXJUnitSpeakNode=simple_class(baseNode)

function bXJUnitSpeakNode:init()
self.isPlaying=false
self.bComplete=false
end

function bXJUnitSpeakNode:update(interval)
if self.bComplete then
return nodeState.success
end
if self.isPlaying then
return nodeState.running
end

local unitKey=self:getData('unitKey')
local word=self:getData('word')
local duration=self:getData('duration')
local wait=self:getData('wait')
local offset=self:getData('offset')

duration=duration or 1

if unitKey==nil then
logErr("仙界 行为树 创建实体 参数检测失败，unitKey 为空")
return nodeState.failure
end

self.isPlaying=true
if wait then
xianjieController:unitSpeak(unitKey,word,duration,offset)
behaviorManager:addWaiting(duration,function()
self.bComplete=true
self.isPlaying=false
self:quicklyTick()
end,self:isUseUnscaledTime())
return nodeState.running
else
self.bComplete=true
self.isPlaying=false
xianjieController:unitSpeak(unitKey,word,duration,offset)
return nodeState.success
end

return nodeState.success
end