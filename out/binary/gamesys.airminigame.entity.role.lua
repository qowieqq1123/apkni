role=simple_class(lifeEntity)
function role:__init(entityType,handle,cfg,name,vis,teamType)

end

function role:initialize(args)
role._base.initialize(self,args)
self.moveDir=0

self.flipX=false
self.takeDamage=nil
self.roleCommonCfg=cfg_airroleconfig_get(1)
self.takeDamageCD=self.roleCommonCfg.invincible


self.entity.SupportDIR=false
self.entity.SupportDIRAnimation=false
self.entity.TurnSpeed=0

self.skillCommandLookup={}
self.recoverSelfTime=nil
self.attrEffectStamp={}

self.dzguid=args.dzguid
self.mountguid=args.mountguid
self.extraAttrs=args.extraAttrs
self.moveTemp={}
self.frameCount=nil

self:initBag()
self:initEquipAttrs()
self:initLevelUpAttrs()
self:initAttrs()
self:initSpeed()
self:initSkill()
self:initBuffList()

self:refreshSuitAttrs()
self:refreshWeaponTypeAttrs()


self:createRoleSpine()
self:addMainColliderByCfg()
self:addPickUpCollider()


self:createEquipEnts()

airMapSystem:setCameraBorder(self)

self.managerStatic.SetCameraToEntity(self.handle,true)
self.managerStatic.SetCameraLocalPosition(Vector3.New(0,20,-30))
self.managerStatic.SetCameraLocalRotation(Vector3.New(30,0,0))

self:lookAtCamera()

self._onCollectDropComplete=function(...)
self:onCollectDropComplete(...)
end

self:addPostDelete()
end

function role:onDelete()
if self==nil or self:isDeleteSelf()then return end
self:removePostDelete()
airActorSystem:deleteActor()
self.managerStatic.ResetCameraParent(true)

self:deleteEquipEnts()

role._base.onDelete(self)

if self.skillCommandLookup then
for _,command in pairs(self.skillCommandLookup)do
command:onDelete()
end
end

self.flipX=nil
self.moveSpeed=nil
self.curAttrs=nil
self.takeDamage=nil
self.takeDamageCD=nil
self.equipExtraAttrs=nil
self._onCollectDropComplete=nil
self.recoverSelfTime=nil
self.attrEffectStamp=nil

self.dzguid=nil
self.mountguid=nil
self.extraAttrs=nil
self.frameCount=nil
self.isMove=nil
self.moveX=nil
self.moveY=nil
end

function role:onPause()
role._base.onPause(self)
self:onCommandsPause()
end

function role:onContinue()
role._base.onContinue(self)
self:onCommandsContinue()
end

function role:onUpdate()
role._base.onUpdate(self)
self:onCommandsUpdate()
local isLevelDoing=airLevelSystem:isLevelDoing()
if isLevelDoing then
if(self.recoverSelfTime==nil or Time.realtimeSinceStartup>=self.recoverSelfTime+self:getPauseTime())then
self.recoverSelfTime=Time.realtimeSinceStartup+5-self:getPauseTime()
self:onRestoreSelf(self:getRecoverSelf())
end

local isWuDi=self.wuDiEndTime and Time.realtimeSinceStartup<=self.wuDiEndTime
if isWuDi and(not self.twinkleDurationTime or self.twinkleDurationTime<=Time.realtimeSinceStartup)then

local twinkleDuration=0.3
self:twinkleSpine(Color.New(0.92,0.93,0.87),twinkleDuration)
self.twinkleDurationTime=Time.realtimeSinceStartup+twinkleDuration
end
end
end

function role:onFastUpdate()
role._base.onFastUpdate(self)
self:onCommandsFastUpdate()


if webGLHelper:isRunWeiXin()then
local x=0
local y=0
if webGLHelper:isKeyDown('w')then
y=0.1
elseif webGLHelper:isKeyDown('s')then
y=-0.1
end
if webGLHelper:isKeyDown('a')then
x=-0.1
elseif webGLHelper:isKeyDown('d')then
x=0.1
end
if x~=0 or y~=0 then
self.moveTemp.x=x
self.moveTemp.y=y
self:onMove(self.moveTemp)
end
end

self:startMove()
end

function role:onRemoveEntity(handle)
role._base.onRemoveEntity(self,handle)
end

function role:onStartLevel()

self:clearLevelBuff()

self.useSkillStamp={}

local maxHp=self:getMaxHP()
self:setAttrValue(aiAttributeType.eHP,maxHp)
role._base.onStartLevel(self)
end



function role:getAttrs()
return self.curAttrs
end

function role:initAttrs()

local processData=airModel:getActorProcessData()
if processData and processData.curAttrs and next(processData.curAttrs)then

