









local xjEntityData_MoJunBox={}


function xjEntityData_MoJunBox:onInit()
local cfg=self:getCfg()
local mojunData=xianjieModel:getMoJunData()
local build_id=mojunData.build_id
local mjCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,build_id)
self.sceneidx=xianjieController:getXJClientBuildSceneIndex(build_id)
self.gridX=cfg.pos[1]
self.gridZ=cfg.pos[2]
self.gridWidth=cfg.size[1]
self.gridHeight=cfg.size[2]
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

self.defaultSpeed=6

self:refreshState()
end

function xjEntityData_MoJunBox:refreshState()
self.endTime=0
self.state=0
local otherTime=10
local zmPos=xianjieModel:getZongMenOutPos_mojie()

if self.startTime>0 then
if self.finish==0 then
if zmPos~=nil then
local mojunData=xianjieModel:getMoJunData()
local cfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunData.mojunJieShu)
local maxEndTime=mojunData.killTime+cfg.boxDuration+1

local boxCfg=self:getCfg()
local speed=xianjieModel:getMoJunBoxTeamSpeed()
local wayTime=self:getBaseWayTime(speed)
local endTime=math.max(self.startTime+wayTime+otherTime,self.startTime+boxCfg.captureTime+otherTime)
self.endTime=math.min(endTime,maxEndTime)
self.state=1
end
else
self.state=2
end
end
end

function xjEntityData_MoJunBox:getBaseWayTime(speed)
local zmPos=xianjieModel:getZongMenOutPos_mojie()
local gridWidth,gridHeight=xianjieModel:getZongMenSize()
local sceneidx=zmPos[1]
local gridX=zmPos[2]
local gridZ=zmPos[3]
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,gridWidth,gridHeight)
local movePath=xianjieController:getMovePath(sceneidx,gridX_c,gridZ_c,self.sceneidx,self.gridX_c,self.gridZ_c,nil)
speed=speed or self.defaultSpeed
return xianjieController:getMovePathWayTime(movePath,speed)
end

function xjEntityData_MoJunBox:getCfg()
return cfgHelper.get1(cfg_seasonmojunboxconfig_get,self.boxId)
end

function xjEntityData_MoJunBox:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
local args={
seasonType=self.seasonType,
stageIndex=self.stageIndex,
boxId=self.boxId,
}
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eMoJunBox,args,needRefreshAOI)
end
end


function xjEntityData_MoJunBox:onDelete()

end

function xjEntityData_MoJunBox:getModelData()
local cfg=self:getCfg()
local modelSet=cfg.modelSet
local body=modelSet.model
local componets=modelSet.components or{}
local scale=modelSet.scale or 1
local flip=modelSet.flip==1
local offset=modelSet.offset and mathHelper.convertArrayToVector(modelSet.offset)or Vector3.zero
local mount=modelSet.mount
local effect=modelSet.effect
local slotInfo=nil
if modelSet.replaceSlot and modelSet.replaceIcon then
slotInfo={modelSet.replaceSlot,modelSet.replaceIcon}
end
return body,componets,scale,flip,offset,slotInfo,mount,effect
end

function xjEntityData_MoJunBox:refreshData(data)
for k,v in pairs(data)do
self[k]=v
end

self:refreshState()
end

return xjEntityData_MoJunBox