









local xjEntityData_MoJun={}


function xjEntityData_MoJun:onInit()
local typeCfg=cfgHelper.get1(cfg_fairylandentitytypeconfig_get,xjServerEnityType.eClientBuild)
local cfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.build_id)
self.sceneidx=xianjieController:getXJClientBuildSceneIndex(self.build_id)
self.gridX,self.gridZ,self.gridWidth,self.gridHeight=xianjieModel:getClientPositionAndSize(cfg.x,cfg.y,typeCfg.size[1],typeCfg.size[2],cfg.size[1],cfg.size[2])
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)
self.gridX_original=cfg.x
self.gridZ_original=cfg.y
self.gridState=xjMapGridStateType.eMoJun
self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eJiJieChuZheng,1)
end

function xjEntityData_MoJun:getCfg()
local mojunData=xianjieModel:getMoJunData()
return cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunData.mojunJieShu)
end

function xjEntityData_MoJun:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
local args={
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=self.build_id,
}
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eMoJun,args,needRefreshAOI)
end
end

function xjEntityData_MoJun:refreshData(d)
self.hp=d.hp
self.build_id=d.build_id
self.killTime=d.killTime
end


function xjEntityData_MoJun:onDelete()

end

function xjEntityData_MoJun:getName()
local cfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.build_id)
return cfg.name
end

function xjEntityData_MoJun:getModelData()
return xianjieModel:getMoJunModelData()
end

function xjEntityData_MoJun:getAtkSize()
local cfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.build_id)
local atkSizeCfg=cfg.clientParam.atkSize
if atkSizeCfg then
return Vector2(atkSizeCfg[1],atkSizeCfg[2])
else
return self:getWorldSize()
end
end

function xjEntityData_MoJun:getSelectEffect()
local cfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.build_id)
return cfg.clientParam.selectEffect
end

function xjEntityData_MoJun:compareKey(guid)
return xianjieModel:isMoJunBuild_int64(guid)
end

return xjEntityData_MoJun