self.curAttrs=processData.curAttrs
else
self.curAttrs=attrListHelper.concatLookup(self.roleCommonCfg.attrs,self.equipExtraAttrs)
self.curAttrs=attrListHelper.concatLookup(self.curAttrs,self.extraAttrs)
end

local maxHp=self:getMaxHP()
self:setAttrValue(aiAttributeType.eHP,maxHp)
end

function role:getBaseAttrValue(attributeType)
local old=self.curAttrs[attributeType]or 0
old=old+self:getExtraAttrValue(attributeType)
local addAttrVal_lvup=self:getLevelUpAttrValue(attributeType)
local addAttrVal_suit=self:getSuitAttrsValue(attributeType)
local addAttrVal_weaponType=self:getWeaponTypeAttrsValue(attributeType)
old=old+addAttrVal_lvup+addAttrVal_suit+addAttrVal_weaponType
return old
end


function role:getAttrValue(attributeType,really)
local attributeCfg=cfg_airattributesconfig_get(attributeType)
local old=self:getBaseAttrValue(attributeType)
local value_p=0
local relevantAttr=attributeCfg.relevantAttr
if relevantAttr then
if relevantAttr==attributeType then
loggerUtil.logErrFMT('关联属性不能是本属性：{0}',attributeType)
return 0
end
value_p=value_p+self:getAttrValue(relevantAttr,really)
end
if value_p~=0 then
if airConfig.isAttr_P(attributeType)then
old=old+value_p
else
old=old+old*value_p/10000
end
end

old=self:clampTopAttr(attributeCfg,old)

if not really then
old=self:clampAttr(attributeType,old)
end
return old
end

function role:setAttrValue(attributeType,value)
local old=self.curAttrs[attributeType]or 0
local new=value
self.curAttrs[attributeType]=new
if new==old then return end
self:onRefreshAttr(attributeType,old,new)
end

function role:addAttrValue(attributeType,value)
local old=self.curAttrs[attributeType]or 0
local new=old+value
self.curAttrs[attributeType]=new
if new==old then return end

self:onRefreshAttr(attributeType,old,new)
end



function role:setAttrValue_P(attributeType,value_P)
local old=self.curAttrs[attributeType]or 0
local new=old*(1+value_P/10000)
self.curAttrs[attributeType]=new
if new==old then return end

self:onRefreshAttr(attributeType,old,new)
end

function role:onRefreshAttr(attributeType,old,new)

if attributeType==aiAttributeType.eHP then
self:initHpChangeBuff()
end
self:initConvertAttr()
self:initDamageAttr()


if attributeType==aiAttributeType.eAddMoveSpeed then
self:onChangeSpeed()
elseif attributeType==aiAttributeType.eHP or
attributeType==aiAttributeType.eMaxHP or
attributeType==aiAttributeType.eMaxHP_P then
local maxHP=self:getMaxHP()
local HP=self:getHP()
if attributeType==aiAttributeType.eMaxHP then
local add=new-old
if add>0 then
HP=math.min(HP+add,maxHP)
else
HP=math.min(HP,maxHP)
end
self.curAttrs[aiAttributeType.eHP]=HP
end
if HP>maxHP then
HP=maxHP
self.curAttrs[aiAttributeType.eHP]=HP
end

airHUDSystem:onHPChange(self.handle,math.floor(HP),math.floor(maxHP))

elseif attributeType==aiAttributeType.ePickupRange then
self:refreshPickUpColliderBounds()
elseif attributeType==aiAttributeType.eAttckRange then
self:refreshWeaponAttackColliderBounds()
elseif attributeType==aiAttributeType.ePriceReduct then
airController:refreshAllWinItemPriceShow()
end





end

function role:getHP()
return self:getAttrValue(aiAttributeType.eHP)
end

function role:getMaxHP()
return self:getAttrValue(aiAttributeType.eMaxHP)
end

function role:isMaxHp()
return self:getHP()>=self:getMaxHP()
end

function role:setHP(value)
local old=self.curAttrs[aiAttributeType.eHP]
if old==value then return end
self:setAttrValue(aiAttributeType.eHP,value)
end

function role:addHP(value)
self:addAttrValue(aiAttributeType.eHP,value)
end

function role:setHP_P(value_P)
self:setAttrValue_P(aiAttributeType.eHP,value_P)
end

function role:setMaxHP(value)
self:setAttrValue(aiAttributeType.eMaxHP,value)
end

function role:setMaxHP_P(value_P)
self:setAttrValue_P(aiAttributeType.eMaxHP,value_P)
end


function role:getPickUpRange()
local pickupRange_P=self:getAttrValue(aiAttributeType.ePickupRange)
local range=self.roleCommonCfg.pickupRange*(1+pickupRange_P/10000)
return range
end


