









local xjEntityData_XJXingYu={}


function xjEntityData_XJXingYu:onInit()
self.sceneidx=self.scene
local pos=self.pos
self.gridX=pos[1]
self.gridZ=pos[2]
local size=self.size
self.gridWidth=size[1]
self.gridHeight=size[2]
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)
self.gridState=xjMapGridStateType.eXJXingYu
end


function xjEntityData_XJXingYu:onDelete()

end

function xjEntityData_XJXingYu:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eXJXingYu,{xyId=self.xyId},needRefreshAOI)
end
end


return xjEntityData_XJXingYu