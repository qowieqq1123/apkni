airEntitySystem={}

local t_remove=table.remove
local _GUID=0

function airEntitySystem:onAppStart()

end

function airEntitySystem:onEnterState(isReconnect)

end


function airEntitySystem:onLeaveState(isReconnect)
airEntitySystem:leaveAirGame()
end

function airEntitySystem:onProtocolReq(isReconnect)

end

function airEntitySystem:startEnterAirGame()

end

function airEntitySystem:enterAirGame()

self.entities={}
self.removeEntities={}
self.everyListenLookup={}
self.listenLookup={}
_GUID=0
airEntitySystem:addEntityAction()
end

function airEntitySystem:leaveAirGame()
airEntitySystem:removeEntityAction()
airEntitySystem:clearAllEntity()

self.entities=nil
self.removeEntities=nil
self.everyListenLookup=nil
self.listenLookup=nil
_GUID=0
end

function airEntitySystem:onUpdate()
for _,ent in pairs(self.entities)do
if not ent.isDelete then
ent:onUpdate()
end
end
end


function airEntitySystem:onFastUpdate()
for _,ent in pairs(self.entities)do
if not ent.isDelete then
ent:onFastUpdate()
end
end
end


function airEntitySystem:createRoleEntity(voc,args)
local entityType=eAirEntityType.TYPE_ROLE
local vis=true
local vocCfg=cfg_airvocationconfig_get(voc)

local handle=AIR.AirEntityManager.CreateEntity(entityType,0,0,0,vis,true)

local teamType=eAirEntityTeam.eRole

local ent=airEntitySystem:createScript(entityType,handle,vocCfg,'',teamType,args)
airEntitySystem:addEntity(handle,ent)
airActorSystem:setActor(ent)
return ent
end

function airEntitySystem:createRoleWeapon(offsetX,offsetY,offsetZ,weaponId,owner)
offsetX=offsetX or 0
offsetY=offsetY or 0
offsetZ=offsetZ or 0
local entityType=eAirEntityType.TYPE_WEAPON
local cfg=cfg_airweaponconfig_get(weaponId)
local roleHandle=owner.handle
local args={owner=owner}
local handle=AIR.AirEntityManager.CreateChildEntity(roleHandle,entityType,offsetX,offsetY,offsetZ,true)
local ent=airEntitySystem:createScript(entityType,handle,cfg,nil,owner.teamType,args)
airEntitySystem:addEntity(handle,ent)
return ent
end

function airEntitySystem:copyEntitySkill(entity,sameParent,skillType,owner,caster,target,actionCfg,args)
local setRoot=true
if sameParent then setRoot=false end
local handle=AIR.AirEntityManager.CopyEntity(entity.handle,true,setRoot)
args=args or{}
local entityType=eAirEntityType.TYPE_SKILL
local teamType=owner.teamType
if teamType==eAirEntityTeam.eMonster then
entityType=eAirEntityType.TYPE_MONSTER_SKILL
end
local ent=airEntitySystem:createSkillScript(skillType,entityType,handle,actionCfg,nil,teamType,args)
airEntitySystem:addEntity(handle,ent)
return ent
end

function airEntitySystem:createEntityDeadSkill(entity,skillId,target,args)
local setRoot=true

local handle=AIR.AirEntityManager.CopyEntity(entity.handle,false,false)
local args={caster=entity,skillid=skillId,target=target,args=args}
local entityType=eAirEntityType.TYPE_MONSTER_DEAD
local teamType=entity.teamType
local cfg=entity.entityCfg
local ent=airEntitySystem:createScript(entityType,handle,cfg,nil,teamType,args)
airEntitySystem:addEntity(handle,ent)
return ent
end

function airEntitySystem:createReplaceEntity(entity,target,args)
local args={caster=entity,target=target,args=args}
local handle=airEntitySystem:getGUID()
local entityType=eAirEntityType.TYPE_ENTITY_REPLACE
local teamType=entity.teamType
local cfg=entity.entityCfg
local ent=airEntitySystem:createScript(entityType,nil,cfg,nil,teamType,args)
airEntitySystem:addEntity(handle,ent)
return ent
end



