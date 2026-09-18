
skill=simple_class(baseEntity)


function skill:initialize(args)
self.owner=args.owner
self.caster=args.caster
self.target=args.target
self.action=args.action
self.skillCfg=args.skillCfg
local bounds=args.bounds
local boundType=args.boundType
local angle=args.angle or 0

local actionCfg=self.entityCfg
self.actionCfg=actionCfg

local rangeType=actionCfg.rangeType
if rangeType==eAirSkillRangeType.eSingle then
self:onTriggerEnterMonster(self.target)
self:deleteEntity()
return
end

if boundType==nil then
local rangeArgs=actionCfg.rangeArgs
boundType,bounds=airSkillSystem:getBounds(rangeType,rangeArgs)
end

local cangle=angle

if boundType==eAirEntityColliderType.eFan then
local bangle=180-bounds[5]
cangle=angle-bangle/2
end
local colliderCfg=airConfig.getEntityColliderConfig(self.entityType)
self:addMainCollider(colliderCfg.layer,Vector3.New(0,cangle,0),boundType,bounds,
colliderCfg.isTrigger,colliderCfg.kinematic,colliderCfg.interpolate,colliderCfg.detection)
end

function skill:deleteEntity()
local handle=self.handle
if self.action then
self.action:onDeleteSkill(handle)
end
self:onDelete()
end

function skill:onDelete()
if self==nil or self:isDeleteSelf()then return end
self._base.onDelete(self)

self.caster=nil
self.owner=nil
self.target=nil
self.action=nil
self.actionCfg=nil
self.skillCfg=nil
end

function skill:onUpdate()
self._base.onUpdate(self)
end

function skill:onFastUpdate()
self._base.onPause(self)
end

function skill:onPause()
self._base.onPause(self)
end

function skill:onContinue()
self._base.onContinue(self)
end

function skill:deleteEntity()
local handle=self.handle
if not self:isActionDelete()then
self.action:onDeleteSkill(handle)
end
self:onDelete()
end

function skill:onTriggerEnterMonster(entity)
if self:isActionDelete()then return end
self.action:onTriggerEnterMonster(entity)
end

function skill:onTriggerExitMonster(entity)
if self:isActionDelete()then return end
self.action:onTriggerExitMonster(entity)
end

function skill:isActionDelete()
return self.action==nil or self.action:isDeleteSelf()
end

function skill:disableCollider()
if self.entity then
self.entity:EnableCollider(-1,false)
end
end