function role:getRecoverSelf()
local maxhp_P=self:getAttrValue(aiAttributeType.eRecoverHPSpeed)
if maxhp_P<=0 then return 0 end
local maxHP=self:getAttrValue(aiAttributeType.eMaxHP)
return math.floor(maxHP*maxhp_P/10000)
end


function role:getCurrrentSpeed()
local moveSpeed=self.orginSpeed
local speed_p=self:getAttrValue(aiAttributeType.eAddMoveSpeed)
if speed_p>0 then
local speed=moveSpeed*(1+speed_p/10000)
return airEntitySystem:clampSpeed(speed)
else
local speed=moveSpeed/(1+math.abs(speed_p/10000))
return airEntitySystem:clampSpeed(speed)
end
end

function role:initSpeed()
self.orginSpeed=self.roleCommonCfg.speed
self.moveSpeed=self:getCurrrentSpeed()
self.entity.MoveSpeed=self.moveSpeed
end

function role:onChangeSpeed()
local old=self.moveSpeed
local speed=self:getCurrrentSpeed()
if speed~=old then
self.moveSpeed=speed
self.entity.MoveSpeed=speed
end
end


function role:initEquipAttrs()
local equips=airModel:getEquipList()

local equipAttrs={}
for i,weaponId in ipairs(equips)do
local extraAttrs=cfgHelper.get2(cfg_airweaponconfig_get,weaponId,'extraAttrs')
equipAttrs=attrListHelper.concatLookup(equipAttrs,extraAttrs)
end
self.equipExtraAttrs=equipAttrs
end

