





airDeadSkillAction=simple_class(airSkillAction)

function airDeadSkillAction:__init(...)

end

function airDeadSkillAction:initalize(args)
self.cacheEntity={}
self.demagedEntity={}


self:start()
end

function airDeadSkillAction:start()
self:initCasterAttr()
self:createCheckEntity()
self:executeBehavour()
end

function airDeadSkillAction:onDelete()
if self.checkRangeEnt then
self.checkRangeEnt:onDelete()
end
self._base:onDelete()
self.damageTime=nil
self.cacheEntity=nil
self.demagedEntity=nil
self.checkRangeEnt=nil
end

function airDeadSkillAction:onPause()
self._base:onPause()
end

function airDeadSkillAction:onContinue()
self._base:onContinue()
end

function airDeadSkillAction:onUpdate()
self._base:onUpdate()
end

function airDeadSkillAction:onFastUpdate()
if self:isDeleteSelf()then return end

self.executeCnt=self.executeCnt-1
if self.executeCnt<=0 then
if self.demageType==1 and self.damageTime and self.damageTime<=Time.realtimeSinceStartup then
self:executeDamage()
self.damageTime=nil
end
if self.demageType==2 and self.damageTime+self.damageCD<=Time.realtimeSinceStartup then
self:executeDamage()
self.damageTime=Time.realtimeSinceStartup
end
end

if self.destroyTime and self.destroyTime<Time.realtimeSinceStartup then
self:recycleSelf()
end
end


function airDeadSkillAction:executeBehavour()
local behaviorValue=self.behaviorValue
local checkTime=behaviorValue[1]or 0
local demageType=behaviorValue[2]or 0
local demageArgs=behaviorValue[3]or 0
if demageType==1 then
self.damageTime=demageArgs[1]+Time.realtimeSinceStartup
elseif demageType==2 then
self.damageTime=Time.realtimeSinceStartup-demageArgs[1]
self.damageCD=demageArgs[1]
end
self.demageType=demageType
self.destroyTime=checkTime+Time.realtimeSinceStartup
end

function airDeadSkillAction:createCheckEntity()
local behaviorValue=self.behaviorValue
local args=self:getTargetArgs()
local skillEntityType=eAirSkillEntityType.eSkillRange

local attach=behaviorValue[4]or 0
local angle=0
if self.target then
angle=airSkillSystem:getAngle(self.actionCfg,self.owner,self.caster,self.target)
end

local checkFlip=behaviorValue[5]
local flip=self.caster:isFlipX()
if self.actionCfg.rangeType==eAirSkillRangeType.eFan then
angle=behaviorValue[6]or angle
if checkFlip==1 then
if flip then
angle=angle+180
end
end
else
if checkFlip==1 then
if flip then
angle=angle+180
end
end
end

local offsetX=behaviorValue[7]or 0
if checkFlip then
if flip then
offsetX=-offsetX
end
end

args.angle=angle

args.offset={offsetX,0}
local ent=airEntitySystem:createSkillEntity(skillEntityType,self.caster,self.caster,self.target,self.actionCfg,args)
if not ent.isDelete then
self.checkRangeEnt=ent
end
end

function airDeadSkillAction:executeDamage()
if self.cacheEntity==nil then return end


for _,entity in pairs(self.cacheEntity)do
self:executeSingleDamage(entity)
end

if self.demageType==1 then
self.cacheEntity=nil
end
end


function airDeadSkillAction:executeSingleDamage(target)
return airSkillSystem:executeSingleDamage(self.owner,target,self.caster,self.skillCfg,self.actionCfg,self.acionValue,self.args)

end

function airDeadSkillAction:initCasterAttr()
if self.caster then
self.curAttrs=table.weakCopy(self.caster.curAttrs)
end
end

function airDeadSkillAction:getCasterAttr()
return self.curAttrs
end

function airDeadSkillAction:onTriggerEnterSkillCheck(entity)
if not self:checkCastEnity(entity)then return false end
if not self.cacheEntity then return false end
local handle=entity.handle
self.cacheEntity[handle]=entity


if self.demageType==3 and(self.demagedEntity and not self.demagedEntity[handle])then
self:executeSingleDamage(entity)
self.demagedEntity[handle]=entity
end
end

function airDeadSkillAction:onTriggerExitSkillCheck(entity)
if not self.cacheEntity then return false end
local handle=entity.handle
self.cacheEntity[handle]=nil
end



