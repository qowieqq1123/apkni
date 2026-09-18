skillRangeCheck=simple_class(baseEntity)


function skillRangeCheck:initialize(args)
self.owner=args.owner
self.caster=args.caster
self.target=args.target
self.action=args.action
self.skillCfg=args.skillCfg

local actionCfg=self.entityCfg
self.actionCfg=actionCfg

local bounds=table.deepCopy(args.bounds)
local boundType=args.boundType
local angle=args.angle or 0

local centerOffset=args.centerOffset

local effectArgs=args.effectArgs


local rangeType=actionCfg.rangeType


if boundType==nil then
local rangeArgs=actionCfg.rangeArgs
boundType,bounds=airSkillSystem:getBounds(rangeType,rangeArgs)
end
if centerOffset then
bounds[1]=centerOffset[1]
bounds[2]=centerOffset[2]
bounds[3]=centerOffset[3]
end

if boundType==nil then
loggerUtil.logErrFMT("碰撞体类型为空 actionid {0}",actionCfg.id)
self:deleteEntity()
return
end

self.rangeType=rangeType
self.boundType=boundType
self.bounds=bounds
self.effectArgs=effectArgs

self.rotateAnim=args.rotateAnim

self.entity.transform.rotation=Quaternion.Euler(0,angle,0)

if args.startWait and args.startWait>0 then
self.startWaitTime=args.startWait+Time.realtimeSinceStartup
else
self:start()
end

end

function skillRangeCheck:start()
if self==nil or self:isDeleteSelf()then return end

local colliderCfg=airConfig.getEntityColliderConfig(self.entityType)
local offsetYAngle=0
if self.rangeType==eAirSkillRangeType.eFan then
offsetYAngle=self.bounds[5]/2
end

self:addMainCollider(colliderCfg.layer,Vector3.New(0,offsetYAngle,0),self.boundType,self.bounds,colliderCfg.isTrigger,colliderCfg.kinematic,colliderCfg.interpolate,colliderCfg.detection)

local effectArgs=self.effectArgs
if effectArgs then
if effectArgs[2]==0 then
self.effectHandle=self.staticAuto.BaseEntity_PlayEffect(self.handle,effectArgs[1],Vector3.zero,Vector3.New(effectArgs[3],effectArgs[3],effectArgs[3]),true,true)
else
self.playEffectTime=effectArgs[2]+Time.realtimeSinceStartup
self.effectArgs=effectArgs
end
end

if self.rotateAnim then
if not self.rotateAnim[3]or self.rotateAnim[3]==0 then
local time=self.rotateAnim[2]
local tweener=Lua.DOTweenProxyExtensions.DOLocalRotate(self.entity.transform,self.entity.transform.rotation.eulerAngles+Vector3.New(0,self.rotateAnim[1]==0 and 360 or-360,0),time,DG.Tweening.RotateMode.FastBeyond360)
tweener:SetLoops(-1,DG.Tweening.LoopType.Incremental)
self.rotateTweener=tweener
else
self.rotateAnimDelay=self.rotateAnim[3]+Time.realtimeSinceStartup
end
end
end

function skillRangeCheck:deleteEntity()
local handle=self.handle
if self.action and self.action.onDeleteSkill then
self.action:onDeleteSkill(handle)
end

self:onDelete()
end

function skillRangeCheck:onDelete()
if self==nil or self:isDeleteSelf()or self.entity==nil then return end

if self.rotateTweener then
self.rotateTweener:Kill()
end
self.rotateTweener=nil

self._base.onDelete(self)
if self.effectHandle then
_stopEffect(self.effectHandle)
end
self.effectHandle=nil
self.caster=nil
self.owner=nil
self.target=nil
self.action=nil
self.actionCfg=nil
self.skillCfg=nil
self.rotateAnimDelay=nil
end

function skillRangeCheck:onUpdate()
self._base.onUpdate(self)
end

function skillRangeCheck:onFastUpdate()
self._base.onFastUpdate(self)

local pauseTime=airLevelSystem:getPauseTime()
if self.startWaitTime and self.startWaitTime+pauseTime<=Time.realtimeSinceStartup then
self:start()
self.startWaitTime=nil
end

if self.playEffectTime and self.playEffectTime+pauseTime<=Time.realtimeSinceStartup then
self.effectHandle=self.staticAuto.BaseEntity_PlayEffect(self.handle,self.effectArgs[1],Vector3.zero,Vector3.New(self.effectArgs[3],self.effectArgs[3],self.effectArgs[3]),true,true)
end

if self.rotateAnimDelay and self.rotateAnimDelay+pauseTime<=Time.realtimeSinceStartup then
local time=self.rotateAnim[2]
local tweener=Lua.DOTweenProxyExtensions.DOLocalRotate(self.entity.transform,self.entity.transform.rotation.eulerAngles+Vector3.New(0,self.rotateAnim[1]==0 and 360 or-360,0),time,DG.Tweening.RotateMode.FastBeyond360)
tweener:SetLoops(-1,DG.Tweening.LoopType.Incremental)
self.rotateTweener=tweener
self.rotateAnimDelay=nil
end
end

function skillRangeCheck:onPause()
self._base.onPause(self)
end

function skillRangeCheck:onContinue()
self._base.onContinue(self)
end

function skillRangeCheck:deleteEntity()
local handle=self.handle
if not self:isActionDelete()then
self.action:onDeleteSkill(handle)
end
self:onDelete()
end

function skillRangeCheck:onTriggerEnterMonster(entity)
if self:isActionDelete()then return end
if self.action.onTriggerEnterSkillCheck then
self.action:onTriggerEnterSkillCheck(entity,self.handle)
end
end

function skillRangeCheck:onTriggerExitMonster(entity)
if self:isActionDelete()then return end
if self.action.onTriggerExitSkillCheck then
self.action:onTriggerExitSkillCheck(entity,self.handle)
end
end

function skillRangeCheck:isActionDelete()
return self.action==nil or self.action:isDeleteSelf()
end

function skillRangeCheck:disableCollider()
if self.entity then
self.entity:EnableCollider(-1,false)
end
end