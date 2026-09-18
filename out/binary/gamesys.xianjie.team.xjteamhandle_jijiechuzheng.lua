









local xjTeamHandle_jiJieChuZheng={}


function xjTeamHandle_jiJieChuZheng:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.marchguid_str)
local teamData=xianjieModel:getMarchTeamData(self.marchguid)
self.teamData=teamData
local hasAtkTarget=false
local entityType=xianjieModel:getEntityTypeByGuid(teamData.infoguid,teamData.tarsceneidx)
if entityType==xjServerEnityType.eClientBuild then
if xianjieModel:isArenaAtk(teamData.infoguid)or xianjieModel:isMoGongAtk(teamData.infoguid)or xianjieModel:isMoJunBuild_int64(teamData.infoguid)then

hasAtkTarget=true
end
else
hasAtkTarget=true
end
self.myEntityType=entityType
self.hasAtkTarget=hasAtkTarget
end


function xjTeamHandle_jiJieChuZheng:checkMyEnemyType()
local entityType=self.myEntityType
local teamData=self.teamData
if entityType==xjServerEnityType.eClientBuild and xianjieModel:checkClientBdIsArenaByGuid(teamData.infoguid)then
local arenaState=xianjieModel:checkArenaOccupyCamp(teamData.infoguid)
return xianjieModel:checkArenaAtkEnemyType(teamData.actorid,arenaState)
elseif entityType==xjServerEnityType.eClientBuild and xianjieModel:checkClientBdIsMoGongByBuildId(teamData.infoguid)then
local arenaState=xianjieModel:checkMoGongOccupyCamp(teamData.infoguid)
return xianjieModel:checkArenaAtkEnemyType(teamData.actorid,arenaState)
elseif entityType==xjServerEnityType.eClientBuild and xianjieModel:isMoJunBuild_int64(teamData.infoguid)then
return xianjieModel:checkEnemyType(teamData.actorid)
else
return xianjieModel:checkEnemyType(teamData.actorid)
end
end

function xjTeamHandle_jiJieChuZheng:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_jiJieChuZheng:getSpeedList()
return self.teamData.speedlist
end

function xjTeamHandle_jiJieChuZheng:getSpeedCnt()
return#self:getSpeedList()
end


function xjTeamHandle_jiJieChuZheng:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_jiJieChuZheng:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_jiJieChuZheng:getZongMenPos()
local teamData=self.teamData

local actorId=teamData.actorid
local zmData=xianjieModel:getZongMenData(actorId)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.srcx,teamData.srcy,zmData.gridWidth,zmData.gridHeight)
return teamData.srcsceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_jiJieChuZheng:getTargetPos()
local teamData=self.teamData
local entitytype=self.myEntityType
local size=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,entitytype,'size')
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.tarx,teamData.tary,size[1],size[2])
return teamData.tarsceneidx,gridX_c,gridZ_c,size[1],size[2]
end


function xjTeamHandle_jiJieChuZheng:getTargetData()
local teamData=self.teamData
if teamData then
return xianjieModel:getEntityDataByGuid(teamData.infoguid,teamData.tarsceneidx)
end
return nil
end

function xjTeamHandle_jiJieChuZheng:getTeamState()
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



function xjTeamHandle_jiJieChuZheng:getMoveWayTime(isBack)
local movePath=self:getMyMovePath(isBack)
local speedlist=self:getSpeedList()
local battleTime=self.teamData.battleTime
return xianjieController:getMovePathWayTime2(movePath,speedlist,isBack,battleTime)
end

function xjTeamHandle_jiJieChuZheng:getMyMovePath(isBack)
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

function xjTeamHandle_jiJieChuZheng:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_jiJieChuZheng:geLerpTime()

local state,time=self:getTeamState()
local endTime=time[2]
local startTime=time[1]
local wayTime=endTime-startTime
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime,wayTime
end

function xjTeamHandle_jiJieChuZheng:getOwnerName()
local teamData=self.teamData
if teamData.actorid then
local zmData=xianjieModel:getZongMenData(teamData.actorid)
if zmData then
return zmData.actorname
end
end
return'佚名'
end

function xjTeamHandle_jiJieChuZheng:getTeamEnityKey()
return self.teamData:getTeamEnityKey()
end

function xjTeamHandle_jiJieChuZheng:getTargetName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eNone then
return"返回宗门"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
local teamData=self.teamData
local str
local jjType=xianjieModel:getJiJieTypeByGuid(teamData.infoguid,teamData.tarsceneidx)
local isPVP=not jjType or jjType==xjJjJieBaseType.eWar
if isPVP then
local entityType=self.myEntityType
if entityType==xjServerEnityType.eClientBuild then

local isArena=xianjieModel:checkClientBdIsArenaByGuid(teamData.infoguid)
if isArena then

