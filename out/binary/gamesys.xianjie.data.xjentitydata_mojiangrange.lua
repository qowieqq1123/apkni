









local xjEntityData_MoJiangRange={}


function xjEntityData_MoJiangRange:onInit()
local typeCfg=cfgHelper.get1(cfg_fairylandentitytypeconfig_get,xjServerEnityType.eClientBuild)
local cfg=self:getCfg()
local clientCfg=cfg.clientParam
self.sceneidx=xianjieController:getXJClientBuildSceneIndex(self.build_id)
self.gridX,self.gridZ,self.gridWidth,self.gridHeight=xianjieModel:getClientPositionAndSize(cfg.x,cfg.y,typeCfg.size[1],typeCfg.size[2],clientCfg.area[1],clientCfg.area[2])
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

self.gridState=xjMapGridStateType.eMoJiangRange
end


function xjEntityData_MoJiangRange:getCfg()
return cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.build_id)
end

function xjEntityData_MoJiangRange:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
local args={
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=self.build_id,
}
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eMoJiangRange,args,needRefreshAOI)
end
end


function xjEntityData_MoJiangRange:onDelete()

end

function xjEntityData_MoJiangRange:getName()
local data=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,self.build_id)
return FMT.fmt("{0}(范围)",data:getName())
end

function xjEntityData_MoJiangRange:refreshData()
end

return xjEntityData_MoJiangRange