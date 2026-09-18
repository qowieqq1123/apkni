
baseEntity=simple_class({})

function baseEntity:__init(entityType,handle,cfg,name,teamType,...)
self.managerStatic=airController.getManagerStatic()
self.staticAuto=airController.getManagerStaticAuto()
self.manager=airController.getManagerInstance()
self.mapManager=airController.getMapManager()
self.defineStatic=airController.getDefineStatic()

self.handle=handle
self.entityCfg=cfg or{}
self.entityType=entityType
self.name=name or cfg and cfg.name
self.visable=true
if self.handle then
self.entity=self.managerStatic.GetEntity(self.handle)
end
self.lookAtAngleX=30
self.isRemoving=false
self.teamType=teamType
self.__register=nil
self.__registerOgi=nil
if handle and handle>0 then
local sortingLayer=self:getSortingLayer()
self:setSortingGroup(sortingLayer,handle)
end
self.colliders={}
self.pause=nil
self.removeDelay=0
self.curRemoveDelay=0
self.isDelete=false
self.isSpineAsset=false
self.isSpriteAsset=false
self.flipX=nil
self:initialize(...)
end

function baseEntity:initialize(...)

end

function baseEntity:onUpdate()

end

function baseEntity:onFastUpdate()

end

function baseEntity:onDelete(delay)
if self==nil or self:isDeleteSelf()then return end
self:removePostDelete()
self:postDelete()
self.isDelete=true
if self.pause and self.handle then
self.staticAuto.BaseEntity_SetPause(self.handle,false)
end
self:disableAllCollider()
airEntitySystem:deleteEntityObj(self.handle,delay)
self:stopAllNotify()
self.colliders=nil
self.handle=nil
self.id=nil
self.entityCfg=nil
self.entityType=nil
self.name=nil
self.visable=nil
self.isRemoving=nil
self.pause=nil
self.removeDelay=nil
self.curRemoveDelay=nil
self.lookAtAngleX=nil
self.isSpineAsset=nil
self.isSpriteAsset=nil
self.bounds=nil
self.flipX=nil
self.order=nil
end

function baseEntity:onPause()
self.pause=true
end

function baseEntity:onContinue()
self.pause=false
end


function baseEntity:postDelete()
airEntitySystem:postRemoveEntity(self.handle)
end

function baseEntity:addPostDelete()
if self.isAddPost==true then return end
self.isAddPost=true
airEntitySystem:listenEveryEntityDeleteAction(self.handle,function(...)
self:onRemoveEntity(...)
end)
end

function baseEntity:removePostDelete()
if not self.isAddPost then return end
self.isAddPost=nil
airEntitySystem:removeEveryEntityDeleteAction(self.handle)
end

function baseEntity:onRemoveEntity()

end

function baseEntity:isDeleteSelf()
return self.isDelete==true or self.isDelete==nil
end

function baseEntity:onStartLevel()

end


function baseEntity:onDeleteBefore()

end

function baseEntity:deleteEntity()
if self:isDeleteSelf()then return end
local delay=self.entityCfg and self.entityCfg.deadTime or 0
if delay>0 then
self:onPlayDespawnAni()
end
self:onDelete(delay)
end

function baseEntity:onPlayDespawnAni()

end

function baseEntity:getEntity()
return self.entity
end

function baseEntity:setActive(active)
if self.handle==nil then return end
self.visable=active
self.staticAuto.BaseEntity_SetEntityActive(self.handle,active)
end

function baseEntity:isRemoving()
return self.isRemoving==true
end

function baseEntity:isActive()
return self.visable==true
end

function baseEntity:getPosition()
if self.handle==nil then return end
return self.staticAuto.BaseEntity_GetPosition(self.handle)
end

function baseEntity:setPosition(pos)
if self.handle==nil then return end
return self.staticAuto.BaseEntity_SetPosition(self.handle,pos)
end

function baseEntity:getLocalPosition()
if self.handle==nil then return end
return self.staticAuto.BaseEntity_GetLocalPosition(self.handle)
end

function baseEntity:setLocalPosition(pos)
if self.handle==nil then return end
return self.staticAuto.BaseEntity_SetLocalPosition(self.handle,pos)
end


