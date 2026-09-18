









local xjEntityData_XianMengEffect={}


function xjEntityData_XianMengEffect:onInit()
self.gridWidth=10
self.gridHeight=10
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)
end

function xjEntityData_XianMengEffect:refreshData(d)
self.gridX=d.gridX
self.gridZ=d.gridX
self.sceneidx=d.sceneidx
self.guildid=d.guildid
self.guildid_str=tostring(d.guildid)
self.lv=d.lv
self.fix=d.fix
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)
end

function xjEntityData_XianMengEffect:createEntity(needRefreshAOI)
if xianjienSceneIndexType:isMoJie(self.sceneidx)then
local canCreate=xianjieModel:getMoJieEnterConfig("guild")

if canCreate and xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eXianMengEffect,{},needRefreshAOI)
end
end
end


function xjEntityData_XianMengEffect:onDelete()

end

return xjEntityData_XianMengEffect