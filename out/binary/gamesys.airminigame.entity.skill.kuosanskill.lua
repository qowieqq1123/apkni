kuosanSkill=simple_class(baseEntity)


function kuosanSkill:initialize(args)
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

local radius=behaviorValue[3]
local expansionSpeed=behaviorValue[4]or 0
local expansionTime=behaviorValue[5]or 0

local boundType,bounds=airSkillSystem:getCircleBounds(radius)

local colliderCfg=airConfig.getEntityColliderConfig(self.entityType)
self:addMainCollider(colliderCfg.layer,Vector3.zero,boundType,bounds,
colliderCfg.isTrigger,colliderCfg.kinematic,colliderCfg.interpolate,colliderCfg.detection)

if expansionSpeed>0 and expansionTime>0 then
local func=function()
if self==nil or self:isDeleteSelf()then return end
self:onExpansionFinish()
end
self.staticAuto.BaseEntity_StartColliderExpansion(self.handle,-1,expansionSpeed,expansionTime,func)
self.expansion=true
end
end

function kuosanSkill:deleteEntity()
local handle=self.handle
if self.action then
self.action:onDeleteSkill(handle)
end
self:onDelete()
end

function kuosanSkill:onDelete()
if self==nil or self:isDeleteSelf()then return end
if self.expansion then
self.staticAuto.BaseEntity_StopColliderExpansion(self.handle,-1,nil)
end
self.expansion=nil
self._base.onDelete(self)
self.caster=nil
self.owner=nil
self.target=nil
self.action=nil
self.actionCfg=nil
self.skillCfg=nil
end

function kuosanSkill:onUpdate()
self._base.onUpdate(self)
end

function kuosanSkill:onFastUpdate()
self._base.onPause(self)
end

function kuosanSkill:onPause()
self._base.onPause(self)
end

function kuosanSkill:onContinue()
self._base.onContinue(self)
end

function kuosanSkill:deleteEntity()
local handle=self.handle
if not self:isActionDelete()then
self.action:onDeleteSkill(handle)
end
self:onDelete()
end

function kuosanSkill:onTriggerEnterMonster(entity)
if self:isActionDelete()then return end
self.action:onTriggerEnterMonster(entity)
end

function kuosanSkill:onTriggerExitMonster(entity)
if self:isActionDelete()then return end
self.action:onTriggerExitMonster(entity)
end

function kuosanSkill:isActionDelete()
return self.action==nil or self.action:isDeleteSelf()
end

function kuosanSkill:onExpansionFinish()
self.expansion=nil
self.action:onTriggerFinish()
end
