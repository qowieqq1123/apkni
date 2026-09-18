
local newAreaIdLookup={
[18]=true,
[19]=true,
[20]=true,
[21]=true,
[22]=true,
[23]=true,
[24]=true,
}

function isometricMapSystem:unlockMountainArea(mapId,setMapId)
setMapId=setMapId or mapId
local datas=zongmenModel:getAllAreaData(mapId)
if datas then
for kk,vv in pairs(datas)do
if vv.opentime>0 then
self:unlockArea(setMapId,vv.area_id)
end
end
end
end

function isometricMapSystem:unlockArea(mapId,id)
_MapManager.SetAreaUnlockStatus(mapId,id,true)



end

function isometricMapSystem:drawArea(mapId,areaId,erase,layer,cfgId)
local check=self:isCanShowNewArea(mapId)
if areaId==-1 then
local cfgs=cfg_monijyareaconfig()
for k,v in pairs(cfgs)do
if v.sf_id==mapId and(check or not self:isNewMapArea(k))and not zongmenModel:isAreaUnlockInMap(mapId,k)then
_MapManager.DrawByArea(mapId,k,erase and-1 or TILE_TYPE.eLockArea,layer or mapLayer.Area1,cfgId or conditionConfig.lockArea)
end
end
else
_MapManager.DrawByArea(mapId,areaId,erase and-1 or TILE_TYPE.eLockArea,layer or mapLayer.Area1,cfgId or conditionConfig.lockArea)
end
end

function isometricMapSystem:playUnlockArea(areaId)
local mapId=zongmenModel:getMountainId()
local tmd=_MapManager.GetTilemapComponent(mapId,'TilemapDissolve',mapLayer.Area2)
if self.ua_tweener and not self.ua_tweener:IsComplete()then
self.ua_tweener:Complete(true)
self.ua_tweener:Kill()
self.ua_tweener=nil
end
tmd:SetDissolveValue(0)

self:drawArea(mapId,areaId,false,mapLayer.Area2)
self:drawArea(mapId,areaId,true)
local cfg=cfgHelper.get1(cfg_monijybasicconfig_get,1)
local cv=cfg.lock_area_brightness
local color=Color.New(cv,cv,cv,1)
_MapManager.SetCellColorInArea(mapId,areaId,color,mapLayer.Area2)
self.ua_tweener=tmd:PlayDissolve(1.5,2)
self.ua_tweener:SetEase(_Ease.Linear)
self.ua_tweener:OnComplete(function()
self:drawArea(mapId,areaId,true,mapLayer.Area2)
end)
end

function isometricMapSystem:setAreaCellBrightness(sfId,areaId,bLock)
local color1
local color2
if bLock then
local cfg=cfgHelper.get1(cfg_monijybasicconfig_get,1)
local cv=cfg.lock_area_brightness
color1=Color.New(cv,cv,cv,1)
cv=cfg.lock_road_brightness
color2=Color.New(cv,cv,cv,1)
else
color1=Color.New(1,1,1,1)
color2=Color.New(1,1,1,1)
end

_MapManager.SetCellColorInArea(sfId,areaId,color1,mapLayer.Area1)
_MapManager.SetCellColorInArea(sfId,areaId,color2,mapLayer.Road1)

local datas={}

