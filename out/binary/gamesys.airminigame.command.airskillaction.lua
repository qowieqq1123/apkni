


airSkillAction=simple_class({})
local guid=0

function airSkillAction:__init(skillCfg,actionCfg,acionValue,behaviorValue,owner,caster,target,args)
guid=guid+1
self.guid=guid
self.skillCfg=skillCfg
self.actionCfg=actionCfg
self.acionValue=acionValue
self.behaviorValue=behaviorValue
self.behavourType=actionCfg.behavourType
self.args=args
self.owner=owner
self.caster=caster
self.target=target
self.command=args.command
self.executeCnt=1
local targetReleation=actionCfg.targetReleation
self.targetReleation=targetReleation
if targetReleation==eAirSkillTargetType.eSelf then
self.target=self.owner
end
self.extraTargetReleation=actionCfg.extraTargetReleation
self.enemyEntites={}
self.enemyEntitesNum=0
self.skillEnts={}
self.isDelete=false
self.targetMaxCount=self.actionCfg.targetMaxCount or 99999
self._onRemoveEntity=function(...)
self:onRemoveEntity(...)
end
airEntitySystem:listenEntityNotify(self._onRemoveEntity)

if self.target==nil and actionCfg.centerType==eAirSkillCenterType.eTarget then
loggerUtil.logErrFMT("职业技能作用的中心点类型不能为1,作用{0}",actionCfg.id)
end

self.centerPos=airEntitySystem:getCenterPos(actionCfg,self.target,self.owner,self.caster)
self:initalize(args)
self.isStart=true
end


function airSkillAction:initalize(args)
local actionCfg=self.actionCfg
local acionValue=self.acionValue
local behaviorValue=self.behaviorValue
local targetReleation=actionCfg.targetReleation
local rangeType=actionCfg.rangeType
if actionCfg.behavourType==nil then
if rangeType==eAirSkillRangeType.eSingle then
self:executeSingleDamage(self.target)
return
end
end
self:createEntity()
end

function airSkillAction:recycleSelf()
local guid=self.guid
if self.command and not self.command:isDeleteSelf()then
self.command:onActionDelete(guid)
end
local command=self.command
self:onDelete()
if command then
command:checkRecycleSelf()
end
end

function airSkillAction:onDelete()
if self.isDelete then return end
if self.skillEnts then
for k,v in pairs(self.skillEnts)do
v:deleteEntity()
end
end
if self._onRemoveEntity then
airEntitySystem:removeEntityNotify(self._onRemoveEntity)
end
self.command=nil
self.skillEnts=nil
self.owner=nil
self.caster=nil
self.target=nil
self.acionValue=nil
self.actionCfg=nil
self.enemyEntites=nil
self.skillCfg=nil
self.penetrateNum=nil
self.penetrateReduce=nil
self.enemyEntitesNum=nil
self.executeCnt=nil
self.extraTargetReleation=nil
self.targetReleation=nil
self.behaviorValue=nil
self.behavourType=nil
self.targetMaxCount=nil
self.isDelete=true
self.isStart=false
end

function airSkillAction:onPause()

end

function airSkillAction:onContinue()

end

function airSkillAction:onUpdate()

end

function airSkillAction:onFastUpdate()
if self:isDeleteSelf()then return end
self.executeCnt=self.executeCnt-1
if self.executeCnt==0 then
self:executeDamage()
self:recycleSelf()
end
end

function airSkillAction:onDeleteSkill(handle)
self.skillEnts[handle]=nil
end

function airSkillAction:isDeleteSelf()
return self.isDelete==true or self.isDelete==nil
end

function airSkillAction:hasSkillEnts()
return self.skillEnts~=nil and next(self.skillEnts)~=nil
end

function airSkillAction:getTargetArgs()
return{
owner=self.owner,
target=self.target,
skillCfg=self.skillCfg,
caster=self.caster,
action=self,
behaviorValue=self.behaviorValue,
}
end

function airSkillAction:createEntity(skillEntityType,angle,args_,target)
target=target or self.target
local args=self:getTargetArgs()
skillEntityType=skillEntityType or eAirSkillEntityType.eCommon

args.angle=angle or
args_ and args_.angle or
airSkillSystem:getAngle(self.actionCfg,self.owner,self.caster,target)

if args_ then
args=table.concatPairs(args,args_)
end

args.target=target

local ent=airEntitySystem:createSkillEntity(skillEntityType,self.owner,self.caster,target,self.actionCfg,args)
if not ent.isDelete then
self.skillEnts[ent.handle]=ent
end
end


function airSkillAction:executeDamage(disableCollider)
local caster=self.caster

if caster==nil or caster:isDeleteSelf()then return end

local actionCfg=self.actionCfg
local targetMaxCount=actionCfg.targetMaxCount or 99999
local pos=self.centerPos
local list={}
for i,entity in pairs(self.enemyEntites)do
local distance=airEntitySystem:getDistance2D(entity.handle,pos.x,pos.z)
list[#list+1]={distance,entity}
end
table.sort(list,function(a,b)
return a[1]<b[1]
end)
local num=#list

local max=math.min(num,targetMaxCount)

for i,v in ipairs(list)do
local entity=v[2]
local ret=self:executeSingleDamage(entity)
if ret then
max=max-1
if max<=0 then
break
end
end
end


if disableCollider~=false then
self:disableMainCollider()
end
end


function airSkillAction:executeSingleDamage(target)
return airSkillSystem:executeSingleDamage(self.owner,target,self.caster,self.skillCfg,self.actionCfg,self.acionValue,self.args)
end

function airSkillAction:disableMainCollider()
for _,ent in pairs(self.skillEnts)do
ent:enableCollider(-1,false)
end
end


function airSkillAction:onTriggerEnterMonster(entity)
if self.enemyEntitesNum>self.targetMaxCount then return false end
if not self:checkCastEnity(entity)then return false end

local handle=entity.handle
if self.enemyEntites[handle]then return false end

self.enemyEntites[handle]=entity
self.enemyEntitesNum=self.enemyEntitesNum+1

return true
end

function airSkillAction:onTriggerExitMonster(entity)
local handle=entity.handle
if self.enemyEntites[handle]==nil then return end

self.enemyEntitesNum=self.enemyEntitesNum-1
self.enemyEntites[handle]=nil
end

function airSkillAction:checkCastEnity(target)
return airSkillSystem:checkCastEnity(self.owner,target,self.actionCfg)
end

function airSkillAction:onRemoveEntity(handle)
if self.enemyEntites[handle]==nil then return end

self.enemyEntitesNum=self.enemyEntitesNum-1
self.enemyEntites[handle]=nil
end