









local xjTeamHandle_moZongAttack={}


function xjTeamHandle_moZongAttack:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.marchguid_str)
self.teamData=xianjieModel:getMarchTeamData(self.marchguid)
self.teamData.infoguidStr=tostring(self.teamData.infoguid)
self.hasAtkTarget=true
end


function xjTeamHandle_moZongAttack:checkMyEnemyType()
return xjEnemyType.eEnemy
end

function xjTeamHandle_moZongAttack:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_moZongAttack:getSpeedList()
return self.teamData.speedlist
end

function xjTeamHandle_moZongAttack:getSpeedCnt()
return#self:getSpeedList()
end


function xjTeamHandle_moZongAttack:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_moZongAttack:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_moZongAttack:getStartPos()
local teamData=self.teamData
local infoguidStr=teamData.infoguidStr
local monData=xianjieModel:getMonsterDataEx(infoguidStr)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.srcx,teamData.srcy,monData.gridWidth,monData.gridHeight)
return teamData.srcsceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_moZongAttack:getTargetPos()
local teamData=self.teamData
local actorId=teamData.actorid
local zmData=xianjieModel:getZongMenData(actorId)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.tarx,teamData.tary,zmData.gridWidth,zmData.gridHeight)
return teamData.tarsceneidx,gridX_c,gridZ_c,zmData.gridWidth,zmData.gridHeight
end


function xjTeamHandle_moZongAttack:getTargetData()
local teamData=self.teamData
if teamData then
return xianjieModel:getZongMenData(teamData.actorid)
end
return nil
end

function xjTeamHandle_moZongAttack:getTeamState()
local curTime=gameUtilityModel.getServerShortTime2()
local bTime=self:getBeginTime()
local wayTime1=self:getMoveWayTime()
local arriveTime=bTime+wayTime1
local lerp=arriveTime-curTime
if lerp>0 then
return xjMarchTeamStateType.eGoto,{bTime,arriveTime,wayTime1},lerp
else
local battleTime=self.teamData.battleTime
local workTime=arriveTime+battleTime
lerp=workTime-curTime
if lerp>0 then
return xjMarchTeamStateType.eBattle,{arriveTime,workTime},lerp
else
return xjMarchTeamStateType.eNone,{arriveTime,workTime}
end
end
end


function xjTeamHandle_moZongAttack:getMoveWayTime()
local movePath=self:getMyMovePath()
local speedlist=self:getSpeedList()
local battleTime=self.teamData.battleTime
return xianjieController:getMovePathWayTime2(movePath,speedlist,false,battleTime)
end

function xjTeamHandle_moZongAttack:getMyMovePath()
local movePath=self.movePath
if movePath then
return movePath
end
local sceneidx_,gridX_c_,gridZ_c_=self:getTargetPos()
local sceneidx,gridX_c,gridZ_c=self:getStartPos()
movePath=xianjieController:getMovePath(sceneidx,gridX_c,gridZ_c,sceneidx_,gridX_c_,gridZ_c_,self.areaTransferSelects)
self.movePath=movePath
return movePath
end

function xjTeamHandle_moZongAttack:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_moZongAttack:geLerpTime()

local state,time=self:getTeamState()
local endTime=time[2]
local startTime=time[1]
local wayTime=endTime-startTime
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
lerpTime=math.ceil(lerpTime)
return lerpTime,wayTime
end

function xjTeamHandle_moZongAttack:getOwnerName()
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

function xjTeamHandle_moZongAttack:getTeamEnityKey()
return self.teamData:getTeamEnityKey()
end

function xjTeamHandle_moZongAttack:getTargetName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eNone then
return"返回宗门"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
local teamData=self.teamData
if teamData.actorid then
local zmData=xianjieModel:getZongMenData(teamData.actorid)
if zmData then
return zmData.actorname
end
end
return'佚名'
end
end

function xjTeamHandle_moZongAttack:getTargetIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack then
return"icon_zjm_duiwu_2"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return"icon_zjm_duiwu_4"
end
end

function xjTeamHandle_moZongAttack:getTargetDesc(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return"已完成"
end
end

function xjTeamHandle_moZongAttack:getStateIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBattle then
return"button_xiangongui_4"
end
end

function xjTeamHandle_moZongAttack:checkIsShowProgress(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return true
end

return false
end

function xjTeamHandle_moZongAttack:checkIsOnMove(state,isBack)
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





function xjTeamHandle_moZongAttack:checkSpeeUp(isWarning)
if not self:checkSpeeUpOpen(isWarning)then
return false
end
return true
end


function xjTeamHandle_moZongAttack:doSpeedUp(itemid)
if not self:checkSpeeUp(true)then
return false
end
xianjieController:reqMarchSpeedUp(self.marchguid,itemid)
return true
end


function xjTeamHandle_moZongAttack:onSpeedUp()
self.movePath=nil
end





function xjTeamHandle_moZongAttack:onDelete()

end


function xjTeamHandle_moZongAttack:getMarchTeamModelSetID()
local teamData=self.teamData
if not teamData then
return 14
end
if teamData.entitytype==xjServerEnityType.eMoJieMoZong_Small then
return 14
elseif teamData.entitytype==xjServerEnityType.eMoJieMoZong_Big then
return 17
end
return 14
end


function xjTeamHandle_moZongAttack:getMarchTeamModelSkinID()
















return 1
end

return xjTeamHandle_moZongAttack