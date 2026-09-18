









local xjEntityData_LeyLine={}


function xjEntityData_LeyLine:onInit()
self.entityType=xjServerEnityType.eClientBuild
self.entityId=xjClientBuildType.flcbXianYuLingMai
local typeCfg=cfgHelper.get1(cfg_fairylandentitytypeconfig_get,self.entityType)
local cfg=self:getCfg()
self.sceneidx=cfg.sceneidx>0 and xianjieModel:getXianYuSceneIndex()or cfg.sceneidx
self.gridX,self.gridZ,self.gridWidth,self.gridHeight=xianjieModel:getClientPositionAndSize(cfg.x,cfg.y,typeCfg.size[1],typeCfg.size[2],cfg.size[1],cfg.size[2])
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

self.gridState=xjMapGridStateType.eLeyLine
self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eCarry,1)
end

function xjEntityData_LeyLine:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eLeyLine,{},needRefreshAOI)
end
end

function xjEntityData_LeyLine:refreshData(d)

end


function xjEntityData_LeyLine:onDelete()

end

function xjEntityData_LeyLine:refreshEnity()
if self.ent_key then
xianjieController:invokeEntityFunc(self.ent_key,'refreshInfo')
end
end

function xjEntityData_LeyLine:getCfg()
return cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.entityId)
end

return xjEntityData_LeyLine