airQianKunZhuSkillAction=simple_class(airSkillAction)

function airQianKunZhuSkillAction:__init(...)

end

function airQianKunZhuSkillAction:initalize(args)
self:start()
end

function airQianKunZhuSkillAction:start()
self.executeCnt=9999999
self.cacheEntity={}
self:createEntity(eAirSkillEntityType.eKuoSan)
self:executeBehavour()
end

function airQianKunZhuSkillAction:onDelete()
self._base:onDelete()
self.cacheEntity=nil
end

function airQianKunZhuSkillAction:onPause()
self._base:onPause()
end

function airQianKunZhuSkillAction:onContinue()
self._base:onContinue()
end

function airQianKunZhuSkillAction:onUpdate()
self._base:onUpdate()
end

function airQianKunZhuSkillAction:onFastUpdate()
if self:isDeleteSelf()then return end
if self.damageTime and self.executeCnt<=0 and self.damageTime<=Time.realtimeSinceStartup then
self:executeDamage()
self.damageTime=nil
end
self.executeCnt=self.executeCnt-1
if self.executeCnt<=0 then
if self.executeCnt==0 then
self:disableMainCollider()
end
if self.destroyTime and self.destroyTime<=Time.realtimeSinceStartup then
self:recycleSelf()
end
end
end


function airQianKunZhuSkillAction:executeBehavour()
local behaviorValue=self.behaviorValue
local effectId=behaviorValue[1]
local scale=behaviorValue[2]
local damageTime=behaviorValue[6]or 0
self.damageTime=damageTime+Time.realtimeSinceStartup
local pos=self.caster:getPosition()
airEntitySystem:playEffect(effectId,pos,false,Vector3.New(scale,scale,scale))
end

function airQianKunZhuSkillAction:executeDamage()
if self.cacheEntity==nil then return end
if self.caster==nil or self.caster:isDeleteSelf()then return end

for _,entity in pairs(self.cacheEntity)do
self:executeSingleDamage(entity)
end
self.cacheEntity=nil
end


function airQianKunZhuSkillAction:onTriggerEnterMonster(entity)
if self.enemyEntitesNum>self.targetMaxCount then return end

if not self:checkCastEnity(entity)then return false end

local handle=entity.handle
if not self.enemyEntites[handle]then
self.enemyEntites[handle]=entity
self.enemyEntitesNum=self.enemyEntitesNum+1
else
return false
end
if self.cacheEntity==nil or
self.damageTime==nil or
self.damageTime<=Time.realtimeSinceStartup then
self:executeSingleDamage(entity)
else
self.cacheEntity[handle]=entity
end
return true
end

function airQianKunZhuSkillAction:onTriggerExitMonster(entity)
local handle=entity.handle
if self.enemyEntites[handle]==nil then return false end

self.enemyEntitesNum=self.enemyEntitesNum-1
self.enemyEntites[handle]=nil
if self.cacheEntity then
self.cacheEntity[handle]=nil
end
return true
end


function airQianKunZhuSkillAction:onTriggerFinish()
self.executeCnt=1
self.destroyTime=5+Time.realtimeSinceStartup
end