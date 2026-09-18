
roundTripSkill=simple_class(baseEntity)


function roundTripSkill:initialize(args)
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

local boundType=behaviorValue[1]
local bounds=behaviorValue[2]
local colliderCfg=airConfig.getEntityColliderConfig(self.entityType)
self:addMainCollider(colliderCfg.layer,Vector3.zero,boundType,bounds,
colliderCfg.isTrigger,colliderCfg.kinematic,colliderCfg.interpolate,colliderCfg.detection)

local turnSpeed=behaviorValue[3]
local speed=behaviorValue[4]
local duration=behaviorValue[5]or 0
if duration==0 then
loggerUtil.debugErrFMT('技能往返设置时间不能等于0')
end
self.isSpineAsset=true
local sortingLayer=self:getSortingLayer()
self:setSpineSorting(sortingLayer,self.handle)

local caster=self.caster
caster:setAssetActive(false)
self.casterVis=false
local distance=speed*duration
local point_l=caster:getLocalPosition()
local point=airEntitySystem:getDistancePoint(caster,self.target,distance,false)

self.entity:DoLocalRotation(Vector3.New(0,0,turnSpeed),duration*2,nil)
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
local offset=0.2
self.timeStamp=duration*2+Time.realtimeSinceStartup+offset
end

function roundTripSkill:deleteEntity()
local handle=self.handle
if self.action then
self.action:onDeleteSkill(handle)
end
self:onDelete()
end

function roundTripSkill:onDelete()
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

function roundTripSkill:onUpdate()
self._base.onUpdate(self)
if self.timeStamp>0 then
if self.timeStamp<Time.realtimeSinceStartup then
self:deleteEntity()
return
end
end
end

function roundTripSkill:onFastUpdate()
self._base.onPause(self)
end

function roundTripSkill:onPause()
self._base.onPause(self)
end

function roundTripSkill:onContinue()
self._base.onContinue(self)
end

function roundTripSkill:deleteEntity()
local handle=self.handle
if not self:isActionDelete()then
self.action:onDeleteSkill(handle)
end
self:onDelete()
end

function roundTripSkill:onTriggerEnterMonster(entity)
if self:isActionDelete()then return end
self.action:onTriggerEnterMonster(entity)
end

function roundTripSkill:onTriggerExitMonster(entity)
if self:isActionDelete()then return end
self.action:onTriggerExitMonster(entity)
end

function roundTripSkill:isActionDelete()
return self.action==nil or self.action:isDeleteSelf()
end
