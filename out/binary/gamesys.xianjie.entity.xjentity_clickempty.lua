









local xjEntity_clickEmpty={}


function xjEntity_clickEmpty:onInit()
self:initData()
end

function xjEntity_clickEmpty:initData()
local data=self.data
self.pos=xianjieController:worldGridPos2WorldPos11(data[1],data[2],data[3],data[4])
local width,height=xianjieController:gridSize2WorldSize(data[3],data[4])
self.size=Vector2(width,height)
end

function xjEntity_clickEmpty:refreshPos(gridX,gridZ)
self.data[1]=gridX
self.data[2]=gridZ
self:initData()
xianjieController:resetEntityPos(self:getKey(),self.pos)
end

return xjEntity_clickEmpty