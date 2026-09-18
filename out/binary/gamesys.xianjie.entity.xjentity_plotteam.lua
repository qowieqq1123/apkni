









local xjEntity_plotTeam={}


function xjEntity_plotTeam:onInit()
self.canSelect=true
local data=self.data
self.cloudid=data[1]
self.plotIdx=data[2]
self.isBack=data[3]
self.beginTime=data[4]
self.isRetract=data[5]
self:initData()
end

function xjEntity_plotTeam:initData()
local teamHandle=self:getTeamHandle()
self.movePath=teamHandle:getMyMovePath(self.isBack)
self.posList,self.linePosList=xianjieController:getMovePathToPosList(self.movePath)
self.moveTagList=teamHandle:getMoveTagList(self.movePath,self.beginTime)
end

function xjEntity_plotTeam:getTeamHandle()
local cloudPlotData=xianjieModel:getCloudPlotData(self.cloudid,self.plotIdx)
if self.isRetract then
return cloudPlotData:getTeamHandle_retract()
else
return cloudPlotData:getTeamHandle()
end
end

return xjEntity_plotTeam