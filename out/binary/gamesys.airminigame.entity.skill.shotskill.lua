

shotSkill=simple_class(baseEntity)


function shotSkill:initialize(args)
self.owner=args.owner
self.caster=args.caster
self.action=args.action
self.target=args.target
self.skillCfg=args.skillCfg
local behaviorValue=args.behaviorValue
self.behaviorValue=behaviorValue
local angle=args.angle or 0
self.angle=angle

local size=behaviorValue[1]
local length=size[1]
local width=size[2]
local height=size[3]
local bounds={0,0,0,length,width,height}
local boundType=eAirEntityColliderType.eRect
local actionCfg=self.entityCfg
self.actionCfg=actionCfg

local speed=behaviorValue[3]
local lockTarget=behaviorValue[7]==1
local turnSpeed=behaviorValue[8]
local canRatation=turnSpeed>1

self.entity.SupportDIR=lockTarget
self.entity.SupportDIRAnimation=canRatation
self.entity.TurnSpeed=turnSpeed
self.entity.MoveSpeed=speed

local layer=self:getColliderLayer()
local colliderCfg=airConfig.getEntityColliderConfig(self.entityType)
self:addMainCollider(layer,Vector3.New(0,0,0),boundType,bounds,
colliderCfg.isTrigger,colliderCfg.kinematic,colliderCfg.interpolate,colliderCfg.detection)


local area=behaviorValue[10]
if area and area>0 then
self:addCollider(1,layer,Vector3.zero,eAirEntityColliderType.eCircle,{0,0,0,area},colliderCfg.isTrigger,colliderCfg.kinematic,colliderCfg.interpolate,colliderCfg.detection)
self.areaEnt={}
end

self:addPostDelete()
self:start()
end

function shotSkill:onDelete()
if self==nil or self:isDeleteSelf()then return end
self:removePostDelete()
self._base.onDelete(self)

self.caster=nil
self.owner=nil
self.target=nil
self.action=nil
self.actionCfg=nil
self.skillCfg=nil
self.timeStamp=nil
self.lockHandle=nil
self.areaEnt=nil
end

function shotSkill:onUpdate()
self._base.onUpdate(self)
if self.timeStamp>0 then
if self.timeStamp<Time.realtimeSinceStartup then
self:deleteEntity()
return
end
end
end

function shotSkill:onFastUpdate()
self._base.onFastUpdate(self)
end

function shotSkill:onPause()
self._base.onPause(self)
end

function shotSkill:onContinue()
self._base.onContinue(self)
end

function shotSkill:deleteEntity()
local handle=self.handle
if not self:isActionDelete()then
self.action:onDeleteSkill(handle)
end
self:onDelete()
end

function shotSkill:onTriggerEnterMonster(entity,guid1,guid2)
if self:isActionDelete()then return end
if guid1==-1 then
if self.behaviorValue[2][1]==2 then
local effectId=self.behaviorValue[2][2][3]
if effectId>0 then
local pos=entity:getPosition()
airEntitySystem:playEffect(effectId,pos,false,Vector3.New(1,1,1))
end
elseif self.behaviorValue[2][1]==1 then
if self.behaviorValue[2][3]and next(self.behaviorValue[2][3])then
local effectId=self.behaviorValue[2][3][3]
if effectId>0 then
local pos=entity:getPosition()
airEntitySystem:playEffect(effectId,pos,false,Vector3.New(1,1,1))
end
end
end
if self.areaEnt then
self.areaEnt[entity.handle]=entity
for h,e in pairs(self.areaEnt)do
if not self:isActionDelete()then
self.action:onTriggerEnterMonster(e)
end
end
if self.triggerDestroy then

self:deleteEntity()
end
else
if self.action:onTriggerEnterMonster(entity)then
if self.triggerDestroy then

self:deleteEntity()
end
end
end
elseif guid1==1 then
self.areaEnt[entity.handle]=entity
end
end

function shotSkill:onTriggerExitMonster(entity,guid1,guid2)
if self:isActionDelete()then return end
if guid1==-1 then
self.action:onTriggerExitMonster(entity)
elseif guid1==1 then
self.areaEnt[entity.handle]=nil
end
end

function shotSkill:start()
local actionCfg=self.actionCfg
local behaviorValue=self.behaviorValue

local showArgs=behaviorValue[2]
local speed=behaviorValue[3]

local time=behaviorValue[5]
local destroyType=behaviorValue[6]
local lockTarget=behaviorValue[7]==1
local turnSpeed=behaviorValue[8]or 0
local canRatation=turnSpeed>0



self.entity.SupportDIR=lockTarget
self.entity.SupportDIRAnimation=canRatation
self.entity.TurnSpeed=turnSpeed
self.entity.MoveSpeed=speed

local stype=showArgs[1]
if stype==1 then
local iconname=airConfig.getSkillImgName(showArgs[2])
self.staticAuto.BaseEntity_SetSpriteRenderer(self.handle,iconname,true)
self:setSelfSpriteSortingGroup()
if showArgs[3]and next(showArgs[3])then
local effectId=showArgs[3][1]
if effectId>0 then
self:playEffect(effectId)
end
end
self.isSpriteAsset=true
if showArgs[4]then
self:setAssetScale(showArgs[4])
end
if showArgs[5]then
self:setAssetLocalRotation(Vector3.New(showArgs[5],showArgs[6],showArgs[7]))
end

local transform=self.staticAuto.BaseEntity_GetSpriteTransform(self.handle)
local autoRotate=showArgs[8]
if autoRotate then
Lua.DOTweenProxyExtensions.DOLocalRotate(transform,transform.localRotation.eulerAngles+Vector3.New(autoRotate[1],autoRotate[2],autoRotate[3]),time,DG.Tweening.RotateMode.FastBeyond360)
end

elseif stype==2 then
local effectId=showArgs[2][2]
if effectId>0 then
self:playEffect(effectId)
end
end

if not lockTarget then
local distance=time*speed
local pos=self:getPosition()
local angle=self.angle
local position=airEntitySystem:getDirectionPosition(pos,angle,distance,false)

self.entity:MoveToWorldPositionByDoTween(position,DG.Tweening.Ease.Linear,0,function()
self:deleteEntity()
end)
if canRatation then
self:lookAtPos(position)
end
else
self.lockHandle=self.target.handle
self:setCanMove(true)
self.entity:MoveToEntity(self.target.entity,DG.Tweening.Ease.Linear)
end

if time>0 then
self.timeStamp=time+Time.realtimeSinceStartup
else
self.timeStamp=0
end

self.triggerDestroy=destroyType==1
if lockTarget then
self.triggerDestroy=true
end

if behaviorValue[9]==1 then
self:lookAtCamera()
end
end

function shotSkill:isActionDelete()
return self.action==nil or self.action:isDeleteSelf()
end


function shotSkill:onRemoveEntity(handle)
if self.lockHandle==handle then
self:deleteEntity()
end
end
