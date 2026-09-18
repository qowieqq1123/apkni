







runAnimatorNode=simple_class(baseNode)

function runAnimatorNode:init()
self.playing=false
end

function runAnimatorNode:update(interval)
if self.playing then
if Time.time>self.endTime then
return nodeState.success
end
return nodeState.running
end

local animId=self:getData('animId')
if not animId then
local name=self:getData('animName')
animId=eAnimationID[name]
end

local stId=self:getData('stId')
_MapManager.RunAnimator(stId,animId)

local duration=self:getData('duration')
if duration and duration>0 then
self.playing=true
self.endTime=Time.time+duration
return nodeState.running
end

return nodeState.success
end