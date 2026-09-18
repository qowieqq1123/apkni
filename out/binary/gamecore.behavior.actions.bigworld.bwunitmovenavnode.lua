








bwUnitMoveNavNode=simple_class(baseNode)

function bwUnitMoveNavNode:init()
self.isPlaying=false
self.bComplete=false
end

function bwUnitMoveNavNode:update(interval)
if self.isPlaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

self.unitKey=self:getData('unitKey')
local orig=self:getData('origin')
local dest=self:getData('destination')or{0,0}
local speed=self:getData('speed')or 2
local runAnimation=self:getData('runAnimation')or 11
local bAnimation=self:getData('bAnimation')or 0
local aAnimation=self:getData('aAnimation')or 0
local fast=self:getData('fast')or 0
local object=worldController:getUnit(self.unitKey)
if orig==nil then
orig=object.Position
else
orig=worldPositionConfig:getPosition_CurrentWorld(orig)
end
dest=worldPositionConfig:getPosition_CurrentWorld(dest)

local corners=worldController:calculateNavPathEx(orig,dest)
if object==nil or corners==nil then
return nodeState.failure
end
self.isPlaying=true
local ways={CS.WorldNavWay.New(corners,speed,Vector3Int(bAnimation,runAnimation,aAnimation))}
local path=CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)
local move=CS.WorldSingelTeam.New(self.unitKey,{path},object)
move.onComplete=function(key,pass)
local over=pass-move.Duration
self:setSharedVar('fast',over)
if worldController:isInWorld()then
worldController:popMove(self.unitKey)
end
self.isPlaying=false
self.bComplete=true
end
worldController:pushMove(move)
move:Goto(fast)

return nodeState.running
end

function bwUnitMoveNavNode:broke()
if self.isPlaying and worldController:isInWorld()then
worldController:popMove(self.unitKey)
end
end
