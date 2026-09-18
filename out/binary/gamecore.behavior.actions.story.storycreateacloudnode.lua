






storyCreateACloudNode=simple_class(baseNode)

function storyCreateACloudNode:update(interval)
local cloudId=self:getData('id')
local pos=self:getData('startPos')
local startPos=Vector3.New(pos[1],pos[2],0)
cloudsControl:createACloudEx(1,cloudId,startPos)
return nodeState.success
end