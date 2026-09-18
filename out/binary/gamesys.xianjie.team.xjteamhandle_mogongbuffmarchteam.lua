









local xjTeamHandle_MoGongBuffMarchTeam={}


function xjTeamHandle_MoGongBuffMarchTeam:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.marchguid_str)
self.teamData=xianjieModel:getMarchTeamData(self.marchguid)

self.buildID=self.teamData.buildingId

local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,self.buildID)
self.teamData.sceneidx=cfg.sceneidx
end

function xjTeamHandle_MoGongBuffMarchTeam:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_MoGongBuffMarchTeam:getSpeedList()
return self.teamData.speedlist
end


function xjTeamHandle_MoGongBuffMarchTeam:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_MoGongBuffMarchTeam:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_MoGongBuffMarchTeam:getZongMenPos()
local teamData=self.teamData
local zmData=xianjieModel:getZongMenData(teamData.actorid)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.srcx,teamData.srcy,zmData.gridWidth,zmData.gridHeight)
return zmData.sceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_MoGongBuffMarchTeam:getTargetPos()

local targetData=self.teamData
local typeCfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,self.buildID)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(targetData.tarx,targetData.tary,typeCfg.size[1],typeCfg.size[2])
return targetData.sceneidx,gridX_c,gridZ_c,typeCfg.size[1],typeCfg.size[2]
end


function xjTeamHandle_MoGongBuffMarchTeam:getTargetData()
return xianjieModel:getMoGongDataByMoGongId(self.buildID)
end

function xjTeamHandle_MoGongBuffMarchTeam:getTeamState()
local curTime=gameUtilityModel.getServerShortTime2()
local bTime=self:getBeginTime()
local wayTime=self:getMoveWayTime()
local arriveTime=bTime+wayTime
local lerp=arriveTime-curTime
if lerp>0 then
return xjMarchTeamStateType.eGoto,{bTime,arriveTime,wayTime},lerp
else
local battleTime=self.teamData.battleTime
if battleTime>0 then
local workTime=arriveTime+battleTime
lerp=workTime-curTime
if lerp>0 then
return xjMarchTeamStateType.eBattle,{arriveTime,workTime},lerp
else
return xjMarchTeamStateType.eNone,{arriveTime,workTime}
end
else
return xjMarchTeamStateType.eNone,{bTime,arriveTime}
end
end
end



function xjTeamHandle_MoGongBuffMarchTeam:getMoveWayTime(isBack)
local movePath=self:getMyMovePath(isBack)
local speedlist=self:getSpeedList()
local battleTime=self.teamData.battleTime
return xianjieController:getMovePathWayTime2(movePath,speedlist,isBack,battleTime)
end

function xjTeamHandle_MoGongBuffMarchTeam:getMyMovePath(isBack)
local movePath=self.movePath
if movePath then
return movePath
end
local sceneidx_,gridX_c_,gridZ_c_=self:getTargetPos()
local sceneidx,gridX_c,gridZ_c=self:getZongMenPos()
movePath=xianjieController:getMovePath(sceneidx,gridX_c,gridZ_c,sceneidx_,gridX_c_,gridZ_c_)
self.movePath=movePath
return movePath
end

function xjTeamHandle_MoGongBuffMarchTeam:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_MoGongBuffMarchTeam:geLerpTime()
local state,time=self:getTeamState()
local endTime=time[2]
local startTime=time[1]
local wayTime=endTime-startTime
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime,wayTime
end

function xjTeamHandle_MoGongBuffMarchTeam:getOwnerName()
local teamData=self.teamData
if teamData.actorid then
local zmData=xianjieModel:getZongMenData(teamData.actorid)
if zmData then
return zmData.actorname
end
end
return'佚名'
end

function xjTeamHandle_MoGongBuffMarchTeam:getTeamEnityKey()
return nil
end

function xjTeamHandle_MoGongBuffMarchTeam:getTargetName(state)
local arenaId=self.buildID
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,arenaId)
local nameStr=cfg and cfg.name or"未知增益建筑"
local targetData=xianjieModel:getMoGongDataByMoGongId(self.buildID)
local str=nameStr
if targetData then
str=FMT.fmt("{0}({1},{2})",nameStr,targetData.gridX_original,targetData.gridZ_original)
end
return str
end

function xjTeamHandle_MoGongBuffMarchTeam:getTargetIconName(state)
return"icon_zjm_duiwu_5"
end

function xjTeamHandle_MoGongBuffMarchTeam:getTargetDesc()
return"驻军中"
end

function xjTeamHandle_MoGongBuffMarchTeam:getStateIconName(state)
return nil
end

function xjTeamHandle_MoGongBuffMarchTeam:checkIsShowProgress(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return true
end

return false
end

function xjTeamHandle_MoGongBuffMarchTeam:checkIsOnMove(state,isBack)
return false
end

function xjTeamHandle_MoGongBuffMarchTeam:checkMyWaiPai()
return self.teamData.isMyWaiPai
end


function xjTeamHandle_MoGongBuffMarchTeam:maskSpeeUp()
return true
end




function xjTeamHandle_MoGongBuffMarchTeam:doRetract()
local content='该部队驻军魔宫中，您确定要召回队伍吗？'
local arenaId=self.buildID
local guid=self.guid
local callback=function()
moGongZhengDuoActController:reqGetMoGongZhuJunRetract(arenaId,guid)
end
local dialogue=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=callback
})
dialogue:show()
end

function xjTeamHandle_MoGongBuffMarchTeam:checkRetract()

local isSelfInitiator=playerModel:checkActorId(self.initiatorActorId)

return isSelfInitiator
end



function xjTeamHandle_MoGongBuffMarchTeam:checkDetailOpen(isWarning)
return false
end







function xjTeamHandle_MoGongBuffMarchTeam:onDelete()

end


function xjTeamHandle_MoGongBuffMarchTeam:checkMyEnemyType()
local actorid=self.teamData.actorid
local selfActorId=playerModel:getActorID()
if mathHelper.compareInt64(actorid,selfActorId)then
return xjEnemyType.eSelf
end

local xmGuid=self.teamData.xmGuid
local xm=xianmengModel:getMyXMGuildID()
if mathHelper.compareInt64(xmGuid,xm)then
return xjEnemyType.eAllies
end

return xjEnemyType.eEnemy
end

return xjTeamHandle_MoGongBuffMarchTeam