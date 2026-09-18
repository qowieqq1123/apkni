









local xjTeamHandle_respointRetract={}


function xjTeamHandle_respointRetract:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.guid)
self.rpMarch=xianjieModel:getResPointMarch(self.guid)
end

function xjTeamHandle_respointRetract:getSpeedList()
return self.rpMarch:getMarchData('dSpeedList')
end

function xjTeamHandle_respointRetract:getSpeedCnt()
return#self:getSpeedList()
end

function xjTeamHandle_respointRetract:getBeginTime()
local speedlist=self:getSpeedList()
return speedlist[1].param_1
end


function xjTeamHandle_respointRetract:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_respointRetract:clearMovePath()
self.movePath=nil
end

function xjTeamHandle_respointRetract:getTeamState()
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



function xjTeamHandle_respointRetract:getMoveWayTime()
local durations=self.rpMarch:getMarchData('dCostDuration')
return durations[1]
end

function xjTeamHandle_respointRetract:calculateMoveWayTime()
local movePath=self:getMyMovePath()
local speedlist=self:getSpeedList()
return xianjieController:getMovePathWayTime2(movePath,speedlist,false,0)
end

function xjTeamHandle_respointRetract:getMyMovePath()
local movePath=self.movePath
if movePath then
return movePath
end

local sPoint=self.rpMarch:getMarchData('dSinceInfo')
local sScene=sPoint[1]
local sGridX_c,sGridZ_c=xianjieController:worldGridCenterPos(sPoint[2],sPoint[3],sPoint[4],sPoint[5])


local tPoint=self.rpMarch:getMarchData('dTargetInfo')
local tScene=tPoint[1]
local tGridX_c,tGridZ_c=xianjieController:worldGridCenterPos(tPoint[2],tPoint[3],tPoint[4],tPoint[5])

movePath=xianjieController:getMovePath(sScene,sGridX_c,sGridZ_c,tScene,tGridX_c,tGridZ_c,self.areaTransferSelects)
self.movePath=movePath
return movePath
end

function xjTeamHandle_respointRetract:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_respointRetract:geLerpTime()
local state,time=self:getTeamState()
local endTime=time[2]
local startTime=time[1]
local wayTime=endTime-startTime
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime,wayTime
end

function xjTeamHandle_respointRetract:getOwnerName()
return playerModel:getActorName()
end

function xjTeamHandle_respointRetract:getTargetPos()
local dTargetInfo=self.rpMarch:getMarchData('dTargetInfo')
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(dTargetInfo[2],dTargetInfo[3],dTargetInfo[4],dTargetInfo[5])
return dTargetInfo[1],gridX_c,gridZ_c,dTargetInfo[4],dTargetInfo[5]
end

function xjTeamHandle_respointRetract:getResPos()
local dSinceInfo=self.rpMarch:getMarchData('dSinceInfo')
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(dSinceInfo[2],dSinceInfo[3],dSinceInfo[4],dSinceInfo[5])
return dSinceInfo[1],gridX_c,gridZ_c
end

function xjTeamHandle_respointRetract:getTeamEnityKey()
return self.rpMarch:getTeamEnityKey()
end

function xjTeamHandle_respointRetract:getTargetName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eNone then
local dTargetInfo=self.rpMarch:getMarchData('dTargetInfo')
local str=FMT.fmt("行军返回中({0},{1})",dTargetInfo[2],dTargetInfo[3])
return str

end
end

function xjTeamHandle_respointRetract:getTargetDesc(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return"已完成"
end
end

function xjTeamHandle_respointRetract:getTargetIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eGoto then
return"icon_zjm_duiwu_4"
end
end

function xjTeamHandle_respointRetract:getStateIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBattle then
return"icon_zjm_duiwu_2"
end
end

function xjTeamHandle_respointRetract:checkIsShowProgress(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return true
end

return false
end

function xjTeamHandle_respointRetract:checkIsOnMove(state,isBack)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eGoto then
return true
end

return false
end


function xjTeamHandle_respointRetract:maskSpeeUp()
return true
end



function xjTeamHandle_respointRetract:maskRetract()
return true
end



function xjTeamHandle_respointRetract:onDelete()

end

return xjTeamHandle_respointRetract