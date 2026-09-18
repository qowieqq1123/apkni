









local xjEntityData_caravanEscortHub={}


function xjEntityData_caravanEscortHub:onInit()
self.entityType=xjServerEnityType.eClientBuild
self.entityId=xjClientBuildType.flcbCaravanEscortHub

local cfg=self:getCfg()
self.sceneidx=self.hubSceneIdx
local typeCfg=cfgHelper.get1(cfg_fairylandentitytypeconfig_get,self.entityType)
local posX=self.hubPosX
local posY=self.hubPosY
self.gridX,self.gridZ,self.gridWidth,self.gridHeight=xianjieModel:getClientPositionAndSize(posX,posY,typeCfg.size[1],typeCfg.size[2],cfg.size[1],cfg.size[2])
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)
self.gridX_original=posX
self.gridZ_original=posY
self.gridState=xjMapGridStateType.eCaravanEscortHub
end

function xjEntityData_caravanEscortHub:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
local hubSceneIdx=self.hubSceneIdx
local hubPosX=self.hubPosX
local hubPosY=self.hubPosY
local hubType=self.hubType
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eCaravanEscortHub,{hubSceneIdx=hubSceneIdx,hubPosX=hubPosX,hubPosY=hubPosY,hubType=hubType},needRefreshAOI)
return true
end

return false
end

function xjEntityData_caravanEscortHub:refreshData(d)

end


function xjEntityData_caravanEscortHub:onDelete()

end

function xjEntityData_caravanEscortHub:getCfg()
return cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.entityId)
end

return xjEntityData_caravanEscortHub