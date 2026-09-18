









local xjEntityData_station={}


function xjEntityData_station:onInit()
self.gridX=self.x
self.gridZ=self.y
self.x=nil
self.y=nil
local size=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,self.entitytype,'size')
self.gridWidth=size[1]
self.gridHeight=size[2]
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

self.gridState=xjMapGridStateType.eStation
self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eStation,1)
self.isMyWaiPai=xianjieModel:checkInBaseWaiPai(xjWaiPiaBaseType.eStation,self.marchguid)
end

function xjEntityData_station:refreshData(d)
self.gridX=d.x
self.gridZ=d.y
self.sceneidx=d.sceneidx
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)
end

function xjEntityData_station:compareKey(guid)
return self.guid_str==tostring(guid)
end

function xjEntityData_station:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eStation,{self.guid},needRefreshAOI)
end
end









function xjEntityData_station:onDelete()

end

return xjEntityData_station