function role:createEquipEnts()
local equips=airModel:getEquipList()
local len=#equips
local equipEntities={}
local weaponNodes=self.roleCommonCfg.weaponNodes[len]
for i,weaponId in ipairs(equips)do
local pos=weaponNodes[i]
local offsetX=pos[1]
local offsetY=pos[2]
local offsetZ=pos[3]
equipEntities[#equipEntities+1]=airEntitySystem:createRoleWeapon(offsetX,offsetY,offsetZ,weaponId,self)
end
self.equipEntities=equipEntities
end

function role:addEquipEnt(weaponId,index)
local equips=airModel:getEquipList()
local len=#equips
local weaponNodes=self.roleCommonCfg.weaponNodes[len]
local pos=weaponNodes[len]
local offsetX=pos[1]
local offsetY=pos[2]
local offsetZ=pos[3]
local ent=airEntitySystem:createRoleWeapon(offsetX,offsetY,offsetZ,weaponId,self)
if index then
self.equipEntities[index]=ent
else
self.equipEntities[#self.equipEntities+1]=ent
end
self:initWeaponHoldAttr()
end

function role:removeEquipEnt(index)
if#self.equipEntities>=index then
local ent=self.equipEntities[index]
ent:deleteEntity()
table.remove(self.equipEntities,index)
end
self:initWeaponHoldAttr()
end

function role:removeEquipEntByHandle(handle)
for i,v in ipairs(self.equipEntities)do
if v.handle==handle then
v:deleteEntity()
table.remove(self.equipEntities,i)
break
end
end
end

function role:changeEquipEnt(weaponId,index)
local len=#self.equipEntities
if len>=index then
local originalEnt=self.equipEntities[index]
local pos=originalEnt:getPosition()
originalEnt:deleteEntity()

local ent=airEntitySystem:createRoleWeapon(pos.x,pos.y,pos.z,weaponId,self)
self.equipEntities[index]=ent
end
self:initWeaponHoldAttr()
end

function role:getEquipIdxByHandle(handle)
for idx,v in ipairs(self.equipEntities)do
if v.handle==handle then
return idx
end
end
end

function role:deleteEquipEnts()
if self.equipEntities==nil then return end
for i=#self.equipEntities,1,-1 do
self.equipEntities[i]:deleteEntity()
end
self.equipEntities=nil
end

function role:refreshEquipEntPosition()
local equips=airModel:getEquipList()
local len=#equips
local weaponNodes=self.roleCommonCfg.weaponNodes[len]
for i,entity in ipairs(self.equipEntities)do
local pos=weaponNodes[i]
local x=pos[1]
local y=pos[2]
local z=pos[3]
local pos=entity:getPosition()
entity:setLocalPosition(Vector3.New(x,y,z))
end
end

function role:addEquipAttr(weaponId)
local extraAttrs=cfgHelper.get2(cfg_airweaponconfig_get,weaponId,'extraAttrs')or{}
self.equipExtraAttrs=attrListHelper.concatLookup(self.equipExtraAttrs,extraAttrs)
end

function role:removeEquipAttr(weaponId)
local extraAttrs=cfgHelper.get2(cfg_airweaponconfig_get,weaponId,'extraAttrs')or{}
for attrId,attrVal in pairs(extraAttrs)do
if self.equipExtraAttrs[attrId]then
self.equipExtraAttrs[attrId]=self.equipExtraAttrs[attrId]-attrVal
if self.equipExtraAttrs[attrId]==0 then
self.equipExtraAttrs[attrId]=nil
end
end
end
end

function role:changeEquipAttr(originalWeaponId,weaponId)

local originalExtraAttrs=cfgHelper.get2(cfg_airweaponconfig_get,originalWeaponId,'extraAttrs')or{}
for attrId,attrVal in pairs(originalExtraAttrs)do
if self.equipExtraAttrs[attrId]then
self.equipExtraAttrs[attrId]=self.equipExtraAttrs[attrId]-attrVal
if self.equipExtraAttrs[attrId]==0 then
self.equipExtraAttrs[attrId]=nil
end
end
end

local weaponCfg=cfgHelper.get(cfg_airweaponconfig_get,weaponId)
local extraAttrs=weaponCfg and weaponCfg.extraAttrs or{}
self.equipExtraAttrs=attrListHelper.concatLookup(self.equipExtraAttrs,extraAttrs)
end

function role:getEquipHurtAttack(hurtType)
local attack=0
for i,ent in ipairs(self.equipEntities)do
local name=ent.entityCfg.name
local attack_1=ent:getBaseAttrValue(aiAttributeType.eAttack)*(1+ent:getBaseAttrValue(aiAttributeType.eWeaponDamage)/10000)
airSkillSystem:debugSkillDamage(FMT.fmt('武器{0}基础伤害：',name),attack_1)
attack=attack+attack_1
if ent:getHurtType()==hurtType then
if hurtType==eSkillHurtType.eOut then
local attack_1=ent:getBaseAttrValue(aiAttributeType.ePhiscAttack)*(1+ent:getBaseAttrValue(aiAttributeType.ePhiscIncreaseDamage)/10000)
attack=attack+attack_1
airSkillSystem:debugSkillDamage(FMT.fmt('武器{0}物理伤害：',name),attack_1)
elseif hurtType==eSkillHurtType.eIn then
local attack_1=ent:getBaseAttrValue(aiAttributeType.eMagicAttack)*(1+ent:getBaseAttrValue(aiAttributeType.eMagicIncreaseDamage)/10000)
attack=attack+attack_1
airSkillSystem:debugSkillDamage(FMT.fmt('武器{0}法术伤害：',name),attack_1)
end
end
end
return attack
end


function role:initLevelUpAttrs()
local processData=airModel:getActorProcessData()
if processData and processData.levelUpAttrs and next(processData.levelUpAttrs)then
self.levelUpAttrs=processData.levelUpAttrs
else
self.levelUpAttrs={}
end
end

function role:addLevelUpAttrs(attrId,attrVal)
if not self.levelUpAttrs then
self:initLevelUpAttrs()
end

if not self.levelUpAttrs[attrId]then
self.levelUpAttrs[attrId]=attrVal
else
self.levelUpAttrs[attrId]=self.levelUpAttrs[attrId]+attrVal
end
end

function role:getLevelUpAttrs()
return self.levelUpAttrs
end

function role:getLevelUpAttrValue(attrId)
if not self.levelUpAttrs then
self:initLevelUpAttrs()
end

return self.levelUpAttrs[attrId]or 0
end


function role:refreshSuitAttrs()
local suitAttrs_lookup={}
local suitAttrs={}

local equips=airModel:getEquipList()
for i,weaponId in ipairs(equips)do
local weaponCfg=cfgHelper.get2(cfg_airweaponconfig_get,weaponId)
local suitId=weaponCfg.suit
if suitId and not suitAttrs_lookup[suitId]then
suitAttrs_lookup[suitId]=true
local suitCfg=weaponCfg.suit and cfgHelper.get(cfg_airsuitconfig_get,suitId)or nil
if suitCfg then
local sameSuitCount=airActorSystem:getActorSameSuitEquipCount(suitId)
local params=suitCfg.suitEffectParams
if params and params[sameSuitCount]then
local attrId=params[sameSuitCount][1]
local attrVal=params[sameSuitCount][2]
if not suitAttrs[attrId]then
suitAttrs[attrId]=attrVal
else
suitAttrs[attrId]=suitAttrs[attrId]+attrVal
end
end
end
end
end
self.suitAttrs=suitAttrs
end

function role:getSuitAttrsValue(attrId)
if not self.suitAttrs then
self:refreshSuitAttrs()
end

return self.suitAttrs[attrId]or 0
end


function role:refreshWeaponTypeAttrs()
local weaponTypeAttrs_lookup={}
local weaponTypeAttrs={}

local equips=airModel:getEquipList()
for i,weaponId in ipairs(equips)do
local weaponCfg=cfgHelper.get2(cfg_airweaponconfig_get,weaponId)
local weaponType=weaponCfg.type1
if weaponType and not weaponTypeAttrs_lookup[weaponType]then
weaponTypeAttrs_lookup[weaponType]=true
local weaponTypeCfg=cfgHelper.get(cfg_airweapontypeconfig_get,weaponType)
if weaponTypeCfg then
local sameTypeCount=airActorSystem:getActorSameTypeEquipCount(weaponType)
local params=weaponTypeCfg.typeEffectParams
if params and params[sameTypeCount]then
local attrId=params[sameTypeCount][1]
local attrVal=params[sameTypeCount][2]
if not weaponTypeAttrs[attrId]then
weaponTypeAttrs[attrId]=attrVal
else
weaponTypeAttrs[attrId]=weaponTypeAttrs[attrId]+attrVal
end
end
end
end
end
self.weaponTypeAttrs=weaponTypeAttrs
end

function role:getWeaponTypeAttrsValue(attrId)
if not self.weaponTypeAttrs then
self:refreshWeaponTypeAttrs()
end

return self.weaponTypeAttrs[attrId]or 0
end

function role:initSkill()
self.useSkillStamp={}
self.skillCD={}

self.roleSkillid=self.entityCfg.skill
local skillCfg=cfg_airskillconfig_get(self.roleSkillid)
self.skillCD[self.roleSkillid]=skillCfg.cd

if self.mountguid then
local mountData=mountModel:getMount(self.mountguid)
mountData=mountData or itemsModel.getItem(self.mountguid)

if mountData then
local mountSkillCfg=itemsConfig.getConfig(mountData.itemid)
if mountSkillCfg and mountSkillCfg.airgameMountSkillid then
local skillid=mountSkillCfg.airgameMountSkillid
self.mountSkillid=skillid
local skillCfg=cfg_airskillconfig_get(self.mountSkillid)
self.skillCD[self.mountSkillid]=skillCfg.cd
else
logErr(FMT.fmt("空战 坐骑缺少技能配置,mountid{0}",mountData.itemid))
end
end
end
end

function role:getCoolDown(skillid)
local cd=self.skillCD[skillid]
local skillCfg=cfg_airskillconfig_get(skillid)
local isNormalAtk=skillCfg.skillType==0
if not cd then return 0 end
if isNormalAtk then
local attackSpeed=self:getAttrValue(aiAttributeType.eAttckSpeed)
if attackSpeed>=0 then
return 1/(1/cd*(1+attackSpeed/10000))
else
return 1/(1/cd/(1+math.abs(attackSpeed/10000)))
end
else
return cd
end
end

function role:isCoolDown(skillid)
return self:getCoolDownTime(skillid)<=0
end

function role:isCanCastSkill(skillid)
return self:isCoolDown(skillid)and
not self:hasBuffStatus(eBuffStatus.eXuanYun)or false
end

function role:getCoolDownTime(skillid)
if self.useSkillStamp[skillid]==nil then return 0 end
local stamp=Time.realtimeSinceStartup
local useStamp=self:getPauseTime()+self.useSkillStamp[skillid]
local costTime=stamp-useStamp
local cd=self:getCoolDown(skillid)
local left=cd-costTime
if left<=0 then return 0 end
return left
end


function role:castSkill(skillid,target,args)
local ignoreCD=args and args.coolType==0 or false
if not ignoreCD and not self:isCoolDown(skillid)then return-1 end
if self:hasBuffStatus(eBuffStatus.eXuanYun)then return-2 end
local skillCfg=cfg_airskillconfig_get(skillid)
if not ignoreCD then
self.useSkillStamp[skillid]=Time.realtimeSinceStartup-self:getPauseTime()
end
local command=airSkillSystem:createSkillCommmand(skillCfg,self,self,target,args)
if not command.isDelete and not self:isDeleteSelf()then
self.skillCommandLookup[command.guid]=command
end
end

function role:castVocSkill(args)
local skillid=self:getRoleSkill()
self:castSkill(skillid,nil,args)
end

function role:castMountSkill(args)
airActorSystem:castMountSkill(args)
end


function role:getMountSkill()
return self.mountSkillid
end

function role:getRoleSkill()
return self.roleSkillid
end


function role:createRoleSpine()
local dzguid=self.dzguid

local args={
tmLv=UIDiscipleModel:getTianMingLevel(self.dzguid)
}

local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(self.dzguid,false,1,args)
modelParams.anim=mountHelper.getMountAniByDZ(dzguid,modelParams.anim)
local scale=self.entityCfg.scale
self:createSpine(modelParams.body,modelParams.componets,scale)
self:addMountSpine(scale)
end


function role:addMountSpine(scale)
local mountInfo=mountHelper.getMount(self.mountguid)
if mountInfo then
local itemid=mountInfo.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local airMountCfg=cfgHelper.get1(cfg_airmountconfig_get,itemid)
local node=itemCfg.node or'zuoqidian'
local modelParams=itemCfg.model
local modelId=modelParams.model
local offset=modelParams.offset or{}
local offset_x=offset[1]or 0
local offset_y=offset[2]or 0
local offset_z=0.2
local scaleArgs=cfgHelper.get2(cfg_dbbodyconfig_get,modelId,'scales')or{}
local modelScale=scaleArgs[2]or 1
local finalScale=scale*modelScale
if airMountCfg then
if airMountCfg.s_model_scale then
finalScale=airMountCfg.s_model_scale
end

if airMountCfg.s_model_offset then
local mountOffset=airMountCfg.s_model_offset
offset_x=mountOffset[1]or 0
offset_y=mountOffset[2]or 0
offset_z=mountOffset[3]or 0
end
end

self:addMount(modelId,{},node,finalScale,Vector3.New(offset_x,offset_y,offset_z),nil)
else
self:addMount(1110010,{},nil,2.5,Vector3.New(0,0,0.5),nil)
end
end

function role:unMount()
self.staticAuto.BaseEntity_UnMountSpine()
end

function role:getHUDOffset()
local mountInfo=mountHelper.getMount(self.mountguid)
if mountInfo then
local itemid=mountInfo.itemid
local airMountCfg=cfgHelper.get1(cfg_airmountconfig_get,itemid)
if airMountCfg.s_hud_offset then
return airMountCfg.s_hud_offset
end
end
return{0,0}
end


function role:initBag()

end

function role:findNearestEnemyTarget(list)
local min
local target
for handle,ent in pairs(list)do
local distance=self.managerStatic.EntityDistance2D(handle,ent.handle)
if(min==nil or distance<min)and not self:isRoleEnemyTeam(ent.teamType)then
min=distance
target=ent
end
end
return target
end

function role:isRoleEnemyTeam(teamType)
return self.teamType==teamType
end


function role:startMove()
if not self.isMove then
self:setIdle(true)
return
end
self.isMove=false
local x=self.moveX
local y=self.moveY
local flipX=false
if x>0 then flipX=true end
if flipX~=self.flipX then
self.flipX=flipX
self.staticAuto.BaseEntity_SetSpineFlipX(self.handle,flipX)
end
airActorSystem:setMoveDelta(x,y)
self.manager.MoveRoleTranslate(self.handle,x,y)
end

function role:onMove(screenPoint)
local frameCount=Time.frameCount
if self.frameCount==frameCount then return end
self.frameCount=frameCount

if self.isDelete or
airController:isPauseGame()or
self:hasBuffStatus(eBuffStatus.eXuanYun)or
not airLevelSystem:isLevelDoing()then
self.isMove=false
self:setIdle(true)
return
end
self.isMove=true
self:setIdle(false)
screenPoint=Vector2.Normalize(screenPoint)

local moveSpeed=self.moveSpeed
local speed=Time.deltaTime*moveSpeed
local x=screenPoint.x*speed
local y=screenPoint.y*speed

self.moveX=x
self.moveY=y

local hd=math.atan2(y,x)
local jd=hd*180/math.pi
self.moveDir=jd
end



function role:addPickUpCollider()
local range=self:getPickUpRange()
local boundType=eAirEntityColliderType.eCircle
local bounds={0,0,0,range}
local colliderCfg=airConfig.getEntityColliderConfig(self.entityType)
local layer=colliderCfg.droplayer
self:addCollider(layer,layer,nil,boundType,bounds,true,false,0,3)
end

function role:refreshPickUpColliderBounds()
local range=self:getPickUpRange()
local bounds={0,0,0,range}
local colliderCfg=airConfig.getEntityColliderConfig(self.entityType)
local layer=colliderCfg.droplayer
self:setColliderBounds(layer,bounds)
end

function role:refreshWeaponAttackColliderBounds()
local equips=self.equipEntities
for _,v in ipairs(equips)do
v:refreshAttackCollider()
end
end


function role:onTriggerEnterDrop(entity)
local ret=airDropSystem:checkCollectDrop(self,entity)
if ret then
self:startCollectDrop(entity)
end
end

function role:startCollectDrop(entity)
local onCollectDropComplete=self._onCollectDropComplete
entity:startCollect(self,onCollectDropComplete)
end


function role:onCollectDropComplete(entity)
if self:isDeleteSelf()then return end
entity:onDrop(self)
end

function role:isCanTakeDamage()
if self:isWuDi()then return false end
if self.takeDamage==nil then return true end
return self.takeDamage+self:getPauseTime()<Time.realtimeSinceStartup
end

function role:onAttack(entity)
airBuffSystem:onRoleAttack(entity)
end

function role:onDamage(damage,isCirtical,caster,ignoreDamageLimit,damageType)
if not self:isCanTakeDamage()then return false end
self.takeDamage=Time.realtimeSinceStartup+self.takeDamageCD-self:getPauseTime()
if damage<=0 then return true end
if isCirtical then

end
local cur=self:getHP()
local next=math.max(cur-damage,0)
local del=cur-next
if del<=0 then return end

self:setHP(next)


self:showDamageBehaiour()
local hp=self:getHP()
if hp<=0 then
self:onDead()
end
return true
end


function role:onReduceHP(HP_P,forceDamage,damageType)
if not forceDamage and not self:isCanTakeDamage()then return false end

local max=self:getMaxHP()
local del=math.min(math.ceil(max*HP_P/10000),max)
if del<=0 then return end

local hp=self:getHP()
local next=math.max(hp-del,0)

self:setHP(next)

self:showDamageBehaiour()
if next<=0 then
self:onDead()
end
return true
end

function role:onDead(ignoreRevive)

if airBuffSystem:onDyingRebirth(self)then
return
end

if not ignoreRevive then

local isHasReviveCount=airModel:checkIsHasRemainingReviveCount()
if isHasReviveCount then

airController:pauseGame(true)

return UIFullAirMiniGameControl:showReviveWin()
end
end



airHUDSystem:onDead(self.handle)
airLevelSystem:setResultFlag(0)
airLevelSystem:setStartFlag(false)
airLevelSystem:setFinishTag()
self:deleteEntity()
end


function role:onDodge(entity)

airHUDSystem:onDodge(self.handle)
airBuffSystem:onDodge(self)
end

function role:onRestoreHP(add)
local max=self:getMaxHP()
local cur=self:getHP()
local next=math.min(cur+add,max)
add=next-cur
if add<=0 then return end

self:setHP(next)
airHUDSystem:onRestoreHP(self.handle,add)
self:showRestoreHPBehaiour()
end

function role:onStealHP(add)
local attributeType=aiAttributeType.eLifeSteal
local attributeCfg=cfg_airattributesconfig_get(attributeType)
local cd=attributeCfg.cd
local stamp=Time.realtimeSinceStartup
if cd then
local nextStamp=self.attrEffectStamp[attributeType]
if nextStamp and nextStamp+self:getPauseTime()>stamp then
return false
end
end
local limit=attributeCfg.limit
local max=self:getMaxHP()
if limit then
add=math.min(add,math.floor(limit[1]/10000*max))
end
local cur=self:getHP()
local next=math.min(cur+add,max)
local add=next-cur
if add<=0 then return end


if cd then
self.attrEffectStamp[attributeType]=stamp+cd-self:getPauseTime()
end

self:setHP(next)
airHUDSystem:onStealHP(self.handle,add)
end

function role:onReflect(value)
if not self:isCanTakeDamage()then return end
local cur=self:getHP()
local next=math.max(cur-value,0)
local del=cur-next
if del<=0 then return end

self:setHP(next)

self:showDamageBehaiour()
airHUDSystem:onReflect(self.handle,del)
if next<=0 then
self:onDead()
end
end


function role:checkReflectDead(value)
return false
end

function role:onRestoreSelf(add)
if add==0 then return end
local max=self:getMaxHP()
local cur=self:getHP()
local next=math.min(cur+add,max)
local add=next-cur
if add<=0 then return end

self:setHP(next)
airHUDSystem:onRestoreSelf(self.handle,add)
self:showRestoreHPBehaiour()
end


function role:onRestoreHPByDrop(addValue,addValue_P)
if self:isMaxHp()then return end
local max=self:getMaxHP()
local cur=self:getHP()
local next=cur
local add=0
local readly=0
if addValue>0 then
readly=addValue
next=next+add
next=math.min(next,max)
add=next-cur
end
if addValue_P>0 then
local add_=math.floor(max*addValue_P/10000)
readly=readly+add_
next=next+add_
next=math.min(next,max)
add=add+next-cur
end
if add<=0 then return end

self:setHP(next)
airHUDSystem:onRestoreHP(self.handle,readly)
self:showRestoreHPBehaiour()
end

function role:onMissSkillAction(entity,skillid,actionid,isPenetrate)

end

function role:showRestoreHPBehaiour()
self:playEffectWithOrder(2136,Vector3.zero,Vector3.New(2,2,2),true,true)
end

function role:showDamageBehaiour()
self:twinkleSpine(Color.New(0.92,0.93,0.87),0.2)
airActorSystem:showCommonDamageBehaiour()
end

function role:showWuDiBehaiour()
self.wuDiEndTime=Time.realtimeSinceStartup+2
end

function role:addBuffByItem(itemid)

end


function role:setMoveCameraBorder(left,top,right,bottom)
self.entity:SetMoveCameraBorder(left,top,right,bottom)
end



function role:onCommandsFastUpdate()
for _,command in pairs(self.skillCommandLookup)do
command:onFastUpdate()
end
end

function role:onCommandsUpdate()
for _,command in pairs(self.skillCommandLookup)do
command:onUpdate()
end
end

function role:onCommandsPause()
for _,command in pairs(self.skillCommandLookup)do
command:onPause()
end
end

function role:onCommandsContinue()
for _,command in pairs(self.skillCommandLookup)do
command:onContinue()
end
end

function role:onCommandDelete(guid)
self.skillCommandLookup[guid]=nil
end



function role:initBuffList()
local data=airModel:getActorProcessData()
self.buffGroups={}
self.buffCheckList={}
self.buffConverGroups={}
self.buffLookup={}
self.buffSameConver={}
self.chixuDamage={}
self.buffTypeLookup={}
self.buffDelayList={}
self.allbuffLookup={}

if data.allBuff and#data.allBuff>0 then
self.allbuffLookup=self:convertServerAllBuff(data.allBuff)

self.attrTopLimit=data.attrTopLimit or{}
local buffLookup=data.buffLookup or{}
local buffDelayList=data.buffDelayList or{}
local buffSameConver=data.buffSameConver or{}
local chixuDamage=data.chixuDamage or{}

for buffid,list in pairs(buffSameConver)do
local t={}
for _,buffguid in ipairs(list)do
t[#t+1]=self.allbuffLookup[buffguid]
end
self.buffSameConver[buffid]=t
end

for _,v in ipairs(buffDelayList)do
local t={}
local buffid=v[1]
local delayType=v[2]
local delayTime=v[3]
t.buffid=buffid
t.delayType=delayType
t.delayTime=delayTime
t.level=1
self.buffDelayList[#self.buffDelayList+1]=t
end

for _,buffguid in ipairs(chixuDamage)do
self.chixuDamage[#self.chixuDamage+1]=self.allbuffLookup[buffguid]
end

local buffLookup_={}
for _,buffguid in ipairs(buffLookup)do
local buffInfo=self.allbuffLookup[buffguid]
if buffInfo then
buffLookup_[buffguid]=buffInfo
local buffCfg=cfg_airbuffconfig_get(buffInfo.buffid)
self:addGroupBuff(buffguid,buffCfg.groupId)
self:addBuffType(buffInfo.buffguid,buffCfg.buffType)
if buffCfg.duration>0 then
self.buffCheckList[#self.buffCheckList+1]=buffInfo
end
end
end
self.buffLookup=buffLookup_

self:checkBuffFinish()
self:checkDelayOpenBuff()
self:initHpChangeBuff()
self:initConvertAttr()
self:initDamageAttr()
self:initWeaponHoldAttr()
self:initSummonChangeAttr()
end
end


function role:clearLevelBuff()
self.buffGroups={}
self.buffCheckList={}
self.allbuffLookup={}
self.buffTypeLookup={}
self.buffCaster={}
self.buffConverGroups={}

self.chixuDamage=self:clearCurrentChiXuDamages()
self.buffLookup=self:clearCurrentBuffLookup()
self.buffDelayList=self:clearCurrentDelayList()
self.buffSameConver=self:clearCurrentSameConver()

for buffguid,v in pairs(self.buffLookup)do
local buffCfg=cfg_airbuffconfig_get(v.buffid)
self:addGroupBuff(buffguid,buffCfg.groupId)
self:addBuffType(v.buffguid,buffCfg.buffType)
if buffCfg.duration>0 then
self.buffCheckList[#self.buffCheckList+1]=v
end
self.allbuffLookup[buffguid]=v
v.times=nil
end

for _,list in pairs(self.buffConverGroups)do
for _,v in ipairs(list)do
self.allbuffLookup[v.buffguid]=v
v.times=nil
end
end

for _,list in pairs(self.buffSameConver)do
for _,v in ipairs(list)do
self.allbuffLookup[v.buffguid]=v
v.times=nil
end
end
self:checkBuffFinish()
self:checkDelayOpenBuff()
self:initHpChangeBuff()
self:initConvertAttr()
self:initDamageAttr()
self:initWeaponHoldAttr()
end

function role:updateExtraAttrs()
self:initHpChangeBuff()
self:initConvertAttr()
self:initDamageAttr()
self:initWeaponHoldAttr()
end
