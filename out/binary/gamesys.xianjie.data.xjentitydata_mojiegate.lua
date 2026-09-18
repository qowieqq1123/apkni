









local xjEntityData_mojieGate={}


function xjEntityData_mojieGate:onInit()
self.entitytype=xjServerEnityType.eClientBuild
local typeCfg=cfgHelper.get1(cfg_fairylandentitytypeconfig_get,self.entitytype)
local cfg=self:getCfg()
self.entityId=cfg.build_id

local entityCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.entityId)

self.sceneidx=xianjieController:getXJClientBuildSceneIndex(self.entityId)
local centerPos_x=entityCfg.x
local centerPos_y=entityCfg.y

self.gridX,self.gridZ,self.gridWidth,self.gridHeight=xianjieModel:getClientPositionAndSize(centerPos_x,centerPos_y,typeCfg.size[1],typeCfg.size[2],entityCfg.size[1],entityCfg.size[2])
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)
self.gridX_original=centerPos_x
self.gridZ_original=centerPos_y
self.gridState=xjMapGridStateType.eMoJieGate
self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eKillBossMonster,1)

self.isGate=true
end

function xjEntityData_mojieGate:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then

local lodRange=xianjieController:getCameraLodRange()
local husParams={0,lodRange[1],0.015,1,0,1}
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eMoJieGate,{self.gateId,husParams=husParams},needRefreshAOI)
return true
end

return false
end

function xjEntityData_mojieGate:refreshData(data)
self.data=data
end


function xjEntityData_mojieGate:onDelete()

end

function xjEntityData_mojieGate:getCfg()
return cfgHelper.get1(cfg_devildomscenegateconfig_get,self.gateId)
end

function xjEntityData_mojieGate:getAtkSize()
local entityCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.entityId)
local atkSizeCfg=entityCfg.clientParam.atkSize
if atkSizeCfg then
return Vector2(atkSizeCfg[1],atkSizeCfg[2])
else
return self:getWorldSize()
end
end

function xjEntityData_mojieGate:getName()
local cfg=self:getCfg()
local gateName=cfg and cfg.name or"未知关口"
local gateXYSceneIndex=cfg.area
local xyName=xianjieController:getCrossServerNamebySCidx(gateXYSceneIndex)
local nameStr=FMT.fmt("{0}-{1}",xyName,gateName)
return nameStr
end


function xjEntityData_mojieGate:getBaseWayTime(isIgnoreArea)
local gridX_c,gridZ_c,sceneidx=xianjieModel:getZongMenWorldGridCenterPos()
local zmData=xianjieModel:getMyZongMenData()

local s_areaID=xianjieModel:checkMapGridDataAreaID(zmData.sceneidx,zmData.gridX,zmData.gridZ)
local actuallyTarX=self.gridX_c
local actuallyTarY=self.gridZ_c
if s_areaID<=0 then

local gateCfg=self:getCfg()
local pos=gateCfg.tagPos
actuallyTarX=pos and pos[1]or nil
actuallyTarY=pos and pos[2]or nil
end

local movePath=xianjieController:getMovePath(sceneidx,gridX_c,gridZ_c,self.sceneidx,actuallyTarX,actuallyTarY,nil,isIgnoreArea)
local speed=self.defaultSpeed
if speed==nil then

loggerUtil.logErrFMT("数据类型{0}没有设置默认速度, 请在数据onInit是赋值默认速度",self.dataType)

speed=xianjieModel:getCloudSearchSpeed()
end
return xianjieController:getMovePathWayTime(movePath,speed,isIgnoreArea)
end

return xjEntityData_mojieGate