









local xjEntity_RPMarchTeam={}


function xjEntity_RPMarchTeam:onInit()
self.canSelect=true
local data=self.data
self.rpGuid=data[1]
self.isBack=data[2]
self.beginTime=data[3]
self:initData()

self.ent_name=FMT.fmt("{0} [{1}]",playerModel:getActorName(),loginModel:getMyServerName())
end

function xjEntity_RPMarchTeam:initData()
local teamHandle=self:getTeamHandle()



self.movePath=teamHandle:getMyMovePath(self.isBack)
self.posList,self.linePosList=xianjieController:getMovePathToPosList(self.movePath)
self.moveTagList=teamHandle:getMoveTagList(self.movePath,self.beginTime)
end

function xjEntity_RPMarchTeam:getTeamHandle()
local rpMarch=xianjieModel:getResPointMarch(self.rpGuid)
return rpMarch:getTeamHandle()
end

return xjEntity_RPMarchTeam