








createModelNode=simple_class(baseNode)

function createModelNode:update(interval)
local modelId=self:getData('modelId')
local pos=self:getData('pos')
local scale=self:getData('scale')
local outKey=self:getData('outKey')
local ent=isometricMapSystem:createModelEntity(modelId)
if pos then
ent.transform.position=Vector3.New(pos[1],pos[2],pos[3]or 0)
end
if scale then
ent.transform.localScale=Vector3.New(pos[1],pos[2],pos[3]or 1)
end
self:setSharedVar(outKey,ent.GUID)

return nodeState.success
end