function baseEntity:setCanMove(flag)
if self.handle==nil then return end
self.canMove=flag
self.staticAuto.BaseEntity_CanMove_set(self.handle,flag)
end

function baseEntity:initEntityAttrs(floatTable,intTable,boolTable)
if self.handle==nil then return end
self.staticAuto.BaseEntity_InitAtts(floatTable,intTable,boolTable)
end

function baseEntity:getAttrValue(attributeType)

end


function baseEntity:getEntityConfig()
return self.entityCfg
end



function baseEntity:addMainColliderByCfg()
if self.handle==nil then return end
local cfg=self.entityCfg
local layer=self:getColliderLayer()
local bounds=cfg.bounds
local boundType=cfg.boundType
self.bounds=bounds
local colliderCfg=airConfig.getEntityColliderConfig(self.entityType)
self.colliderLength,self.colliderWidth,self.colliderHeight=airSkillSystem:getBodySize(boundType,bounds)
self:addMainCollider(layer,nil,boundType,bounds,
colliderCfg.isTrigger,colliderCfg.kinematic,colliderCfg.interpolate,colliderCfg.detection)
end

function baseEntity:addMainCollider(layer,angle,colliderType,bounds,isTrigger,kinematic,interpolate,detection)
return self:addCollider(-1,layer,angle,colliderType,bounds,isTrigger,kinematic,interpolate,detection)
end

function baseEntity:addCollider(guid,layer,angle,colliderType,bounds,isTrigger,kinematic,interpolate,detection)
if self.handle==nil then return end
if self.colliders[guid]then return end
angle=angle or Vector3.zero

if self.staticAuto.BaseEntity_CreateCollider(self.handle,guid,layer,angle,colliderType,bounds,
isTrigger,kinematic,interpolate,detection)then
self.colliders[guid]=true
self:enableCollider(guid,true)
end
end

function baseEntity:setMainColliderBounds(bounds)
self:setColliderBounds(-1,bounds)
end

function baseEntity:setColliderBounds(guid,bounds)
if not self.colliders[guid]then return end
if self.handle==nil then return end
self.staticAuto.BaseEntity_SetColliderBounds(self.handle,guid,bounds)
end

function baseEntity:enableCollider(guid,vis)
if not self.colliders[guid]then return end
if self.handle==nil then return end
self.staticAuto.BaseEntity_EnableCollider(self.handle,guid,vis)
end

function baseEntity:getColliderLayer()
return airConfig.getEntityColliderLayer(self.entityType)
end

function baseEntity:disableAllCollider()
if self.handle==nil then return end
for guid,_ in pairs(self.colliders)do
self.staticAuto.BaseEntity_EnableCollider(self.handle,guid,false)
end
end

function baseEntity:getColliderSize()
return self.colliderLength,self.colliderWidth,self.colliderHeight
end

function baseEntity:setColliderRotation(guid,angle)
if self.handle==nil then return end
self.staticAuto.BaseEntity_SetColliderRotation(self.handle,guid,angle)
end


function baseEntity:setSortingGroup(layer,order)
if self.handle==nil then return end
if order<-1 then order=math.abs(order)end
self.staticAuto.BaseEntity_SetSortingGroup(self.handle,layer,order)
end

function baseEntity:setSortingGroupLayerName(layer)
if self.handle==nil then return end
self.staticAuto.BaseEntity_SetSortingGroupLayerName(self.handle,layer)
end

function baseEntity:setSortingGroupLayer(order)
if self.handle==nil then return end
if order<-1 then order=math.abs(order)end
self.staticAuto.BaseEntity_SetSortingGroupOrder(self.handle,order)
end

function baseEntity:getSortingLayer()
return airConfig.getEntitySortingLayer(self.entityType)
end

function baseEntity:getSortingOrder()
local order=self.handle
if order<-1 then order=math.abs(order)end
return order
end

function baseEntity:setSpineSorting(layer,order)
if self.handle==nil then return end
if not self.isSpineAsset then return end
if order<-1 then order=math.abs(order)end
self.staticAuto.BaseEntity_SetSpineSortingLayer(self.handle,layer)
self.staticAuto.BaseEntity_SetSpineSortingOrder(self.handle,order)
end

