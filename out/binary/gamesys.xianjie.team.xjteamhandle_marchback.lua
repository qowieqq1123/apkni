









local xjTeamHandle_marchBack={}


function xjTeamHandle_marchBack:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.marchguid_str)
self.teamData=xianjieModel:getMarchTeamData(self.marchguid)

local teamData=self.teamData
local isIgnoreArea=false
if teamData and teamData.entitytype==xjServerEnityType.eClientBuild then
if xianjienSceneIndexType:isMoJie(teamData.srcsceneidx)then
local isGate=xianjieModel:checkClientBuildIsGateByPos(teamData.srcx,teamData.srcy)
isIgnoreArea=isGate
end
end
self.isIgnoreArea=isIgnoreArea
end


function xjTeamHandle_marchBack:checkMyEnemyType()
return xianjieModel:checkEnemyType(self.teamData.actorid)
end

function xjTeamHandle_marchBack:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_marchBack:getSpeedList()
return self.teamData.speedlist
end

function xjTeamHandle_marchBack:getSpeedCnt()
return#self:getSpeedList()
end


function xjTeamHandle_marchBack:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_marchBack:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_marchBack:getResPos()
local teamData=self.teamData
local size=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,teamData.entitytype,'size')

local srcx=teamData.srcx
local srcy=teamData.srcy
if teamData.actuallySrcX and teamData.actuallySrcY then
srcx=teamData.actuallySrcX
srcy=teamData.actuallySrcY
end

local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(srcx,srcy,size[1],size[2])
return teamData.srcsceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_marchBack:getTargetPos()
local teamData=self.teamData
local size=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,xjServerEnityType.eActor,'size')
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.tarx,teamData.tary,size[1],size[2])
return teamData.tarsceneidx,gridX_c,gridZ_c,size[1],size[2]
end

function xjTeamHandle_marchBack:getTeamState()
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


function xjTeamHandle_marchBack:getMarchTeamModelSetID()

local teamData=self.teamData
local fightres=teamData.fightres
local premarchtype=teamData.premarchtype
local p1,p2,p3
if premarchtype==xjServerMarchType.eKill then
p1,p2,p3=1,2,3
elseif premarchtype==xjServerMarchType.eJiJieChuZheng or premarchtype==xjServerMarchType.eJiJieJoin then
p1,p2,p3=4,11,12
elseif premarchtype==xjServerMarchType.eKillBossMonster then
p1,p2,p3=4,5,6
elseif premarchtype==xjServerMarchType.eStation then
p1,p2,p3=4,5,6
elseif premarchtype==xjServerMarchType.eYuanZhu then
p1,p2,p3=4,5,6
elseif premarchtype==xjServerMarchType.eAttackRole then
p1,p2,p3=4,5,6
elseif premarchtype==xjServerMarchType.eMoJunYaoMo then
p1,p2,p3=4,5,6
elseif premarchtype==xjServerMarchType.eMoJunFenShenAttack then
p1,p2,p3=4,5,6
elseif premarchtype==xjServerMarchType.eMoJieSG then
p1,p2,p3=4,5,6
elseif premarchtype==xjServerMarchType.eMoJingZhenJi_Normal then
p1,p2,p3=4,5,6
elseif premarchtype==xjServerMarchType.eMoJingZhenJi_Origin then
p1,p2,p3=4,5,6
else
p1,p2,p3=1,2,3
end
if fightres>0 then
if fightres==1 then
return p2
else
return p3
end
else
return p1
end
end


function xjTeamHandle_marchBack:getMoveWayTime()
local movePath=self:getMyMovePath()
local speedlist=self:getSpeedList()
local isIgnoreArea=self.isIgnoreArea
return xianjieController:getMovePathWayTime2(movePath,speedlist,false,0,isIgnoreArea)
end

function xjTeamHandle_marchBack:getMyMovePath()
local movePath=self.movePath
if movePath then
return movePath
end
local sceneidx_,gridX_c_,gridZ_c_=self:getTargetPos()
local sceneidx,gridX_c,gridZ_c=self:getResPos()
local isIgnoreArea=self.isIgnoreArea
movePath=xianjieController:getMovePath(sceneidx,gridX_c,gridZ_c,sceneidx_,gridX_c_,gridZ_c_,self.areaTransferSelects,isIgnoreArea)
self.movePath=movePath
return movePath
end

function xjTeamHandle_marchBack:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
local isIgnoreArea=self.isIgnoreArea
return xianjieController:getMoveTagList(movePath,bTime,speedlist,isIgnoreArea)
end

function xjTeamHandle_marchBack:geLerpTime()

local state,time=self:getTeamState()
local endTime=time[2]
local startTime=time[1]
local wayTime=endTime-startTime
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime,wayTime
end

function xjTeamHandle_marchBack:getOwnerName()
local teamData=self.teamData
if teamData.actorid then
local zmData=xianjieModel:getZongMenData(teamData.actorid)
if zmData then
return zmData.actorname
end
end
return'佚名'
end

function xjTeamHandle_marchBack:getTeamEnityKey()
return self.teamData:getTeamEnityKey()
end

function xjTeamHandle_marchBack:getTargetName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eNone then
local teamData=self.teamData
local str=FMT.fmt("行军返回中({0},{1})",teamData.tarx,teamData.tary)
return str
end
end

function xjTeamHandle_marchBack:getTargetIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eGoto then
return"icon_zjm_duiwu_4"
end
end

function xjTeamHandle_marchBack:getTargetDesc(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return"已完成"
end
end

function xjTeamHandle_marchBack:getStateIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBattle then
return"icon_zjm_duiwu_2"
end
end

function xjTeamHandle_marchBack:checkIsShowProgress(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return true
end

return false
end

function xjTeamHandle_marchBack:checkIsOnMove(state,isBack)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eGoto then
return true
end

return false
end

function xjTeamHandle_marchBack:checkMyWaiPai()
return self.teamData.isMyWaiPai
end



function xjTeamHandle_marchBack:checkSpeeUp(isWarning)
if not self:checkSpeeUpOpen(isWarning)then
return false
end
return true
end


function xjTeamHandle_marchBack:doSpeedUp(itemid)
if not self:checkSpeeUp(true)then
return false
end
xianjieController:reqMarchSpeedUp(self.marchguid,itemid)
return true
end


function xjTeamHandle_marchBack:onSpeedUp()
self.movePath=nil
end



function xjTeamHandle_marchBack:maskRetract()
return true
end



function xjTeamHandle_marchBack:onDelete()

end


function xjTeamHandle_marchBack:getMarchTeamModelSkinID()
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

return xjTeamHandle_marchBack