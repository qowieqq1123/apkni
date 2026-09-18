









local xjTeamHandle_MoGongBuffTeam={}


function xjTeamHandle_MoGongBuffTeam:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.guid_str)
self.teamData=xianjieModel:getMGZDBuildZJTeamData(self.guid)

local buildID_64=self.teamData.data.paramList[1]
self.buildID=mathHelper.int64_to_number(buildID_64)
self.initiatorActorId=self.teamData.data.paramList[2]

local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,self.buildID)
self.teamData.sceneidx=cfg.sceneidx
end

function xjTeamHandle_MoGongBuffTeam:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_MoGongBuffTeam:getSpeedList()
return self.teamData.speedlist
end


function xjTeamHandle_MoGongBuffTeam:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_MoGongBuffTeam:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_MoGongBuffTeam:getZongMenPos()
local zmData=xianjieModel:getMyZongMenData()
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(zmData.gridX_c,zmData.gridZ_c,zmData.gridWidth,zmData.gridHeight)
return zmData.sceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_MoGongBuffTeam:getTargetPos()

local targetData=xianjieModel:getMGZDBuildDataByBuildID(self.buildID)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(targetData.gridX,targetData.gridZ,targetData.gridWidth,targetData.gridHeight)
return targetData.sceneidx,gridX_c,gridZ_c,targetData.gridWidth,targetData.gridHeight
end


function xjTeamHandle_MoGongBuffTeam:getTargetData()
return xianjieModel:getMoGongDataByMoGongId(self.buildID)
end

function xjTeamHandle_MoGongBuffTeam:getTeamState()
return nil
end



function xjTeamHandle_MoGongBuffTeam:getMoveWayTime(isBack)
local movePath=self:getMyMovePath(isBack)
local speedlist=self:getSpeedList()
local battleTime=self.teamData.battleTime
return xianjieController:getMovePathWayTime2(movePath,speedlist,isBack,battleTime)
end

function xjTeamHandle_MoGongBuffTeam:getMyMovePath(isBack)
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

function xjTeamHandle_MoGongBuffTeam:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_MoGongBuffTeam:geLerpTime()
local state,time=self:getTeamState()
local endTime=time[2]
local startTime=time[1]
local wayTime=endTime-startTime
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime,wayTime
end

function xjTeamHandle_MoGongBuffTeam:getOwnerName()
local teamData=self.teamData
if teamData.actorid then
local zmData=xianjieModel:getZongMenData(teamData.actorid)
if zmData then
return zmData.actorname
end
end
return'佚名'
end

function xjTeamHandle_MoGongBuffTeam:getTeamEnityKey()
return nil
end

function xjTeamHandle_MoGongBuffTeam:getTargetName(state)
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

function xjTeamHandle_MoGongBuffTeam:getTargetIconName(state)
return"icon_zjm_duiwu_5"
end

function xjTeamHandle_MoGongBuffTeam:getTargetDesc()
return"驻军中"
end

function xjTeamHandle_MoGongBuffTeam:getStateIconName(state)
return nil
end

function xjTeamHandle_MoGongBuffTeam:checkIsShowProgress(state)
return false
end

function xjTeamHandle_MoGongBuffTeam:checkIsOnMove(state,isBack)
return false
end

function xjTeamHandle_MoGongBuffTeam:checkMyWaiPai()
return self.teamData.isMyWaiPai
end


function xjTeamHandle_MoGongBuffTeam:maskSpeeUp()
return true
end




function xjTeamHandle_MoGongBuffTeam:doRetract()
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,self.buildID)
local content=FMT.fmt('该部队驻军{0}中，您确定要召回队伍吗？',cfg.name)
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

function xjTeamHandle_MoGongBuffTeam:checkRetract()

local isSelfInitiator=playerModel:checkActorId(self.initiatorActorId)

return isSelfInitiator
end



function xjTeamHandle_MoGongBuffTeam:checkDetailOpen(isWarning)
return false
end

function xjTeamHandle_MoGongBuffTeam:onDetailShow()
return false
end



function xjTeamHandle_MoGongBuffTeam:onDelete()

end


function xjTeamHandle_MoGongBuffTeam:checkMyEnemyType()
local actorid=self.teamData.data.actorid
local selfActorId=playerModel:getActorID()
if mathHelper.compareInt64(actorid,selfActorId)then
return xjEnemyType.eSelf
end

local xmGuid=self.teamData.data.xmGuid
local xm=xianmengModel:getMyXMGuildID()
if mathHelper.compareInt64(xmGuid,xm)then
return xjEnemyType.eAllies
end

return xjEnemyType.eEnemy
end

return xjTeamHandle_MoGongBuffTeam