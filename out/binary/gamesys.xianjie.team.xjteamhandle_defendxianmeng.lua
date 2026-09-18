









local xjTeamHandle_DefendXianMeng={}


function xjTeamHandle_DefendXianMeng:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.marchguid_str)
self.teamData=xianjieModel:getMarchTeamData(self.marchguid)
end


function xjTeamHandle_DefendXianMeng:checkMyEnemyType()
return xianjieModel:checkEnemyType(self.teamData.srcactorid)
end

function xjTeamHandle_DefendXianMeng:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_DefendXianMeng:getSpeedList()
return self.teamData.speedlist
end

function xjTeamHandle_DefendXianMeng:getSpeedCnt()
return#self:getSpeedList()
end


function xjTeamHandle_DefendXianMeng:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_DefendXianMeng:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_DefendXianMeng:getZongMenPos()
local teamData=self.teamData
local actorId=teamData.srcactorid
local zmData=xianjieModel:getZongMenData(actorId)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.srcx,teamData.srcy,zmData.gridWidth,zmData.gridHeight)
return teamData.srcsceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_DefendXianMeng:getTargetPos()
local teamData=self.teamData
local xmData=xianjieModel:getXianMengData(teamData.targuildid)
local gridWidth=xmData and xmData.gridWidth or 1
local gridHeight=xmData and xmData.gridHeight or 1
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.tarx,teamData.tary,gridWidth,gridHeight)
return teamData.tarsceneidx,gridX_c,gridZ_c,gridWidth,gridHeight
end


function xjTeamHandle_DefendXianMeng:getTargetData()
local teamData=self.teamData
if teamData and teamData.taractorid then
return xianjieModel:getXianMengData(teamData.targuildid)
end
return nil
end

function xjTeamHandle_DefendXianMeng:getTeamState()
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


function xjTeamHandle_DefendXianMeng:getMoveWayTime()
local movePath=self:getMyMovePath()
local speedlist=self:getSpeedList()
return xianjieController:getMovePathWayTime2(movePath,speedlist,false,0)
end

function xjTeamHandle_DefendXianMeng:getMyMovePath()
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

function xjTeamHandle_DefendXianMeng:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_DefendXianMeng:geLerpTime()

local state,time=self:getTeamState()
local endTime=time[2]
local startTime=time[1]
local wayTime=endTime-startTime
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime,wayTime
end

function xjTeamHandle_DefendXianMeng:getOwnerName()
local teamData=self.teamData
local teamSceneIdx=self.teamData and(self.teamData.srcsceneidx or self.teamData.tarsceneidx)or xianjienSceneIndexType.eXianJie
local isMoJieTeam=xianjienSceneIndexType:isMoJie(teamSceneIdx)or false
local nowSceneIdx=xianjieModel:getSceneIndex()
local isInMoJie=nowSceneIdx and xianjienSceneIndexType:isMoJie(nowSceneIdx)or false
if isMoJieTeam~=isInMoJie then
local str=isMoJieTeam and"魔界仙盟"or"仙界仙盟"
return str
else
if teamData.srcactorid then
local zmData=xianjieModel:getZongMenData(teamData.srcactorid)
if zmData then
return zmData.actorname
end
end
end

return'佚名'
end

function xjTeamHandle_DefendXianMeng:getTeamEnityKey()
local state=self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return nil
end
return self.teamData:getTeamEnityKey()
end

function xjTeamHandle_DefendXianMeng:getTargetName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack then
return"驻防撤退"
elseif state==xjMarchTeamStateType.eGoto then
return"前往驻防"
else
return"驻防中"
end
end

function xjTeamHandle_DefendXianMeng:getTargetIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack then
return"icon_zjm_duiwu_4"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return"icon_zjm_duiwu_1"
else
return"icon_zjm_duiwu_1"
end
end

function xjTeamHandle_DefendXianMeng:getTargetDesc(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return FMT.fmt("<color=#f7f7f7>正在援助{0}</color>",self:getOwnerName())
end
end

function xjTeamHandle_DefendXianMeng:getStateIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBattle then
return"button_xiangongui_4"
end
end

function xjTeamHandle_DefendXianMeng:checkIsShowProgress(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return true
end

return false
end

function xjTeamHandle_DefendXianMeng:checkIsOnMove(state,isBack)
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

function xjTeamHandle_DefendXianMeng:checkMyWaiPai()
return self.teamData.isMyWaiPai
end



function xjTeamHandle_DefendXianMeng:checkSpeeUp(isWarning)
local state=self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return false
end
if not self:checkSpeeUpOpen(isWarning)then
return false
end
return true
end


function xjTeamHandle_DefendXianMeng:doSpeedUp(itemid)
if not self:checkSpeeUp(true)then
return false
end
xianjieController:reqMarchSpeedUp(self.marchguid,itemid)
return true
end


function xjTeamHandle_DefendXianMeng:onSpeedUp()
self.movePath=nil
end




function xjTeamHandle_DefendXianMeng:doRetract()
if not self:checkRetract(true)then
return false
end

local marchguid=self.marchguid
local content='是否召回本队伍？召回的队伍将返回宗门（如有消耗的魔令会返还）'
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


function xjTeamHandle_DefendXianMeng:onDelete()

end


function xjTeamHandle_DefendXianMeng:getMarchTeamModelSkinID()
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

return xjTeamHandle_DefendXianMeng