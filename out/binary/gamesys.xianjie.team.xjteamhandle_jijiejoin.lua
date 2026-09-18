









local xjTeamHandle_jiJieJoin={}


function xjTeamHandle_jiJieJoin:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.marchguid_str)
self.teamData=xianjieModel:getMarchTeamData(self.marchguid)
end


function xjTeamHandle_jiJieJoin:checkMyEnemyType()
return xianjieModel:checkEnemyType(self.teamData.actorid)
end

function xjTeamHandle_jiJieJoin:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_jiJieJoin:getSpeedList()
return self.teamData.speedlist
end

function xjTeamHandle_jiJieJoin:getSpeedCnt()
return#self:getSpeedList()
end


function xjTeamHandle_jiJieJoin:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_jiJieJoin:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_jiJieJoin:getZongMenPos()
local teamData=self.teamData
local zmData=xianjieModel:getMyZongMenData()
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.srcx,teamData.srcy,zmData.gridWidth,zmData.gridHeight)
return teamData.srcsceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_jiJieJoin:getTargetPos()
local teamData=self.teamData
local zmData=xianjieModel:getMyZongMenData()
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.tarx,teamData.tary,zmData.gridWidth,zmData.gridHeight)
return teamData.tarsceneidx,gridX_c,gridZ_c,zmData.gridWidth,zmData.gridHeight
end


function xjTeamHandle_jiJieJoin:getTargetData()
local teamData=self.teamData
if teamData then
return xianjieModel:getZongMenData(teamData.taractorid)
end
return nil
end

function xjTeamHandle_jiJieJoin:getTeamState()
local curTime=gameUtilityModel.getServerShortTime2()
local bTime=self:getBeginTime()
local wayTime1=self:getMoveWayTime(false)
local arriveTime=bTime+wayTime1
local lerp=arriveTime-curTime
if lerp>0 then
return xjMarchTeamStateType.eGoto,{bTime,arriveTime,wayTime1},lerp
else
return xjMarchTeamStateType.eNone,{bTime,arriveTime},lerp
end
end



function xjTeamHandle_jiJieJoin:getMoveWayTime(isBack)
local movePath=self:getMyMovePath(isBack)
local speedlist=self:getSpeedList()
local battleTime=self.teamData.battleTime
return xianjieController:getMovePathWayTime2(movePath,speedlist,isBack,battleTime)
end

function xjTeamHandle_jiJieJoin:getMyMovePath(isBack)
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

function xjTeamHandle_jiJieJoin:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_jiJieJoin:geLerpTime()

local state,time=self:getTeamState()
local endTime=time[2]
local startTime=time[1]
local wayTime=endTime-startTime
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime,wayTime
end

function xjTeamHandle_jiJieJoin:getOwnerName()
local teamData=self.teamData
if teamData.actorid then
local zmData=xianjieModel:getZongMenData(teamData.actorid)
if zmData then
return zmData.actorname
end
end
return'佚名'
end

function xjTeamHandle_jiJieJoin:getTeamEnityKey()
return self.teamData:getTeamEnityKey()
end

function xjTeamHandle_jiJieJoin:getTargetName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return"等待集结"
elseif state==xjMarchTeamStateType.eGoto then
return"前往集结中"
end
end

function xjTeamHandle_jiJieJoin:getTargetIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return"icon_zjm_duiwu_4"
elseif state==xjMarchTeamStateType.eGoto then
return"icon_zjm_duiwu_4"
end
end

function xjTeamHandle_jiJieJoin:getTargetDesc(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return"等待集结"
end
end

function xjTeamHandle_jiJieJoin:getStateIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBattle then
return"button_xiangongui_4"
end
end

function xjTeamHandle_jiJieJoin:checkIsShowProgress(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eGoto then
return true
end

return false
end

function xjTeamHandle_jiJieJoin:checkIsOnMove(state,isBack)
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

function xjTeamHandle_jiJieJoin:checkMyWaiPai()
return self.teamData.isMyWaiPai
end



function xjTeamHandle_jiJieJoin:checkSpeeUp(isWarning)
if not self:checkSpeeUpOpen(isWarning)then
return false
end
return true
end


function xjTeamHandle_jiJieJoin:doSpeedUp(itemid)
if not self:checkSpeeUp(true)then
return false
end
xianjieController:reqMarchSpeedUp(self.marchguid,itemid)
return true
end


function xjTeamHandle_jiJieJoin:onSpeedUp()
self.movePath2=nil
self.movePath1=nil
end



function xjTeamHandle_jiJieJoin:maskRetract()

return true
end


function xjTeamHandle_jiJieJoin:doRetract()
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

































































function xjTeamHandle_jiJieJoin:onDelete()

end


function xjTeamHandle_jiJieJoin:getMarchTeamModelSkinID()
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

return xjTeamHandle_jiJieJoin