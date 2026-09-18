





aiSwitchAnimatorNode=simple_class(baseNode)

function aiSwitchAnimatorNode:update(interval)
local animId=self:getData('animId')

if not animId then
local name=self:getData('animName')
animId=eAnimationID[name]
end

local args=self:getArgs()
_MapManager.RunAnimator(args.stId,animId)

return nodeState.success
end