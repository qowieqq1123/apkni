






bXJUnitScaleNode=simple_class(baseNode)

function bXJUnitScaleNode:init()
self.isPlaying=false
self.bComplete=false
end

function bXJUnitScaleNode:update(interval)
if self.bComplete then
return nodeState.success
end
if self.isPlaying then
return nodeState.running
end

local unitKey=self:getData('unitKey')
local scale=self:getData('scale')
local duration=self:getData('duration')or 0

if unitKey==nil then
logErr("仙界 行为树 缩放实体 unitKey 为空")
return nodeState.failure
end

if scale==nil then
logErr("仙界 行为树 缩放实体 scale 为空")
return nodeState.failure
end

local entKey=xianjieModel:getStoryUnit(unitKey)
if entKey then
self.ent=xianjieController:getEntity(entKey)
if self.ent==nil then
return nodeState.failure
end
else
return nodeState.failure
end

self.isPlaying=true
if duration>0 then
local callBack=function()
self.bComplete=true
self.isPlaying=false
self:quicklyTick()
end

self.ent:setScale(scale,duration,callBack)
return nodeState.running
else
self.bComplete=true
self.isPlaying=false
self.ent:setScale(scale,duration)
return nodeState.success
end

return nodeState.success
end