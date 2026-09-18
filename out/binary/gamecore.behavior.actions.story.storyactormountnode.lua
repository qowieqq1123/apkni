








storyActorMountNode=simple_class(baseNode)

function storyActorMountNode:update(interval)
local npcId=self:getData('npcId')
local bodyId=self:getData('bodyId')
local hpName=self:getData('hpName')
local offset=self:getData('offset')

local guid=storyAIManager:getStoryBTBlackBoard(npcId)
local manager=CS.EntityManager.Instance
local ent=manager:GetEntity(guid)
if bodyId then
local escale=isometricMapSystem:getModelScale(bodyId)
offset=offset and Vector3.New(offset[1],offset[2],offset[3])or Vector3.New(0,0,0)
ent:Mount(bodyId,nil,hpName,escale,offset,nil)
else
ent:UnMount();
end

return nodeState.success
end