









local xjEntityData_cloudQiYu={}


function xjEntityData_cloudQiYu:onInit()
local cfg=cfgHelper.get2(cfg_fairylandcloudunlockconfig_get,self.cloudid,self.idx)
local pos=cfg.pos
local size=cfg.size
self.gridX=pos[1]
self.gridZ=pos[2]
self.gridWidth=size[1]
self.gridHeight=size[2]
self.sceneidx=xianjienSceneIndexType.eXianJie
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(pos[1],pos[2],size[1],size[2])
self.gridX_c=gridX_c
self.gridZ_c=gridZ_c

self.gridState=xjMapGridStateType.eCloudQiYu
end


function xjEntityData_cloudQiYu:createEntity(needRefreshAOI)
if self.ent_key==nil then
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eCloudQiYu,{self.cloudid,self.idx},needRefreshAOI)
end
end


function xjEntityData_cloudQiYu:onDelete()

end

return xjEntityData_cloudQiYu