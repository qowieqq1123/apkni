









local xjTeamHandle_marchYuanZhu={}


function xjTeamHandle_marchYuanZhu:onInit()
self.onlykey=FMT.fmt('{0}_{1}_{2}',self.teamType,self.marchguid_str,self.sceneidx)
self.teamData=xianjieModel:getMarchTeamData(self.marchguid)
self.isZhuZha=false
if self.teamData==nil then
self.isZhuZha=true
if xianjienSceneIndexType:isMoJie(self.sceneidx)then
self.teamData=xianjieModel:getSelfYuanJunTeamData_MoJie(self.marchguid)
elseif xianjienSceneIndexType:isMoGongZhengDuo(self.sceneidx)then
self.teamData=xianjieModel:getSelfYuanJunTeamData_MoGong(self.marchguid)
else
self.teamData=xianjieModel:getSelfYuanJunTeamData(self.marchguid)
end

self.teamState=xjMarchTeamStateType.eNone

local paramList=self.teamData and self.teamData.data and self.teamData.data.paramList
if paramList and next(paramList)then
self.srcactorid=paramList[1]
end
end
end


function xjTeamHandle_marchYuanZhu:checkMyEnemyType()
if self.isZhuZha then
return xjEnemyType.eSelf
else
return xianjieModel:checkEnemyType(self.teamData.srcactorid)
end
end

function xjTeamHandle_marchYuanZhu:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_marchYuanZhu:getSpeedList()
return self.teamData.speedlist
end

function xjTeamHandle_marchYuanZhu:getSpeedCnt()
return#self:getSpeedList()
end


function xjTeamHandle_marchYuanZhu:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_marchYuanZhu:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_marchYuanZhu:getZongMenPos()
local teamData=self.teamData
local zmData=xianjieModel:getMyZongMenData()
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.srcx,teamData.srcy,zmData.gridWidth,zmData.gridHeight)
return teamData.srcsceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_marchYuanZhu:getTargetPos()
local teamData=self.teamData
if self.teamState==xjMarchTeamStateType.eNone then
local zmData=xianjieModel:getZongMenData(self.srcactorid)
if zmData then
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(zmData.gridX,zmData.gridZ,zmData.gridWidth,zmData.gridHeight)
return zmData.sceneidx,gridX_c,gridZ_c
end
return teamData.tarsceneidx,0,0
end
local gridWidth,gridHeight
if teamData.srcactorid then
local zmData=xianjieModel:getZongMenData(teamData.srcactorid)
if zmData then
gridWidth=zmData.gridWidth
gridHeight=zmData.gridHeight
else
gridWidth=1
gridHeight=1
end
end
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.tarx,teamData.tary,gridWidth,gridHeight)
return teamData.tarsceneidx,gridX_c,gridZ_c,gridWidth,gridHeight
end


function xjTeamHandle_marchYuanZhu:getTargetData()
local teamData=self.teamData
if teamData and teamData.taractorid then
return xianjieModel:getZongMenData(teamData.taractorid)
end
return nil
end

function xjTeamHandle_marchYuanZhu:getTeamState()
if self.teamState and self.teamState==xjMarchTeamStateType.eNone then
return xjMarchTeamStateType.eNone,{0,0}
end
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


function xjTeamHandle_marchYuanZhu:getMoveWayTime()
local movePath=self:getMyMovePath()
local speedlist=self:getSpeedList()
return xianjieController:getMovePathWayTime2(movePath,speedlist,false,0)
end

function xjTeamHandle_marchYuanZhu:getMyMovePath()
local movePath=self.movePath
if movePath then
return movePath
end
local sceneidx_,gridX_c_,gridZ_c_=self:getTargetPos()
local sceneidx,gridX_c,gridZ_c=self:getZongMenPos()
movePath=xianjieController:getMovePath(sceneidx,gridX_c,gridZ_c,sceneidx_,gridX_c_,gridZ_c_,self.areaTransferSelects)
self.movePath=movePath
return movePath
end

function xjTeamHandle_marchYuanZhu:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_marchYuanZhu:geLerpTime()

local state,time=self:getTeamState()
local endTime=time[2]
local startTime=time[1]
local wayTime=endTime-startTime
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime,wayTime
end

