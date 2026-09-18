










storyMoveStraightToPosNode=simple_class(baseNode)

function storyMoveStraightToPosNode:init()
self.storyMoving=false
self.storyMoveComplete=false
end

function storyMoveStraightToPosNode:broke()
self:stopTweener()
end

function storyMoveStraightToPosNode:getVectorIntPos(inpos)
local targetPos
if type(inpos)=='string'then
targetPos=self:getSharedVar(inpos)
elseif type(inpos)=='table'then
targetPos=_MapManager.ToVector3Int(inpos[1],inpos[2],inpos[3]or 0)
end
return targetPos
end

function storyMoveStraightToPosNode:update(interval)
local npcid=self:getData('npcid')
local inPos=self:getData('inPos')
local speed=self:getData('speed')or 0
local name=self:getData('animName')
local animId=eAnimationID[name]

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
end

local moveType=self:getData('moveType')
if moveType then
moveType=eAIMoveType[moveType]
end
self.storyMoving=true
_MapManager.RunAnimator(guid,animId or eAnimationID.walk)
local tran=_MapManager.GetTilemapObjectTransform(guid)
local wpos=_MapManager.GetCellCenterWorld(zongmenModel:getMountainId(),targetPos,mapLayer.Data)
local offset=self:getData('offset')
if offset then
wpos.x=wpos.x+offset[1]
wpos.y=wpos.y+offset[2]
if offset[3]then
wpos.z=wpos.z+offset[3]
end
end
local mpos=tran.position
local dis=Vector3.Distance(wpos,mpos)
local duration=dis/speed
self.tweener=_DOTweenProxy.DOMove(tran,wpos,duration)
self.tweener:SetEase(_Ease.Linear)
self.tweener:OnComplete(function(...)
self:stopTweener()
self.storyMoving=false
self.storyMoveComplete=true
_MapManager.RunAnimator(guid,eAnimationID.stand)
self:quicklyTick()
end)
return nodeState.running
end
return nodeState.failure
end

function storyMoveStraightToPosNode:stopTweener()
if self.tweener then
self.tweener:Kill(false)
self.tweener=nil
end
end

function storyMoveStraightToPosNode:skip()
local npcid=self:getData('npcid')
local inPos=self:getData('inPos')

local guid=storyAIManager:getStoryBTBlackBoard(npcid)
local targetPos=self:getVectorIntPos(inPos)
if guid and targetPos then
self:stopTweener()
_MapManager.RunAnimator(guid,eAnimationID.stand)
_MapManager.SetPosition(guid,targetPos)
end
return nodeState.success
end