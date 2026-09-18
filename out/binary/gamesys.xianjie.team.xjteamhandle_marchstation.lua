









local xjTeamHandle_marchStation={}


function xjTeamHandle_marchStation:onInit()
self.onlykey=FMT.fmt('{0}_{1}',self.teamType,self.marchguid_str)
self.teamData=xianjieModel:getMarchTeamData(self.marchguid)
end


function xjTeamHandle_marchStation:checkMyEnemyType()
local targetData=self:getAtkTargetData()
if targetData then
return xianjieModel:checkPVPEnemyType(self.teamData.actorid,targetData.actorid)
else
return xianjieModel:checkEnemyType(self.teamData.actorid)
end
end

function xjTeamHandle_marchStation:getMarchtype()
return self.teamData and self.teamData.marchtype or-1
end

function xjTeamHandle_marchStation:getSpeedList()
return self.teamData.speedlist
end

function xjTeamHandle_marchStation:getSpeedCnt()
return#self:getSpeedList()
end



function xjTeamHandle_marchStation:getSpeedMulti()
local speedlist=self:getSpeedList()
local len=#speedlist
if len>1 then
return math.floor(speedlist[len].param_2/speedlist[1].param_2)
end
return 1
end

function xjTeamHandle_marchStation:getBeginTime()
local speedlist=self.teamData.speedlist
return speedlist[1].param_1
end


function xjTeamHandle_marchStation:getZongMenPos()
local teamData=self.teamData
local zmData=xianjieModel:getMyZongMenData()
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.srcx,teamData.srcy,zmData.gridWidth,zmData.gridHeight)
return teamData.srcsceneidx,gridX_c,gridZ_c
end

function xjTeamHandle_marchStation:getTargetPos()
local teamData=self.teamData
local entitytype=xjServerEnityType.eMonster
local size=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,entitytype,'size')
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(teamData.tarx,teamData.tary,size[1],size[2])
return teamData.tarsceneidx,gridX_c,gridZ_c,size[1],size[2]
end


function xjTeamHandle_marchStation:getTargetData()
local sceneidx,gridX_c,gridZ_c=self:getTargetPos()
local ent=xianjieController:findEntityByGrid(sceneidx,gridX_c,gridZ_c,XJ_ENTITY_TYPE.eStation)
if ent then
local infoguid=ent:get_infoguid()
return xianjieModel:getStationData(infoguid)
end
return nil
end


function xjTeamHandle_marchStation:getAtkTargetData()
return self:getTargetData()
end

function xjTeamHandle_marchStation:getTeamState()
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


function xjTeamHandle_marchStation:getMoveWayTime()
local movePath=self:getMyMovePath()
local speedlist=self:getSpeedList()
return xianjieController:getMovePathWayTime2(movePath,speedlist,false,0)
end

function xjTeamHandle_marchStation:getMyMovePath()
local movePath=self.movePath
if movePath then
return movePath
end
local sceneidx_,gridX_c_,gridZ_c_=self:getTargetPos()
local sceneidx,gridX_c,gridZ_c=self:getZongMenPos()
movePath=xianjieController:getMovePath(sceneidx,gridX_c,gridZ_c,sceneidx_,gridX_c_,gridZ_c_,self.areaTransferSelects)
self.movePath=movePath
return movePath
end

function xjTeamHandle_marchStation:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_marchStation:geLerpTime()

local state,time=self:getTeamState()
local endTime=time[2]
local startTime=time[1]
local wayTime=endTime-startTime
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime,wayTime
end

function xjTeamHandle_marchStation:getOwnerName()
local teamData=self.teamData
if teamData.actorid then
local zmData=xianjieModel:getZongMenData(teamData.actorid)
if zmData then
return zmData.actorname
end
end
return'佚名'
end

function xjTeamHandle_marchStation:getTeamEnityKey()
return self.teamData:getTeamEnityKey()
end

function xjTeamHandle_marchStation:getTargetName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eNone then
return"返回宗门"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
local teamData=self.teamData





local str=FMT.fmt("空地({0},{1})",teamData.tarx,teamData.tary)
return str
end
end

function xjTeamHandle_marchStation:getTargetIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack then
return"icon_zjm_duiwu_2"
elseif state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return"icon_zjm_duiwu_4"
end
end

function xjTeamHandle_marchStation:getTargetDesc(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eNone then
return"已完成"
end
end

function xjTeamHandle_marchStation:getStateIconName(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBattle then
return"button_xiangongui_4"
end
end

function xjTeamHandle_marchStation:checkIsShowProgress(state)
state=state or self:getTeamState()
if state==xjMarchTeamStateType.eBack or state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle then
return true
end

return false
end

function xjTeamHandle_marchStation:checkIsOnMove(state,isBack)
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

function xjTeamHandle_marchStation:checkMyWaiPai()
return self.teamData.isMyWaiPai
end



function xjTeamHandle_marchStation:checkSpeeUp(isWarning)
if not self:checkSpeeUpOpen(isWarning)then
return false
end
return true
end


function xjTeamHandle_marchStation:doSpeedUp(itemid)
if not self:checkSpeeUp(true)then
return false
end
xianjieController:reqMarchSpeedUp(self.marchguid,itemid)
return true
end


function xjTeamHandle_marchStation:onSpeedUp()
self.movePath=nil
end




function xjTeamHandle_marchStation:doRetract()
if not self:checkRetract(true)then
return false
end
local marchguid=self.marchguid
local content='是否召回本队伍？召回的队伍将返回宗门（如有消耗的仙令会返还）'
local callback=function()
xianjieController:reqMarchRetract(self.marchguid)
end
local dialogue=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=callback
})
dialogue:show()
return true
end



function xjTeamHandle_marchStation:onDelete()

end


function xjTeamHandle_marchStation:getMarchTeamModelSkinID()
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

return xjTeamHandle_marchStation