









bwUnitShowTypeNode=simple_class(baseNode)

function bwUnitShowTypeNode:update(interval)

local isShow=self:getData('isShow')
local typeList=self:getData('typeList')

worldController:setAllUnitActiveState(isShow,typeList)

return nodeState.success
end