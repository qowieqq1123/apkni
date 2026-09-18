









local xjEntityData_MoJunEffect={}


function xjEntityData_MoJunEffect:onInit()
local cfg=self:getCfg()
local mojunData=xianjieModel:getMoJunData()
local build_id=mojunData.build_id
local mjCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,build_id)
self.sceneidx=xianjieController:getXJClientBuildSceneIndex(build_id)
self.gridX,self.gridZ,self.gridWidth,self.gridHeight=xianjieModel:getClientPositionAndSize(cfg.xy[1],cfg.xy[2],1,1,cfg.wh[1],cfg.wh[2])
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

end

function xjEntityData_MoJunEffect:getCfg()
return cfgHelper.get1(cfg_seasonmojuneffectareaconfig_get,self.areaId)
end

function xjEntityData_MoJunEffect:getIsMyMoJunArea()
return self.areaId==xianjieModel:getMoJunMyAreaId()
end

function xjEntityData_MoJunEffect:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
local args={
seasonType=self.seasonType,
stageIndex=self.stageIndex,
idx=self.idx,
confid=self.confid,
areaId=self.areaId,
}
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eMoJunEffectRange,args,needRefreshAOI)
end
end


function xjEntityData_MoJunEffect:onDelete()

end

function xjEntityData_MoJunEffect:getName()
local cfg=cfgHelper.get1(cfg_seasonmojuneffectconfig_get,self.confid)
return cfg.name
end

function xjEntityData_MoJunEffect:refreshData(data)
for k,v in pairs(data)do
self[k]=v
end
local cfg=self:getCfg()
local mojunData=xianjieModel:getMoJunData()
local build_id=mojunData.build_id
local mjCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,build_id)
self.sceneidx=mjCfg.sceneidx
self.gridX,self.gridZ,self.gridWidth,self.gridHeight=xianjieModel:getClientPositionAndSize(cfg.xy[1],cfg.xy[2],1,1,cfg.wh[1],cfg.wh[2])
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)
end

return xjEntityData_MoJunEffect