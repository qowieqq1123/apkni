











aiSpeakNode=simple_class(baseNode)

function aiSpeakNode:reset()
aiSpeakNode._base.reset(self)
self.isSpeaking=false
self.bComplete=false
end

function aiSpeakNode:update(interval)
if self.isSpeaking then
return nodeState.running
end

if self.bComplete then
self.bComplete=false
return self.checkState or nodeState.inactive
end

self.checkState=nodeState.running
self.isSpeaking=true
local args=self:getArgs()
local duration=self:getData('duration')or math.random(self:getData('minDuration'),self:getData('maxDuration'))
local content=self:getData('content')or''
local skin=self:getData('skin')or 1
local container=self:getData('container')
container=hudContainerType[container]
aiManager:setSpeakCMDToDisciple(args.dzId,content,duration,skin,container,function(isBreak)
self.checkState=isBreak and nodeState.failure or nodeState.success
self.isSpeaking=false
self.bComplete=true
self:quicklyTick()
end)
return self.checkState
end