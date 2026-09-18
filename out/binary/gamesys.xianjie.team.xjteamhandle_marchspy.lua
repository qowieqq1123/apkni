









local xjTeamHandle_marchSpy={}


function xjTeamHandle_marchSpy:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.marchguid_str)
self.teamData=xianjieModel:getMarchTeamData(self.marchguid)
end


function xjTeamHandle_marchSpy:checkMyEnemyType()
local teamData=self.teamData
if teamData.infoguid then
return xianjieModel:checkEnemyType(teamData.srcactorid)
elseif teamData.taractorid then
local targetData=xianjieModel:getStationData(teamData.taractorid)
if targetData then
return xianjieModel:checkPVPEnemyType(teamData.srcactorid,targetData.actorid)
else
return xianjieModel:checkPVPEnemyType(teamData.srcactorid,teamData.taractorid)
end
end
end

function xjTeamHandle_marchSpy:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_marchSpy:getSpeedList()
return self.teamData.speedlist
end

function xjTeamHandle_marchSpy:getSpeedCnt()
return#self:getSpeedList()
end



function xjTeamHandle_marchSpy:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_marchSpy:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_marchSpy:getZongMenPos()
local teamData=self.teamData
local zmData=xianjieModel:getMyZongMenData()
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.srcx,teamData.srcy,zmData.gridWidth,zmData.gridHeight)
return teamData.srcsceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_marchSpy:getTargetPos()
local teamData=self.teamData
local targetData=self:getTargetData()
local w,h
if targetData~=nil then
w=targetData.gridWidth
h=targetData.gridHeight
else
w=1
h=1
end
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.tarx,teamData.tary,w,h)
return teamData.tarsceneidx,gridX_c,gridZ_c,w,h
end


function xjTeamHandle_marchSpy:getTargetData()
local teamData=self.teamData
if teamData then
if teamData.infoguid then
return xianjieModel:getMonsterData(teamData.infoguid)
else
return xianjieModel:getStationData(teamData.taractorid)or xianjieModel:getZongMenData(teamData.taractorid)or xianjieModel:getXianMengData(teamData.taractorid)
end
end
return nil
end

function xjTeamHandle_marchSpy:getTeamState()
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



function xjTeamHandle_marchSpy:getMoveWayTime(isBack)
local movePath=self:getMyMovePath(isBack)
local speedlist=self:getSpeedList()
local battleTime=self.teamData.battleTime
return xianjieController:getMovePathWayTime2(movePath,speedlist,isBack,battleTime)
end

function xjTeamHandle_marchSpy:getMyMovePath(isBack)
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

function xjTeamHandle_marchSpy:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_marchSpy:geLerpTime()

local state,time=self:getTeamState()
local endTime=time[2]
local startTime=time[1]
local wayTime=endTime-startTime
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime,wayTime
end

function xjTeamHandle_marchSpy:getOwnerName()
local teamData=self.teamData
if teamData.srcactorid then
local zmData=xianjieModel:getZongMenData(teamData.srcactorid)
if zmData then
return zmData.actorname
end
end
return'佚名'
end

function xjTeamHandle_marchSpy:getTeamEnityKey()
return self.teamData:getTeamEnityKey()
end

function xjTeamHandle_marchSpy:getTargetName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eNone then
return"返回宗门"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
local teamData=self.teamData
if teamData.infoguid then
local monsterData=xianjieModel:getMonsterData(teamData.infoguid)
local cfg=monsterData:getCfg()
local monsterGroupId=cfg.monster[1]
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroupId)
local monsterName=groupcfg.name
local str=FMT.fmt("{0}({1},{2})",monsterName,teamData.tarx,teamData.tary)
return str
elseif teamData.taractorid then
local str
local targetData=xianjieModel:getStationData(teamData.taractorid)
if targetData then
local zmData=xianjieModel:getZongMenData(targetData.actorid)
str=FMT.fmt("侦查{0}的驻地({1},{2})",zmData.actorname,teamData.tarx,teamData.tary)
else
local zmData=xianjieModel:getZongMenData(teamData.taractorid)
if zmData then
str=FMT.fmt("侦查{0}({1},{2})",zmData.actorname,teamData.tarx,teamData.tary)
else
local xmData=xianjieModel:getXianMengData(teamData.taractorid)
if xmData then
str=FMT.fmt("侦查{0}({1},{2})",xmData.guildname,teamData.tarx,teamData.tary)
else
str='侦查目标丢失'
end
end
end
return str
end
end
end

function xjTeamHandle_marchSpy:getTargetIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack then
return"icon_zjm_duiwu_2"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
local teamData=self.teamData
if teamData.infoguid then
return"icon_zjm_duiwu_4"
else
return"icon_zjm_duiwu_1"
end
end
end

function xjTeamHandle_marchSpy:getTargetDesc(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return"已完成"
end
end

function xjTeamHandle_marchSpy:getStateIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBattle then
local teamData=self.teamData
if teamData.infoguid then
return"button_xiangongui_4"
else
return"button_xiangongui_1"
end
end
end

function xjTeamHandle_marchSpy:checkIsShowProgress(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return true
end

return false
end

function xjTeamHandle_marchSpy:checkIsOnMove(state,isBack)
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

function xjTeamHandle_marchSpy:checkMyWaiPai()
return self.teamData.isMyWaiPai
end



function xjTeamHandle_marchSpy:checkSpeeUp(isWarning)
if not self:checkSpeeUpOpen(isWarning)then
return false
end
return true
end


function xjTeamHandle_marchSpy:doSpeedUp(itemid)
if not self:checkSpeeUp(true)then
return false
end
xianjieController:reqMarchSpeedUp(self.marchguid,itemid)
return true
end


function xjTeamHandle_marchSpy:onSpeedUp()
self.movePath2=nil
self.movePath1=nil
end




function xjTeamHandle_marchSpy:doRetract()
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



function xjTeamHandle_marchSpy:onDelete()

end


function xjTeamHandle_marchSpy:getMarchTeamModelSkinID()
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

return xjTeamHandle_marchSpy