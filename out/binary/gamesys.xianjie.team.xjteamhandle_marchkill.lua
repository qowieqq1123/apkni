









local xjTeamHandle_marchKill={}


function xjTeamHandle_marchKill:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.marchguid_str)
self.teamData=xianjieModel:getMarchTeamData(self.marchguid)
self.hasAtkTarget=true

local teamData=self.teamData
local entityData=xianjieModel:getEntityDataByGuid(teamData.infoguid,teamData.tarsceneidx)
local isIgnoreArea=false
if entityData and entityData.dataType==xjDataType.eMoJieGate then
isIgnoreArea=true
end
self.isIgnoreArea=isIgnoreArea
end


function xjTeamHandle_marchKill:checkMyEnemyType()
return xianjieModel:checkEnemyType(self.teamData.actorid)
end

function xjTeamHandle_marchKill:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_marchKill:getSpeedList()
return self.teamData.speedlist
end

function xjTeamHandle_marchKill:getSpeedCnt()
return#self:getSpeedList()
end



function xjTeamHandle_marchKill:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_marchKill:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_marchKill:getZongMenPos()
local teamData=self.teamData
local zmData=xianjieModel:getMyZongMenData()
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.srcx,teamData.srcy,zmData.gridWidth,zmData.gridHeight)
return teamData.srcsceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_marchKill:getTargetPos()
local teamData=self.teamData
local entityData=xianjieModel:getEntityDataByGuid(teamData.infoguid,teamData.tarsceneidx)
local gridWidth,gridHeight
if entityData~=nil then
gridWidth=entityData.gridWidth
gridHeight=entityData.gridHeight
else
local size=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,xjServerEnityType.eMonster,'size')
gridWidth=size[1]
gridHeight=size[2]
end

local gridWidth_s=gridWidth
local gridHeight_s=gridHeight
if entityData then
local size=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,entityData.entitytype,'size')
gridWidth_s=size[1]
gridHeight_s=size[2]
end

local tarx=teamData.tarx
local tary=teamData.tary
if teamData.actuallyTarX and teamData.actuallyTarY then
tarx=teamData.actuallyTarX
tary=teamData.actuallyTarY
end

local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(tarx,tary,gridWidth_s,gridHeight_s)
return teamData.tarsceneidx,gridX_c,gridZ_c,gridWidth,gridHeight
end


function xjTeamHandle_marchKill:getTargetData()
local teamData=self.teamData
if teamData then
return xianjieModel:getEntityDataByGuid(teamData.infoguid,teamData.tarsceneidx)
end
return nil
end

function xjTeamHandle_marchKill:getTeamState()
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



function xjTeamHandle_marchKill:getMoveWayTime(isBack)
local movePath=self:getMyMovePath(isBack)
local speedlist=self:getSpeedList()
local battleTime=self.teamData.battleTime
local isIgnoreArea=self.isIgnoreArea
return xianjieController:getMovePathWayTime2(movePath,speedlist,isBack,battleTime,isIgnoreArea)
end

function xjTeamHandle_marchKill:getMyMovePath(isBack)
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

local isIgnoreArea=self.isIgnoreArea
if not isBack then
movePath=xianjieController:getMovePath(sceneidx,gridX_c,gridZ_c,sceneidx_,gridX_c_,gridZ_c_,self.areaTransferSelects,isIgnoreArea)
self.movePath1=movePath
else
movePath=xianjieController:getMovePath(sceneidx_,gridX_c_,gridZ_c_,sceneidx,gridX_c,gridZ_c,self.areaTransferSelects,isIgnoreArea)
self.movePath2=movePath
end
return movePath
end

function xjTeamHandle_marchKill:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
local isIgnoreArea=self.isIgnoreArea
return xianjieController:getMoveTagList(movePath,bTime,speedlist,isIgnoreArea)
end

function xjTeamHandle_marchKill:geLerpTime()