function airEntitySystem:createRoleHaloSkill(offsetX,offsetY,offsetZ,skillType,caster,actionCfg,args)
offsetX=offsetX or 0
offsetY=offsetY or 0
offsetZ=offsetZ or 0
local entityType=eAirEntityType.TYPE_SKILL
local roleHandle=caster.handle
args=args or{}
args.owner=caster
local teamType=caster.teamType

local handle=AIR.AirEntityManager.CreateChildEntity(roleHandle,entityType,offsetX,offsetY,offsetZ,true)
if teamType==eAirEntityTeam.eMonster then
entityType=eAirEntityType.TYPE_MONSTER_SKILL
end
local ent=airEntitySystem:createSkillScript(skillType,entityType,handle,actionCfg,nil,teamType,args)
airEntitySystem:addEntity(handle,ent)
return ent
end

function airEntitySystem:createMonsterEntity(id,x,y,vis,args)
local entityType=eAirEntityType.TYPE_MONSTER
if vis==nil then vis=true end
local cfg=cfg_airemonsterconfig_get(id)
local handle=AIR.AirEntityManager.CreateEntity(entityType,x,0,y,vis,true)
local monsterType=cfg.monsterType
entityType=airConfig.getMonsterType(monsterType)
local teamType=eAirEntityTeam.eMonster

local ent=airEntitySystem:createScript(entityType,handle,cfg,nil,teamType,args)


airEntitySystem:addEntity(handle,ent)

airHUDSystem:createHpHUD(entityType,handle)
return ent
end


function airEntitySystem:createSkillEntity(skillType,owner,caster,target,actionCfg,args)
args=args or{}
local entityType=eAirEntityType.TYPE_SKILL
local pos=args.pos or airEntitySystem:getCenterPos(actionCfg,target,owner,caster)
if args.offset then
pos.x=pos.x+args.offset[1]
pos.z=pos.z+args.offset[2]
end
local handle=AIR.AirEntityManager.CreateEntity(entityType,pos.x,0,pos.z,true)
local teamType=owner.teamType
if teamType==eAirEntityTeam.eMonster then
entityType=eAirEntityType.TYPE_MONSTER_SKILL
end
local ent=airEntitySystem:createSkillScript(skillType,entityType,handle,actionCfg,nil,teamType,args)
airEntitySystem:addEntity(handle,ent)
return ent
end


function airEntitySystem:createDropEntity(x,y,id,args)
local entityType=eAirEntityType.TYPE_DROP
local handle=AIR.AirEntityManager.CreateEntity(entityType,x,0,y,true,true)
local teamType=eAirEntityTeam.eNeutral
local cfg=cfg_airdropconfig_get(id)

local ent=airEntitySystem:createScript(entityType,handle,cfg,nil,teamType,args)
airEntitySystem:addEntity(handle,ent)
airDropSystem:addDropEnt(ent)
return ent
end


function airEntitySystem:createMaskEntity(x,y,bundle,asset,action)
local entityType=eAirEntityType.TYPE_OTHER
local handle=AIR.AirEntityManager.CreateEntity(entityType,x,0,y,true,true)
local args={}
args.bundle=bundle
args.asset=asset
args.action=action
local ent=airEntitySystem:createOtherScript(eAirOtherEntityType.eMonsterMask,handle,nil,nil,nil,args)
airEntitySystem:addEntity(handle,ent)
return ent
end


function airEntitySystem:createHarmEntity(action)
local entityType=eAirEntityType.TYPE_OTHER
local handle=AIR.AirEntityManager.CreateEntity(entityType,0,0,0,true,true)
local args={}
args.action=action
local ent=airEntitySystem:createOtherScript(eAirOtherEntityType.eHarm,handle,nil,nil,nil,args)
airEntitySystem:addEntity(handle,ent)
return ent
end


function airEntitySystem:createTower(owner,id,x,z)
local bundle=globalABLookup.airmainicons
local asset=cfgHelper.get2(cfg_airtoweronfig_get,id,'warnIcon')
local action=function()
if not airLevelSystem:isLevelDoing()then return end
airEntitySystem:createTowerEntity(owner,id,x,z)
end
airEntitySystem:createMaskEntity(x,z,bundle,asset,action)
end


