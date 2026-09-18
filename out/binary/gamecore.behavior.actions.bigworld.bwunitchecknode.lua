








bwUnitCheckNode=simple_class(baseNode)

function bwUnitCheckNode:update(interval)
local unitKey=self:getData('unitKey')
local warning=self:getData('warning')
local variable=self:getData('variable')
if unitKey==nil or variable==nil or variable==""then
return nodeState.failure
end

if worldController:haveUnit(unitKey)then
self:setSharedVar(variable,true)
else
if warning then
loggerUtil.logErrFMT("大世界实体检测节点失败（{0}）",unitKey)
end
self:setSharedVar(variable,false)
end
return nodeState.success
end