









local xjTeamHandle_moJunFenShenAttack={}


function xjTeamHandle_moJunFenShenAttack:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.marchguid_str)
self.teamData=xianjieModel:getMarchTeamData(self.marchguid)
self.teamData.infoguidStr=tostring(self.teamData.infoguid)
self.hasAtkTarget=true
end


function xjTeamHandle_moJunFenShenAttack:checkMyEnemyType()
return xjEnemyType.eEnemy
end

function xjTeamHandle_moJunFenShenAttack:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_moJunFenShenAttack:getSpeedList()
return self.teamData.speedlist
end

function xjTeamHandle_moJunFenShenAttack:getSpeedCnt()
return#self:getSpeedList()
end


function xjTeamHandle_moJunFenShenAttack:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_moJunFenShenAttack:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_moJunFenShenAttack:getStartPos()
local teamData=self.teamData
local infoguidStr=teamData.infoguidStr
local monData=xianjieModel:getMoJunFenShenDataEx(infoguidStr)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.srcx,teamData.srcy,monData.gridWidth,monData.gridHeight)
return teamData.srcsceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_moJunFenShenAttack:getTargetPos()
local teamData=self.teamData
local actorId=teamData.taractorid
local zmData=xianjieModel:getZongMenData(actorId)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.tarx,teamData.tary,zmData.gridWidth,zmData.gridHeight)
return teamData.tarsceneidx,gridX_c,gridZ_c,zmData.gridWidth,zmData.gridHeight
end


function xjTeamHandle_moJunFenShenAttack:getTargetData()
local teamData=self.teamData
if teamData then
return xianjieModel:getZongMenData(teamData.taractorid)
end
return nil
end

function xjTeamHandle_moJunFenShenAttack:getTeamState()
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


function xjTeamHandle_moJunFenShenAttack:getMoveWayTime()
local movePath=self:getMyMovePath()
local speedlist=self:getSpeedList()
local battleTime=self.teamData.battleTime
return xianjieController:getMovePathWayTime2(movePath,speedlist,false,battleTime)
end

function xjTeamHandle_moJunFenShenAttack:getMyMovePath()
local movePath=self.movePath
if movePath then
return movePath
end
local sceneidx_,gridX_c_,gridZ_c_=self:getTargetPos()
local sceneidx,gridX_c,gridZ_c=self:getStartPos()
movePath=xianjieController:getMovePath(sceneidx,gridX_c,gridZ_c,sceneidx_,gridX_c_,gridZ_c_)
self.movePath=movePath
return movePath
end

function xjTeamHandle_moJunFenShenAttack:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_moJunFenShenAttack:geLerpTime()

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

function xjTeamHandle_moJunFenShenAttack:getOwnerName()
local teamData=self.teamData
if teamData.infoguidStr then
local infoguidStr=teamData.infoguidStr
local monData=xianjieModel:getMoJunFenShenDataEx(infoguidStr)
if monData then
return monData:getName()
end
end
return'佚名'
end

function xjTeamHandle_moJunFenShenAttack:getTeamEnityKey()
return self.teamData:getTeamEnityKey()
end

function xjTeamHandle_moJunFenShenAttack:getTargetName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eNone then
return"返回宗门"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
local teamData=self.teamData
if teamData.taractorid then
local zmData=xianjieModel:getZongMenData(teamData.taractorid)
if zmData then
return zmData.actorname
end
end
return'佚名'
end
end

function xjTeamHandle_moJunFenShenAttack:getTargetIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack then
return"icon_zjm_duiwu_2"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return"icon_zjm_duiwu_4"
end
end

function xjTeamHandle_moJunFenShenAttack:getTargetDesc(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return"已完成"
end
end

function xjTeamHandle_moJunFenShenAttack:getStateIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBattle then
return"button_xiangongui_4"
end
end

function xjTeamHandle_moJunFenShenAttack:checkIsShowProgress(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return true
end

return false
end

function xjTeamHandle_moJunFenShenAttack:checkIsOnMove(state,isBack)
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




function xjTeamHandle_moJunFenShenAttack:checkSpeeUpOpen(isWarning)
return false
end



function xjTeamHandle_moJunFenShenAttack:checkIsCanRetract()
return false
end



function xjTeamHandle_moJunFenShenAttack:onDelete()

end


function xjTeamHandle_moJunFenShenAttack:getMarchTeamModelSetID()













local id=20
local MJZJID=xianjieModel:getMoJunZhangJieID()
if MJZJID==MoJunZhangJieID.two then
id=32
end
return id
end


function xjTeamHandle_moJunFenShenAttack:getMarchTeamModelSkinID()
local teamData=self.teamData
if not teamData then
return 1
end
local sectdressId=teamData.marchdress
if not sectdressId or sectdressId==0 then
return 1
end
local type=UISettingModel:getSettingType(sectdressId)
local settingcfg=UISettingConfig.getCfg(type,sectdressId)
local skinId=1
if settingcfg then
skinId=settingcfg.xjSkinId
end
return skinId
end

return xjTeamHandle_moJunFenShenAttack