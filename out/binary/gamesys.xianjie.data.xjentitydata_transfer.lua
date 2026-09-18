









local xjEntityData_transfer={}


function xjEntityData_transfer:onInit()
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

self.gridState=xjMapGridStateType.eTransfer
end

function xjEntityData_transfer:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eTransfer,{self.sceneidx,self.tagPos[1]},needRefreshAOI)
end
end


function xjEntityData_transfer:onDelete()

end

return xjEntityData_transfer