function baseEntity:setSpriteSorting(layer,order)
if self.handle==nil then return end
if not self.isSpriteAsset then return end
if order<-1 then order=math.abs(order)end
self.staticAuto.BaseEntity_SetSpriteSortingGroup(self.handle,layer,order)
end

function baseEntity:setAssetSorting(layer,order)
if self.handle==nil then return end
if order<-1 then order=math.abs(order)end
self:setSpineSorting(self.handle,layer,order)
self:setSpriteSorting(self.handle,layer,order)
end


function baseEntity:setPauseUpdate(flag)
if flag==self.pause then return false end
if flag then
self:onPause()
else
self:onContinue()
end
if self.handle then
self.staticAuto.BaseEntity_SetPause(self.handle,flag)
end
return true
end

function baseEntity:getPauseTime()
return airLevelSystem:getPauseTime()
end

function baseEntity:lockDir(flag)
if self.entity==nil then return end
self.entity.SupportDIRAnimation=not flag
end

function baseEntity:faceToOffsetNow(x,y,offsetAngele,reverse)
if self.entity==nil then return end
if reverse==nil then reverse=false end
if offsetAngele==nil then offsetAngele=0 end
self.entity:FaceToWithOffset(x,y,0,offsetAngele,reverse)
end

function baseEntity:onHit()

end

function baseEntity:setAssetActive(flag)
self:setSpineActive(flag)
self:setSpriteActive(flag)
end

function baseEntity:setAssetLocalPosition(pos)
self:setSpineLocalPosition(pos)
self:setSpriteLocalPosition(pos)
end

function baseEntity:setAssetScale(scale)
if self.isSpineAsset then
self:setSpineScale(scale)
end
if self.isSpriteAsset then
self:setSpriteScale(scale)
end
end

function baseEntity:setAssetLocalRotation(rotation)
self:setSpineLocalRotation(rotation)
self:setSpriteLocalRotation(rotation)
end

function baseEntity:createSpineByCfg()
local model=self.entityCfg.spineid
if model==nil then return end
local scale=self.entityCfg.scale
self:createSpine(model,nil,scale)
end

function baseEntity:createSpine(model,slots,scale,action)
if self.handle==nil then return end
local sortingLayer=self:getSortingLayer()
local sortOrder=self:getSortingOrder()
self.isSpineAsset=true
self.staticAuto.BaseEntity_CreateSpine(self.handle,model,slots,sortingLayer,sortOrder,scale,function()
if self and not self.isClose then
self:loadSpineFinish()
if action then
action()
end
end
end)
end

function baseEntity:setSpineOffset(x,y)
if self.handle==nil then return end
self.staticAuto.BaseEntity_SetSpineActorOffset(self.handle,Vector3.New(x,y,0))
end

function baseEntity:loadSpineFinish()

end

function baseEntity:addMount(mountBodyID,mountSlots,mountHP,scale,offset,onMountFinish)
if self.handle==nil then return end
self.staticAuto.BaseEntity_MountSpine(self.handle,mountBodyID,mountSlots,mountHP,scale,offset,onMountFinish)
end

function baseEntity:twinkleSpine(color,duration)
if self.handle==nil then return end
if duration==nil then duration=0.1 end
self.staticAuto.BaseEntity_TwinkleSpine(self.handle,duration,color)
end

function baseEntity:setFlipX(flipX)
if self.handle==nil then return end
if self.flipX==flipX then return end
self.flipX=flipX
self.staticAuto.BaseEntity_SetSpineFlipX(self.handle,flipX)
end

function baseEntity:isFlipX()
return self.flipX
end


function baseEntity:setLocalRotation(rotation)
if self.handle==nil then return end
self.staticAuto.BaseEntity_SetLocalRotation(self.handle,rotation)
end

function baseEntity:lookAtTarget(target)
local jd=self:countTowardToTargetAngle(target)
self:setLocalRotation(Vector3.New(0,jd,0))
end

function baseEntity:lookAtPos(pos)
local jd=self:countTowardToPosAngle(pos)
self:setLocalRotation(Vector3.New(0,jd,0))
end

