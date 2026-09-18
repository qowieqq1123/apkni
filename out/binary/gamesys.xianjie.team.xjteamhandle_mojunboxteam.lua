









local xjTeamHandle_MoJunBoxTeam={}


function xjTeamHandle_MoJunBoxTeam:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.guid)
self.mjBoxMarch=xianjieModel:getMoJunBoxMarch(self.guid)
end


function xjTeamHandle_MoJunBoxTeam:checkMyEnemyType()
return xjEnemyType.eSelf
end

function xjTeamHandle_MoJunBoxTeam:getSpeedList()
local speedList=self.mjBoxMarch:getMarchData('dSpeedList')
return speedList
end

function xjTeamHandle_MoJunBoxTeam:getSpeedCnt()
return#self:getSpeedList()
end


function xjTeamHandle_MoJunBoxTeam:getSpeedMulti()
return 1
end

function xjTeamHandle_MoJunBoxTeam:getBeginTime()
local speedlist=self:getSpeedList()
return speedlist[1].param_1
end

function xjTeamHandle_MoJunBoxTeam:getBattleDuration()
local dCostDuration=self.mjBoxMarch:getMarchData('dCostDuration')
return dCostDuration[2]or 0
end

function xjTeamHandle_MoJunBoxTeam:getMoveWayTime()
local dCostDuration=self.mjBoxMarch:getMarchData('dCostDuration')
return dCostDuration[1]





end

function xjTeamHandle_MoJunBoxTeam:clearMovePath()
self.movePath_b=nil
self.movePath_f=nil
end

function xjTeamHandle_MoJunBoxTeam:getMyMovePath(isBack)
local movePath
if isBack then
movePath=self.movePath_b
else
movePath=self.movePath_f
end
if movePath then
return movePath
end
if isBack==nil then
local state=self:getTeamState()
if state==xjMarchTeamStateType.eGoto then
isBack=false
else
isBack=true
end
end

local sPoint=self.mjBoxMarch:getMarchData('dSinceInfo')
local sScene=sPoint[1]
local sGridX_c,sGridZ_c=xianjieController:worldGridCenterPos(sPoint[2],sPoint[3],sPoint[4],sPoint[5])


local tPoint=self.mjBoxMarch:getMarchData('dTargetInfo')
local tScene=tPoint[1]
local tGridX_c,tGridZ_c=xianjieController:worldGridCenterPos(tPoint[2],tPoint[3],tPoint[4],tPoint[5])

if not isBack then
movePath=xianjieController:getMovePath(sScene,sGridX_c,sGridZ_c,tScene,tGridX_c,tGridZ_c,self.areaTransferSelects)
self.movePath_f=movePath
else
movePath=xianjieController:getMovePath(tScene,tGridX_c,tGridZ_c,sScene,sGridX_c,sGridZ_c,self.areaTransferSelects)
self.movePath_b=movePath
end
return movePath
end


function xjTeamHandle_MoJunBoxTeam:getTeamState()
local curTime=gameUtilityModel.getServerShortTime2()
local bTime=self:getBeginTime()
local wayTime1=self:getMoveWayTime()
local arriveTime=bTime+wayTime1
local lerp=arriveTime-curTime
local flag=self.mjBoxMarch:getMarchData("dHandleFlag")
local dType=self.mjBoxMarch:getMarchData("dDataType")
if dType==mjMoJunBoxMarchTeamType.eNormal then
local battleTime=self:getBattleDuration()
local workTime=arriveTime+battleTime
if lerp>0 then
return xjMarchTeamStateType.eGoto,{bTime,arriveTime,wayTime1,workTime},lerp
else
lerp=workTime-curTime
if lerp>0 or flag==0 then
return xjMarchTeamStateType.eBattle,{arriveTime,workTime},lerp
else
local wayTime2=self:getMoveWayTime(true)
local arriveTime=workTime+wayTime2
lerp=arriveTime-curTime
if lerp>0 then
return xjMarchTeamStateType.eBack,{workTime,arriveTime,wayTime2},lerp
else
return xjMarchTeamStateType.eNone,{bTime,arriveTime}
end
end
end
else
return xjMarchTeamStateType.eBack,{bTime,arriveTime,wayTime1},lerp
end
end


