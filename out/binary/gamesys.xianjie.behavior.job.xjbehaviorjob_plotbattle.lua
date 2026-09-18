









local xjBehaviorJob_plotBattle={}


function xjBehaviorJob_plotBattle:onInit()
local cloudid=self.tree:getShareValue('cloudid')
local plotIdx=self.tree:getShareValue('plotIdx')
self.cloudid=cloudid
self.plotIdx=plotIdx

local cloudData=xianjieModel:getCloudData(cloudid)
local plotParams=cloudData:getCloudPlotParams(plotIdx)
local cloudPlotData=cloudData:getCloudPlotData(plotIdx)
local teamHandle=cloudPlotData:getTeamHandle()

local bTime=plotParams[1][1].param_1
local wayTime=teamHandle:getMoveWayTime(false)
local battleTime=cloudPlotData.battleTime
self.endTime=bTime+wayTime+battleTime
end


function xjBehaviorJob_plotBattle:onStart()


local cloudPlotData=xianjieModel:getCloudPlotData(self.cloudid,self.plotIdx)
local teamHandle=cloudPlotData:getTeamHandle()
if teamHandle:checkTargetInScene()then
self.ent_key=cloudPlotData.ent_key
if self.ent_key then
xianjieController:invokeEntityFunc(self.ent_key,'activeBattleEffect',true)
end
return true
end
return false
end

function xjBehaviorJob_plotBattle:tick(interval)
local time=gameUtilityModel.getServerShortTime2()
if time>=self.endTime then
return true
end
return false
end


function xjBehaviorJob_plotBattle:onDispose()
if self.ent_key then
xianjieController:invokeEntityFunc(self.ent_key,'activeBattleEffect',false)
self.ent_key=nil
end
end

return xjBehaviorJob_plotBattle