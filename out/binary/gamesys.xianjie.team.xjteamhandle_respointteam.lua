









local xjTeamHandle_respointTeam={}


function xjTeamHandle_respointTeam:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.guid)
self.rpMarch=xianjieModel:getResPointMarch(self.guid)
self.rpData=xianjieModel:getResPointData(self.guid)
end

function xjTeamHandle_respointTeam:getSpeedList()
return self.rpMarch:getMarchData('dSpeedList')
end

function xjTeamHandle_respointTeam:getSpeedCnt()
return#self:getSpeedList()
end

function xjTeamHandle_respointTeam:getSpeedCnt()
return#self:getSpeedList()
end


function xjTeamHandle_respointTeam:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_respointTeam:getBeginTime()
local speedlist=self:getSpeedList()
return speedlist[1].param_1
end

function xjTeamHandle_respointTeam:getBattleDuration()
local dCostDuration=self.rpMarch:getMarchData('dCostDuration')
return dCostDuration[2]
end

function xjTeamHandle_respointTeam:getMoveWayTime(isBack)
local movePath=self:getMyMovePath(isBack)
local speedlist=self:getSpeedList()
local battleTime=self:getBattleDuration()
return xianjieController:getMovePathWayTime2(movePath,speedlist,isBack,battleTime)
end

function xjTeamHandle_respointTeam:clearMovePath()
self.movePath_b=nil
self.movePath_f=nil
end

function xjTeamHandle_respointTeam:getMyMovePath(isBack)
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

local sPoint=self.rpMarch:getMarchData('dSinceInfo')
local sScene=sPoint[1]
local sGridX_c,sGridZ_c=xianjieController:worldGridCenterPos(sPoint[2],sPoint[3],sPoint[4],sPoint[5])


local tPoint=self.rpMarch:getMarchData('dTargetInfo')
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


function xjTeamHandle_respointTeam:getTeamState()
local curTime=gameUtilityModel.getServerShortTime2()
local bTime=self:getBeginTime()
local wayTime1=self:getMoveWayTime(false)
local arriveTime=bTime+wayTime1
local lerp=arriveTime-curTime
local flag=self.rpMarch:getMarchData("dHandleFlag")
local dType=self.rpMarch:getMarchData("dDataType")
local battleTime=self:getBattleDuration()
local workTime=arriveTime+battleTime
if dType==xjResPointMarchTeamType.eCollectible then
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
if lerp>0 or flag==0 then
return xjMarchTeamStateType.eGoto,{bTime,arriveTime,wayTime1,workTime},lerp
else
lerp=workTime-curTime
if lerp>0 then
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
end
end


function xjTeamHandle_respointTeam:getMarchTeamModelSetID()
local dType=self.rpMarch:getMarchData("dDataType")
if dType==xjResPointMarchTeamType.eCollectible then
return 1
else
local state=self:getTeamState()
if state==xjMarchTeamStateType.eBack then

local rpData=xianjieModel:getResPointData(self.guid)
if rpData and rpData.deadTime==nil then

return 3
else

return 2
end
else
return 1
end
end
end


function xjTeamHandle_respointTeam:getBaseWayTime(speed)
local movePath=self:getMyMovePath(false)
return xianjieController:getMovePathWayTime(movePath,speed)
end

function xjTeamHandle_respointTeam:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_respointTeam:geLerpTime()
local state,time=self:getTeamState()
local endTime=time[2]
local startTime=time[1]
local wayTime=endTime-startTime
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime,wayTime
end

function xjTeamHandle_respointTeam:getOwnerName()
return playerModel:getActorName()
end

function xjTeamHandle_respointTeam:getTargetPos()
local dTargetInfo=self.rpMarch:getMarchData('dTargetInfo')
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(dTargetInfo[2],dTargetInfo[3],dTargetInfo[4],dTargetInfo[5])
return dTargetInfo[1],gridX_c,gridZ_c,dTargetInfo[4],dTargetInfo[5]
end


function xjTeamHandle_respointTeam:getTargetData()
return xianjieModel:getResPointData(self.guid)
end


function xjTeamHandle_respointTeam:getAtkTargetData()
local dType=self.rpMarch:getMarchData("dDataType")
if dType==xjResPointMarchTeamType.eNormal then
local state=self:getTeamState()
if state==xjMarchTeamStateType.eGoto then
return self:getTargetData()
end
end
end

function xjTeamHandle_respointTeam:getResPos()
local dSinceInfo=self.rpMarch:getMarchData('dSinceInfo')
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(dSinceInfo[2],dSinceInfo[3],dSinceInfo[4],dSinceInfo[5])
return dSinceInfo[1],gridX_c,gridZ_c
end
function xjTeamHandle_respointTeam:getTeamEnityKey()
return self.rpMarch:getTeamEnityKey()
end

function xjTeamHandle_respointTeam:getTargetName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack then
return"返回宗门"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
local rpData=xianjieModel:getResPointData(self.guid)
if rpData then
local cfg=rpData:getCfg()
if rpData.rpType==XJ_ResPoint_TYPE.eCollectible and xianjieController:checkRPXiangBangPoint(rpData)then
if state==xjMarchTeamStateType.eBattle then
local cjstr=FMT.fmt("{0}(探索中)",cfg.name)
return cjstr or""
end
return cfg.name or""
else
local monsterGroupId=cfg.monster_id
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroupId)
local name=groupcfg.name
return FMT.fmt("{0}({1},{2})",name,rpData.gridX,rpData.gridZ)
end
end
end
end

function xjTeamHandle_respointTeam:getTargetDesc(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return"已完成"
end
end

function xjTeamHandle_respointTeam:getTargetIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack then
return"icon_zjm_duiwu_2"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return"icon_zjm_duiwu_4"
end
end

function xjTeamHandle_respointTeam:getStateIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBattle then
return"button_xiangongui_4"
end
end

function xjTeamHandle_respointTeam:checkIsShowProgress(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return true
end

return false
end

function xjTeamHandle_respointTeam:checkIsOnMove(state,isBack)
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


function xjTeamHandle_respointTeam:maskSpeeUp()
return true
end




function xjTeamHandle_respointTeam:doRetract()
if not self:checkRetract(true)then
return false
end
local rpMarch=self.rpMarch
local content='是否召回本队伍？召回的队伍将返回宗门（如有消耗的仙令会返还）'
local callback=function()
xianjieController:doResPointMarchRetract(rpMarch)
end
local dialogue=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=callback
})
dialogue:show()
return true
end


function xjTeamHandle_respointTeam:onRetract()

end

function xjTeamHandle_respointTeam:checkIsCanRetract()
local state=self:getTeamState()
return state==xjMarchTeamStateType.eGoto
end



function xjTeamHandle_respointTeam:onDelete()

end

return xjTeamHandle_respointTeam