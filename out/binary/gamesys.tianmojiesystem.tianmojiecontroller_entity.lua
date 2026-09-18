













local _entity={}

local _locate=nil

local _discipleMount=1110013

function tianMoJieController:lookAtMonster(sfId,monsterGuid,soon)
if mainControl:isInScene(eSceneType.eZongmen)then
local entityData=self:getEntity(sfId,monsterGuid)

if entityData then
isometricMapSystem:moveCameraToObject(entityData.entityGuid,not soon)
return true
end
end
return false
end

function tianMoJieController:lookAtMonsterAnim(sfId,monsterGuid,duration,callback)
if mainControl:isInScene(eSceneType.eZongmen)then
local entityData=self:getEntity(sfId,monsterGuid)
if entityData then
isometricMapSystem:moveCameraToObject(entityData.entityGuid,true,callback,duration)
return true
end
end
return false
end

function tianMoJieController:locateMinHPMonster(sfId,anim)
local list=self:getMountainEntityList(sfId)
if next(list)~=nil then
local sEntity=nil
local minHP=nil
for guidStr,entityData in pairs(list)do
local actorId=sfId==mapIdType.zhufeng_hy and visitControl:getCurrentActor()or playerModel:getActorID()
local monsterData=tianMoJieModel:getMonster(actorId,entityData.monsterGuid)
if minHP then
if monsterData.percent<minHP then
sEntity=entityData
minHP=monsterData.percent
end
else
sEntity=entityData
minHP=monsterData.percent
end
end
if sEntity then
if anim then
return self:lookAtMonsterAnim(sfId,sEntity.monsterGuid,0.5)
else
return self:lookAtMonster(sfId,sEntity.monsterGuid,true)
end
end
end
return false
end

function tianMoJieController:locateSelfMinHPMonsterAfterLoadMap()
local actorId=playerModel:getActorID()
local list=tianMoJieModel:getMonstersByActor(actorId)
if next(list)~=nil then
local targetGuid=nil
local minHP=nil
for guidStr,monsterData in pairs(list)do
if minHP then
if monsterData.percent<minHP then
targetGuid=monsterData.guid
minHP=monsterData.percent
end
else
targetGuid=monsterData.guid
minHP=monsterData.percent
end
end
if targetGuid then
_locate=targetGuid
return true
end
end
return false
end

function tianMoJieController:locatePreSaveMonster(sfId,soon)
if _locate then
self:lookAtMonster(sfId,_locate,true)
_locate=nil
end
end

function tianMoJieController:getMountainEntityList(sfId)
local list=_entity[sfId]
if list==nil then
list={}
_entity[sfId]=list
end
return list
end

function tianMoJieController:createEntity(sfId,monsterGuid)
local list=self:getMountainEntityList(sfId)
local guidStr=tostring(monsterGuid)
if not list[guidStr]then
local actorId=sfId==mapIdType.zhufeng_hy and visitControl:getCurrentActor()or playerModel:getActorID()
local monsterData=tianMoJieModel:getMonster(actorId,monsterGuid)
if monsterData then
local entityData=self:newEntity(sfId,monsterData)
list[guidStr]=entityData
end
end
end

function tianMoJieController:newEntity(sfId,monsterData)
local entityData={
monsterGuid=monsterData.guid,
position=monsterData.position,
}
local monsterCfg=cfgHelper.get1(cfg_tianmojiemonconfig_get,monsterData.id)
local monsterGroup=cfgHelper.get1(cfg_monstergroup_get,monsterCfg.monster)
local body=monsterGroup.model[1]
local slots=monsterGroup.model[3]
local scale=isometricMapSystem:getModelScale(body)
local pos=_MapManager.ToVector3Int(monsterData.position[1],monsterData.position[2],0)
local entityGuid=isometricMapSystem:createRoleEntity(objectType.eTianMoJieMonster,sfId,0,body,slots,SortingLayers.ITBuilding,scale,pos)
isometricMapSystem:setflip(entityGuid,(monsterData.position[3]or 0)==0)
if monsterCfg.mount then
local mountInfo=monsterCfg.mount
local ent=CS.EntityManager.Instance:GetEntity(entityGuid)
ent:Mount(mountInfo[1],mountInfo[2],mountInfo[3],mountInfo[4],mathHelper.convertArrayToVector(mountInfo[5]),nil)
end
entityData.entityGuid=entityGuid

