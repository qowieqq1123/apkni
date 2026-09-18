
local xjTeamHandle_lingshouAttack={}


function xjTeamHandle_lingshouAttack:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.marchguid_str)
self.teamData=xianjieModel:getMarchTeamData(self.marchguid)
end


function xjTeamHandle_lingshouAttack:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_lingshouAttack:getSpeedList()
return self.teamData.speedlist
end


function xjTeamHandle_lingshouAttack:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_lingshouAttack:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_lingshouAttack:getZongMenPos()
local teamData=self.teamData
local actorId=teamData.actorid
local zmData=xianjieModel:getZongMenData(actorId)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.srcx,teamData.srcy,zmData.gridWidth,zmData.gridHeight)
return teamData.srcsceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_lingshouAttack:getTargetPos()
local targetData=self:getTargetData()
return targetData.sceneidx,targetData.gridX_c,targetData.gridZ_c,targetData.gridWidth,targetData.gridHeight
end


function xjTeamHandle_lingshouAttack:getTargetData()
return xianjieModel:getXJLingShouData(self.teamData.infoguid)
end

function xjTeamHandle_lingshouAttack:getTeamState()
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



function xjTeamHandle_lingshouAttack:getMoveWayTime(isBack)
local movePath=self:getMyMovePath(isBack)
local speedlist=self:getSpeedList()
local battleTime=self.teamData.battleTime
return xianjieController:getMovePathWayTime2(movePath,speedlist,isBack,battleTime)
end

function xjTeamHandle_lingshouAttack:getMyMovePath(isBack)
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

function xjTeamHandle_lingshouAttack:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_lingshouAttack:geLerpTime()
local state,time=self:getTeamState()
local endTime=time[2]
local startTime=time[1]
local wayTime=endTime-startTime
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime,wayTime
end

function xjTeamHandle_lingshouAttack:getOwnerName()
local teamData=self.teamData
if teamData.actorid then
local zmData=xianjieModel:getZongMenData(teamData.actorid)
if zmData then
return zmData.actorname
end
end
return'佚名'
end

function xjTeamHandle_lingshouAttack:getTeamEnityKey()
return self.teamData:getTeamEnityKey()
end

function xjTeamHandle_lingshouAttack:getTargetName(state)
local targetData=self:getTargetData()
local str="未知灵兽"
if targetData then
local nameStr=targetData:getName()
str=FMT.fmt("{0}({1},{2})",nameStr,targetData.gridX_c,targetData.gridZ_c)
end
return str
end

function xjTeamHandle_lingshouAttack:getTargetIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack then
return"icon_zjm_duiwu_2"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return"icon_zjm_duiwu_4"
end
end

function xjTeamHandle_lingshouAttack:getTargetDesc(state)
local str
if self.teamData==nil then
local teamSceneIdx=self.teamData and(self.teamData.sceneidx or self.teamData.tarsceneidx)or xianjienSceneIndexType.eXianJie
local isMoJieTeam=xianjienSceneIndexType:isMoJie(teamSceneIdx)or false
if isMoJieTeam then
str="跳转至魔界可查看"
else
str="跳转至仙界可查看"
end
else
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
str="已完成"
end
end

return str
end

function xjTeamHandle_lingshouAttack:getStateIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBattle then
return"button_xiangongui_4"
end
end

function xjTeamHandle_lingshouAttack:checkIsShowProgress(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return true
end

return false
end

function xjTeamHandle_lingshouAttack:checkIsOnMove(state,isBack)
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

function xjTeamHandle_lingshouAttack:checkMyWaiPai()
return self.teamData.isMyWaiPai
end



function xjTeamHandle_lingshouAttack:checkSpeeUp(isWarning)
if not self:checkSpeeUpOpen(isWarning)then
return false
end
return true
end


function xjTeamHandle_lingshouAttack:doSpeedUp(itemid)
if not self:checkSpeeUp(true)then
return false
end
xianjieController:reqMarchSpeedUp(self.marchguid,itemid)
return true
end


function xjTeamHandle_lingshouAttack:onSpeedUp()
self.movePath2=nil
self.movePath1=nil
end




function xjTeamHandle_lingshouAttack:doRetract()
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



function xjTeamHandle_lingshouAttack:onDelete()

end


function xjTeamHandle_lingshouAttack:getMarchTeamModelSkinID()
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

return xjTeamHandle_lingshouAttack