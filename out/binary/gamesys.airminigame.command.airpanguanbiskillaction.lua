
airPanGuanBiSkillAction=simple_class(airSkillAction)

function airPanGuanBiSkillAction:__init(...)

end

function airPanGuanBiSkillAction:initalize(args)
self:start()
end

function airPanGuanBiSkillAction:start()
self:createEntity(eAirSkillEntityType.eCommon)
self:executeBehavour()
end

function airPanGuanBiSkillAction:onDelete()
self._base:onDelete()
self.destroyTime=nil
self.damageTime=nil
end

function airPanGuanBiSkillAction:onPause()
self._base:onPause()
end

function airPanGuanBiSkillAction:onContinue()
self._base:onContinue()
end

function airPanGuanBiSkillAction:onUpdate()
self._base:onUpdate()
end

function airPanGuanBiSkillAction:onFastUpdate()
if self:isDeleteSelf()then return end

self.executeCnt=self.executeCnt-1
if self.damageTime and self.executeCnt<=0 and self.damageTime<=Time.realtimeSinceStartup then
self:executeDamage()
self.damageTime=nil
end
if self.destroyTime and self.destroyTime<Time.realtimeSinceStartup then
self:recycleSelf()
end
end


function airPanGuanBiSkillAction:executeBehavour()
local behaviorValue=self.behaviorValue
local effectId=behaviorValue[1]
local scale=behaviorValue[2]
local damageTime=behaviorValue[3]or 0
self.damageTime=damageTime+Time.realtimeSinceStartup
local pos=self.target:getPosition()
airEntitySystem:playEffect(effectId,pos,false,Vector3.New(scale,scale,scale))
self.destroyTime=0.1+self.damageTime

self.caster:runSpineAnimator(1016)
local animTime=behaviorValue[4]or 1
self.caster:setAnimWaitTime(animTime)
end



