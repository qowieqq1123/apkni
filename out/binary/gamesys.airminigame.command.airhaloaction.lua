





airHaloAction=simple_class(airSkillAction)

function airHaloAction:__init(...)

end

function airHaloAction:initalize(args)
self.cacheEntity={}
self.demagedEntity={}
self.delayDemageEntity={}
if self.targetReleation==eAirSkillTargetType.eSelf then
self.cacheEntity[self.owner.handle]=self.owner
end
self:start()
end

function airHaloAction:start()
local behaviorValue=self.behaviorValue
if behaviorValue[10]and behaviorValue[10]>0 then
self.startBehaveTime=behaviorValue[10]+Time.realtimeSinceStartup
else
self:executeBehavour()
end


end

function airHaloAction:onDelete()
self._base:onDelete()
if self.checkRangeEnt then
self.checkRangeEnt:onDelete()
end
self.damageTime=nil
self.cacheEntity=nil
self.demagedEntity=nil
self.checkRangeEnt=nil
self.delayDemageEntity=nil
end

function airHaloAction:onPause()
self._base:onPause()
end

function airHaloAction:onContinue()
self._base:onContinue()
end

function airHaloAction:onUpdate()
self._base:onUpdate()
end

function airHaloAction:onFastUpdate()
if self:isDeleteSelf()then return end

self.executeCnt=self.executeCnt-1
local pauseTime=0
if self.startBehaveTime and self.startBehaveTime+pauseTime<=Time.realtimeSinceStartup then
self:executeBehavour()
self.startBehaveTime=nil
end

if self.executeCnt<=0 then
if self.demageType==1 and self.damageTime and self.damageTime+pauseTime<=Time.realtimeSinceStartup then
self:executeDamage()
self.damageTime=nil
end
if self.demageType==2 and self.damageTime+self.damageCD+pauseTime<=Time.realtimeSinceStartup then
self:executeDamage()
self.damageTime=Time.realtimeSinceStartup
end
if self.demageType==3 and self.delayDemageEntity and self.damageCD and self.damageCD>0 then

for h,v in pairs(self.delayDemageEntity)do
if v[1]+pauseTime<=Time.realtimeSinceStartup then
self:executeSingleDamage(v[2])

self.demagedEntity[h]=v[2]
self.delayDemageEntity[h]=nil
end
end

end
end

if self.destroyTime and self.destroyTime+pauseTime<Time.realtimeSinceStartup then
if self.behaviorValue[9]==1 then
if self.owner.aiBehaviour then
self.owner.aiBehaviour:remsumeStackTarget()
self.owner.aiBehaviour:onContinue()
end
end
self:recycleSelf()
end
end


function airHaloAction:executeBehavour()

self:createCheckEntity()

local behaviorValue=self.behaviorValue
local checkTime=behaviorValue[1]or 0
local demageType=behaviorValue[2]or 0
local demageArgs=behaviorValue[3]or 0
if demageType==1 then
self.damageTime=demageArgs[1]+Time.realtimeSinceStartup
elseif demageType==2 then
self.damageTime=Time.realtimeSinceStartup-demageArgs[1]+(demageArgs[2]or 0)
self.damageCD=demageArgs[1]
elseif demageType==3 then
self.damageCD=demageArgs[1]or 0
end
self.demageType=demageType
self.destroyTime=checkTime+Time.realtimeSinceStartup

end

function airHaloAction:createCheckEntity()
local behaviorValue=self.behaviorValue
local args=self:getTargetArgs()
local skillEntityType=eAirSkillEntityType.eSkillRange

local attach=behaviorValue[4]or 0
local angle=0
local haveTarget=self.target~=nil
if haveTarget then
angle=airEntitySystem:getSignedAngle(Vector3.right,Vector3.Normalize(self.target:getPosition()-self.owner:getPosition()),Vector3.up)
end

local checkFlip=behaviorValue[5]
local flip=self.caster:isFlipX()
if not haveTarget then
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
end

local offsetX=behaviorValue[7]or 0






local angleAdd=behaviorValue[11]or 0
if checkFlip then
if flip then
angleAdd=-angleAdd
end
end

args.angle=angle+angleAdd
local ent
if offsetX~=0 then
args.centerOffset={offsetX,0,0}
end


if attach==1 and not self.caster:isDeleteSelf()then
args.effectArgs=behaviorValue[8]
args.rotateAnim=behaviorValue[12]
ent=airEntitySystem:createRoleHaloSkill(0,0,0,skillEntityType,self.caster,self.actionCfg,args)
else

args.effectArgs=behaviorValue[8]
args.rotateAnim=behaviorValue[12]
args.pos=self:getCenterPos(self.actionCfg,self.target,self.owner,self.caster)
ent=airEntitySystem:createSkillEntity(skillEntityType,self.owner,self.caster,self.target,self.actionCfg,args)
end

if not ent.isDelete then
self.checkRangeEnt=ent
end

if behaviorValue[9]==1 then
if self.owner.aiBehaviour then
self.owner.aiBehaviour:stopStackTarget()
self.owner.aiBehaviour:onPause()
self.owner.entity:StopMoveTween(false,false)
end
end



end

function airHaloAction:getCenterPos(actionCfg,target,owner,caster)
local pos
local centerType=actionCfg.centerType
if centerType==eAirSkillCenterType.eTarget then
pos=airEntitySystem:getPosition(target)
elseif centerType==eAirSkillCenterType.eSelf then
pos=airEntitySystem:getPosition(owner)
elseif centerType==eAirSkillCenterType.eWeapon then
pos=airEntitySystem:getPosition(caster)
end
return pos
end

function airHaloAction:executeDamage()
if self.cacheEntity==nil then return end
if self.caster==nil or self.caster:isDeleteSelf()then return end



for _,entity in pairs(self.cacheEntity)do
self:executeSingleDamage(entity)
end

if self.demageType==1 then
self.cacheEntity=nil
end
end

function airHaloAction:onTriggerEnterSkillCheck(entity)
if not self:checkCastEnity(entity)then return false end
if not self.cacheEntity then return false end
local handle=entity.handle
self.cacheEntity[handle]=entity


if self.demageType==3 and(self.demagedEntity and not self.demagedEntity[handle])and not self.delayDemageEntity[handle]then
if self.damageCD>0 then
self.delayDemageEntity[handle]={Time.realtimeSinceStartup+self.damageCD,entity}
else
self:executeSingleDamage(entity)
self.demagedEntity[handle]=entity
end
end
end

function airHaloAction:onTriggerExitSkillCheck(entity)
if not self.cacheEntity then return false end
local handle=entity.handle

self.cacheEntity[handle]=nil
end



