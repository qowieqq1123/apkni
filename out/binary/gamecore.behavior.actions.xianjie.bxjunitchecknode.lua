






bXJUnitCheckNode=simple_class(baseNode)

function bXJUnitCheckNode:update(interval)

local unitKey=self:getData('unitKey')
local iswait=self:getData('iswait')

if iswait==nil then
iswait=false
end

if unitKey==nil then
logErr("仙界 行为树 检查实体 unitKey 为空")
return nodeState.failure
end

if xianjieModel:getUnit(unitKey)==nil then
if iswait then
return nodeState.running
else
return nodeState.failure
end
end

return nodeState.success
end