









local xjEntityData_resource={}


function xjEntityData_resource:onInit()
self.gridX=self.x
self.gridZ=self.y
self.x=nil
self.y=nil
local size=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,self.entitytype,'size')
self.gridWidth=size[1]
self.gridHeight=size[2]
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

self.gridState=xjMapGridStateType.eResource
end

function xjEntityData_resource:compareKey(guid)
return self.infoguid_str==tostring(guid)
end

function xjEntityData_resource:refreshData(d)
self.gridX=d.x
self.gridZ=d.y
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)
self.sceneidx=d.sceneidx
end

function xjEntityData_resource:getCfg()
return cfgHelper.get1(cfg_fairylandinfoconfig004_get,self.infoid)
end

function xjEntityData_resource:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then

end
end


function xjEntityData_resource:onDelete()

end

return xjEntityData_resource