









local xjEntityData_cloudUnLock={}


function xjEntityData_cloudUnLock:onInit()
local pos_c,pos,size=xianjieModel:caculationCloudSize(self.cloudid)
self.gridWidth=size[1]
self.gridHeight=size[2]
self.sceneidx=xianjienSceneIndexType.eXianJie
self.gridX_c=pos_c[1]
self.gridZ_c=pos_c[2]
self.gridX=pos[1]
self.gridZ=pos[2]
self.defaultSpeed=xianjieModel:getCloudSearchSpeed()
end


function xjEntityData_cloudUnLock:createEntity(needRefreshAOI)
if self.ent_key==nil then
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eCloudUnLock,{self.cloudid},needRefreshAOI)
end
end


function xjEntityData_cloudUnLock:onRemoveWidget(widget)
widget:SetChildSceneEntityRemoveModel(0)
end

function xjEntityData_cloudUnLock:refreshEnity()
if self.ent_key then
xianjieController:invokeEntityFunc(self.ent_key,'refreshInfo')
end
end

function xjEntityData_cloudUnLock:getEventCostTime()
local cfgs=cfgHelper.get1(cfg_fairylandcloudunlockconfig_get,self.cloudid)
for i,cfg in ipairs(cfgs)do
local typo=cfg.explore[1]
if typo==xjCloudSearchType.eBack then
return cfg.begin
end
end
end

function xjEntityData_cloudUnLock:runAnim()
if self.ent_key then
local ent=xianjieController:getEntity(self.ent_key)
if ent then
ent:runAnim()
end
end
end




function xjEntityData_cloudUnLock:onDelete()

end

return xjEntityData_cloudUnLock