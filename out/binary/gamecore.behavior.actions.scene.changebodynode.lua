








changeBodyNode=simple_class(baseNode)

function changeBodyNode:update(interval)
local guid=self:getData('guid')
local body=self:getData('body')
local slots=self:getData('slots')or{}
local scale=self:getData('scale')

isometricMapSystem:changeBody(guid,body,slots,scale)

return nodeState.success
end