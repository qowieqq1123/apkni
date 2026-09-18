







invokeSelfFuncNode=simple_class(baseNode)

function invokeSelfFuncNode:update(interval)
local func=self:getData('funcKey')
if func then
if func(self:getOwner())~=false then
return nodeState.success
else
return nodeState.failure
end
else
return nodeState.success
end
end