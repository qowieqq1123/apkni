








bwUnitStayAnimationNode=simple_class(baseNode)

function bwUnitStayAnimationNode:init()
self.isPlaying=false
self.bComplete=false
end

function bwUnitStayAnimationNode:update(interval)
if self.isPlaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

self.unitKey=self:getData('unitKey')
local position=self:getData('position')
local duration=self:getData('duration')or 0
local fast=self:getData('fast')or 0
local animation=self:getData('animation')or 0
local object=worldController:getUnit(self.unitKey)

if object==nil or duration<=0 then
return nodeState.failure
end
if position then
position=worldPositionConfig:getPosition_CurrentWorld(position)
else
position=object.Position
end
self.isPlaying=true
local ways={CS.WorldWaitWay.New(position,duration,Vector3Int(0,animation,0))}
local path=CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)
local move=CS.WorldSingelTeam.New(self.unitKey,{path},object)
move.onComplete=function(key,pass)
local over=pass-duration
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

function bwUnitStayAnimationNode:broke()
if self.isPlaying and worldController:isInWorld()then
worldController:popMove(self.unitKey)
end
end