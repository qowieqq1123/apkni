









local xjEntityData_cloudLock={}


function xjEntityData_cloudLock:onInit()
local pos_c,pos,size=xianjieModel:caculationCloudSize(self.cloudid)
self.gridWidth=size[1]
self.gridHeight=size[2]
self.sceneidx=xianjienSceneIndexType.eXianJie
self.gridX_c=pos_c[1]
self.gridZ_c=pos_c[2]
self.gridX=pos[1]
self.gridZ=pos[2]
local cfgs=cfgHelper.get1(cfg_fairylandcloudconfig_get,self.cloudid)
local singleSearchSpeed=cfgs.singleSearchSpeed
local speed=singleSearchSpeed or xianjieModel:getCloudSearchSpeed()
self.defaultSpeed=speed
self.gridState=xjMapGridStateType.eCloudLock
end


function xjEntityData_cloudLock:createEntity(needRefreshAOI)
if self.ent_key==nil then
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eCloud,{self.cloudid},needRefreshAOI)
end
end

function xjEntityData_cloudLock:refreshEnity()
if self.ent_key then
xianjieController:invokeEntityFunc(self.ent_key,'refreshInfo')
end
end

function xjEntityData_cloudLock:getEventCostTime()
local cfgs=cfgHelper.get1(cfg_fairylandcloudunlockconfig_get,self.cloudid)
for i,cfg in ipairs(cfgs)do
local typo=cfg.explore[1]
if typo==xjCloudSearchType.eBack then
return cfg.begin
end
end
end


function xjEntityData_cloudLock:onDelete()

end

return xjEntityData_cloudLock