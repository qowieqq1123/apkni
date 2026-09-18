









local xjEntityData_cloudPlot={}


function xjEntityData_cloudPlot:onInit()
local pos=self.cfg.pos
local size=self.cfg.size
self.gridX=pos[1]
self.gridZ=pos[2]
self.gridWidth=size[1]
self.gridHeight=size[2]
self.sceneidx=xianjienSceneIndexType.eXianJie
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(pos[1],pos[2],size[1],size[2])
self.gridX_c=gridX_c
self.gridZ_c=gridZ_c
self.battleTime=self.cfg.battleTime or xianjieModel:getPlotBattleTime()

self.gridState=xjMapGridStateType.eCloudPlot
end

function xjEntityData_cloudPlot:getCurType()
return self.cfg.data[1]
end

function xjEntityData_cloudPlot:getBaseSpeedList()
local speedlist={}
local baseSpeed=xianjieModel:getCloudSearchSpeed()

local curTime=gameUtilityModel.getServerShortTime()
speedlist[1]={param_1=curTime,param_2=baseSpeed/2}


return speedlist
end


function xjEntityData_cloudPlot:createEntity(needRefreshAOI)
if self.ent_key==nil then
local typo=self:getCurType()
if typo==xjCloudPlotType.eMonster then
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.ePlotMonster,{self.cloudid,self.plotIdx},needRefreshAOI)
else
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.ePlotEvent,{self.cloudid,self.plotIdx},needRefreshAOI)
end
end
end


function xjEntityData_cloudPlot:initBehaviorData()
if self.behaviorData==nil then
self.behaviorData={cloudid=self.cloudid,plotIdx=self.plotIdx}
end
end


function xjEntityData_cloudPlot:initTeamHandle()
if self.teamHandleID==nil then
self.teamHandleID=xianjieController:addXJTeamHandle(xjTeamHandleType.ePlotTeam,{cloudid=self.cloudid,plotIdx=self.plotIdx})
end
self:initTeamHandle_retract()
end

function xjEntityData_cloudPlot:clearTeamHandle()
if self.teamHandleID~=nil then
xianjieController:removeXJTeamHandle(self.teamHandleID)
self.teamHandleID=nil
end
self:clearTeamHandle_retract()
end

function xjEntityData_cloudPlot:initTeamHandle_retract()
if self.teamHandleID_retract==nil then
self.teamHandleID_retract=xianjieController:addXJTeamHandle(xjTeamHandleType.ePlotTeamReract,{cloudid=self.cloudid,plotIdx=self.plotIdx})
end
end

function xjEntityData_cloudPlot:clearTeamHandle_retract()
if self.teamHandleID_retract~=nil then
xianjieController:removeXJTeamHandle(self.teamHandleID_retract)
self.teamHandleID_retract=nil
end
end

function xjEntityData_cloudPlot:getTeamHandle_retract()
if self.teamHandleID_retract~=nil then
return xianjieController:getXJTeamHandle(self.teamHandleID_retract)
end
end


function xjEntityData_cloudPlot:onDelete()

end

return xjEntityData_cloudPlot