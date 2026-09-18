









returnStateNode=simple_class(baseNode)

function returnStateNode:update(interval)
local state=self:getData('state')
state=nodeState[state]
return state
end