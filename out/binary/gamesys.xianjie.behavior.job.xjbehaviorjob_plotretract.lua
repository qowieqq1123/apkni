









local xjBehaviorJob_plotRetract={}


function xjBehaviorJob_plotRetract:onInit()
local cloudid=self.tree:getShareValue('cloudid')
local plotIdx=self.tree:getShareValue('plotIdx')
self.cloudid=cloudid
self.plotIdx=plotIdx
local cloudData=xianjieModel:getCloudData(cloudid)
local plotParams=cloudData:getCloudPlotParams(plotIdx)
local cloudPlotData=cloudData:getCloudPlotData(plotIdx)
local teamHandle=cloudPlotData:getTeamHandle()

local retract=plotParams[6]
local bTime=retract[2][1].param_1
local wayTime=retract[1]
self.isBack=false
self.beginTime=bTime
self.endTime=bTime+wayTime
local func=function()
self:onSpeedUp()
end
self.tree:setShareValue('onSpeedUp',func)
end

function xjBehaviorJob_plotRetract:onSpeedUp()
local cloudData=xianjieModel:getCloudData(self.cloudid)
local plotParams=cloudData:getCloudPlotParams(self.plotIdx)
local retract=plotParams[6]
local bTime=retract[2][1].param_1
local wayTime=retract[1]
self.beginTime=bTime
self.endTime=bTime+wayTime
if self.entKey then
xianjieController:invokeEntityFunc(self.entKey,'onSpeedUp')
end
end


function xjBehaviorJob_plotRetract:onStart()


local cloudPlotData=xianjieModel:getCloudPlotData(self.cloudid,self.plotIdx)
local teamHandle=cloudPlotData:getTeamHandle()
if teamHandle:checkLineInScene()then
local d={self.cloudid,self.plotIdx,self.isBack,self.beginTime,true}
self.entKey=xianjieController:addTeamEntity(XJ_ENTITY_TYPE.ePlotTeam,d,true)
self.tree:setShareValue('teamEntityKey',self.entKey)
return true
end
return false
end

function xjBehaviorJob_plotRetract:tick(interval)
local time=gameUtilityModel.getServerShortTime2()
if time>=self.endTime then
return true
end
return false
end


function xjBehaviorJob_plotRetract:onDispose()
if self.entKey then
xianjieController:removeEntity(self.entKey)
self.tree:setShareValue('teamEntityKey',nil)
self.entKey=nil
end
self.tree:setShareValue('onSpeedUp',nil)
end

return xjBehaviorJob_plotRetract