








bwUnitMoveNavPathNode=simple_class(baseNode)

function bwUnitMoveNavPathNode:init()
self.isPlaying=false
self.bComplete=false
end

function bwUnitMoveNavPathNode:update(interval)
if self.isPlaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

self.unitKey=self:getData('unitKey')
self.orig=self:getData('origin')
self.path=self:getData('path')
self.speed=self:getData('speed')or 2
self.runAnimation=self:getData('runAnimation')or 11
self.fast=self:getData('fast')or 0
self.onStep=self:getData('onStep')
self.onComplete=self:getData('onComplete')
self.object=worldController:getUnit(self.unitKey)
if self.object==nil or self.path==nil or#self.path<=0 then
return nodeState.failure
end
if#self.path>=1 then
self.bComplete=false
self.isPlaying=true
self:moveSegment(1)
return nodeState.running
end
return nodeState.success
end

function bwUnitMoveNavPathNode:broke()
if self.isPlaying and worldController:isInWorld()then
worldController:popMove(self.unitKey)
end
end

function bwUnitMoveNavPathNode:moveSegment(index)
local last=index==#self.path
local first=index==1
local dept=nil
if first then
if self.orig then
dept=worldPositionConfig:getPosition_CurrentWorld(self.orig)
else
dept=self.object.Position
end
else
dept=worldPositionConfig:getPosition_CurrentWorld(self.path[index-1])
end
local dest=worldPositionConfig:getPosition_CurrentWorld(self.path[index])
local corners=worldController:calculateNavPathEx(dept,dest)
if corners==nil then
return nodeState.failure
end

local bAnimation=first and 0 or self.runAnimation
local aAnimation=last and 0 or self.runAnimation
local ways={CS.WorldNavWay.New(corners,self.speed,Vector3Int(bAnimation,self.runAnimation,aAnimation))}
local path=CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)
local move=CS.WorldSingelTeam.New(self.unitKey,{path},self.object)
move.onComplete=function(key,pass)
local over=pass-move.Duration
self.fast=over
if worldController:isInWorld()then
worldController:popMove(self.unitKey)
end
if self.onStep then
self.onStep(self:getOwner(),index)
end
if last then
if self.onComplete then
self.onComplete(self:getOwner())
end
self.isPlaying=false
self.bComplete=true
self:setSharedVar('fast',self.fast)
else
self:moveSegment(index+1)
end
end
worldController:pushMove(move)
move:Goto(self.fast)
end