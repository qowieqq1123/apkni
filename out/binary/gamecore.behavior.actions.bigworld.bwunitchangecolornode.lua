








bwUnitChangeColorNode=simple_class(baseNode)

function bwUnitChangeColorNode:init()
self.isPlaying=false
self.bComplete=false
end

function bwUnitChangeColorNode:update(interval)
if self.isPlaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local unitKey=self:getData('unitKey')
local sColor=self:getData('sColor')
local eColor=self:getData('eColor')or{0,0,0,0}
local fast=self:getData('fast')or 0
local duration=self:getData('duration')or 0
eColor=Color.New(eColor[1],eColor[2],eColor[3],eColor[4])
local time=duration-fast
if unitKey==nil then
return nodeState.failure
end

self.isPlaying=true
if sColor then
sColor=Color.New(sColor[1],sColor[2],sColor[3],sColor[4])
local tColor=Color.Lerp(sColor,eColor,fast/duration)
worldController:changeModelColor(unitKey,tColor,0)
end
worldController:changeModelColor(unitKey,eColor,time,function()
self.isPlaying=false
self.bComplete=true
self:quicklyTick()
end)

return nodeState.running
end