local fight=monsterCfg.fight
if fight then
local offset=fight[4]or{0,0}
local effectGuid=isometricMapSystem:createRoleEntity(objectType.eTianMoJieMonster_Effect,sfId,0,fight[1],fight[2],SortingLayers.ITUI,fight[3]or 1,_MapManager.AddVector3Int(pos,offset[1],offset[2],0))
entityData.effectGuid=effectGuid
end

local offset=_MapManager.GetObjectHeadOffset(entityGuid)
local hudGuid=nil
hudGuid=hudControl:addHUD(INSTANCE_TYPE.eCommonFlagHUD,entityGuid,offset,true,true,function(id)
entityData.hudGuid=id
local widget=hudControl:getHUDWidget(id)
widget:SetChildButtonClick(1,function()
self:onClickEntiy(sfId,monsterData.guid)
end)
end)
local bloodGuid=nil
bloodGuid=hudControl:addHUD(INSTANCE_TYPE.eBloodProgressBar,entityGuid,Vector3.zero,true,true,function(id)
entityData.bloodGuid=id
local widget=hudControl:getHUDWidget(id)
widget:SetChildProgressValue(1,monsterData.percent,10000)
widget:SetChildProgressText(1,FMT.fmt("{0}%",monsterData.percent/100))
end)

local attachs=self:createAttachDisciple(sfId,monsterData.position)
entityData.attachs=attachs

local btArgs={
monster=entityGuid,
guid=monsterData.guid,
sfId=sfId,
fight=entityData.effectGuid,
}
for i,v in ipairs(attachs)do
btArgs[FMT.fmt("disciple{0}",i)]=v
end
local bt=behaviorManager:addBehaviorTree("ai_tianmojie_monster",nil,true,btArgs,true)
entityData.bt=bt

return entityData
end

function tianMoJieController:deleteEntity(sfId,monsterGuid)
local list=self:getMountainEntityList(sfId)
local guidStr=tostring(monsterGuid)
local entityData=list[guidStr]
if entityData then
self:cancelEntity(entityData)
list[guidStr]=nil
end
end

function tianMoJieController:cancelEntity(entityData)
if entityData.bloodGuid then
hudControl:removeHUD(entityData.bloodGuid)
end
if entityData.hudGuid then
hudControl:removeHUD(entityData.hudGuid)
end
if entityData.entityGuid then
_MapManager.RemoveTilemapObject(entityData.entityGuid)
end
if entityData.effectGuid then
CS.EntityManager.Instance:RemoveEntity(entityData.effectGuid)
end
self:deleteAttachDisciple(entityData.attachs)
end

function tianMoJieController:getEntity(sfId,monsterGuid)
local list=self:getMountainEntityList(sfId)
local guidStr=tostring(monsterGuid)
return list[guidStr]
end

function tianMoJieController:haveEntity(sfId,monsterGuid)
local list=self:getMountainEntityList(sfId)
local guidStr=tostring(monsterGuid)
return list[guidStr]~=nil
end

function tianMoJieController:clearEntityBySF(sfId)
local list=self:getMountainEntityList(sfId)
for guidStr,entityData in pairs(list)do
self:deleteEntity(sfId,entityData.monsterGuid)
end
end

function tianMoJieController:resetEntityData()
for i,v in pairs(_entity)do
self:clearEntityBySF(i)
end
end

function tianMoJieController:refreshEntityBlood(sfId,monsterGuid)
local entityData=self:getEntity(sfId,monsterGuid)
if entityData then
local actorId=sfId==mapIdType.zhufeng_hy and visitControl:getCurrentActor()or playerModel:getActorID()
local monsterData=tianMoJieModel:getMonster(actorId,monsterGuid)
if monsterData then
if entityData.bloodGuid then
local widget=hudControl:getHUDWidget(entityData.bloodGuid)
if widget then
widget:SetChildProgress(1,monsterData.percent,10000)
widget:SetChildProgressText(1,FMT.fmt("{0}%",monsterData.percent/100))
end
end
end
end
end

function tianMoJieController:refreshEntitysByActor(actorId)
if playerModel:checkActorId(actorId)then
if mainControl:isSceneLoaded(eSceneType.eZongmen)and mountainControl:isLoaded(mapIdType.zhufeng)and zongmenModel:getMountainId()==mapIdType.zhufeng then
self:refreshEntitys(mapIdType.zhufeng,actorId)
end
else
if mainControl:isSceneLoaded(eSceneType.eZongmen)and mountainControl:isLoaded(mapIdType.zhufeng_hy)and zongmenModel:getMountainId()==mapIdType.zhufeng_hy and visitControl:isCurrentActor(actorId)then
self:refreshEntitys(mapIdType.zhufeng_hy,actorId)
end
end
end

