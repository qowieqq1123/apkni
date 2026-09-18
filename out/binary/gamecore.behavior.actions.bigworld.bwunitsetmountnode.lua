








bwUnitSetMountNode=simple_class(baseNode)

function bwUnitSetMountNode:init()
self.isPlaying=false
self.bComplete=false
end

function bwUnitSetMountNode:update(interval)
if self.isPlaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local unitKey=self:getData('unitKey')
local body=self:getData('body')or-1
local slots=self:getData('slots')or{}
local hpName=self:getData('handPoint')or'root'
local scale=self:getData('scale')or 1
local offset=self:getData('offset')or{0,0,0}

offset=mathHelper.convertArrayToVector(offset)

if unitKey==nil then
return nodeState.failure
end

if body>0 then
self.isPlaying=true
worldController:changeUnitMount(unitKey,body,slots,hpName,scale,offset)





self.isPlaying=false
self.bComplete=true
return nodeState.running
else
worldController:clearUnitMount(unitKey)
return nodeState.success
end
end