function xjTeamHandle_MoJunBoxTeam:getMarchTeamModelSetID()
local state=self:getTeamState()
if state==xjMarchTeamStateType.eBack then
return 2
else
return 1
end
end


function xjTeamHandle_MoJunBoxTeam:getBaseWayTime(speed)
local movePath=self:getMyMovePath(false)
return xianjieController:getMovePathWayTime(movePath,speed)
end

function xjTeamHandle_MoJunBoxTeam:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_MoJunBoxTeam:geLerpTime()
local state,time=self:getTeamState()
local endTime=time[2]
local startTime=time[1]
local wayTime=endTime-startTime
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime,wayTime
end

function xjTeamHandle_MoJunBoxTeam:getOwnerName()
return playerModel:getActorName()
end

function xjTeamHandle_MoJunBoxTeam:getTargetPos()
local dTargetInfo=self.mjBoxMarch:getMarchData('dTargetInfo')
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(dTargetInfo[2],dTargetInfo[3],dTargetInfo[4],dTargetInfo[5])
return dTargetInfo[1],gridX_c,gridZ_c,dTargetInfo[4],dTargetInfo[5]
end


function xjTeamHandle_MoJunBoxTeam:getTargetData()
return xianjieModel:getResPointData(self.guid)
end


function xjTeamHandle_MoJunBoxTeam:getAtkTargetData()
local state=self:getTeamState()
if state==xjMarchTeamStateType.eGoto then
return self:getTargetData()
end
end

function xjTeamHandle_MoJunBoxTeam:getResPos()
local dSinceInfo=self.mjBoxMarch:getMarchData('dSinceInfo')
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(dSinceInfo[2],dSinceInfo[3],dSinceInfo[4],dSinceInfo[5])
return dSinceInfo[1],gridX_c,gridZ_c
end
function xjTeamHandle_MoJunBoxTeam:getTeamEnityKey()
return self.mjBoxMarch:getTeamEnityKey()
end

function xjTeamHandle_MoJunBoxTeam:getTargetName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack then
return"返回宗门"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
if state==xjMarchTeamStateType.eBattle then
return"魔君宝箱(采集中)"
else
return"魔君宝箱"
end
else
return"魔君宝箱(已采集)"
end
end

function xjTeamHandle_MoJunBoxTeam:getTargetDesc(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return"已完成"
end
end

function xjTeamHandle_MoJunBoxTeam:getTargetIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack then
return"icon_zjm_duiwu_2"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return"icon_zjm_duiwu_4"
end
end

function xjTeamHandle_MoJunBoxTeam:getStateIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBattle then
return"button_xiangongui_4"
end
end

function xjTeamHandle_MoJunBoxTeam:checkIsShowProgress(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return true
end

return false
end

function xjTeamHandle_MoJunBoxTeam:checkIsOnMove(state,isBack)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eGoto then
if isBack==nil or isBack==false then
return true
end
elseif state==xjMarchTeamStateType.eBack then
if isBack==nil or isBack==true then
return true
end
end
return false
end

function xjTeamHandle_MoJunBoxTeam:onDetailShow()
return false
end

function xjTeamHandle_MoJunBoxTeam:maskSpeeUp()
return true
end




function xjTeamHandle_MoJunBoxTeam:doRetract()
if not self:checkRetract(true)then
return false
end
return false
end


function xjTeamHandle_MoJunBoxTeam:onRetract()

end

function xjTeamHandle_MoJunBoxTeam:checkIsCanRetract()
return false
end



function xjTeamHandle_MoJunBoxTeam:onDelete()

end

return xjTeamHandle_MoJunBoxTeam