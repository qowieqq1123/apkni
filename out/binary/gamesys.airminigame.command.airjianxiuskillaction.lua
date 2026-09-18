airJianXiuSkillAction=simple_class(airSkillAction)

function airJianXiuSkillAction:__init(...)

end

function airJianXiuSkillAction:initalize()
self.shotNum=0

self:start()
end

function airJianXiuSkillAction:start()
self.checkEnt={}
self:createCheckEntity()

self:executeBehavour()
end

function airJianXiuSkillAction:onDelete()
self._base:onDelete()
if self.checkRangeEnt then
self.checkRangeEnt:onDelete()
end
self.shotNum=nil
self.nextDeltaTime=nil
self.entityArgs_=nil
self.checkEnt=nil
end

function airJianXiuSkillAction:onPause()
self._base:onPause()
if self.checkRangeEnt then
self.checkRangeEnt:onPause()
end
end

function airJianXiuSkillAction:onContinue()
self._base:onContinue()
if self.checkRangeEnt then
self.checkRangeEnt:onContinue()
end
end

function airJianXiuSkillAction:onUpdate()
self._base:onUpdate()
if self.checkRangeEnt then
self.checkRangeEnt:onUpdate()
end

end

function airJianXiuSkillAction:onFastUpdate()
self._base:onFastUpdate()
if self.checkRangeEnt then
self.checkRangeEnt:onFastUpdate()
end

if not self.checkEnt then return end

if self.damageTime+self.shotCD<=Time.realtimeSinceStartup then
self.damageTime=Time.realtimeSinceStartup
self:executeDamage()
end

if self.destroyTime and self.destroyTime<Time.realtimeSinceStartup then
self:recycleSelf()
end
end

function airJianXiuSkillAction:isDeleteSelf()
return self.isDelete==true
end

function airJianXiuSkillAction:executeBehavour()
local behaviorValue=self.behaviorValue

self.caster.staticAuto.BaseEntity_PlayEffect(self.caster.handle,behaviorValue[10],Vector3.zero,true,true)

self.destroyTime=(behaviorValue[11]or 5)+Time.realtimeSinceStartup
self.shotCD=behaviorValue[12]or 0.5
self.damageTime=Time.realtimeSinceStartup-self.shotCD

self:executeDamage()
end

function airJianXiuSkillAction:executeDamage()
if self:isDeleteSelf()then
return
end
if self.checkEnt then
local key,checkEnt=next(self.checkEnt)
if checkEnt then

local args_={target=checkEnt,angle=0}
self:createEntity(args_)

else
local args_={}
self:createEntity(args_)
end
end
end


function airJianXiuSkillAction:executeSingleDamage(target)
return airSkillSystem:executeSingleDamage(self.owner,target,self.caster,self.skillCfg,self.actionCfg,self.acionValue,self.args)
end

function airJianXiuSkillAction:createEntity(args)
self._base.createEntity(self,eAirSkillEntityType.eJianXiuShot,nil,args)
end


function airJianXiuSkillAction:createCheckEntity()

local args=self:getTargetArgs()
local skillEntityType=eAirSkillEntityType.eSkillRange

local ent=airEntitySystem:createRoleHaloSkill(0,0,0,skillEntityType,self.caster,self.actionCfg,args)
if not ent.isDelete then
self.checkRangeEnt=ent
end
end



function airJianXiuSkillAction:onTriggerEnterMonster(entity)
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

function airJianXiuSkillAction:onTriggerExitMonster(entity)
local handle=entity.handle
if self.enemyEntites[handle]==nil then return false end

self.enemyEntitesNum=self.enemyEntitesNum-1
self.enemyEntites[handle]=nil
return true
end

function airJianXiuSkillAction:onTriggerEnterSkillCheck(entity)
if not self:checkCastEnity(entity)then return false end
if not self.checkEnt then return false end
local handle=entity.handle
self.checkEnt[handle]=entity
end

function airJianXiuSkillAction:onTriggerExitSkillCheck(entity)
if not self.checkEnt then return false end
local handle=entity.handle
self.checkEnt[handle]=nil
end


function airJianXiuSkillAction:getFanAngle(actionCfg,owner,caster,target)
local centerType=actionCfg.centerType
if centerType==eAirSkillCenterType.eTarget then
return 0
elseif centerType==eAirSkillCenterType.eSelf then
return airEntitySystem:getAoundYAngle(owner.handle,target.handle)
elseif centerType==eAirSkillCenterType.eWeapon then
return airEntitySystem:getAoundYAngle(caster.handle,target.handle)
end
end
