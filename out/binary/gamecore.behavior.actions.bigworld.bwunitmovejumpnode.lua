








bwUnitMoveJumpNode=simple_class(baseNode)

function bwUnitMoveJumpNode:init()
self.isPlaying=false
self.bComplete=false
end

function bwUnitMoveJumpNode:update(interval)
if self.isPlaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

self.unitKey=self:getData('unitKey')
local duration=self:getData('duration')or 0.4
local position=self:getData('position')
local offset=self:getData('offset')or{0,0,0}
local fast=self:getData('fast')or 0
local animation=self:getData('animation')or 2002
local height=self:getData("height")or 3
local flip=self:getData('flip')or false
local object=worldController:getUnit(self.unitKey)
position=position and worldPositionConfig:getPosition_CurrentWorld(position)or object.Position
offset=mathHelper.convertArrayToVector(offset)

if object==nil or duration<=0 or position==nil then
return nodeState.failure
end

self.isPlaying=true
local sPos=offset+position
local ePos=sPos+Vector3.up*height
local ways={CS.WorldLineWay.New(sPos,ePos,flip,height/duration,Vector3Int(0,animation,0))}
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

function bwUnitMoveJumpNode:broke()
if self.isPlaying and worldController:isInWorld()then
worldController:popMove(self.unitKey)
end
end