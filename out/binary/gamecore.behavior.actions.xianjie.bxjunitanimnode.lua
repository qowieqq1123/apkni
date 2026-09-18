






bXJUnitAnimNode=simple_class(baseNode)

function bXJUnitAnimNode:init()
self.isPlaying=false
self.bComplete=false
end

function bXJUnitAnimNode:update(interval)

if self.isplaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local unitKey=self:getData('unitKey')
local anim=self:getData('anim')or eAnimationID.stand

if unitKey==nil then
logErr("仙界 行为树 创建实体 参数检测失败，unitKey 为空")
return nodeState.failure
end

local entKey=xianjieModel:getStoryUnit(unitKey)
if entKey then
local ent=xianjieController:getEntity(entKey)
if ent then
ent:modelPlayAnimation(anim)
end
end

return nodeState.success
end