









local xjTeamHandle_notDataMarchTeam={}


function xjTeamHandle_notDataMarchTeam:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.marchguid_str)
self.teamData=xianjieModel:getNotDataMarchTeam(self.marchguid)
end

function xjTeamHandle_notDataMarchTeam:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_notDataMarchTeam:getSpeedList()
return self.teamData.speedlist
end

function xjTeamHandle_notDataMarchTeam:getSpeedCnt()
return#self:getSpeedList()
end


function xjTeamHandle_notDataMarchTeam:getSpeedMulti()
return 1
end

function xjTeamHandle_notDataMarchTeam:getBeginTime()
return nil
end


function xjTeamHandle_notDataMarchTeam:getZongMenPos()
return nil
end

function xjTeamHandle_notDataMarchTeam:getTargetPos()
return nil
end


function xjTeamHandle_notDataMarchTeam:getTargetData()
return nil
end

function xjTeamHandle_notDataMarchTeam:getTeamState()
return nil
end



function xjTeamHandle_notDataMarchTeam:getMoveWayTime(isBack)
return 0
end

function xjTeamHandle_notDataMarchTeam:getMyMovePath(isBack)
return nil
end

function xjTeamHandle_notDataMarchTeam:getMoveTagList(movePath,bTime)
return nil
end

function xjTeamHandle_notDataMarchTeam:geLerpTime()
return nil
end

function xjTeamHandle_notDataMarchTeam:getOwnerName()
local teamData=self.teamData
if teamData.actorid then
local zmData=xianjieModel:getZongMenData(teamData.actorid)
if zmData then
return zmData.actorname
end
end
return'佚名'
end

function xjTeamHandle_notDataMarchTeam:getTeamEnityKey()

return nil
end

function xjTeamHandle_notDataMarchTeam:getTargetName(state)
local str
local teamSceneIdx=self.teamData and(self.teamData.sceneidx or self.teamData.tarsceneidx)or xianjienSceneIndexType.eXianJie
local isMoJieTeam=xianjienSceneIndexType:isMoJie(teamSceneIdx)or false
if isMoJieTeam then
str="魔界行军队伍"
else
str="仙界行军队伍"
end
return str
end

function xjTeamHandle_notDataMarchTeam:getTargetIconName(state)
return"icon_zjm_duiwu_4"
end

function xjTeamHandle_notDataMarchTeam:getTargetDesc()
local str
local teamSceneIdx=self.teamData and(self.teamData.sceneidx or self.teamData.tarsceneidx)or xianjienSceneIndexType.eXianJie
local isMoJieTeam=xianjienSceneIndexType:isMoJie(teamSceneIdx)or false
if isMoJieTeam then
str="跳转至魔界可查看"
else
str="跳转至仙界可查看"
end
return str
end

function xjTeamHandle_notDataMarchTeam:getStateIconName(state)
return nil
end

function xjTeamHandle_notDataMarchTeam:checkIsShowProgress(state)
return false
end

function xjTeamHandle_notDataMarchTeam:checkIsOnMove(state,isBack)
return false
end

function xjTeamHandle_notDataMarchTeam:checkMyWaiPai()
return self.teamData.isMyWaiPai
end


function xjTeamHandle_notDataMarchTeam:maskSpeeUp()
return false
end




function xjTeamHandle_notDataMarchTeam:doRetract()
return false
end

function xjTeamHandle_notDataMarchTeam:checkRetract()
return false
end



function xjTeamHandle_notDataMarchTeam:checkDetailOpen(isWarning)
return false
end

function xjTeamHandle_notDataMarchTeam:onDetailShow()
return false
end



function xjTeamHandle_notDataMarchTeam:onDelete()

end

return xjTeamHandle_notDataMarchTeam