if areaId>0 then
for k,v in pairs(self.repairDatas)do
if sfId==v.mapId and areaId==v.areaId then
datas[#datas+1]=k
local add_list=self:getAppendModel(v.guid)
if add_list then
for kk,vv in pairs(add_list)do
datas[#datas+1]=kk
end
end
end
end
for k,v in pairs(self.sundriseRecord)do
if sfId==v.mapId and areaId==v.areaId and v.type~=sundriseType.eBrand then
datas[#datas+1]=k
end
end
elseif areaId==-1 then
for k,v in pairs(self.repairDatas)do
if sfId==v.mapId and not zongmenModel:isAreaUnlockInMap(sfId,v.areaId)then
datas[#datas+1]=k
local add_list=self:getAppendModel(v.guid)
if add_list then
for kk,vv in pairs(add_list)do
datas[#datas+1]=kk
end
end
end
end
for k,v in pairs(self.sundriseRecord)do
if sfId==v.mapId and not zongmenModel:isAreaUnlockInMap(sfId,v.areaId)and v.type~=sundriseType.eBrand then
datas[#datas+1]=k
end
end
end

for i,v in ipairs(datas)do
_MapManager.SetFadeToColor(v,color1,bLock and 0 or 0.5,nil)
end
end

function isometricMapSystem:drawAreaLine(data,isErase)
if data then
for i,vv in ipairs(data)do
_MapManager.DrawLine(vv[1],vv[2],vv[3],vv[4],mapLayer.Area2,isErase and-1 or vv[5],true)
end
end
end

function isometricMapSystem:setNewAreaShow(mapId)
if mapId==mapIdType.zhufeng or mapId==mapIdType.zhufeng_hy or mapId==mapIdType.zhufeng_design then
local check=self:isCanShowNewArea(mapId)
local isRunMiniGame=webGLHelper:isRunMiniGame()
if isRunMiniGame then
surfaceControl:setSurfacePartActive(surfacePartIndex.areaLeft,mapId,check)
else
surfaceControl:setSurfacePartActive(surfacePartIndex.decorationLeft,mapId,not check)
surfaceControl:setSurfacePartActive(surfacePartIndex.areaLeft,mapId,check)




surfaceControl:setSurfacePartActive(surfacePartIndex.oldFeiShenTaiLeft,mapId,false)
surfaceControl:setSurfacePartActive(surfacePartIndex.newFeiShenTaiLeft,mapId,false)

end
end
end

local newAreaCheck=false
function isometricMapSystem:isCanShowNewArea(mapId)
mapId=mapId or zongmenModel:getMountainId()
if mapId==mapIdType.zhufeng_hy then
return visitControl:isCanShowNewArea()
else
return newAreaCheck or systemModel.isOpen(SYSTEM_DEFINE.eZongMenCeFeng)
end
end

function isometricMapSystem:initNewAreaCheck()
local mapId=mapIdType.zhufeng
if mapId~=zongmenModel:getMountainId()then
return
end
newAreaCheck=systemModel.isOpen(SYSTEM_DEFINE.eZongMenCeFeng)
end

function isometricMapSystem:isCanActiveNewArea()
return not newAreaCheck and systemModel.isOpen(SYSTEM_DEFINE.eZongMenCeFeng)
end

function isometricMapSystem:isNewMapArea(areaId)
return newAreaIdLookup[areaId]~=nil
end

function isometricMapSystem:isCanShowArea(areaId,mapId)
if self:isNewMapArea(areaId)then
return self:isCanShowNewArea(mapId)
end
return true
end

function isometricMapSystem:startActiveNewArea()
local mapId=mapIdType.zhufeng
if mapId~=zongmenModel:getMountainId()then
return
end
self:setCameraBorder()
end

function isometricMapSystem:activeNewArea(isInit)
local mapId=mapIdType.zhufeng
if mapId~=zongmenModel:getMountainId()then
return
end
newAreaCheck=true
self:setNewAreaShow(mapId)
for newAreaId,v in pairs(newAreaIdLookup)do
local isUnlock=zongmenModel:isAreaUnlock(newAreaId)
if not isUnlock then
if not isInit then
_MapManager.DrawByArea(mapId,newAreaId,TILE_TYPE.eLockArea,mapLayer.Area1,conditionConfig.lockArea)
_MapManager.LoadSundriseByArea(mapId,newAreaId,function(_mapId,areaId,cfgId,flip,pos)
self:createSundries({id=cfgId,flip=flip,pos=pos,areaId=areaId,mapId=_mapId})
end)
end
end
self:setAreaCellBrightness(mapId,newAreaId,not isUnlock)
end
self:showRepairBuilding(mapId)
self:setCameraBorder()
self:loadLockAreaRoad(mapId)
end