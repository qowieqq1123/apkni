


airXueYinDaoSkillAction=simple_class(airSkillAction)

function airXueYinDaoSkillAction:__init(...)

end

function airXueYinDaoSkillAction:initalize(args)
self:start()
end

function airXueYinDaoSkillAction:start()
self:createBehavior()
end

function airXueYinDaoSkillAction:onDelete()
if not self.caster:isDeleteSelf()then
self.caster:setAssetActive(true)
end
self._base.onDelete(self)
self.destroyTime=nil
self.damageTime=nil
end













function airXueYinDaoSkillAction:onFastUpdate()
if self.model~=2 then
return
end
if self:isDeleteSelf()then return end
self.executeCnt=self.executeCnt-1
if self.damageTime and self.executeCnt<=0 and self.damageTime<=Time.realtimeSinceStartup then
self:executeDamage()
self.damageTime=nil
end
if self.destroyTime and self.destroyTime<=Time.realtimeSinceStartup then
self:recycleSelf()
end
end

function airXueYinDaoSkillAction:createBehavior()

local behaviorValue=self.behaviorValue
local damageTime=behaviorValue[2]or 0
local duration=behaviorValue[3]or 0

local distance=behaviorValue[4]or 2
local angle=self.caster:countTowardToTargetAngle(self.target)
local tpos=self.target:getPosition()
local cpos=self.caster:getPosition()
local dv=tpos-cpos
local nv=Vector3.Normalize(dv)
local pos=Vector3.__add(cpos,Vector3.__sub(dv,Vector3.__mul(nv,distance)))

local bounds=behaviorValue[1]

local args=self:getTargetArgs()
args.angle=angle
args.pos=pos
args.boundType=eAirEntityColliderType.eFan
args.bounds=bounds

local ent=airEntitySystem:copyEntitySkill(self.caster,false,eAirSkillEntityType.eCommon,self.owner,self.caster,self.target,self.actionCfg,args)
if not ent.isDelete then
self.skillEnts[ent.handle]=ent
end

ent:enableCollider(-1,false)

self.caster:setAssetActive(false)



local lookAtAngleX=self.caster.lookAtAngleX
local quaternion=Quaternion.Euler(lookAtAngleX,0,0)
local angleZ=airEntitySystem:getEntityZAngle(self.caster,self.target,quaternion)
ent.entity:SetYZDir(lookAtAngleX,0,angleZ)

local bangle=180-bounds[5]
local cangle=angle-bangle/2
ent:setColliderRotation(-1,Vector3.New(0,cangle,0))

self.model=1
local speed=behaviorValue[5]or 50
local dis=Vector3.Distance(cpos,pos)
local ctime=dis/speed
ent.entity:MoveToWorldPositionByDoTweenDuration(pos,DG.Tweening.Ease.Linear,ctime,0,function()
ent:enableCollider(-1,true)
self.model=2
ent:runSpineAnimator(1016)

self.damageTime=damageTime+Time.realtimeSinceStartup
local time=damageTime>duration and damageTime or duration
self.destroyTime=time+Time.realtimeSinceStartup+0.1
end)
end