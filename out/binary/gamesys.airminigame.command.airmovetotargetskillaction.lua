airMoveToTargetSkillAction=simple_class(airSkillAction)

function airMoveToTargetSkillAction:__init(...)

end

function airMoveToTargetSkillAction:initalize(args)
self.direction=args.direction
self.pos=args.pos
self.executeCnt=99999
self.demagedEntity={}
self:createEntity()
self:start()
end

function airMoveToTargetSkillAction:start()
local behaviorValue=self.behaviorValue
if behaviorValue[6]and behaviorValue[6]>0 then
self.startBehaveTime=behaviorValue[6]+Time.realtimeSinceStartup
else
self:executeBehavour()
end

end

function airMoveToTargetSkillAction:onDelete()
self._base:onDelete()
self.demagedEntity={}
self.direction=nil
self.pos=nil
end

function airMoveToTargetSkillAction:onPause()
self._base:onPause()
end

function airMoveToTargetSkillAction:onContinue()
self._base:onContinue()
end

function airMoveToTargetSkillAction:onUpdate()
self._base:onUpdate()


end

function airMoveToTargetSkillAction:onFastUpdate()
self._base:onFastUpdate()
self.executeCnt=self.executeCnt-1

if self.startBehaveTime and self.startBehaveTime<=Time.realtimeSinceStartup then
self:executeBehavour()
self.startBehaveTime=nil
end

if self.delayPlay and self.delayPlay<=Time.realtimeSinceStartup then
if self.delayEffectHandle then
_stopEffect(self.delayEffectHandle)
end
self:doMove()
self.delayPlay=nil
end
if self.destroyTime and self.destroyTime<=Time.realtimeSinceStartup then
if self.owner and self.owner.aiBehaviour then
self.owner.aiBehaviour:remsumeStackTarget()
self.owner.aiBehaviour:onContinue()
end
if self.moveEffectHandle then
_stopEffect(self.moveEffectHandle)
end
self:recycleSelf()
self.destroyTime=nil
end
end

function airMoveToTargetSkillAction:isDeleteSelf()
return self.isDelete==true
end

function airMoveToTargetSkillAction:createEntity(skillEntityType,angle,args_)
local args=self:getTargetArgs()
skillEntityType=skillEntityType or eAirSkillEntityType.eCommon

args.angle=angle or
args_ and args_.angle or
airSkillSystem:getAngle(self.actionCfg,self.owner,self.caster,self.target)

if args_ then
args=table.concatPairs(args,args_)
end

local ent=airEntitySystem:createRoleHaloSkill(0,0,0,skillEntityType,self.owner,self.actionCfg,args)
if not ent.isDelete then
self.skillEnts[ent.handle]=ent
end
end

function airMoveToTargetSkillAction:executeBehavour()
local behaviorValue=self.behaviorValue


local distance=behaviorValue[1]
local duration=behaviorValue[2]
local delay=behaviorValue[3]
local delayEffect=behaviorValue[4]
local moveEffect=behaviorValue[5]

self.distance=distance
self.duration=duration
self.moveEffect=moveEffect
self.delayPlay=delay+Time.realtimeSinceStartup

self.targetPoint=airEntitySystem:getDistancePoint(self.owner,self.target,self.distance,true)

if delayEffect then
local scale=delayEffect[2]
self.delayEffectHandle=self.owner.staticAuto.BaseEntity_PlayEffect(self.owner.handle,delayEffect[1],Vector3.New(delayEffect[3]or 0,delayEffect[4]or 0,delayEffect[5]or 0),Vector3.New(scale,scale,scale),true,true)

if self.owner.aiBehaviour then
self.owner.aiBehaviour:stopStackTarget()
self.owner.aiBehaviour:onPause()
self.owner.entity:StopMoveTween(false,false)
end
end

if delay==0 then
local point=self.targetPoint

self.owner.entity:MoveToWorldPositionByDoTweenDuration(point,DG.Tweening.Ease.Linear,duration,0,function()


self.destroyTime=2+Time.realtimeSinceStartup
end)
if moveEffect then
local scale=moveEffect[2]or 1
self.moveEffectHandle=self.owner.staticAuto.BaseEntity_PlayEffect(self.owner.handle,moveEffect[1],Vector3.New(moveEffect[3]or 0,moveEffect[4]or 0,moveEffect[5]or 0),Vector3.New(scale,scale,scale),true,true)
end
end

self.executeCnt=1
end

function airMoveToTargetSkillAction:doMove()
local point=self.targetPoint






self.owner.entity:MoveToWorldPositionByDoTweenDuration(point,DG.Tweening.Ease.Linear,self.duration,0,function()
if self.owner and self.owner.aiBehaviour then
self.owner.aiBehaviour:remsumeStackTarget()
self.owner.aiBehaviour:onContinue()
end

self.destroyTime=2+Time.realtimeSinceStartup
end)
if self.moveEffect then
local scale=self.moveEffect[2]or 1
self.moveEffectHandle=self.owner.staticAuto.BaseEntity_PlayEffect(self.owner.handle,self.moveEffect[1],Vector3.New(self.moveEffect[3]or 0,self.moveEffect[4]or 0,self.moveEffect[5]or 0),Vector3.New(scale,scale,scale),true,true)
end
end

function airMoveToTargetSkillAction:executeDamage(disableCollider)
local caster=self.caster

if caster==nil or caster:isDeleteSelf()then return end

local actionCfg=self.actionCfg
local targetMaxCount=actionCfg.targetMaxCount or 99999
local pos=self.centerPos
local list={}

for i,entity in pairs(self.enemyEntites)do
local distance=airEntitySystem:getDistance2D(entity.handle,pos.x,pos.z)
list[#list+1]={distance,entity}
end
table.sort(list,function(a,b)
return a[1]<b[1]
end)
local num=#list

local max=math.min(num,targetMaxCount)

for i,v in ipairs(list)do
local entity=v[2]
local ret=self:executeSingleDamage(entity)
if ret then
max=max-1
if max<=0 then
break
end
end
end


if disableCollider~=false then
self:disableMainCollider()
end
end

function airMoveToTargetSkillAction:onTriggerEnterMonster(entity)

if self.enemyEntitesNum>self.targetMaxCount then return false end
if not self:checkCastEnity(entity)then return false end

local handle=entity.handle
if self.enemyEntites[handle]then return false end

self.enemyEntites[handle]=entity
self.enemyEntitesNum=self.enemyEntitesNum+1

if self.demagedEntity and not self.demagedEntity[handle]then
self:executeDamage()
self.demagedEntity[handle]=entity
end

return true
end

function airMoveToTargetSkillAction:onTriggerExitMonster(entity)

local handle=entity.handle
if self.enemyEntites[handle]==nil then return end

self.enemyEntitesNum=self.enemyEntitesNum-1
self.enemyEntites[handle]=nil
end
