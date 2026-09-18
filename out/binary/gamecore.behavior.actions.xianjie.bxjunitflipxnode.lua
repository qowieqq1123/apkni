






bXJUnitFlipXNode=simple_class(baseNode)

function bXJUnitFlipXNode:update(interval)

local unitKey=self:getData('unitKey')
local flipx=self:getData('flipx')or false

if unitKey==nil then
logErr("仙界 行为树 翻转实体 unitKey 为空")
return nodeState.failure
end

local entKey=xianjieModel:getStoryUnit(unitKey)
if entKey then
local ent=xianjieController:getEntity(entKey)
ent:setModelFlipX(flipx)
end

return nodeState.success
end