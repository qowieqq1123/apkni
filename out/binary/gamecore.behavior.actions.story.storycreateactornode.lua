











storyCreateActorNode=simple_class(baseNode)

function storyCreateActorNode:update(interval)
local npcid=self:getData('npcid')
local pos=self:getData('pos')
local scaleType=self:getData('scaleType')
local scale=self:getData('scale')
local flip=self:getData('flip')
local offset=self:getData('offset')
local defaultHide=self:getData('hide')or 1
if offset then
offset=Vector3(offset[1]or 0,offset[2]or 0,0)
else
offset=Vector3(0,0,0)
end
pos=_MapManager.ToVector3Int(pos[1],pos[2],0)
local guid=storyAIManager:createStoryRole(npcid,scaleType,pos,offset,scale)
storyAIManager:setStoryBTBlackBoard(npcid,guid)
if flip then
isometricMapSystem:flip(guid)
end
if defaultHide then
_MapManager.SetColor(guid,Color.New(1,1,1,defaultHide))
end
return nodeState.success
end