function baseEntity:countTowardToTargetAngle(target)
return self:countTowardToPosAngle(target:getPosition())
end

function baseEntity:countTowardToPosAngle(pos)
local dis=Vector3.__sub(pos,self:getPosition())
local hd=math.atan2(dis.x,dis.z)
local jd=hd*180/math.pi
return jd
end

function baseEntity:setSpineActive(flag)
if self.handle==nil then return end
self.staticAuto.BaseEntity_SetSpineActive(self.handle,flag)
end

function baseEntity:setSpineLocalPosition(pos)
if self.handle==nil then return end
self.staticAuto.BaseEntity_SetSpineLocalPosition(self.handle,pos)
end

function baseEntity:setSpineScale(scale)
if self.handle==nil then return end
self.staticAuto.BaseEntity_SetSpineScale(self.handle,scale)
end

function baseEntity:setSpineLocalRotation(rotation)
if self.handle==nil then return end
if not self.isSpineAsset then return end
self.staticAuto.BaseEntity_SetSpineLocalRotation(self.handle,rotation)
end

function baseEntity:runSpineAnimator(stateId)
self.managerStatic.RunSpineAnimator(self.handle,stateId)
end

function baseEntity:createSpriteByCfg()
local sprite=self.entityCfg.sprite
if sprite==nil then return end
local scale=self.entityCfg.scale
self.isSpriteAsset=true
self:setSpriteRender(sprite)
self:setSpriteScale(scale)
self:setSelfSpriteSortingGroup()
end

function baseEntity:setSpriteRender(sprite)
if self.handle==nil then return end
self.staticAuto.BaseEntity_SetSpriteRenderer(self.handle,sprite,true)
end

function baseEntity:setBundleSpriteRender(abname,sprite)
if self.handle==nil then return end
self.staticAuto.BaseEntity_SetSpriteRenderer(self.handle,abname,sprite,true)
end

function baseEntity:setSelfSpriteSortingGroup()
local sortingLayer=self:getSortingLayer()
self:setSpriteSortingGroup(sortingLayer)
end

function baseEntity:setSpriteSortingGroup(sortingLayer)
if self.handle==nil then return end
local order=self.handle
if order<-1 then order=math.abs(order)end
self.staticAuto.BaseEntity_SetSpriteSortingGroup(self.handle,sortingLayer,order)
end

function baseEntity:setSpriteActive(flag)
if self.handle==nil then return end
self.staticAuto.BaseEntity_SetSpriteActive(self.handle,flag)
end

function baseEntity:setSpriteLocalPosition(pos)
if self.handle==nil then return end
self.staticAuto.BaseEntity_SetSpriteLocalPosition(self.handle,pos)
end

function baseEntity:setSpriteScale(scale)
if self.handle==nil then return end
self.staticAuto.BaseEntity_SetSpriteRendererScale(self.handle,scale)
end

function baseEntity:setSpriteLocalRotation(rotation)
if self.handle==nil then return end
if not self.isSpriteAsset then return end
self.staticAuto.BaseEntity_SetSpriteRendererLocalRotation(self.handle,rotation)
end

function baseEntity:playEffect(effectId,offset,attach,removeWithEnity)
if self.handle==nil then return end
if removeWithEnity==nil then removeWithEnity=true end
if attach==nil then attach=true end
if offset==nil then offset=Vector3.zero end
return self.staticAuto.BaseEntity_PlayEffect(self.handle,effectId,offset,attach,removeWithEnity)
end

function baseEntity:playEffectWithOrder(effectId,offset,scale,attach,removeWithEnity,layer,order)
if self.handle==nil then return end
if removeWithEnity==nil then removeWithEnity=true end
if attach==nil then attach=true end
if offset==nil then offset=Vector3.zero end
if scale==nil then scale=Vector3.New(1,1,1)end
if layer==nil then layer=""end
if order==nil then order=-1 end
if order<-1 then order=math.abs(order)end
return self.staticAuto.BaseEntity_PlayEffectWithOrder(self.handle,effectId,offset,scale,attach,removeWithEnity,layer,order)
end


