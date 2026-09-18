









local xjEntityData_ZhenTaiRange={}


function xjEntityData_ZhenTaiRange:onInit()
local typeCfg=cfgHelper.get1(cfg_fairylandentitytypeconfig_get,xjServerEnityType.eClientBuild)
local cfg=self:getCfg()
local clientCfg=cfg.clientParam
self.sceneidx=xianjieController:getXJClientBuildSceneIndex(self.client_build_id)
self.gridX,self.gridZ,self.gridWidth,self.gridHeight=xianjieModel:getClientPositionAndSize(cfg.x,cfg.y,typeCfg.size[1],typeCfg.size[2],clientCfg.area[1],clientCfg.area[2])
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)
self.gridState=xjMapGridStateType.eZhenTaiRange
end


function xjEntityData_ZhenTaiRange:getCfg()
return cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.client_build_id)
end

function xjEntityData_ZhenTaiRange:createEntity(needRefreshAOI)
if xianjienSceneIndexType:isMoJie(self.sceneidx)then
local isUnLockFog=xianjieController:checkMoJiePosOpenFog(self.sceneidx,self.gridX,self.gridZ)
if not isUnLockFog then
return
end
end
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
local args={
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=self.build_id,
client_build_id=self.client_build_id,
}
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eZhenTaiRange,args,needRefreshAOI)
end
end


function xjEntityData_ZhenTaiRange:onDelete()

end

function xjEntityData_ZhenTaiRange:getName()
return FMT.fmt("{0}(范围)",self:getCfg().name)
end

function xjEntityData_ZhenTaiRange:refreshData()
end

return xjEntityData_ZhenTaiRange