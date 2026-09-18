








bwUnitMoveFlyNode=simple_class(baseNode)

function bwUnitMoveFlyNode:init()
self.isPlaying=false
self.bComplete=false
end

function bwUnitMoveFlyNode:update(interval)
if self.isPlaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

self.unitKey=self:getData('unitKey')
local orig=self:getData('origin')
local dest=self:getData('destination')or{0,0}
local speed=self:getData('speed')or 3
local flyAnimation=self:getData('flyAnimation')or 0
local flyHeight=self:getData('flyHeight')or 3
local horizontal=self:getData('horizontal')or 4
local cloudHigher=self:getData('cloudHigher')or 5
local fast=self:getData('fast')or 0
local object=worldController:getUnit(self.unitKey)
local sPos=orig and worldPositionConfig:getPosition_CurrentWorld(orig)or object.Position
local ePos=worldPositionConfig:getPosition_CurrentWorld(dest)
local corners={sPos,ePos}

if object==nil or corners==nil then
return nodeState.failure
end

self.isPlaying=true
local ways={CS.WorldFlyWay.New(corners,speed,flyHeight,horizontal,cloudHigher,Vector3Int(0,flyAnimation,0))}
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

function bwUnitMoveFlyNode:broke()
if self.isPlaying and worldController:isInWorld()then
worldController:popMove(self.unitKey)
end
end