function baseEntity:setHudScaleSetting(scale,distance,minScale,maxScale)
if self.handle==nil then return end
self.staticAuto.BaseEntity_SetHUDScale(self.handle,scale,distance,minScale,maxScale,0,0)
end

function baseEntity:isSelf(entity)
return entity.handle==self.handle
end

function baseEntity:isEnemy(entity)
return entity.teamType~=eAirEntityTeam.eNeutral and
entity.teamType~=self.teamType
end

function baseEntity:isFriend(entity)
return not self:isSelf(entity)and
entity.teamType==self.teamType
end

function baseEntity:stopAllNotify()
if self.__register then
for id,v in pairs(self.__register)do
for _,func in ipairs(v)do
notifySystem:removelistener(id,func)
end
end
end
self.__register=nil
self.__registerOgi=nil
end

function baseEntity:addNotify(id,func)
if self.__register==nil then self.__register={}end
if self.__register[id]==nil then self.__register[id]={}end
if self.__registerOgi==nil then self.__registerOgi={}end
if self.__registerOgi[id]==nil then self.__registerOgi[id]={}end
local t1=self.__registerOgi[id]
if t1[func]==true then return end
t1[func]=true

local t=self.__register[id]
local newfunc=function(...)
if not self or self.isClose then return end
func(...)
end
t[#t+1]=newfunc
notifySystem:listenNotify(id,newfunc)
end


function baseEntity:onTriggerEnter(entity,guid1,guid2)
local entityType=entity.entityType
if entityType==eAirEntityType.TYPE_ROLE then
if self.onTriggerEnterRole then
self:onTriggerEnterRole(entity,guid1,guid2)
end
if self.entityType==eAirEntityType.TYPE_MONSTER_SKILL then
if self.onTriggerEnterMonster then
self:onTriggerEnterMonster(entity,guid1,guid2)
end
end
elseif entityType==eAirEntityType.TYPE_MONSTER or
entityType==eAirEntityType.TYPE_MONSTER_ELITE or
entityType==eAirEntityType.TYPE_MONSTER_BOSS or
entityType==eAirEntityType.TYPE_MONSTER_NEUTRAL then
if self.onTriggerEnterMonster then
self:onTriggerEnterMonster(entity,guid1,guid2)
end
elseif entityType==eAirEntityType.TYPE_SKILL or
entityType==eAirEntityType.TYPE_MONSTER_SKILL then
if self.onTriggerEnterSkill then
self:onTriggerEnterSkill(entity,guid1,guid2)
end
elseif entityType==eAirEntityType.TYPE_DROP then
if self.onTriggerEnterDrop then
self:onTriggerEnterDrop(entity,guid1,guid2)
end
end
end

function baseEntity:onTriggerExit(entity,guid1,guid2)
local entityType=entity.entityType
if entityType==eAirEntityType.TYPE_ROLE then
if self.onTriggerExitRole then
self:onTriggerExitRole(entity,guid1,guid2)
end
if self.entityType==eAirEntityType.TYPE_MONSTER_SKILL then
if self.onTriggerExitMonster then
self:onTriggerExitMonster(entity,guid1,guid2)
end
end
elseif entityType==eAirEntityType.TYPE_MONSTER or
entityType==eAirEntityType.TYPE_MONSTER_ELITE or
entityType==eAirEntityType.TYPE_MONSTER_BOSS or
entityType==eAirEntityType.TYPE_MONSTER_NEUTRAL then
if self.onTriggerExitMonster then
self:onTriggerExitMonster(entity,guid1,guid2)
end
elseif entityType==eAirEntityType.TYPE_SKILL or
entityType==eAirEntityType.TYPE_MONSTER_SKILL then
if self.onTriggerExitSkill then
self:onTriggerExitSkill(entity,guid1,guid2)
end
end
end


function baseEntity:getDistance(entity)
return self.managerStatic.EntityDistance2D(self.handle,entity.handle)
end

function baseEntity:lookAtCamera(collider,asset)
if self.handle==nil then return end
if collider==nil then collider=true end
if asset==nil then asset=true end
self.lookAtAngleX=30
self.staticAuto.BaseEntity_SetChildLocalRotation(self.handle,Vector3.New(30,0,0),collider,asset)
end


