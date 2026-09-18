











storyMoveToPositionNode=simple_class(baseNode)

function storyMoveToPositionNode:reset()
storyMoveToPositionNode._base.reset(self)
self.storyMoving=false
self.storyMoveComplete=false
end

function storyMoveToPositionNode:broke()
local npcid=self:getData('npcid')
if npcid then
local guid=storyAIManager:getStoryBTBlackBoard(npcid)
if guid==nil then return end
_MapManager.StopMove(guid,true)
end
end

function storyMoveToPositionNode:getVectorIntPos(inpos)
local targetPos
if type(inpos)=='string'then
targetPos=self:getSharedVar(inpos)
elseif type(inpos)=='table'then
targetPos=_MapManager.ToVector3Int(inpos[1],inpos[2],0)
end
return targetPos
end

function storyMoveToPositionNode:update(interval)
local npcid=self:getData('npcid')
local inPos=self:getData('inPos')
local speed=self:getData('speed')or 0
local animId=self:getData('animId')

if self.storyMoving then
return nodeState.running
end
if self.storyMoveComplete then
self.storyMoveComplete=false
return nodeState.success
end

local guid=storyAIManager:getStoryBTBlackBoard(npcid)
local targetPos=self:getVectorIntPos(inPos)
if targetPos then
if speed==0 then
_MapManager.SetPosition(guid,targetPos)
return nodeState.success
else
local moveType=self:getData('moveType')
if moveType then
moveType=eAIMoveType[moveType]
end
local post=self:getData('post')or 6
self.storyMoving=true
if moveType==eAIMoveType.eFly then
_MapManager.SetRoleFlyArgs(guid,1,post,speed)
isometricMapSystem:flyToPosition(guid,targetPos,function()
self.storyMoving=false
self.storyMoveComplete=true
end)
else
isometricMapSystem:enableFindPathLimit(false)
_MapManager.MoveToPosition(guid,targetPos,function()
_MapManager.RunAnimator(guid,eAnimationID.stand)
self.storyMoving=false
self.storyMoveComplete=true
end,nil,speed)
isometricMapSystem:enableFindPathLimit(true)
_MapManager.RunAnimator(guid,animId or eAnimationID.walk)
end
return nodeState.running
end
end
return nodeState.failure
end

function storyMoveToPositionNode:skip()
local npcid=self:getData('npcid')
local inPos=self:getData('inPos')

local guid=storyAIManager:getStoryBTBlackBoard(npcid)
local targetPos=self:getVectorIntPos(inPos)
if guid and targetPos then
_MapManager.StopMove(guid,true)
_MapManager.RunAnimator(guid,eAnimationID.stand)
_MapManager.SetPosition(guid,targetPos)
end
return nodeState.success
end