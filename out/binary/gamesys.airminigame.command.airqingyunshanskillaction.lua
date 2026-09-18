airQingYunShanSkillAction=simple_class(airSkillAction)

function airQingYunShanSkillAction:__init(...)

end

function airQingYunShanSkillAction:initalize(args)
self:start()
end

function airQingYunShanSkillAction:start()
self:createEntity()
end

function airQingYunShanSkillAction:onDelete()
self._base:onDelete()
end

function airQingYunShanSkillAction:onPause()
self._base:onPause()
end

function airQingYunShanSkillAction:onContinue()
self._base:onContinue()
end

function airQingYunShanSkillAction:onUpdate()
self._base:onUpdate()
if self.isStart and not self:hasSkillEnts()then
self:recycleSelf()
end
end

function airQingYunShanSkillAction:onFastUpdate()

end


function airQingYunShanSkillAction:createEntity()
local caster=self.caster
local args=self:getTargetArgs()
local ent=airEntitySystem:copyEntitySkill(caster,true,eAirSkillEntityType.eRoundTrip,self.owner,self.caster,self.target,self.actionCfg,args)
if not ent.isDelete then
self.skillEnts[ent.handle]=ent
end
end

function airQingYunShanSkillAction:onTriggerEnterMonster(entity)
if self.enemyEntitesNum>self.targetMaxCount then return end

if not self:checkCastEnity(entity)then return false end

local handle=entity.handle
if not self.enemyEntites[handle]then
self.enemyEntites[handle]=entity
self.enemyEntitesNum=self.enemyEntitesNum+1
end
self:executeSingleDamage(entity)
return true
end

function airQingYunShanSkillAction:onTriggerExitMonster(entity)
local handle=entity.handle
if self.enemyEntites[handle]==nil then return false end

self.enemyEntitesNum=self.enemyEntitesNum-1
self.enemyEntites[handle]=nil
return true
end
