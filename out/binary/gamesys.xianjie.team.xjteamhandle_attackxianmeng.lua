









local xjTeamHandle_AttackXianMeng={}


function xjTeamHandle_AttackXianMeng:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.marchguid_str)
self.teamData=xianjieModel:getMarchTeamData(self.marchguid)
self.hasAtkTarget=true
end


function xjTeamHandle_AttackXianMeng:checkMyEnemyType()
return xianjieModel:checkPVPEnemyType2(self.teamData.srcactorid,self.teamData.targuildid)
end

function xjTeamHandle_AttackXianMeng:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_AttackXianMeng:getSpeedList()
return self.teamData.speedlist
end

function xjTeamHandle_AttackXianMeng:getSpeedCnt()
return#self:getSpeedList()
end


function xjTeamHandle_AttackXianMeng:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_AttackXianMeng:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_AttackXianMeng:getZongMenPos()
local teamData=self.teamData
local actorId=teamData.srcactorid
local zmData=xianjieModel:getZongMenData(actorId)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.srcx,teamData.srcy,zmData.gridWidth,zmData.gridHeight)
return teamData.srcsceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_AttackXianMeng:getTargetPos()
local teamData=self.teamData
local xmData=xianjieModel:getXianMengData(teamData.targuildid)
local gridWidth=xmData and xmData.gridWidth or 1
local gridHeight=xmData and xmData.gridHeight or 1
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.tarx,teamData.tary,gridWidth,gridHeight)
return teamData.tarsceneidx,gridX_c,gridZ_c,gridWidth,gridHeight
end


function xjTeamHandle_AttackXianMeng:getTargetData()
local teamData=self.teamData
if teamData then
return xianjieModel:getXianMengData(teamData.targuildid)
end
return nil
end

function xjTeamHandle_AttackXianMeng:getTeamState()
local curTime=gameUtilityModel.getServerShortTime2()
local bTime=self:getBeginTime()
local wayTime1=self:getMoveWayTime(false)
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



function xjTeamHandle_AttackXianMeng:getMoveWayTime(isBack)
local movePath=self:getMyMovePath(isBack)
local speedlist=self:getSpeedList()
local battleTime=self.teamData.battleTime
return xianjieController:getMovePathWayTime2(movePath,speedlist,isBack,battleTime)
end

function xjTeamHandle_AttackXianMeng:getMyMovePath(isBack)
local movePath
if isBack then
movePath=self.movePath2
else
movePath=self.movePath1
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
local sceneidx_,gridX_c_,gridZ_c_=self:getTargetPos()
local sceneidx,gridX_c,gridZ_c=self:getZongMenPos()
if not isBack then
movePath=xianjieController:getMovePath(sceneidx,gridX_c,gridZ_c,sceneidx_,gridX_c_,gridZ_c_,self.areaTransferSelects)
self.movePath1=movePath
else
movePath=xianjieController:getMovePath(sceneidx_,gridX_c_,gridZ_c_,sceneidx,gridX_c,gridZ_c,self.areaTransferSelects)
self.movePath2=movePath
end
return movePath
end

function xjTeamHandle_AttackXianMeng:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_AttackXianMeng:geLerpTime()

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

function xjTeamHandle_AttackXianMeng:getOwnerName()
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

function xjTeamHandle_AttackXianMeng:getTeamEnityKey()
return self.teamData:getTeamEnityKey()
end

function xjTeamHandle_AttackXianMeng:getTargetName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eNone then
return"返回宗门"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
local teamData=self.teamData
if teamData.targuildid then
local zmData=xianjieModel:getXianMengData(teamData.targuildid)
if zmData then
return FMT.fmt("{0}({1},{2})",zmData.guildname,teamData.tarx,teamData.tary)
end
end
return'佚名'
end
end

function xjTeamHandle_AttackXianMeng:getTargetIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack then
return"icon_zjm_duiwu_2"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return"icon_zjm_duiwu_4"
end
end

function xjTeamHandle_AttackXianMeng:getTargetDesc(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return"已完成"
end
end

function xjTeamHandle_AttackXianMeng:getStateIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBattle then
return"button_xiangongui_4"
end
end

function xjTeamHandle_AttackXianMeng:checkIsShowProgress(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return true
end

return false
end

function xjTeamHandle_AttackXianMeng:checkIsOnMove(state,isBack)
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

function xjTeamHandle_AttackXianMeng:checkMyWaiPai()
return self.teamData.isMyWaiPai
end



function xjTeamHandle_AttackXianMeng:checkSpeeUp(isWarning)
if not self:checkSpeeUpOpen(isWarning)then
return false
end
return true
end


function xjTeamHandle_AttackXianMeng:doSpeedUp(itemid)
if not self:checkSpeeUp(true)then
return false
end
xianjieController:reqMarchSpeedUp(self.marchguid,itemid)
return true
end


function xjTeamHandle_AttackXianMeng:onSpeedUp()
self.movePath2=nil
self.movePath1=nil
end




function xjTeamHandle_AttackXianMeng:doRetract()
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



function xjTeamHandle_AttackXianMeng:onDelete()

end


function xjTeamHandle_AttackXianMeng:getMarchTeamModelSkinID()
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

return xjTeamHandle_AttackXianMeng