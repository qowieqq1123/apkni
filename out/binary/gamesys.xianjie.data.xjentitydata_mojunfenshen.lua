









local xjEntityData_MoJunFenShen={}


function xjEntityData_MoJunFenShen:onInit()
local mojunData=xianjieModel:getMoJunData()
local build_id=mojunData.build_id
self.sceneidx=xianjieController:getXJClientBuildSceneIndex(build_id)
self.gridX=self.x
self.gridZ=self.y
self.x=nil
self.y=nil
local size=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,self.entitytype,'size')
self.gridWidth=size[1]
self.gridHeight=size[2]
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

self.gridState=xjMapGridStateType.eMonster




self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eMoJunFenShenAttack,1)
end

function xjEntityData_MoJunFenShen:getCfg()
local name=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,self.entitytype,'configname')
local func=cfgHelper.getCofingGetFunction(name)
local cfg=cfgHelper.get1(func,self.infoid)





return cfg
end

function xjEntityData_MoJunFenShen:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
local args={
infoguid=self.infoguid,
}
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eMoJunFenShen,args,needRefreshAOI)
end
end


function xjEntityData_MoJunFenShen:onDelete()

end

function xjEntityData_MoJunFenShen:getName()
local mojunData=xianjieModel:getMoJunData()
local jsCfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunData.mojunJieShu)
return self:getCfg().name or jsCfg.name
end

function xjEntityData_MoJunFenShen:getModelData()
return xianjieModel:getMoJunModelData()
end

function xjEntityData_MoJunFenShen:getAtkSize()
local cfg=self:getCfg()
local atkSizeCfg=cfg.clientParam.atkSize
if atkSizeCfg then
return Vector2(atkSizeCfg[1],atkSizeCfg[2])
else
return self:getWorldSize()
end
end

function xjEntityData_MoJunFenShen:getSelectEffect()
local cfg=self:getCfg()
return cfg.clientParam.selectEffect
end

function xjEntityData_MoJunFenShen:refreshData(d)

end

return xjEntityData_MoJunFenShen