function tianMoJieController:refreshEntitys(sfId,actorId)
local list=self:getMountainEntityList(sfId)
local monsterDatas=tianMoJieModel:getMonstersByActor(actorId)
for guidStr,entityData in pairs(list)do
local monsterData=monsterDatas[guidStr]
if monsterData then
if entityData.bloodGuid then
local widget=hudControl:getHUDWidget(entityData.bloodGuid)
if widget then
widget:SetChildProgress(1,monsterData.percent,10000)
widget:SetChildProgressText(1,FMT.fmt("{0}%",monsterData.percent/100))
end
end
elseif not tianMoJieModel:isDumpData(actorId,entityData.monsterGuid)then
self:cancelEntity(entityData)
list[guidStr]=nil
end
end
for guidStr,monsterData in pairs(monsterDatas)do
local entityData=list[guidStr]
if not entityData then
entityData=self:newEntity(sfId,monsterData)
list[guidStr]=entityData
end
end
end

function tianMoJieController:onClickEntiy(sfId,monsterGuid)
local actorId=sfId==mapIdType.zhufeng_hy and visitControl:getCurrentActor()or playerModel:getActorID()
local monsterData=tianMoJieModel:getMonster(actorId,monsterGuid)
if not monsterData then
return
end

local args={
actorId=actorId,
monsterGuid=monsterGuid,
}
UIManager:showWindow("UITianMoJieMonsterWin",args)
end

function tianMoJieController:checkEntityClick(guid)
local sfId=zongmenModel:getMountainId()
local entityDatas=tianMoJieController:getMountainEntityList(sfId)
for guidStr,entityData in pairs(entityDatas)do
if mathHelper.compareInt64(entityData.entityGuid,guid)then
self:onClickEntiy(sfId,entityData.monsterGuid)
return true
end
end
return false
end

function tianMoJieController:getMonsterDataByEntityGuid(guid)
local sfId=zongmenModel:getMountainId()
local entityDatas=tianMoJieController:getMountainEntityList(sfId)
for guidStr,entityData in pairs(entityDatas)do
if mathHelper.compareInt64(entityData.entityGuid,guid)then
local monsterGuid=entityData.monsterGuid
local actorId=sfId==mapIdType.zhufeng_hy and visitControl:getCurrentActor()or playerModel:getActorID()
local monsterData=tianMoJieModel:getMonster(actorId,monsterGuid)
if monsterData then
return monsterData
end
end
end
end

