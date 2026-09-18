














storyHideObjectNode=simple_class(baseNode)

function storyHideObjectNode:broke()
local otype=self:getData('otypo')
if otype then
_MapManager.SetObjectDisplay(otype,true)
end
end

function storyHideObjectNode:update(interval)
local otype=self:getData('otypo')
local flag=self:getData('flag')
_MapManager.SetObjectDisplay(otype,flag)
return nodeState.success
end