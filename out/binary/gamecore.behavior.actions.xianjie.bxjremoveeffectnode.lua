






bXJRemoveEffectNode=simple_class(baseNode)

function bXJRemoveEffectNode:update(interval)

local key=self:getData('key')

if key==nil then
return nodeState.failure
end

xianjieController:stopEffect_GameInterface(key)

return nodeState.success
end