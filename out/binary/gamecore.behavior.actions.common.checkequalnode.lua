







checkEqualNode=simple_class(baseNode)

function checkEqualNode:update(interval)
local checkGlobal=self:getData('checkGlobal')
local key=self:getDataValue('key')
local sv
if checkGlobal then
sv=self:getGlobalVar(key)
else
sv=self:getSharedVar(key)
end
local cv=self:getData('value')

if sv==cv then
return nodeState.success

end

return nodeState.failure
end