function tianMoJieController:createAttachDisciple(sfId,position)
local centerX=position[1]
local centerY=position[2]
local attachs=position[4]
local npcLib=cfgHelper.get2(cfg_tianmojiebaseconfig_get,1,"npcDisciple")
local disciples={}
if attachs then
for i,v in ipairs(attachs)do
local npcId=npcLib[math.random(1,#npcLib)]
local modelParams=npcModel:getImageInfoOutSide(npcId)
local pos=_MapManager.ToVector3Int(centerX+v[1],centerY+v[2],0)
local scale=modelParams.scale
local guid=isometricMapSystem:createRoleEntity(objectType.eDefault,sfId,0,modelParams.body,modelParams.componets,SortingLayers.ITSky1,scale,pos)
isometricMapSystem:setflip(guid,(v[3]or 0)==0)
local ent=_EntityManager:GetEntity(guid)
ent:Mount(_discipleMount,nil,"root",scale,Vector3.zero,nil)
ent:SetColor(Color.New(1,1,1,0))
table.insert(disciples,guid)
end
end
return disciples
end

function tianMoJieController:deleteAttachDisciple(data)
if data then
for i,v in ipairs(data)do
_MapManager.RemoveTilemapObject(v)
end
end
end

function tianMoJieController:randomAttachDisciple(bt)
local sfId=bt:getSharedVar("sfId")
local guid=bt:getSharedVar("guid")
local monster=bt:getSharedVar("monster")
local entityData=tianMoJieController:getEntity(sfId,guid)
if entityData then
local npcLib=cfgHelper.get2(cfg_tianmojiebaseconfig_get,1,"npcDisciple")
for i,v in ipairs(entityData.attachs)do
local npcId=npcLib[math.random(1,#npcLib)]
local modelParams=npcModel:getImageInfoOutSide(npcId)
isometricMapSystem:changeBody(v,modelParams.body,modelParams.componets,modelParams.scale)
end
end
end

function tianMoJieController:hideMonsters(sfId)
local list=self:getMountainEntityList(sfId)
for guidStr,entityData in pairs(list)do
for i,v in ipairs(entityData.attachs)do
local ent=_EntityManager:GetEntity(v)
ent:RunAnimator(eAnimationID.stand,1)
ent:SetColor(Color.New(1,1,1,0))
end
if entityData.bt then
behaviorManager:removeBehaviorTree(entityData.bt)
entityData.bt=nil
end
local ent=_EntityManager:GetEntity(entityData.entityGuid)
ent:RunAnimator(eAnimationID.stand,1)
ent:SetColor(Color.New(1,1,1,0))

if entityData.effectGuid then
ent=_EntityManager:GetEntity(entityData.effectGuid)
ent:SetColor(Color.New(1,1,1,0))
end

local widget=hudControl:getHUDWidget(entityData.hudGuid)
widget:SetChildActive(-1,false)

widget=hudControl:getHUDWidget(entityData.bloodGuid)
widget:SetChildActive(-1,false)
end
end

function tianMoJieController:reshowMonsters(sfId)
local list=self:getMountainEntityList(sfId)
for guidStr,entityData in pairs(list)do
if entityData.bt then
behaviorManager:removeBehaviorTree(entityData.bt)
entityData.bt=nil
end
local btArgs={
monster=entityData.entityGuid,
guid=entityData.monsterGuid,
sfId=sfId,
}
for i,v in ipairs(entityData.attachs)do
btArgs[FMT.fmt("disciple{0}",i)]=v
end
local bt=behaviorManager:addBehaviorTree("ai_tianmojie_monster",nil,true,btArgs,true)
entityData.bt=bt

local ent=_EntityManager:GetEntity(entityData.entityGuid)
ent:RunAnimator(eAnimationID.stand,1)
ent:SetColor(Color.New(1,1,1,1))

if entityData.effectGuid then
ent=_EntityManager:GetEntity(entityData.effectGuid)
ent:SetColor(Color.New(1,1,1,1))
end

local widget=hudControl:getHUDWidget(entityData.hudGuid)
widget:SetChildActive(-1,true)

widget=hudControl:getHUDWidget(entityData.bloodGuid)
widget:SetChildActive(-1,true)
end
end

function tianMoJieController:pauseAttachBT(sfId,monsterGuid)
local entityData=tianMoJieController:getEntity(sfId,monsterGuid)
if not entityData then return end
for i,v in ipairs(entityData.attachs)do
local ent=_EntityManager:GetEntity(v)
ent:RunAnimator(eAnimationID.stand,1)
ent:SetColor(Color.New(1,1,1,0))
end
if entityData.bt then
behaviorManager:removeBehaviorTree(entityData.bt)
entityData.bt=nil
end
end

function tianMoJieController:resumeAttachBT(sfId,monsterGuid)
local entityData=tianMoJieController:getEntity(sfId,monsterGuid)
if not entityData then return end
if entityData.bt then
behaviorManager:removeBehaviorTree(entityData.bt)
entityData.bt=nil
end
local btArgs={
monster=entityData.entityGuid,
guid=monsterGuid,
sfId=sfId,
}
for i,v in ipairs(entityData.attachs)do
btArgs[FMT.fmt("disciple{0}",i)]=v
end
local bt=behaviorManager:addBehaviorTree("ai_tianmojie_monster",nil,true,btArgs,true)
entityData.bt=bt
end

function tianMoJieController:deadEntity(sfId,monsterGuid)
local entityData=tianMoJieController:getEntity(sfId,monsterGuid)

if entityData then
local actorId=sfId==mapIdType.zhufeng_hy and visitControl:getCurrentActor()or playerModel:getActorID()
local monsterData=tianMoJieModel:getDumpData(actorId,monsterGuid)
if monsterData then
tianMoJieModel:deleteDumpData(actorId,monsterGuid)
self:pauseAttachBT(sfId,monsterGuid)

if sfId==mapIdType.zhufeng and tianMoJieModel:haveMonsterByActor(actorId)then
self.deadData=monsterData
else
local btArgs={
showEffect=false,
entityGuid=entityData.entityGuid,
sfId=sfId,
monsterGuid=monsterGuid,
}
behaviorManager:addBehaviorTree("ai_tianmojie_dead",nil,true,btArgs,true)
end
end
end
end