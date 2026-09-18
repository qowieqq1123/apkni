









local xjTeamHandle_zhenYanBack={}


function xjTeamHandle_zhenYanBack:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.marchguid_str)
self.teamData=xianjieModel:getMarchTeamData(self.marchguid)
self.teamData.infoguidStr=tostring(self.teamData.infoguid)
end


function xjTeamHandle_zhenYanBack:checkMyEnemyType()
return xjEnemyType.eEnemy
end

function xjTeamHandle_zhenYanBack:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_zhenYanBack:getSpeedList()
return self.teamData.speedlist
end

function xjTeamHandle_zhenYanBack:getSpeedCnt()
return#self:getSpeedList()
end


function xjTeamHandle_zhenYanBack:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_zhenYanBack:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_zhenYanBack:getResPos()
local teamData=self.teamData
local actorId=teamData.actorid
local zmData=xianjieModel:getZongMenData(actorId)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.srcx,teamData.srcy,zmData.gridWidth,zmData.gridHeight)
return teamData.tarsceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_zhenYanBack:getTargetPos()
local teamData=self.teamData
local infoguidStr=teamData.infoguidStr
local monData=xianjieModel:getMonsterDataEx(infoguidStr)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.tarx,teamData.tary,monData.gridWidth,monData.gridHeight)
return teamData.srcsceneidx,gridX_c,gridZ_c,monData.gridWidth,monData.gridHeight
end

function xjTeamHandle_zhenYanBack:getTeamState()
local curTime=gameUtilityModel.getServerShortTime2()
local bTime=self:getBeginTime()
local wayTime=self:getMoveWayTime()
local arriveTime=bTime+wayTime
local lerp=arriveTime-curTime
if lerp>0 then
return xjMarchTeamStateType.eGoto,{bTime,arriveTime,wayTime},lerp
else
return xjMarchTeamStateType.eNone,{bTime,arriveTime}
end
end


function xjTeamHandle_zhenYanBack:getMarchTeamModelSetID()

local teamData=self.teamData
local fightres=teamData.fightres
if fightres==1 then
return 24
elseif fightres==2 then
return 25
else
return 25
end
end


function xjTeamHandle_zhenYanBack:getMoveWayTime()
local movePath=self:getMyMovePath()
local speedlist=self:getSpeedList()
return xianjieController:getMovePathWayTime2(movePath,speedlist,false,0)
end

function xjTeamHandle_zhenYanBack:getMyMovePath()
local movePath=self.movePath
if movePath then
return movePath
end
local sceneidx_,gridX_c_,gridZ_c_=self:getTargetPos()
local sceneidx,gridX_c,gridZ_c=self:getResPos()
movePath=xianjieController:getMovePath(sceneidx,gridX_c,gridZ_c,sceneidx_,gridX_c_,gridZ_c_,self.areaTransferSelects)
self.movePath=movePath
return movePath
end

function xjTeamHandle_zhenYanBack:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_zhenYanBack:geLerpTime()

local state,time=self:getTeamState()
local endTime=time[2]
local startTime=time[1]
local wayTime=endTime-startTime
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime,wayTime
end

function xjTeamHandle_zhenYanBack:getOwnerName()
local teamData=self.teamData
if teamData.infoguidStr then
local infoguidStr=teamData.infoguidStr
local monData=xianjieModel:getMonsterDataEx(infoguidStr)
if monData then
return monData:getName()
end
end
return'佚名'
end

function xjTeamHandle_zhenYanBack:getTeamEnityKey()
return self.teamData:getTeamEnityKey()
end

function xjTeamHandle_zhenYanBack:getTargetName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eNone then
local teamData=self.teamData
local str=FMT.fmt("行军返回中({0},{1})",teamData.tarx,teamData.tary)
return str
end
end

function xjTeamHandle_zhenYanBack:getTargetIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eGoto then
return"icon_zjm_duiwu_4"
end
end

function xjTeamHandle_zhenYanBack:getTargetDesc(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return"已完成"
end
end

function xjTeamHandle_zhenYanBack:getStateIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBattle then
return"icon_zjm_duiwu_2"
end
end

function xjTeamHandle_zhenYanBack:checkIsShowProgress(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return true
end

return false
end

function xjTeamHandle_zhenYanBack:checkIsOnMove(state,isBack)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eGoto then
return true
end

return false
end

function xjTeamHandle_zhenYanBack:checkMyWaiPai()
return self.teamData.isMyWaiPai
end



function xjTeamHandle_zhenYanBack:checkSpeeUp(isWarning)
if not self:checkSpeeUpOpen(isWarning)then
return false
end
return true
end


function xjTeamHandle_zhenYanBack:doSpeedUp(itemid)
if not self:checkSpeeUp(true)then
return false
end
xianjieController:reqMarchSpeedUp(self.marchguid,itemid)
return true
end


function xjTeamHandle_zhenYanBack:onSpeedUp()
self.movePath=nil
end



function xjTeamHandle_zhenYanBack:maskRetract()
return true
end



function xjTeamHandle_zhenYanBack:onDelete()

end


function xjTeamHandle_zhenYanBack:getMarchTeamModelSkinID()















return 1
end

return xjTeamHandle_zhenYanBack