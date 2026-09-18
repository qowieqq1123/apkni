









local xjEntity_MoJunBoxTeam={}


function xjEntity_MoJunBoxTeam:onInit()
self.canSelect=true
local data=self.data
self.boxGuid=data[1]
self.isBack=data[2]
self.beginTime=data[3]
self:initData()

self.ent_name=FMT.fmt("{0} [{1}]",playerModel:getActorName(),loginModel:getMyServerName())
end

function xjEntity_MoJunBoxTeam:initData()
local teamHandle=self:getTeamHandle()



self.movePath=teamHandle:getMyMovePath(false)
self.posList,self.linePosList=xianjieController:getMovePathToPosList(self.movePath)
self.moveTagList=teamHandle:getMoveTagList(self.movePath,self.beginTime)
end

function xjEntity_MoJunBoxTeam:getTeamHandle()
local rpMarch=xianjieModel:getMoJunBoxMarch(self.boxGuid)
return rpMarch:getTeamHandle()
end

return xjEntity_MoJunBoxTeam