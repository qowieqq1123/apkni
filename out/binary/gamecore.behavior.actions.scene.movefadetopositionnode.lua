







moveFadeToPositionNode=simple_class(baseNode)



function moveFadeToPositionNode:reset()
moveFadeToPositionNode._base.reset(self)
self.moveFading=false
end

function moveFadeToPositionNode:update(interval)
if self.moveFading then
return nodeState.running
end
local data=self.data
self.args=self:getArgs()
if data and data.outPos then
local targetPos=self:getSharedVar(data.outPos)
if targetPos then
local entityPos=_MapManager.GetTilemapObjectPosition(self.args.stId)
if _MapManager.IsPositionEqual(entityPos,targetPos)then
self.moveFading=false
return nodeState.success
else
local canMove=_MapManager.MoveToPosition(self.args.stId,targetPos,function()
self:moveFinish()
end,nil,data.speed or 0)

local alpha=data.alpha or 1
local target=Color.New(1,1,1,alpha)
_MapManager.SetFadeToColor(self.args.stId,target,data.speed*3,nil)
if canMove then
_MapManager.RunAnimator(self.args.stId,data.animId or eAnimationID.run)
self.moveFading=true
return nodeState.running
end
end
end
end
return nodeState.failure
end

function moveFadeToPositionNode:broke()
if self.state==nodeState.running then
_MapManager.StopMove(self.args.stId)
self:moveFinish()
end
end

function moveFadeToPositionNode:moveFinish()
if self.data.alpha==0 then
aiManager:setDiscipleBTSharedVal(self.args.dzId,ai_stop_speak,true)
end
_MapManager.RunAnimator(self.args.stId,eAnimationID.stand)
self.moveFading=false
return nodeState.success
end
