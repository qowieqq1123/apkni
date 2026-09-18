






bXJPlayEffectNode=simple_class(baseNode)

function bXJPlayEffectNode:update(interval)

local key=self:getData('key')
local effectid=self:getData('effectid')
local pos=self:getData('pos')
local delay=self:getData('delay')or 0

if key==nil or effectid==nil or pos==nil then
return nodeState.failure
end

xianjieController:palyEffect_GameInterface(key,effectid,pos,delay)

return nodeState.success
end