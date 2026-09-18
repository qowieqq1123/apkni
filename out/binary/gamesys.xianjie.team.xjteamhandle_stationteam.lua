









local xjTeamHandle_stationTeam={}


function xjTeamHandle_stationTeam:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.guid_str)
self.teamData=xianjieModel:getSelfStationTeamData(self.guid)
end

function xjTeamHandle_stationTeam:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_stationTeam:getSpeedList()
return self.teamData.speedlist
end

function xjTeamHandle_stationTeam:getSpeedCnt()
return#self:getSpeedList()
end


function xjTeamHandle_stationTeam:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_stationTeam:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_stationTeam:getZongMenPos()
local zmData=xianjieModel:getMyZongMenData()
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(zmData.gridX_c,zmData.gridZ_c,zmData.gridWidth,zmData.gridHeight)
return zmData.sceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_stationTeam:getTargetPos()

local targetData=xianjieModel:getStationData(self.guid)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(targetData.gridX,targetData.gridZ,targetData.gridWidth,targetData.gridHeight)
return targetData.sceneidx,gridX_c,gridZ_c,targetData.gridWidth,targetData.gridHeight
end


function xjTeamHandle_stationTeam:getTargetData()
return xianjieModel:getStationData(self.guid)
end

function xjTeamHandle_stationTeam:getTeamState()
return nil
end



function xjTeamHandle_stationTeam:getMoveWayTime(isBack)
return 0
end

function xjTeamHandle_stationTeam:getMyMovePath(isBack)
return nil
end

function xjTeamHandle_stationTeam:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_stationTeam:geLerpTime()
return nil
end

function xjTeamHandle_stationTeam:getOwnerName()
local teamData=self.teamData
if teamData.actorid then
local zmData=xianjieModel:getZongMenData(teamData.actorid)
if zmData then
return zmData.actorname
end
end
return'佚名'
end

function xjTeamHandle_stationTeam:getTeamEnityKey()

return nil
end

function xjTeamHandle_stationTeam:getTargetName(state)
local str="空地"
local targetData=xianjieModel:getStationData(self.guid)
if targetData then
str=FMT.fmt("空地({0},{1})",targetData.gridX,targetData.gridZ)
end
return str
end

function xjTeamHandle_stationTeam:getTargetIconName(state)
return"icon_zjm_duiwu_5"
end

function xjTeamHandle_stationTeam:getTargetDesc()
local teamSceneIdx=self.teamData and self.teamData.sceneidx or xianjienSceneIndexType.eXianJie
local teamLogicSceneType=xianjieController:transSceneIdxToLogicSceneType(teamSceneIdx)
local nowSceneIdx=xianjieModel:getSceneIndex()
local nowLogicSceneType=xianjieController:transSceneIdxToLogicSceneType(nowSceneIdx)
if teamLogicSceneType~=nowLogicSceneType then
local str=""
if teamLogicSceneType==eXianJieLogicSceneType.eMoJie then
str="魔界驻扎中"
elseif teamLogicSceneType==eXianJieLogicSceneType.eMoGong then
str="宝库驻扎中"
elseif teamLogicSceneType==eXianJieLogicSceneType.eXianJie then
str="仙界驻扎中"
end
return str
else
return"驻扎中"
end
end

function xjTeamHandle_stationTeam:getStateIconName(state)
return nil
end

function xjTeamHandle_stationTeam:checkIsShowProgress(state)
return false
end

function xjTeamHandle_stationTeam:checkIsOnMove(state,isBack)
return false
end

function xjTeamHandle_stationTeam:checkMyWaiPai()
return self.teamData.isMyWaiPai
end


function xjTeamHandle_stationTeam:maskSpeeUp()
return true
end




function xjTeamHandle_stationTeam:doRetract()
local guid=self.guid
local content='该部队驻扎中，您确定要召回队伍吗？'
local callback=function()
xianjieController:reqOrder(int64.new(tostring(guid)),xjOrderType.eStationBack,{},{},"");
end
local dialogue=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=callback
})
dialogue:show()
return true
end

function xjTeamHandle_stationTeam:checkRetract()
local teamSceneIdx=self.teamData and self.teamData.sceneidx or xianjienSceneIndexType.eXianJie
local isMoJieTeam=xianjienSceneIndexType:isMoJie(teamSceneIdx)or false
local nowSceneIdx=xianjieModel:getSceneIndex()
local isInMoJie=nowSceneIdx and xianjienSceneIndexType:isMoJie(nowSceneIdx)or false
if isMoJieTeam~=isInMoJie then
return false
end

return true
end



function xjTeamHandle_stationTeam:checkDetailOpen(isWarning)
return false
end

function xjTeamHandle_stationTeam:onDetailShow()
return false
end



function xjTeamHandle_stationTeam:onDelete()

end

return xjTeamHandle_stationTeam