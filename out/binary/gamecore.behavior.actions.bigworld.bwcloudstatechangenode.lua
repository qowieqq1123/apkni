








bwCloudStateChangeNode=simple_class(baseNode)

function bwCloudStateChangeNode:init()
self.isplaying=false
self.bComplete=false
end

function bwCloudStateChangeNode:update(interval)
if self.isplaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local index=self:getData("index")
local state=self:getData("state")
local duration=self:getData('duration')or 0

if index==nil or state==nil then
return nodeState.failure
end

local data=bit.lshift(state,16)+index

if duration>0 then
self.isplaying=true
self.bComplete=false
worldController:setSingleCloud(data,duration,function(idx)
self.isplaying=false
self.bComplete=true
self:quicklyTick()
end)
return nodeState.running
else
worldController:setSingleCloud(data)
self.isplaying=false
self.bComplete=true
return nodeState.success
end
end