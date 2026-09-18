









local xjTeamHandle_benYuanZhenJi={}


function xjTeamHandle_benYuanZhenJi:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.marchguid_str)
self.teamData=xianjieModel:getMarchTeamData(self.marchguid)
self.hasAtkTarget=true
end


function xjTeamHandle_benYuanZhenJi:checkMyEnemyType()
return xianjieModel:checkEnemyType(self.teamData.actorid)
end

function xjTeamHandle_benYuanZhenJi:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_benYuanZhenJi:getSpeedList()
return self.teamData.speedlist
end

function xjTeamHandle_benYuanZhenJi:getSpeedCnt()
return#self:getSpeedList()
end



function xjTeamHandle_benYuanZhenJi:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_benYuanZhenJi:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_benYuanZhenJi:getZongMenPos()
local teamData=self.teamData
local zmData=xianjieModel:getMyZongMenData()
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.srcx,teamData.srcy,zmData.gridWidth,zmData.gridHeight)
return teamData.srcsceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_benYuanZhenJi:getTargetPos()
local teamData=self.teamData
local entitytype=xjServerEnityType.eClientBuild
local buildid=teamData.buildingId
local cfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,buildid)
local size=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,entitytype,'size')
local gridX,gridZ,gridWidth,gridHeight=xianjieModel:getClientPositionAndSize(teamData.tarx,teamData.tary,size[1],size[2],cfg.size[1],cfg.size[2])
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,gridWidth,gridHeight)
return teamData.tarsceneidx,gridX_c,gridZ_c,gridWidth,gridHeight
end


function xjTeamHandle_benYuanZhenJi:getTargetData()
local teamData=self.teamData
if teamData then
return xianjieModel:findBenYuanZhenJiDataByBuildId(teamData.buildingId)
end
return nil
end

function xjTeamHandle_benYuanZhenJi:getTeamState()
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



function xjTeamHandle_benYuanZhenJi:getMoveWayTime(isBack)
local movePath=self:getMyMovePath(isBack)
local speedlist=self:getSpeedList()
local battleTime=self.teamData.battleTime
return xianjieController:getMovePathWayTime2(movePath,speedlist,isBack,battleTime)
end

function xjTeamHandle_benYuanZhenJi:getMyMovePath(isBack)
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

function xjTeamHandle_benYuanZhenJi:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_benYuanZhenJi:geLerpTime()

local state,time=self:getTeamState()
local endTime=time[2]
local startTime=time[1]
local wayTime=endTime-startTime
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime,wayTime
end

function xjTeamHandle_benYuanZhenJi:getOwnerName()
local teamData=self.teamData
if teamData.actorid then
local zmData=xianjieModel:getZongMenData(teamData.actorid)
if zmData then
return zmData.actorname
end
end
return'佚名'
end

function xjTeamHandle_benYuanZhenJi:getTeamEnityKey()
return self.teamData:getTeamEnityKey()
end

function xjTeamHandle_benYuanZhenJi:getTargetName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eNone then
return"返回宗门"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
local teamData=self.teamData
local entityData=xianjieModel:findBenYuanZhenJiDataByBuildId(teamData.buildingId)
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

function xjTeamHandle_benYuanZhenJi:getTargetIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack then
return"icon_zjm_duiwu_2"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return"icon_zjm_duiwu_4"
end
end

function xjTeamHandle_benYuanZhenJi:getTargetDesc(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return"已完成"
end
end

function xjTeamHandle_benYuanZhenJi:getStateIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBattle then
return"button_xiangongui_4"
end
end

function xjTeamHandle_benYuanZhenJi:checkIsShowProgress(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return true
end

return false
end

function xjTeamHandle_benYuanZhenJi:checkIsOnMove(state,isBack)
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

function xjTeamHandle_benYuanZhenJi:checkMyWaiPai()
return self.teamData.isMyWaiPai
end


function xjTeamHandle_benYuanZhenJi:getMarchTeamModelSetID()













return 4
end


function xjTeamHandle_benYuanZhenJi:getMarchTeamModelSkinID()
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


function xjTeamHandle_benYuanZhenJi:checkSpeeUp(isWarning)
if not self:checkSpeeUpOpen(isWarning)then
return false
end
return true
end


function xjTeamHandle_benYuanZhenJi:doSpeedUp(itemid)
if not self:checkSpeeUp(true)then
return false
end
xianjieController:reqMarchSpeedUp(self.marchguid,itemid)
return true
end


function xjTeamHandle_benYuanZhenJi:onSpeedUp()
self.movePath2=nil
self.movePath1=nil
end




function xjTeamHandle_benYuanZhenJi:doRetract()
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



function xjTeamHandle_benYuanZhenJi:onDelete()

end


function xjTeamHandle_benYuanZhenJi:getMarchTeamModelSkinID()
local teamData=self.teamData
if not teamData then
return 1
end
local sectdressId=teamData.marchdress
if not sectdressId or sectdressId==0 then
return 4
end
local type=UISettingModel:getSettingType(sectdressId)
local settingcfg=UISettingConfig.getCfg(type,sectdressId)
local skinId=4
if settingcfg then
skinId=settingcfg.xjSkinId
end
return skinId
end

return xjTeamHandle_benYuanZhenJi