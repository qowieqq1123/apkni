








storyCreateBuildNode=simple_class(baseNode)

function storyCreateBuildNode:update(interval)
local buildid=self:getData('buildid')
local level=self:getData('level')or 1
local pos=self:getData('pos')
local flip=self:getData('flip')
local pos=_MapManager.ToVector3Int(pos[1],pos[2],0)


local guid=storyAIManager:createStoryBuild(buildid,level,pos)
if flip then
isometricMapSystem:flip(guid)
end
return nodeState.success
end