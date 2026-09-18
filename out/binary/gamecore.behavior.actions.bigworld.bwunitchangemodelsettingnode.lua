








bwUnitChangeModelSettingNode=simple_class(baseNode)

function bwUnitChangeModelSettingNode:update(interval)

local unitKey=self:getData('unitKey')
local unitType=self:getData('unitType')
local modelRes=self:getData('modelRes')
local modelSettings=modelRes and worldModel:getModelSettings(modelRes,unitType)or nil

if unitKey==nil then
return nodeState.failure
end

worldController:changeUnitModel(unitKey,modelSettings)

return nodeState.success
end