local state,time=self:getTeamState()
local endTime=time[2]
local startTime=time[1]
local wayTime=endTime-startTime
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime,wayTime
end

function xjTeamHandle_marchKill:getOwnerName()
local teamData=self.teamData
if teamData.actorid then
local zmData=xianjieModel:getZongMenData(teamData.actorid)
if zmData then
return zmData.actorname
end
end
return'佚名'
end

function xjTeamHandle_marchKill:getTeamEnityKey()
return self.teamData:getTeamEnityKey()
end

function xjTeamHandle_marchKill:getTargetName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eNone then
return"返回宗门"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
local teamData=self.teamData
local entityData=xianjieModel:getEntityDataByGuid(teamData.infoguid,teamData.tarsceneidx)
if not entityData then
if state==xjMarchTeamStateType.eBattle then
return"未知怪物"
elseif state==xjMarchTeamStateType.eBattle then
return"战斗中"
end
end
local nameStr=entityData and entityData:getName()or"未知怪物"
local str=FMT.fmt("{0}({1},{2})",nameStr,teamData.tarx,teamData.tary)
return str
end
end

function xjTeamHandle_marchKill:getTargetIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack then
return"icon_zjm_duiwu_2"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return"icon_zjm_duiwu_4"
end
end

function xjTeamHandle_marchKill:getTargetDesc(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return"已完成"
end
end

function xjTeamHandle_marchKill:getStateIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBattle then
return"button_xiangongui_4"
end
end

function xjTeamHandle_marchKill:checkIsShowProgress(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return true
end

return false
end

function xjTeamHandle_marchKill:checkIsOnMove(state,isBack)
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

function xjTeamHandle_marchKill:checkMyWaiPai()
return self.teamData.isMyWaiPai
end


function xjTeamHandle_marchKill:getMarchTeamModelSetID()
local teamData=self.teamData
local monsterData=xianjieModel:getEntityDataByGuid(teamData.infoguid,teamData.tarsceneidx)
if monsterData then
local entityType=monsterData.entitytype
if entityType==xjServerEnityType.eMonsterHouse or entityType==xjServerEnityType.eMoJieMoZong_Big or
entityType==xjServerEnityType.eMoJieZhenYan_Big or
entityType==xjServerEnityType.eMoJieShangGuMoster then
return 10
elseif entityType==xjServerEnityType.eBossMonster or entityType==xjServerEnityType.eMoJieMoZong_Small or
entityType==xjServerEnityType.eMoJieZhenYan_Small or
entityType==xjServerEnityType.eMoJieZhenYan_Spe or
entityType==xjServerEnityType.eMoJingZhenJi_Normal or
entityType==xjServerEnityType.eMoJieMoster then
return 4
elseif entityType==xjServerEnityType.eClientBuild then
local isGate=monsterData.isGate
if isGate then
return 4
elseif xianjieModel:isMoJiangBuild_int64(teamData.infoguid)then
return 4
elseif xianjieModel:checkClientBdIsBenYuanZhenJiByGuid(teamData.infoguid)then
return 4
else
return 1
end
elseif entityType==xjTeamHandleType.eMarchMJSLDebuffAdd then
return 13
else
return 1
end
else
return 4
end
end



function xjTeamHandle_marchKill:checkSpeeUp(isWarning)
if not self:checkSpeeUpOpen(isWarning)then
return false
end
return true
end


function xjTeamHandle_marchKill:doSpeedUp(itemid)
if not self:checkSpeeUp(true)then
return false
end
xianjieController:reqMarchSpeedUp(self.marchguid,itemid)
return true
end


function xjTeamHandle_marchKill:onSpeedUp()
self.movePath2=nil
self.movePath1=nil
end




function xjTeamHandle_marchKill:doRetract()
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



function xjTeamHandle_marchKill:onDelete()

end


function xjTeamHandle_marchKill:getMarchTeamModelSkinID()
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

return xjTeamHandle_marchKill