local arenaId=mathHelper.int64_to_number(teamData.infoguid)
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,arenaId)
local nameStr=cfg and cfg.name or"未知擂台"
str=FMT.fmt("{0}({1},{2})",nameStr,teamData.tarx,teamData.tary)
end

local isMoGong=xianjieModel:checkClientBdIsMoGongByBuildId(teamData.infoguid)
if isMoGong then

local arenaId=mathHelper.int64_to_number(teamData.infoguid)
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,arenaId)
local nameStr=cfg and cfg.name or"魔宫"
str=FMT.fmt("{0}({1},{2})",nameStr,teamData.tarx,teamData.tary)
end
end
elseif self.myEntityType==xjServerEnityType.eClientBuild and xianjieModel:isMoJunBuild_int64(teamData.infoguid)then
local mojunId=mathHelper.int64_to_number(teamData.infoguid)
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,mojunId)
local nameStr=cfg and cfg.name or"魔君"
str=FMT.fmt("{0}({1},{2})",nameStr,teamData.tarx,teamData.tary)
else
local monsterData=xianjieModel:getMonsterData(teamData.infoguid)
if not monsterData then
if state==xjMarchTeamStateType.eBattle then
return"未知怪物"
elseif state==xjMarchTeamStateType.eBattle then
return"战斗中"
end
end
local cfg=monsterData:getCfg()
local monsterGroupId=cfg.monster[1]
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroupId)
local monsterName=groupcfg.name
str=FMT.fmt("{0}({1},{2})",monsterName,teamData.tarx,teamData.tary)
end
return str
end
end

function xjTeamHandle_jiJieChuZheng:getTargetIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack then
return"icon_zjm_duiwu_2"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return"icon_zjm_duiwu_6"
end
end

function xjTeamHandle_jiJieChuZheng:getTargetDesc(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return"已完成"
end
end

function xjTeamHandle_jiJieChuZheng:getStateIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBattle then
return"button_xiangongui_4"
end
end

function xjTeamHandle_jiJieChuZheng:checkIsShowProgress(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return true
end

return false
end

function xjTeamHandle_jiJieChuZheng:checkIsOnMove(state,isBack)
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

function xjTeamHandle_jiJieChuZheng:checkMyWaiPai()
return self.teamData.isMyWaiPai
end


function xjTeamHandle_jiJieChuZheng:getMarchTeamModelSetID()
local state=self:getTeamState()
if state==xjMarchTeamStateType.eBattle or state==xjMarchTeamStateType.eGoto then
return 10
else
return 11
end
end



function xjTeamHandle_jiJieChuZheng:checkSpeeUp(isWarning)
if not self:checkSpeeUpOpen(isWarning)then
return false
end
return true
end


function xjTeamHandle_jiJieChuZheng:doSpeedUp(itemid)
if not self:checkSpeeUp(true)then
return false
end
xianjieController:reqMarchSpeedUp(self.marchguid,itemid)
return true
end


function xjTeamHandle_jiJieChuZheng:onSpeedUp()
self.movePath2=nil
self.movePath1=nil
end



function xjTeamHandle_jiJieChuZheng:maskRetract()

return true
end

function xjTeamHandle_jiJieChuZheng:doRetract()
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



function xjTeamHandle_jiJieChuZheng:checkDetailOpen(isWarning)
if self:checkMyWaiPai()then
return true
end
if isWarning then
UIManager.error('暂无详情')
end

return false
end

function xjTeamHandle_jiJieChuZheng:checkDetail(isWarning)
if not self:checkDetailOpen(isWarning)then
return false
end

return true
end

function xjTeamHandle_jiJieChuZheng:onDetailShow()
local teamSceneIdx=self.teamData and(self.teamData.sceneidx or self.teamData.tarsceneidx)or xianjienSceneIndexType.eXianJie
local teamLogicSceneType=xianjieController:transSceneIdxToLogicSceneType(teamSceneIdx)
local nowSceneIdx=xianjieModel:getSceneIndex()
local nowLogicSceneType=xianjieController:transSceneIdxToLogicSceneType(nowSceneIdx)
if teamLogicSceneType~=nowLogicSceneType then
local content="该队伍不在当前场景 是否跳转至对应场景？"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=function()
local sceneType=xianjieModel:sceneIndex2SceneType(teamSceneIdx)
return xianjieController:jumpXianJie(sceneType,nil,function()
return self:onDetailShow()
end)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return false
end
local massactorid=self.teamData.actorid
local massguid=self.teamData.massguid
local args={}
args.callback=function(list)
UIManager:showWindow('UIXianJie_marchTeamDetailWin',{massActorId=massactorid,massGuid=massguid,list=list})
end
xianjieController:reqMassDetail(self.teamData.actorid,int64.new(tostring(self.teamData.massguid)),args)
return false
end



function xjTeamHandle_jiJieChuZheng:onDelete()

end


function xjTeamHandle_jiJieChuZheng:getMarchTeamModelSkinID()
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

return xjTeamHandle_jiJieChuZheng