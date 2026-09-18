









local xjEntityData_NPC={}


function xjEntityData_NPC:onInit()
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

self.gridState=xjMapGridStateType.eNPC
end

function xjEntityData_NPC:refreshData(d)

end

function xjEntityData_NPC:getCfg()
return cfgHelper.get1(cfg_tasknpcconfig_get,self.npcid)
end

function xjEntityData_NPC:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eNPC,{self.npcid},needRefreshAOI)
end
end


function xjEntityData_NPC:onDelete()

end

return xjEntityData_NPC