function airEntitySystem:createTowerEntity(owner,id,x,z)
local handle=AIR.AirEntityManager.CreateEntity(eAirEntityType.TYPE_SUMMON,x,0,z,true,true)
local teamType=owner.teamType
local cfg=cfg_airtoweronfig_get(id)
local args={owner=owner}
local ent=airEntitySystem:createScript(eAirEntityType.TYPE_TOWER,handle,cfg,nil,teamType,args)
airEntitySystem:addEntity(handle,ent)
owner:addSummon(ent)
return ent
end


function airEntitySystem:createTrap(owner,trapId,x,z)
local bundle=globalABLookup.airmainicons
local asset=cfgHelper.get2(cfg_airtraponfig_get,trapId,'warnIcon')
local action=function()
if not airLevelSystem:isLevelDoing()then return end
airEntitySystem:createTrapEntity(owner,trapId,x,z)
end
airEntitySystem:createMaskEntity(x,z,bundle,asset,action)
end


function airEntitySystem:createTrapEntity(owner,id,x,z)
local handle=AIR.AirEntityManager.CreateEntity(eAirEntityType.TYPE_SUMMON,x,0,z,true,true)
local teamType=owner.teamType
local cfg=cfg_airtraponfig_get(id)
local args={owner=owner}
local ent=airEntitySystem:createScript(eAirEntityType.TYPE_TRAP,handle,cfg,nil,teamType,args)
airEntitySystem:addEntity(handle,ent)
owner:addSummon(ent)
return ent
end


























function airEntitySystem:createScript(entityType,...)
airEntitySystem:preloadEntity(entityType)
local info=airEntitySystem:getEntityInfo(entityType)
return info.ctor(entityType,...)
end

function airEntitySystem:createOtherScript(otherType,...)
airEntitySystem:preloadOtherEntity(otherType)
local info=airEntitySystem:getOtherEntityCtor(otherType)
return info.ctor(otherType,...)
end

function airEntitySystem:createSkillScript(skillType,entityType,...)
airEntitySystem:preloadSkill(skillType)
local info=airEntitySystem:getSkillInfo(skillType)
return info.ctor(entityType,...)
end








function airEntitySystem:getGUID()
_GUID=_GUID-1
return _GUID
end

function airEntitySystem:getEntities()
return self.entities
end

function airEntitySystem:addEntity(handle,ent)
self.entities[handle]=ent

end

function airEntitySystem:getEntity(handle)
return self.entities[handle]
end

