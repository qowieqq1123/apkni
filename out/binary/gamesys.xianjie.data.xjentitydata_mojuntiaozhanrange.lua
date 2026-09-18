









local xjEntityData_MoJunTiaoZhanRange={}


function xjEntityData_MoJunTiaoZhanRange:onInit()
local typeCfg=cfgHelper.get1(cfg_fairylandentitytypeconfig_get,xjServerEnityType.eClientBuild)
local cfg=self:getCfg()
self.sceneidx=xianjieController:getXJClientBuildSceneIndex(self.build_id)
self.gridX,self.gridZ,self.gridWidth,self.gridHeight=xianjieModel:getClientPositionAndSize(cfg.x,cfg.y,typeCfg.size[1],typeCfg.size[2],cfg.param.area2[1],cfg.param.area2[2])
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

end


function xjEntityData_MoJunTiaoZhanRange:getCfg()
return cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.build_id)
end

function xjEntityData_MoJunTiaoZhanRange:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
local args={
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=self.build_id,
twodata=self.twodata,
guid=self.guid,
}
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eMoJunTiaoZhanRange,args,needRefreshAOI)
end
end


function xjEntityData_MoJunTiaoZhanRange:onDelete()

end

function xjEntityData_MoJunTiaoZhanRange:getName()
local data=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,self.build_id)
return FMT.fmt("{0}(范围)",data:getName())
end

function xjEntityData_MoJunTiaoZhanRange:refreshData(v)
if v then

self.twodata=v
end
end

return xjEntityData_MoJunTiaoZhanRange
