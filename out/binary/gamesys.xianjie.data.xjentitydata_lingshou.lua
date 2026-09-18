














local xjEntityData_lingshou={}

function xjEntityData_lingshou:onInit()
self.gridX=self.x
self.gridZ=self.y
self.x=nil
self.y=nil
local size=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,self.entitytype,'size')
self.gridWidth=size[1]
self.gridHeight=size[2]
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

self.gridState=xjMapGridStateType.eLingShou

self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eLingShouAttack,1)

self.isMySelf=mathHelper.compareInt64(playerModel:getActorID(),self.ownerActorId)
end

function xjEntityData_lingshou:refreshData(data)
if self.isExpire and self.gridState then

xianjieModel:setGridState(self.sceneidx,self.gridX,self.gridZ,self.gridWidth,self.gridHeight,self.gridState,false)
self.gridState=nil
end

self.bufflistlen=data.bufflistlen
self.buffList=data.buffList

self.expiresec=data.expiresec
self.ownerActorId=data.ownerActorId
self.ownerXMGuid=data.ownerXMGuid

end

function xjEntityData_lingshou:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil and not self.isExpire and systemModel.isOpen(SYSTEM_DEFINE.eXianJieZhuaChong)then
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eLingShou,{self.infoguid},needRefreshAOI)
end
end

function xjEntityData_lingshou:onDelete()

end

function xjEntityData_lingshou:getCfg()
local name=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,self.entitytype,'configname')
local func=cfgHelper.getCofingGetFunction(name)
local cfg=cfgHelper.get1(func,self.infoid)





return cfg
end

function xjEntityData_lingshou:getName()
local cfg=self:getCfg()
local monsterGroupId=cfg.monster[1]
local name=cfgHelper.get2(cfg_monstergroup_get,monsterGroupId,"name")
return name
end

function xjEntityData_lingshou:getModelData()
local cfg=self:getCfg()
local modelSet=cfg.modelSet
local monsterCfg={}
if cfg.monster then
monsterCfg=cfgHelper.get1(cfg_monstergroup_get,cfg.monster[1])
end

local body=modelSet.model or(monsterCfg.model and monsterCfg.model[1])
local componets=modelSet.components or(monsterCfg.model and monsterCfg.model[3])or{}
local scale=modelSet.scale or 1
local flip=modelSet.flip==1
local offset=modelSet.offset and mathHelper.convertArrayToVector(modelSet.offset)or Vector3.zero
local mount=modelSet.mount
local effect=modelSet.effect
local slotInfo=nil
if modelSet.replaceSlot and modelSet.replaceIcon then
slotInfo={modelSet.replaceSlot,modelSet.replaceIcon}
end

return body,componets,scale,flip,offset,slotInfo,mount,effect
end

function xjEntityData_lingshou:compareKey(guid)
return self.infoguid_str==tostring(guid)
end

return xjEntityData_lingshou
