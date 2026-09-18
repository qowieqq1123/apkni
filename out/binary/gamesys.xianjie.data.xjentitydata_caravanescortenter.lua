









local xjEntityData_caravanEscortEnter={}


function xjEntityData_caravanEscortEnter:onInit()
self.entityType=xjServerEnityType.eClientBuild
self.entityId=xjClientBuildType.flcbCaravanEscortEnter

local cfg=self:getCfg()
self.sceneidx=cfg.sceneidx>0 and xianjieModel:getXianYuSceneIndex()or cfg.sceneidx
local typeCfg=cfgHelper.get1(cfg_fairylandentitytypeconfig_get,self.entityType)
self.gridX,self.gridZ,self.gridWidth,self.gridHeight=xianjieModel:getClientPositionAndSize(cfg.x,cfg.y,typeCfg.size[1],typeCfg.size[2],cfg.size[1],cfg.size[2])
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)
self.gridX_original=cfg.x
self.gridZ_original=cfg.y
self.gridState=xjMapGridStateType.eCaravanEscortEnter
self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eJiJieChuZheng,1)
end

function xjEntityData_caravanEscortEnter:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eCaravanEscortEnter,{},needRefreshAOI)
return true
end

return false
end

function xjEntityData_caravanEscortEnter:refreshData(d)

end


function xjEntityData_caravanEscortEnter:onDelete()

end

function xjEntityData_caravanEscortEnter:getCfg()
return cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.entityId)
end

function xjEntityData_caravanEscortEnter:getAtkSize()
local cfg=self:getCfg()
local atkSizeCfg=cfg.clientParam.atkSize
if atkSizeCfg then
return Vector2(atkSizeCfg[1],atkSizeCfg[2])
else
return self:getWorldSize()
end
end

return xjEntityData_caravanEscortEnter