



targetRoundSkill=simple_class(baseEntity)

function targetRoundSkill:initialize(args)
self.owner=args.owner
self.caster=args.caster
self.action=args.action
self.target=args.target
self.skillCfg=args.skillCfg
self.behaviorValue=args.behaviorValue













local behaviorValue=self.behaviorValue
local effectData=behaviorValue[1]
local speed=behaviorValue[3]

local lockTarget=true
local turnSpeed=behaviorValue[4]or 0
local canRatation=turnSpeed>0

self.entity.SupportDIR=lockTarget
self.entity.SupportDIRAnimation=canRatation
self.entity.TurnSpeed=turnSpeed
self.entity.MoveSpeed=speed

self.lockHandle=self.target.handle
self:setCanMove(true)
self.entity:MoveToEntity(self.target.entity,DG.Tweening.Ease.Linear)

local colliderCfg=airConfig.getEntityColliderConfig(self.entityType)
local bounds=behaviorValue[6]
self:addMainCollider(colliderCfg.layer,Vector3.New(0,0,0),eAirEntityColliderType.eCircle,bounds,
colliderCfg.isTrigger,colliderCfg.kinematic,colliderCfg.interpolate,colliderCfg.detection)

self.model=1

self.flyEffect=self:playEffect(effectData[1])


















self:addPostDelete()
end









function targetRoundSkill:onDelete()
if self==nil or self:isDeleteSelf()then return end
self:removePostDelete()
self._base.onDelete(self)

self.caster=nil
self.owner=nil
self.target=nil
self.action=nil

self.skillCfg=nil
self.lockHandle=nil
end

function targetRoundSkill:deleteEntity()
local handle=self.handle
if not self:isActionDelete()then
self.action:onDeleteSkill(handle)
end
self:onDelete()
end

function targetRoundSkill:handleExplosion()
self.entity:UnBindEntity()
self.lockHandle=nil
local behaviorValue=self.behaviorValue
local effectData=behaviorValue[1]
local scale=effectData[3]
local targetPos=self:getPosition()
airEntitySystem:playEffect(effectData[2],targetPos,false,Vector3.New(scale,scale,scale))
_stopEffect(self.flyEffect)
local bounds=behaviorValue[7]

self:enableCollider(-1,false)
local colliderCfg=airConfig.getEntityColliderConfig(self.entityType)
self:addCollider(0,colliderCfg.layer,Vector3.New(0,0,0),eAirEntityColliderType.eCircle,bounds,
colliderCfg.isTrigger,colliderCfg.kinematic,colliderCfg.interpolate,colliderCfg.detection)
self.action:setDamageTime()
self.model=2
end

function targetRoundSkill:onTriggerEnterMonster(entity)
if self:isActionDelete()then return end
if self.model==1 then
if entity.handle==self.lockHandle then
self:handleExplosion()
end
else
self.action:onTriggerEnterMonster(entity)
end
end

function targetRoundSkill:onTriggerExitMonster(entity)
if self:isActionDelete()then return end
self.action:onTriggerExitMonster(entity)
end

function targetRoundSkill:isActionDelete()
return self.action==nil or self.action:isDeleteSelf()
end

function targetRoundSkill:onRemoveEntity(handle)
if self.lockHandle==handle then
self.lockHandle=nil
self.entity:UnBindEntity()
if self.target:isDeleteSelf()then
return
end
if self.caster:isDeleteSelf()then
return
end
local behaviorValue=self.behaviorValue
local speed=behaviorValue[3]
local targetPos=self.target:getPosition()
local casterPos=self.caster:getPosition()
local distance=Vector3.Distance(casterPos,targetPos)
local ctime=distance/speed
self.entity:MoveToWorldPositionByDoTweenDuration(targetPos,_Ease.Linear,ctime,0,function()
self:handleExplosion()
end)
end
end