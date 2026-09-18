







aiRunAnimatorNode=simple_class(baseNode)

function aiRunAnimatorNode:init()
self.isAniPlaying=false
end

function aiRunAnimatorNode:update(interval)
if self.isAniPlaying then
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

local args=self:getArgs()
_MapManager.RunAnimator(args.stId,animId)

local duration=self:getData('duration')
if duration and duration>0 then
self.isAniPlaying=true
self.endTime=Time.time+duration
return nodeState.running
end

return nodeState.success
end

function aiRunAnimatorNode:skip()
local args=self:getArgs()
_MapManager.RunAnimator(args.stId,eAnimationID.stand)
return nodeState.success
end