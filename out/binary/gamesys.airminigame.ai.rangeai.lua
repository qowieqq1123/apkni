rangeAI=simple_class(monsterAI)

function rangeAI:__init(...)

end

function rangeAI:stepAI(args)
self.target=args.target
self.targetHandle=self.target.handle
self.handle=self.owner.handle
local distance=self.aiCfg.distance
self.minDistance=distance[1]
self.maxDistance=distance[2]
self.attackRange=self.owner:getAttackRaduis()
self.curTime=Time.realtimeSinceStartup
self.tickInterval=1
end

function rangeAI:start()
self.isStart=true
return true
end

function rangeAI:unbindTarget()
self.target=nil
self.isStart=false
end

function rangeAI:bindTarget(target)
self:unbindTarget()
self.target=target
end


function rangeAI:onUpdate()
if not self.isStart then return end
if self.isPause then return end
local ret,typo=self:isSafeDistance()
if self.isMoveAway and Time.realtimeSinceStartup-self.curTime>self.tickInterval then
self.isMoveAway=nil
end
if not ret then
if typo==1 then
self:randomMoveClose()
elseif typo==2 then
self:randomMoveAway()
end
else
self:stopMove()
end

self:refreshFlipX()
end

function rangeAI:onFastUpdate()
if not self.isStart then return end
if self.isPause then return end
self._base.onFastUpdate(self)
end

function rangeAI:onPause()
self._base.onPause(self)
self:stopMove()
end

function rangeAI:onContinue()
self._base.onContinue(self)
end

function rangeAI:onDelete()
self._base.onDelete(self)
self.targetHandle=nil
self.handle=nil
self.distance=nil
self.isMoveClose=nil
self.isMoveAway=nil
end

function rangeAI:stopMove()
if self.isMoveAway==nil or self.isMoveClose==nil then return end
self.isMoveClose=nil
self.isMoveAway=nil
self.owner.entity:StopMoveTween(false,false)
end


function rangeAI:randomMoveAway()
if self.isMoveAway then return end
self.isMoveAway=true
local distance=math.random(self.maxDistance+5,self.maxDistance+10)
local point=airMonsterSystem:randomDistancePoint(self.owner,self.target,distance)
self.owner.entity:MoveToWorldPositionByDoTween(point,DG.Tweening.Ease.Linear,0)
self.curTime=Time.realtimeSinceStartup
end


function rangeAI:randomMoveClose()
self.isMoveClose=true
local point=self.target:getPosition()
self.owner.entity:MoveToWorldPositionByDoTween(point,DG.Tweening.Ease.Linear,0)
end

function rangeAI:isSafeDistance()
local distance=airEntitySystem:getDistance(self.handle,self.targetHandle)
if distance>self.maxDistance then
return false,1
end
if distance<self.minDistance then
return false,2
end
return true
end