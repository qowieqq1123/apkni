








bwUnitDropItemNode=simple_class(baseNode)

function bwUnitDropItemNode:init()
self.isPlaying=false
self.bComplete=false
end

function bwUnitDropItemNode:update(interval)
if self.bComplete then
return nodeState.success
end
if self.isPlaying then
return nodeState.running
end

local unitKey=self:getData('unitKey')
local items=self:getData('items')
local wait=self:getData('wait')or false

if unitKey==nil or items==nil then
return nodeState.failure
end

self.isPlaying=true
if wait then
worldHUDModel:dropItem(unitKey,#items,items,function()
self.bComplete=true
self.isPlaying=false
self:quicklyTick()
end)
return nodeState.running
else
self.bComplete=true
self.isPlaying=false
worldHUDModel:dropItem(unitKey,#items,items)
return nodeState.success
end
end