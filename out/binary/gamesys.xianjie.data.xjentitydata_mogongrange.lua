









local xjEntityData_MoGongRange={}


function xjEntityData_MoGongRange:onInit()
local typeCfg=cfgHelper.get1(cfg_fairylandentitytypeconfig_get,xjServerEnityType.eClientBuild)
local cfg=self:getCfg()
self.sceneidx=xianjienSceneIndexType.eMoGongZhengDuo
self.gridX,self.gridZ,self.gridWidth,self.gridHeight=xianjieModel:getClientPositionAndSize(cfg.x,cfg.y,typeCfg.size[1],typeCfg.size[2],cfg.param.area[1],cfg.param.area[2])
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

self.gridState=xjMapGridStateType.eMoGongRange
end

function xjEntityData_MoGongRange:getCfg()
return cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.moGongId)
end

function xjEntityData_MoGongRange:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
local args={
moGongId=self.moGongId,
}
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eMoGongRange,args,needRefreshAOI)
end
end


function xjEntityData_MoGongRange:onDelete()

end

function xjEntityData_MoGongRange:getName()
local data=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,self.build_id)
return FMT.fmt("{0}(范围)",data:getName())
end

function xjEntityData_MoGongRange:refreshData()
end

return xjEntityData_MoGongRange
