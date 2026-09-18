









moveToPositionNode=simple_class(baseNode)

function moveToPositionNode:reset()
aiMoveToPositionNode._base.reset(self)
self.isMoving=false
self.bComplete=false
end

function moveToPositionNode:broke()
if self.isMoving then
local args=self:getArgs()
_MapManager.StopMove(args.stId,true)
_MapManager.RunAnimator(args.stId,eAnimationID.stand)
self.isMoving=false
end
end

function moveToPositionNode:update(interval)
if self.isMoving then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end


local pos=self:getData('inPos')
local tpos=pos
if type(pos)=='table'then
tpos=_MapManager.ToVector3Int(pos[1],pos[2],pos[3]or 0)
end

if tpos then
self.isMoving=true
local speed=self:getData('speed')
local animId=self:getData('animId')
if not animId then
local name=self:getData('animName')
animId=eAnimationID[name]
end
local cfgId=self:getData('cfgId')or-1
local args=self:getArgs()
_MapManager.RunAnimator(args.stId,animId)
local finishCallback=function()
self.isMoving=false
self.bComplete=true
self:quicklyTick()
_MapManager.RunAnimator(args.stId,eAnimationID.stand)
end

local nowPos=_MapManager.GetTilemapObjectPosition(args.stId)
local isSamePos=_MapManager.IsPositionEqual(nowPos,tpos)
if isSamePos then
finishCallback()
return nodeState.running
end

local check
local noLimit=self:getData('noLimit')
if noLimit then
isometricMapSystem:enableFindPathLimit(false)
check=_MapManager.MoveToPosition(args.stId,tpos,finishCallback,nil,speed,cfgId)
isometricMapSystem:enableFindPathLimit(true)
else
check=_MapManager.MoveToPosition(args.stId,tpos,finishCallback,nil,speed,cfgId)
end

if not check then
self.isMoving=false
return nodeState.failure
end

return nodeState.running
else
return nodeState.failure
end
end
