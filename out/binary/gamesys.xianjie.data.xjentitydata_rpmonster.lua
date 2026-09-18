









local xjEntityData_RPMonster={}


function xjEntityData_RPMonster:onInit()
local cfg=self:getCfg()
self.name="xjEntityData_RPMonster"

self.gridWidth=cfg.size[1]
self.gridHeight=cfg.size[2]
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

self.feign=cfg.feign~=nil and not xianjieModel:haveResPointMarch(self.rpGuid)
self.dead=false

self.gridState=xjMapGridStateType.eResPoint
self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eKill,1)
end

function xjEntityData_RPMonster:refreshData(d)
for i,v in pairs(d)do
self[i]=v
end
end

function xjEntityData_RPMonster:getCfg()
return xianjieModel:getXJResPointClassifyCfg(self.rpType,self.rpId)
end

function xjEntityData_RPMonster:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
local ent_type=self.feign and XJ_ENTITY_TYPE.eRPMonster2 or XJ_ENTITY_TYPE.eRPMonster
self.ent_key=xianjieController:addEntity(ent_type,{guid=self.rpGuid},needRefreshAOI)
end
end


function xjEntityData_RPMonster:onDelete()
if xianjieModel:haveResPointData(self.dataGuid)then
xianjieModel:refreshResPointData(self.dataGuid,nil,false)
end
end


function xjEntityData_RPMonster:initBehaviorData()
if self.behaviorData==nil then
self.behaviorData={cloudid=self.cloudid,plotIdx=self.plotIdx}
end
end

function xjEntityData_RPMonster:getModelData()
local cfg=self:getCfg()
local body,componets,scale,flip,offset,slotInfo,mount,effect
if self.feign then
local feignCfg=cfg.feign
body=feignCfg.model
componets=feignCfg.components or{}
scale=feignCfg.scale
effect=feignCfg.effect
flip=feignCfg.flip==1
offset=feignCfg.offset and mathHelper.convertArrayToVector(feignCfg.offset)or Vector3.zero
mount=feignCfg.mount
if feignCfg.replaceSlot and feignCfg.replaceIcon then
slotInfo={feignCfg.replaceSlot,feignCfg.replaceIcon}
end
else
local modelSet=cfg.modelSet
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,cfg.monster_id)
body=modelSet.model or monsterCfg.model[1]
componets=modelSet.components or monsterCfg.model[3]or{}
scale=modelSet.scale or 1
flip=modelSet.flip==1
offset=modelSet.offset and mathHelper.convertArrayToVector(modelSet.offset)or Vector3.zero
mount=modelSet.mount
effect=modelSet.effect
if modelSet.replaceSlot and modelSet.replaceIcon then
slotInfo={modelSet.replaceSlot,modelSet.replaceIcon}
end
end
return body,componets,scale,flip,offset,slotInfo,mount,effect
end

function xjEntityData_RPMonster:getSelectEffect()
local cfg=self:getCfg()
local modelSet=cfg.modelSet
return modelSet.selectEffect
end

return xjEntityData_RPMonster