function airEntitySystem:getEntitysByEntityType(entityType)
local entities={}
for k,v in pairs(self.entities)do
if v.entityType==entityType then
entities[#entities+1]=v
end
end
return entities
end

function airEntitySystem:deleteEntityObj(handle,delay)
if delay==nil then delay=0 end
if handle==nil then return end
local ent=self.entities[handle]
if ent==nil then return end

airController.getManagerStatic().DeleteEntity(handle,delay)

airHUDSystem:onRemoveEntity(handle)
self.entities[handle]=nil
end

function airEntitySystem:clearAllEntity(finishLevel)
if self.entities==nil then return end
local removing={}
for handle,v in pairs(self.entities)do
if not finishLevel or
airEntitySystem:isClearEntityByFinishLevel(v)then
removing[#removing+1]={handle,v}
end
end

for k,v in pairs(removing)do
local ent=v[2]
if not finishLevel then
ent:onDeleteBefore()
end
ent:deleteEntity()
end
end

function airEntitySystem:onLevelStart()
for _,v in pairs(self.entities)do
v:onStartLevel()
end
end


function airEntitySystem:isClearEntityByFinishLevel(entity)
local entityType=entity.entityType
if entityType==eAirEntityType.TYPE_ROLE then return false end
if entityType==eAirEntityType.TYPE_WEAPON then return false end
return true
end

function airEntitySystem:addEntityAction()

local instance=airController.getManagerInstance()





instance:SetRayHitAction(function(...)
airEntitySystem:onEntityHit(...)
end)


instance:SetTriggerEnterAction(function(...)
airEntitySystem:onTriggerEnterAction(...)
end)


instance:SetTriggerExitAction(function(...)
airEntitySystem:onTriggerExitAction(...)
end)
end

function airEntitySystem:removeEntityAction()

local instance=airController.getManagerInstance()

if instance==nil then return end

instance:SetRayHitAction(nil)

instance:SetTriggerEnterAction(nil)

instance:SetTriggerExitAction(nil)
end

function airEntitySystem:onTriggerEnterAction(handle1,handle2,guid1,guid2)
local ent1=self.entities[handle1]
local ent2=self.entities[handle2]

if ent1==nil then
loggerUtil.logErrFMT('实体{0}是否已销毁？',handle1)
return
end
if ent2==nil then
loggerUtil.logErrFMT('实体{0}是否已销毁？',handle2)
return
end
ent1:onTriggerEnter(ent2,guid1,guid2)
end


function airEntitySystem:onTriggerExitAction(handle1,handle2,guid1,guid2)
local ent1=self.entities[handle1]
local ent2=self.entities[handle2]
if ent1==nil then
loggerUtil.logErrFMT('实体{0}是否已销毁？',handle1)
return
end
if ent2==nil then
loggerUtil.logErrFMT('实体{0}是否已销毁？',handle2)
return
end
ent1:onTriggerExit(ent2,guid1,guid2)
end


function airEntitySystem:onEntityHit(handle)
local ent=self.entities[handle]
ent:onClick()
end

function airEntitySystem:getDistance(handle1,handle2)
return airController.getManagerStatic().EntityDistance2D(handle1,handle2)
end

function airEntitySystem:getDistance2D(handle,x,z)
return airController.getManagerStatic().Distance2D(handle,x,z)
end

function airEntitySystem:getPosition2D(entity)
local pos=entity:getPosition()
return pos.x,pos.z
end

function airEntitySystem:getPosition(entity)
return entity:getPosition()
end

function airEntitySystem:getAoundYAngle(handle1,handle2)
return airController.getManagerStatic().GetEntityXAngle(handle1,handle2)
end

function airEntitySystem:getEntityZAngle(ent1,ent2,quaternion)
local pos=ent2:getPosition()
return airController.getManagerStatic().GetEntityZAngle(ent1.handle,pos,quaternion)
end

function airEntitySystem:getAroundZAngle(pos1,pos2,quaternion)
return airController.getManagerStatic().GetAroundZAngle(pos1,pos2,quaternion)
end


function airEntitySystem:getSignedAngle(pos1,pos2,axis)
return airController.getManagerStatic().SignedAngle(pos1,pos2,axis)
end



function airEntitySystem:getAoundAngle(handle1,handle2,form,roundAxis)
return airController.getManagerStatic().SignedEntityAngle(handle1,handle2,form,roundAxis)
end

function airEntitySystem:getCenterPos(actionCfg,target,owner,caster)
local pos
local centerType=actionCfg.centerType
local rangeType=actionCfg.rangeType
local rangeArgs=actionCfg.rangeArgs
if centerType==eAirSkillCenterType.eTarget then
pos=airEntitySystem:getPosition(target)
elseif centerType==eAirSkillCenterType.eSelf then
if rangeType==eAirSkillRangeType.eRect then
local distance=rangeArgs[1]/2
pos=airEntitySystem:getDistancePoint(owner,target,distance)
else
pos=airEntitySystem:getPosition(owner)
end
elseif centerType==eAirSkillCenterType.eWeapon then
if rangeType==eAirSkillRangeType.eRect then
local distance=rangeArgs[1]/2
pos=airEntitySystem:getDistancePoint(caster,target,distance)
else
pos=airEntitySystem:getPosition(caster)
end
end
return pos
end

function airEntitySystem:getDirectionPosition(origin,angle,distance,clamp)
local angleRadius=angle*Mathf.Deg2Rad
local deltaX=distance*Mathf.Cos(angleRadius)
local deltaZ=distance*Mathf.Sin(angleRadius)
local posX=origin.x+deltaX
local posZ=origin.z+deltaZ
if clamp~=false then
posX,posZ=airMapSystem:clamp(posX,posZ)
end
return Vector3.New(posX,origin.y,posZ)
end


function airEntitySystem:getEntityDirection(owner,target)
local startPos=owner:getPosition()
local endPos=target:getPosition()
local x=endPos.x-startPos.x
local z=endPos.z-startPos.z
return Vector3.New(x,endPos.y,z)
end

function airEntitySystem:getDistancePoint(owner,target,distance,clamp)
local pos=owner:getPosition()
local direction=airEntitySystem:getEntityDirection(owner,target)
local normalize=Vector3.Normalize(direction)
local posX=pos.x+normalize.x*distance
local posZ=pos.z+normalize.z*distance
if clamp~=false then
posX,posZ=airMapSystem:clamp(posX,posZ)
end
return Vector3.New(posX,pos.y,posZ)
end




function airEntitySystem:listenEntityNotify(func)
self.listenLookup[func]=true
end

function airEntitySystem:removeEntityNotify(func)
self.listenLookup[func]=nil
end



function airEntitySystem:listenEveryEntityDeleteAction(handle,func)
self.everyListenLookup[handle]=func
end

function airEntitySystem:removeEveryEntityDeleteAction(handle)
self.everyListenLookup[handle]=nil
end

function airEntitySystem:postRemoveEntity(handle)
for handle_,func in pairs(self.everyListenLookup)do
if handle_~=handle then
func(handle)
end
end

for func,_ in pairs(self.listenLookup)do
func(handle)
end
end

function airEntitySystem:playEffect(effectId,pos,flipX,scale)
local static=airController.getManagerStatic()
return static.PlayEffect(effectId,pos,flipX,scale)
end

function airEntitySystem:playMoveEffect(effectId,param,srcPos,endPos,onFinish,scale)
local static=airController.getManagerStatic()
static.PlayMoveEffect(effectId,param,srcPos,endPos,onFinish,scale)
end

function airEntitySystem:playCameraEffect(effectId,offsetPos,flipX,scale)
local static=airController.getManagerStatic()
static.PlayCameraEffect(effectId,offsetPos,flipX,scale)
end

function airEntitySystem:clampSpeed(speed)
local speedRange=cfg_airroleconfig_get(1).speedRange
local min=speedRange[1]
local max=speedRange[2]
speed=math.min(max,speed)
speed=math.max(min,speed)
return speed
end


function airEntitySystem:pauseAllEntitys(flag)
if self.entities and next(self.entities)then
for k,v in pairs(self.entities)do
v:setPauseUpdate(flag)
end
end
end

function airEntitySystem:getEntityOffsetPos(posX,posZ,count)
count=count or 1
local value=math.ceil(count/2)
local offsetList={}
for i=1,count do
offsetList[#offsetList+1]=i-1
end
mathHelper.randomList(offsetList)
local randomOp={{1,1},{1,-1},{-1,1},{-1,-1}}
mathHelper.randomList(randomOp)
local opIdx=0
local ratioIdx=0
local posList={}
local index=1
local offsetIndex=1
while index<=count do
local offsetMin=offsetList[offsetIndex]
local offsetMax=offsetList[offsetIndex+1]or offsetList[1]
if offsetMin==nil then
offsetIndex=1
offsetMin=offsetList[offsetIndex]
offsetMax=offsetList[offsetIndex+1]or offsetList[1]
end
opIdx=opIdx+1
if opIdx>4 then opIdx=1 end
local op=randomOp[opIdx]
local offset=math.random(offsetMin*10,offsetMax*10)/5
local x=posX+op[1]*offset
local z=posZ+op[2]*offset
if airMapSystem:isInMap(x,z)then
posList[index]={x,z}
index=index+1
end
end
return posList
end

function airEntitySystem:getEntityRandomPos(posX,posZ,min,max,count)
local angleCount=0
local posList={}
local index=1
min=math.floor(min*100)
max=math.floor(max*100)

while index<=count do
local angle=math.random(angleCount,360)*Mathf.Deg2Rad
local radius=math.random(min,max)
radius=radius/100
local x=posX+radius*Mathf.Cos(angle)
local z=posZ+radius*Mathf.Sin(angle)
if airMapSystem:isInMap(x,z)then
posList[index]={x,z}
index=index+1
end
angleCount=angleCount+1
if angleCount>10000 then
break
end
end

if index<count then
for i=index,count do
posList[i]={posX,posZ}
end
end
return posList
end
