







setSurfacePartActiveNode=simple_class(baseNode)

function setSurfacePartActiveNode:update(interval)
local mapId=self:getData('mapId')
local index=self:getData('index')
local bActive=self:getData('bActive')
surfaceControl:setSurfacePartActive(index,mapId,bActive)
return nodeState.success
end