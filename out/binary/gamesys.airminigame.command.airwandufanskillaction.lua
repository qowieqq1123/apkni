

airWanDuFanSkillAction=simple_class(airSkillAction)

function airWanDuFanSkillAction:__init(...)

end

function airWanDuFanSkillAction:initalize(args)
self:start()
end

function airWanDuFanSkillAction:start()

self:executeBehavour()
end

function airWanDuFanSkillAction:onDelete()
self._base:onDelete()
self.destroyTime=nil
self.damageTime=nil
end

function airWanDuFanSkillAction:onPause()
self._base:onPause()
end

function airWanDuFanSkillAction:onContinue()
self._base:onContinue()
end

function airWanDuFanSkillAction:onUpdate()
self._base:onUpdate()
end

function airWanDuFanSkillAction:onFastUpdate()
if not self.damageTime then
return
end
if self:isDeleteSelf()then return end
self.executeCnt=self.executeCnt-1
if self.damageTime and self.executeCnt<=0 and self.damageTime<=Time.realtimeSinceStartup then
self:executeDamage()
self.damageTime=nil
end
if self.destroyTime and self.destroyTime<=Time.realtimeSinceStartup then
self:recycleSelf()
end
end











function airWanDuFanSkillAction:executeBehavour()
local behaviorValue=self.behaviorValue








local args={}
args.pos=self.caster:getPosition()
self:createEntity(args)

self.caster:runSpineAnimator(1016)
local animTime=behaviorValue[5]or 1
if self.caster.setAnimWaitTime then
self.caster:setAnimWaitTime(animTime)
end
end

function airWanDuFanSkillAction:setDamageTime()
local behaviorValue=self.behaviorValue
local damageTime=behaviorValue[2]or 0.1
self.damageTime=damageTime+Time.realtimeSinceStartup
self.destroyTime=0.1+self.damageTime
end










function airWanDuFanSkillAction:createEntity(args)
self._base.createEntity(self,eAirSkillEntityType.eTargetRoundSkill,nil,args)
end


