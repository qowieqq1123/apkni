roamingAI=simple_class(monsterAI)

function roamingAI:__init(...)

end

function roamingAI:stepAI(args)
local pos=self.owner:getPosition()
self.sleep=5
self.sleepTime=nil
self.points=airMonsterSystem:randomCruisePoint(10,pos.y)
self.pointIdx=0
self.isMoveing=nil
self._onMoveFinish=function(...)
self:onMoveFinish(...)
end
end

function roamingAI:start()
self.isStart=true
return true
end


function roamingAI:onUpdate()
if not self.isStart then return end
if self.isPause then return end
if self.isMoveing then

elseif self.sleepTime then
if self.sleepTime-timeHelper.getServerShortTime()<=0 then
self.isMoveing=nil
end
else
local pointIdx=self:getNextPoint()
if pointIdx then
self.pointIdx=pointIdx
self.isMoveing=true
self.owner.entity:MoveToWorldPositionByDoTween(self.points[pointIdx],DG.Tweening.Ease.Linear,0,self._onMoveFinish)
end
end
end

function roamingAI:onFastUpdate()
if not self.isStart then return end
if self.isPause then return end
self._base.onFastUpdate(self)
end

function roamingAI:onPause()
self._base.onPause(self)
end

function roamingAI:onContinue()
self._base.onContinue(self)
end

function roamingAI:onDelete()
if self.owner and not self.owner:isDeleteSelf()then
self.owner.entity:SetMoveFinishAction(nil)
end
self._base.onDelete(self)
self.sleep=nil
self.sleepTime=nil
self.points=nil
self.isMoveing=nil
self.pointIdx=nil
self._onMoveFinish=nil
end

function roamingAI:onMoveFinish(handle,x,z)
self.isMoveing=nil




end

function roamingAI:startSleep()
self.sleepTime=timeHelper.getServerShortTime()+math.random(1,self.sleep)
end

function roamingAI:getNextPoint()
local pointIdx=math.random(1,#self.points)
while pointIdx==self.pointIdx do
pointIdx=math.random(1,#self.points)
end
return pointIdx
end