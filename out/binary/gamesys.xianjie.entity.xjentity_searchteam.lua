









local xjEntity_searchTeam={}


function xjEntity_searchTeam:onInit()
self.canSelect=true
local data=self.data
self.cloudid=data[1]
self.isBack=data[2]
self:initData()
end

function xjEntity_searchTeam:initData()
local teamHandle=self:getTeamHandle()
self.movePath=teamHandle:getMyMovePath(self.isBack)
self.posList,self.linePosList=xianjieController:getMovePathToPosList(self.movePath)
self.moveTagList=teamHandle:getMoveTagList(self.movePath,self.isBack)
end

function xjEntity_searchTeam:getTeamHandle()
local cloudData=xianjieModel:getCloudData(self.cloudid)
return cloudData:getTeamHandle()
end

return xjEntity_searchTeam