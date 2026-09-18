






bXJUnitDeleteNode=simple_class(baseNode)

function bXJUnitDeleteNode:update(interval)

local unitKey=self:getData('unitKey')

if unitKey==nil then
logErr("仙界 行为树 创建实体 参数检测失败，unitKey 为空")
return nodeState.failure
end

local result=xianjieController:popStoryUnit(unitKey)
if not result then
logErr("仙界 行为树 删除实体 失败，unityKey =",unitKey)
return nodeState.failure
end

return nodeState.success
end