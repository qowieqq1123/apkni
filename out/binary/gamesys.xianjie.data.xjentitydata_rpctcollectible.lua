









local xjEntityData_RPCtCollectible={}


function xjEntityData_RPCtCollectible:onInit()
local cfg=self:getCfg()
self.name="xjEntityData_RPCtCollectible"

self.gridWidth=cfg.size[1]
self.gridHeight=cfg.size[2]
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

self.gridState=xjMapGridStateType.eResPoint
end

function xjEntityData_RPCtCollectible:refreshData(d)
for i,v in pairs(d)do
self[i]=v
end
end

function xjEntityData_RPCtCollectible:getCfg()
return xianjieModel:getXJResPointClassifyCfg(self.rpType,self.rpId)
end

function xjEntityData_RPCtCollectible:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eRPCtCollectible,{guid=self.rpGuid},needRefreshAOI)
end
end


function xjEntityData_RPCtCollectible:onDelete()
if xianjieModel:haveResPointData(self.dataGuid)then
xianjieModel:refreshResPointData(self.dataGuid,nil,false)
end
end


function xjEntityData_RPCtCollectible:getModelData()
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

return xjEntityData_RPCtCollectible