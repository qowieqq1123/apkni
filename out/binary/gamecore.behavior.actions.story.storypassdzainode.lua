






storyPassDZAINode=simple_class(baseNode)

function storyPassDZAINode:update(interval)
local dzIndex=self:getData('dzIndex')
local AIType=self:getData('AIType')

local owner=self:getOwner()
if owner.isSkip then
storyAIManager:skipZMDiscipleAI(dzIndex,AIType)
end
return nodeState.success
end