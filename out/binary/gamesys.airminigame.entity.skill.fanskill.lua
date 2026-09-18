fanSkill=simple_class(baseEntity)


function fanSkill:initialize(args)
self.owner=args.owner
self.caster=args.caster
self.target=args.target
self.action=args.action
self.skillCfg=args.skillCfg
local behaviorValue=args.behaviorValue
self.behaviorValue=behaviorValue

local actionCfg=self.entityCfg
self.actionCfg=actionCfg
local caster=self.caster
local isFlipX=self.caster:isFlipX()
local lookAtAngleX=caster.lookAtAngleX
local quaternion=Quaternion.Euler(lookAtAngleX,0,0)
local pos=args.pos
self:setPosition(pos)
local angle=airEntitySystem:getAroundZAngle(pos,self.target:getPosition(),quaternion)
local collider=behaviorValue[1]
local damageTime=behaviorValue[2]
local duration=behaviorValue[3]
local offset=behaviorValue[4]
local scale=behaviorValue[5]or 1
local tAngle=collider[5]
local distance=collider[6]
if duration==0 then
loggerUtil.debugErrFMT('技能往返设置时间不能等于0')
end

caster:setAssetActive(false)
self.isSpineAsset=caster.isSpineAsset
self.isSpriteAsset=caster.isSpriteAsset
self.casterVis=false

if offset then
self:setAssetLocalPosition(Vector3.New(offset[1],offset[2],0))
end
local startAngle=angle-tAngle/2
local endAngle=angle+tAngle/2
if startAngle<0 then startAngle=startAngle+360 end
if endAngle<0 then endAngle=endAngle+360 end
if startAngle>360 then startAngle=startAngle%360 end
if endAngle>360 then endAngle=endAngle%360 end


if endAngle<90 and startAngle>270 then
local endAngle_=endAngle
endAngle=startAngle
startAngle=endAngle_
end

local endTarget=Vector3.New(lookAtAngleX,0,endAngle)

self.entity:SetYZDir(lookAtAngleX,0,startAngle)
local action=function()
if caster and not caster:isDeleteSelf()then
caster:setAssetActive(true)
self.casterVis=true
end
self:deleteEntity()
end
self:setAssetScale(scale)
self:setFlipX(isFlipX)
self:setAssetLocalRotation(Vector3.zero)
self.entity:DoLocalRotationByDotween(endTarget,DG.Tweening.Ease.Linear,duration,0,action)

local time=duration
if damageTime>duration then time=damageTime end
self.timeStamp=time+Time.realtimeSinceStartup+0.1
end

function fanSkill:deleteEntity()
local handle=self.handle
if self.action then
self.action:onDeleteSkill(handle)
end
self:onDelete()
end

function fanSkill:onDelete()
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

function fanSkill:onUpdate()
self._base.onUpdate(self)
if self.timeStamp>0 then
if self.timeStamp<Time.realtimeSinceStartup then
self:deleteEntity()
return
end
end
end

function fanSkill:onFastUpdate()
self._base.onPause(self)
end

function fanSkill:onPause()
self._base.onPause(self)
end

function fanSkill:onContinue()
self._base.onContinue(self)
end

function fanSkill:deleteEntity()
local handle=self.handle
if not self:isActionDelete()then
self.action:onDeleteSkill(handle)
end
self:onDelete()
end

function fanSkill:onTriggerEnterMonster(entity)
if self:isActionDelete()then return end
self.action:onTriggerEnterMonster(entity)
end

function fanSkill:onTriggerExitMonster(entity)
if self:isActionDelete()then return end
self.action:onTriggerExitMonster(entity)
end

function fanSkill:isActionDelete()
return self.action==nil or self.action:isDeleteSelf()
end
