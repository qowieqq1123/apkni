








aiMoveToDoorWayNode=simple_class(aiMoveToPositionNode)

function aiMoveToDoorWayNode:getMoveAnimId(speed)
return speed>0.5 and eAnimationID.run or eAnimationID.walk
end

function aiMoveToDoorWayNode:getMoveToPos()
local ubdId=self:getData('bdId')
local bdData=zongmenModel:getBuildingData(ubdId)
if not bdData then
return nil
end
local tpos,dpos=isometricMapSystem:getDoorWayPos(bdData)
return tpos
end

function aiMoveToDoorWayNode:normalMove()
if self.isMoving then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local tpos=self:getMoveToPos()
if not tpos then
return nodeState.failure
end

local args=self:getArgs()
self.isMoving=true
self.checkState=nodeState.running
local speed=self:getData('speed')or 1
local animId=self:getData('animId')or self:getMoveAnimId(speed)
aiManager:setMoveCMDToDisciple(args.dzId,tpos,speed,animId,function(isBreak)
self.checkState=isBreak and nodeState.failure or nodeState.running
self.isMoving=false
self.bComplete=true
self:quicklyTick()
end)
return self.checkState
end