








storyChangeSortingLayerNode=simple_class(baseNode)

function storyChangeSortingLayerNode:update(interval)
local npcid=self:getData('npcid')
local layer=self:getData('layer')
local order=self:getData('order')
local guid=storyAIManager:getStoryBTBlackBoard(npcid)
local ent=_EntityManager:GetEntity(guid)
if layer then
ent:SetSortingLayer(layer)
end
if order then
ent:SetSortingOrder(order)
end
return nodeState.success
end