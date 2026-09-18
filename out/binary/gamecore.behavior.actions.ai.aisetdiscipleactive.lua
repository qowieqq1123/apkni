





aiSetDiscipleActive=simple_class(baseNode)

function aiSetDiscipleActive:update(interval)
local stId=self:getSharedVar('stId')
local bActive=self:getData('bActive')
_MapManager.SetTilemapObjectActive(stId,bActive)
return nodeState.success
end