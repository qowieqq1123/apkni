









local xjEntityData_RPCollectible={}


function xjEntityData_RPCollectible:onInit()
local cfg=self:getCfg()
self.name="xjEntityData_RPCollectible"

self.gridWidth=cfg.size[1]
self.gridHeight=cfg.size[2]
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

self.gridState=xjMapGridStateType.eResPoint
self.feign=cfg.feign~=nil and not xianjieModel:haveResPointMarch(self.rpGuid)
self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eKill,1)
end

function xjEntityData_RPCollectible:refreshData(d)
for i,v in pairs(d)do
self[i]=v
end
end

function xjEntityData_RPCollectible:getCfg()
return xianjieModel:getXJResPointClassifyCfg(self.rpType,self.rpId)
end

function xjEntityData_RPCollectible:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eRPCollectible,{guid=self.rpGuid},needRefreshAOI)
end
end


function xjEntityData_RPCollectible:onDelete()
if xianjieModel:haveResPointData(self.dataGuid)then
xianjieModel:refreshResPointData(self.dataGuid,nil,false)
end
end

function xjEntityData_RPCollectible:getModelData()
local cfg=self:getCfg()
local modelSet=cfg.modelSet
local body=modelSet.model
local componets=modelSet.components or{}
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

return xjEntityData_RPCollectible