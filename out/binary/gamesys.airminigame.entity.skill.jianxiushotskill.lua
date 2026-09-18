jianxiuShotSkill=simple_class(baseEntity)


function jianxiuShotSkill:initialize(args)
self.owner=args.owner
self.caster=args.caster
self.action=args.action
self.target=args.target

self.noTarget=self.target==nil

self.skillCfg=args.skillCfg
self.lockHandle=nil
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

self.effectid=behaviorValue[9]

self.jumpArgs=behaviorValue[4]

self.bombEffect=behaviorValue[13]

self.entity.SupportDIR=lockTarget
self.entity.SupportDIRAnimation=canRatation
self.entity.TurnSpeed=turnSpeed
self.entity.MoveSpeed=speed

local layer=self:getColliderLayer()
local colliderCfg=airConfig.getEntityColliderConfig(self.entityType)
self:addMainCollider(layer,Vector3.New(0,angle,0),boundType,bounds,
colliderCfg.isTrigger,colliderCfg.kinematic,colliderCfg.interpolate,colliderCfg.detection)
self:addPostDelete()
self:start()
end

function jianxiuShotSkill:onDelete()
if self==nil or self:isDeleteSelf()then return end
self:removePostDelete()
self._base.onDelete(self)

if self.effectHandle then
_stopEffect(self.effectHandle)
self.effectHandle=nil
end

self.caster=nil
self.owner=nil
self.target=nil
self.action=nil
self.actionCfg=nil
self.skillCfg=nil
self.timeStamp=nil
self.lockHandle=nil
end

function jianxiuShotSkill:onUpdate()
self._base.onUpdate(self)
if self.circleDuration and self.circleDuration<Time.realtimeSinceStartup then
self.pathFinish=true
self.circleDuration=nil
end

if self.startStamp+self.perIndex*self.perDuration<Time.realtimeSinceStartup then
self.perIndex=self.perIndex+1

if self.angleList[self.perIndex]then
self:lookAtAngleZ(self.angleList[self.perIndex])
end
end

if not self.noTarget then
if self.pathFinish and self.target and self.target:isDeleteSelf()then
self:deleteEntity()
return
end
end

if self.timeStamp>0 then
if self.timeStamp<Time.realtimeSinceStartup then
self:deleteEntity()
return
end
end
end

function jianxiuShotSkill:onFastUpdate()
self._base.onFastUpdate(self)
end

function jianxiuShotSkill:onPause()
self._base.onPause(self)
end

function jianxiuShotSkill:onContinue()
self._base.onContinue(self)
end

function jianxiuShotSkill:deleteEntity()
local handle=self.handle
if not self:isActionDelete()then
if self.bombEffect then
local pos=self:getPosition()
airEntitySystem:playEffect(self.bombEffect,pos,false,Vector3.one)
end
self.action:onDeleteSkill(handle)
end
self:onDelete()
end

function jianxiuShotSkill:onTriggerEnterMonster(entity)
if self:isActionDelete()then return end
if not self:isPathFinish()then return end
if self.action:onTriggerEnterMonster(entity)then
if self.triggerDestroy then

self:deleteEntity()
end
end
end

function jianxiuShotSkill:onTriggerExitMonster(entity)
if self:isActionDelete()then return end
if not self:isPathFinish()then return end
self.action:onTriggerExitMonster(entity)
end

function jianxiuShotSkill:isPathFinish()
return self.pathFinish
end

function jianxiuShotSkill:start()
local actionCfg=self.actionCfg
local behaviorValue=self.behaviorValue

local icon=behaviorValue[2]
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

if icon>0 then
local iconname=airConfig.getSkillImgName(icon)
self.staticAuto.BaseEntity_SetSpriteRenderer(self.handle,iconname,false)
self:setSpriteSortingGroup()
end

if self.effectid and self.effectid>0 then
self.effectHandle=self.staticAuto.BaseEntity_PlayEffect(self.handle,self.effectid,Vector3.zero,true,true)
end

local radius=self.jumpArgs[1]

local transform=self.entity.transform


local distance=time*speed
local pos=self:getPosition()



local path={}

local flipX=self.caster:isFlipX()or false

self.flipX=flipX

local x=flipX and 1 or-1
local z=-1

local index=0
local random=0






local duan=8



local angleList={}

local addz
for i=3,7 do
local a=i*Mathf.PI*2/duan
random=math.random(4,6)

addz=z*Mathf.Sin(a)*radius*(1+random*0.05)
table.insert(path,Vector3(pos.x+x*(Mathf.Cos(a)*radius),pos.y+addz,pos.z))
index=index+1

table.insert(angleList,a/Mathf.Deg2Rad)
end

self.entity.transform.position=path[1]
table.remove(path,1)

self:lookAtAngleZ(angleList[1])

self.angleList=angleList

self.path=path

local duration=(2*radius*Mathf.PI/duan)*(index-1)/speed

self.perDuration=duration/(index-1)
self.perIndex=1
self.startStamp=Time.realtimeSinceStartup

if self.noTarget then

self.circleDuration=duration+Time.realtimeSinceStartup
local pos1=path[#path]
local pos2=Vector3.New(pos1.x,pos.y,pos1.z)

local position=airEntitySystem:getDirectionPosition(pos2,flipX and 0 or 180,distance)


local circleTweener=Lua.DOTweenProxyExtensions.DoPath(transform,
path,duration,DG.Tweening.PathType.CatmullRom)
circleTweener:SetEase(DG.Tweening.Ease.InOutSine)

self.pathFinish=false

circleTweener:OnComplete(function()
self.pathFinish=true
self.entity:MoveToWorldPositionByDoTween(position,DG.Tweening.Ease.Linear,0,function()
self:deleteEntity()
end)

end)
else
if not lockTarget then
self.circleDuration=duration+Time.realtimeSinceStartup
if self.target then
local angle_=airEntitySystem:getAoundYAngle(self.caster.handle,self.target.handle)
local position=airEntitySystem:getDirectionPosition(path[#path],angle_,distance)
table.insert(path,position)
end

local circleTweener=Lua.DOTweenProxyExtensions.DoPath(transform,
path,duration+distance/speed,DG.Tweening.PathType.CatmullRom)
circleTweener:SetEase(DG.Tweening.Ease.InOutSine)

self.pathFinish=false

circleTweener:OnComplete(function()
self.pathFinish=true
self:deleteEntity()
end)
else
self.circleDuration=duration+Time.realtimeSinceStartup

local circleTweener=Lua.DOTweenProxyExtensions.DoPath(transform,
path,duration,DG.Tweening.PathType.CatmullRom)
circleTweener:SetEase(DG.Tweening.Ease.InOutSine)

self.pathFinish=false

circleTweener:OnComplete(function()
self.pathFinish=true
self.lockHandle=self.target.handle
self:setCanMove(true)
self.entity:MoveToEntity(self.target.entity,DG.Tweening.Ease.Linear)
end)
end
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
end

function jianxiuShotSkill:isActionDelete()
return self.action==nil or self.action:isDeleteSelf()
end


function jianxiuShotSkill:onRemoveEntity(handle)
if self.lockHandle==handle then
self:deleteEntity()
end
end


function jianxiuShotSkill:lookAtAngleZ(angle)
self:setLocalRotation(Vector3.New(self.flipX and angle-90 or angle+90,90,0))
end