function xjTeamHandle_marchYuanZhu:getOwnerName()
local teamData=self.teamData
local teamSceneIdx=self.teamData and(self.teamData.sceneidx or self.teamData.tarsceneidx)or xianjienSceneIndexType.eXianJie

local teamLogicSceneType=xianjieController:transSceneIdxToLogicSceneType(teamSceneIdx)
local nowSceneIdx=xianjieModel:getSceneIndex()
local nowLogicSceneType=xianjieController:transSceneIdxToLogicSceneType(nowSceneIdx)

if teamLogicSceneType~=nowLogicSceneType then
local sceneName=xianjieController:getSceneIdxLogicName(teamSceneIdx)
local str=FMT.fmt("{0}宗门",sceneName)
return str
else
if teamData.srcactorid then
local zmData=xianjieModel:getZongMenData(teamData.srcactorid)
if zmData then
return zmData.actorname
end
end
if self.srcactorid then
local zmData=xianjieModel:getZongMenData(self.srcactorid)
if zmData then
return zmData.actorname
end
end
end

return'佚名'
end

function xjTeamHandle_marchYuanZhu:getTeamEnityKey()
local state=self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return nil
end
return self.teamData:getTeamEnityKey()
end

function xjTeamHandle_marchYuanZhu:getTargetName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack then
return"撤退"
elseif state==xjMarchTeamStateType.eGoto then
local teamData=self.teamData
local str=FMT.fmt("前往援助({0},{1})",teamData.tarx,teamData.tary)
return str
elseif state==xjMarchTeamStateType.eNone then
local teamSceneIdx=self.teamData and(self.teamData.sceneidx or self.teamData.tarsceneidx)or xianjienSceneIndexType.eXianJie
local isMoJieTeam=xianjienSceneIndexType:isMoJie(teamSceneIdx)or false
local nowSceneIdx=xianjieModel:getSceneIndex()
local isInMoJie=nowSceneIdx and xianjienSceneIndexType:isMoJie(nowSceneIdx)or false
if isMoJieTeam~=isInMoJie then
local str=isMoJieTeam and"魔界援助中"or"仙界援助中"
return str
else
local zmData=xianjieModel:getZongMenData(self.srcactorid)
if zmData then
local str=FMT.fmt("援助中({0},{1})",zmData.gridX,zmData.gridZ)
return str
end
end
end
end

function xjTeamHandle_marchYuanZhu:getTargetIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack then
return"icon_zjm_duiwu_4"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return"icon_zjm_duiwu_1"
else
return"icon_zjm_duiwu_1"
end
end

function xjTeamHandle_marchYuanZhu:getTargetDesc(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return FMT.fmt("<color=#f7f7f7>正在援助{0}</color>",self:getOwnerName())
end
end

function xjTeamHandle_marchYuanZhu:getStateIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBattle then
return"button_xiangongui_4"
end
end

function xjTeamHandle_marchYuanZhu:checkIsShowProgress(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return true
end

return false
end

function xjTeamHandle_marchYuanZhu:checkIsOnMove(state,isBack)
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

function xjTeamHandle_marchYuanZhu:checkMyWaiPai()
return self.teamData.isMyWaiPai
end



function xjTeamHandle_marchYuanZhu:checkSpeeUp(isWarning)
local state=self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return false
end
if not self:checkSpeeUpOpen(isWarning)then
return false
end
return true
end


function xjTeamHandle_marchYuanZhu:doSpeedUp(itemid)
if not self:checkSpeeUp(true)then
return false
end
xianjieController:reqMarchSpeedUp(self.marchguid,itemid)
return true
end


function xjTeamHandle_marchYuanZhu:onSpeedUp()
self.movePath=nil
end




function xjTeamHandle_marchYuanZhu:doRetract()
if not self:checkRetract(true)then
return false
end

local marchguid=self.marchguid
local content='是否召回本队伍？召回的队伍将返回宗门（如有消耗的仙令会返还）'
local callback=function()
xianjieController:reqMarchRetract(marchguid)
end
local dialogue=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=callback
})
dialogue:show()
return true
end
































































function xjTeamHandle_marchYuanZhu:onDelete()

end


function xjTeamHandle_marchYuanZhu:getMarchTeamModelSkinID()
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

return xjTeamHandle_marchYuanZhu