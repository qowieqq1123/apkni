airMoveSkillAction=simple_class(airSkillAction)

function airMoveSkillAction:__init(...)

end

function airMoveSkillAction:initalize(args)
self.direction=args.direction
self.pos=args.pos
self.executeCnt=99999
self:start()
end

function airMoveSkillAction:start()
self:executeBehavour()
end

function airMoveSkillAction:onDelete()
self._base:onDelete()
self.direction=nil
self.pos=nil
end

function airMoveSkillAction:onPause()
self._base:onPause()
end

function airMoveSkillAction:onContinue()
self._base:onContinue()
end

function airMoveSkillAction:onUpdate()
self._base:onUpdate()


end

function airMoveSkillAction:onFastUpdate()
self._base:onFastUpdate()
self.executeCnt=self.executeCnt-1
if self.executeCnt<=0 then
self:recycleSelf()
end
end

function airMoveSkillAction:isDeleteSelf()
return self.isDelete==true
end

function airMoveSkillAction:executeBehavour()
local behaviorValue=self.behaviorValue
local actionCfg=self.actionCfg

local distance=behaviorValue[1]
local duration=behaviorValue[2]
local ani=behaviorValue[3]
local point=self:getMovePoint(self.pos,self.direction,distance)
self.owner.entity:MoveToWorldPositionByDoTweenDuration(point,DG.Tweening.Ease.Linear,duration)
self.executeCnt=1
end

function airMoveSkillAction:getMovePoint(pos,direction,distance)
local normalize=Vector3.Normalize(direction)
local posX=pos.x+normalize.x*distance
local posZ=pos.z+normalize.z*distance
posX,posZ=airMapSystem:clamp(posX,posZ)
return Vector3.New(posX,pos.y,posZ)
end