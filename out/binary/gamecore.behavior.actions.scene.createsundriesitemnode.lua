







createSundriesItemNode=simple_class(baseNode)

function createSundriesItemNode:update(interval)
local id=self:getData('id')
local pos=self:getData('pos')

local mapId=zongmenModel:getMountainId()
local x=pos[1]
local y=pos[2]


















sundriseCreateControl:findDataAndCreate(mapId,x,y,id)
return nodeState.success
end