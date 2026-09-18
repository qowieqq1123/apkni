
function isometricMapSystem:initAppendObjectData()
self.appendObjects={}
end

function isometricMapSystem:createAppendModel(bdData)
local add_model=cfgHelper.get2(cfg_monijybuildconfig_get,bdData.build_id,'add_model')
if not add_model then
return
end
local list={}
local bdpos=_MapManager.ToVector3Int(bdData.x,bdData.y,0)
local mapId=_MapManager.GetObjectMapID(bdData.entityId)
for i,v in ipairs(add_model)do
local scale=self:getModelScale(v.model)
local offset=Vector3.New(v.offset[1],v.offset[2],0)
local guid=_MapManager.CreateTilemapObject(objectType.eDefault,v.model,nil,SortingLayers.ITBuilding,scale,mapId,bdpos,offset)
_MapManager.RunAnimator(guid,eAnimationID.stand)
list[guid]=v.model
end

self:setAppendModel(bdData.entityId,list)
end

function isometricMapSystem:setAppendModel(stId,list)
self.appendObjects[stId]=list
end

function isometricMapSystem:getAppendModel(stId)
return self.appendObjects[stId]
end

function isometricMapSystem:removeAppendModel(stId)
local add_list=self:getAppendModel(stId)
if add_list then
for k,v in pairs(add_list)do
_MapManager.RemoveTilemapObject(k)
end
self:setAppendModel(stId,nil)
end
end