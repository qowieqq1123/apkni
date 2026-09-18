

roundTrip2Skill=simple_class(baseEntity)


function roundTrip2Skill:initialize(args)
self.owner=args.owner
self.caster=args.caster
self.target=args.target
self.action=args.action
self.skillCfg=args.skillCfg
local bounds=args.bounds
local boundType=args.boundType
local behaviorValue=args.behaviorValue
self.behaviorValue=behaviorValue

local actionCfg=self.entityCfg
self.actionCfg=actionCfg

local speed=behaviorValue[1]
local duration=behaviorValue[2]
local distance=speed*duration
if duration==0 then
loggerUtil.debugErrFMT('技能往返设置时间不能等于0')
end
self.isSpineAsset=true
local sortingLayer=self:getSortingLayer()
self:setSpineSorting(sortingLayer,self.handle)

local caster=self.caster
caster:setAssetActive(false)
self.casterVis=false
local point_l=caster:getLocalPosition()
local point=airEntitySystem:getDistancePoint(caster,self.target,distance,false)

local boundType=eAirEntityColliderType.eRect
local bounds=behaviorValue[5]
local colliderCfg=airConfig.getEntityColliderConfig(self.entityType)
self:addMainCollider(colliderCfg.layer,Vector3.zero,boundType,bounds,
colliderCfg.isTrigger,colliderCfg.kinematic,colliderCfg.interpolate,colliderCfg.detection)

local lookAtAngleX=caster.lookAtAngleX
local quaternion=Quaternion.Euler(lookAtAngleX,0,0)
local angle=airEntitySystem:getEntityZAngle(self.caster,self.target,quaternion)
self.entity:SetYZDir(lookAtAngleX,0,angle)

local jd=self:countTowardToTargetAngle(self.target)
self:setColliderRotation(-1,Vector3.New(0,jd,0))

self:setSpineActive(true)
local action=function()
local action1=function()
caster:setAssetActive(true)
self.casterVis=true
if self and not self:isDeleteSelf()then
self:deleteEntity()
end
end
self.entity:MoveToPositionByDoTweenDuration(point_l,DG.Tweening.Ease.Linear,duration,0,action1)
end

self.entity:MoveToWorldPositionByDoTweenDuration(point,DG.Tweening.Ease.Linear,duration,0,action)
self.timeStamp=duration*2+Time.realtimeSinceStartup+0.2
local offset=self.behaviorValue[4][3]or{0,0,0}
offset=Vector3.New(offset[1],offset[2],0)
self:playEffect(self.behaviorValue[4][1],offset)
end









function roundTrip2Skill:onDelete()
if self==nil or self:isDeleteSelf()then return end
if self.casterVis==false and self.caster and not self.caster:isDeleteSelf()then
self.caster:setAssetActive(true)
end
self.timeStamp=nil
self._base.onDelete(self)
self.caster=nil
self.owner=nil
self.target=nil
self.action=nil
self.actionCfg=nil
self.skillCfg=nil
self.casterVis=nil
end

function roundTrip2Skill:onUpdate()

if self.timeStamp>0 then
if self.timeStamp<Time.realtimeSinceStartup then
self:deleteEntity()
return
end
end
end













function roundTrip2Skill:onTriggerEnterMonster(entity)
if self:isActionDelete()then return end
self.action:onTriggerEnterMonster(entity)
end

function roundTrip2Skill:onTriggerExitMonster(entity)
if self:isActionDelete()then return end
self.action:onTriggerExitMonster(entity)
end

function roundTrip2Skill:deleteEntity()
local handle=self.handle
if not self:isActionDelete()then
self.action:onDeleteSkill(handle)
end
self:onDelete()
end

function roundTrip2Skill:isActionDelete()
return self.action==nil or self.action:isDeleteSelf()
end
