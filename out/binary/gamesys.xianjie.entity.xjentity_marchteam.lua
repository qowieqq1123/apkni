









local xjEntity_marchTeam={}


function xjEntity_marchTeam:onInit()
self.canSelect=true
local data=self.data
self.marchguid=data[1]
self.isBack=data[2]
self.beginTime=data[3]
self:initData()

local marchData=xianjieModel:getMarchTeamData(self.marchguid)
if marchData.marchtype==xjServerMarchType.eMoJunFenShenAttack then
self.ent_name="魔君"
else
local actorId=marchData.srcactorid or marchData.actorid
local zmData=xianjieModel:getZongMenData(actorId)
local actorName=zmData.actorname
local serverName=loginModel:getServerName(zmData.serverid)
self.ent_name=FMT.fmt("{0} [{1}]",actorName,serverName)

end
end

function xjEntity_marchTeam:initData()
local teamHandle=self:getTeamHandle()



self.movePath=teamHandle:getMyMovePath(self.isBack)
local isIgnoreArea=teamHandle.isIgnoreArea
self.posList,self.linePosList=xianjieController:getMovePathToPosList(self.movePath,nil,isIgnoreArea)
self.moveTagList=teamHandle:getMoveTagList(self.movePath,self.beginTime)
end

function xjEntity_marchTeam:getTeamHandle()
local teamData=xianjieModel:getMarchTeamData(self.marchguid)
if teamData==nil then
logErr("获取队伍数据失败",tostring(self.marchguid))
end
return teamData:getTeamHandle()
end

return xjEntity_marchTeam