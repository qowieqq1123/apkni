airCastSkillProbabiltyAction=simple_class(airSkillAction)

function airCastSkillProbabiltyAction:__init(...)

end

function airCastSkillProbabiltyAction:initalize(args)
self.waitTime=nil
self:start()
end

function airCastSkillProbabiltyAction:start()
self:executeBehavour()
end

function airCastSkillProbabiltyAction:onDelete()
self._base:onDelete()
self.waitTime=nil
end

function airCastSkillProbabiltyAction:onPause()
self._base:onPause()
end

function airCastSkillProbabiltyAction:onContinue()
self._base:onContinue()
end

function airCastSkillProbabiltyAction:onUpdate()
self._base:onUpdate()
end

function airCastSkillProbabiltyAction:onFastUpdate()
if self:isDeleteSelf()then return end

self.executeCnt=self.executeCnt-1


if self.waitTime and self.waitTime<Time.realtimeSinceStartup then
self.waitTime=nil
if self.caster and not self.caster:isDeleteSelf()then

self.caster:castSkill(self.skillId,self.target,{coolType=0})
end
self:recycleSelf()
end
end



function airCastSkillProbabiltyAction:executeBehavour()
local behaviorValue=self.behaviorValue
local skillId=behaviorValue[1]
local probabilty=behaviorValue[2]

local waitTime=behaviorValue[3]or 0

if waitTime==0 then
local r=math.random(0,10000)
if r>=0 and r<=probabilty then
if self.caster and not self.caster:sDeleteSelf()then
self.caster:castSkill(skillId,self.target,{coolType=0})
end
end
self:recycleSelf()
else
local r=math.random(0,10000)
if r>=0 and r<=probabilty then
self.waitTime=waitTime+Time.realtimeSinceStartup
self.skillId=skillId

else
self:recycleSelf()
end
end

end




