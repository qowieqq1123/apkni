









local xjTeamHandle_plot={}


function xjTeamHandle_plot:onInit()
self.onlykey=FMT.fmt('{0}_{1}_{2}',self.teamType,self.cloudid,self.plotIdx)
self.cloudData=xianjieModel:getCloudData(self.cloudid)
self.cloudPlotData=self.cloudData:getCloudPlotData(self.plotIdx)
end

function xjTeamHandle_plot:getSpeedList()
local plotParams=self.cloudData:getCloudPlotParams(self.plotIdx)
if plotParams then
return plotParams[1]
else
return self.cloudPlotData:getBaseSpeedList()
end
end

function xjTeamHandle_plot:getSpeedCnt()
return#self:getSpeedList()
end


function xjTeamHandle_plot:getZongMenPos()
local plotParams=self.cloudData:getCloudPlotParams(self.plotIdx)
if plotParams then
local zmpos=plotParams[2]
local zmData=xianjieModel:getMyZongMenData()
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(zmpos[2],zmpos[3],zmData.gridWidth,zmData.gridHeight)
return zmpos[1],gridX_c,gridZ_c
else
local zmData=xianjieModel:getMyZongMenData()
local gridX_c,gridZ_c=xianjieModel:getZongMenWorldGridCenterPos(zmData)
return zmData.sceneidx,gridX_c,gridZ_c
end
end

function xjTeamHandle_plot:getTargetPos()
local cloudPlotData=self.cloudPlotData
return cloudPlotData.sceneidx,cloudPlotData.gridX_c,cloudPlotData.gridZ_c,1,1
end


function xjTeamHandle_plot:getTargetData()
return self.cloudPlotData
end


function xjTeamHandle_plot:getBaseWayTime()
local movePath=self:getMyMovePath(false)
local speed=xianjieModel:getCloudSearchSpeed()
return xianjieController:getMovePathWayTime(movePath,speed)
end



function xjTeamHandle_plot:getMoveWayTime(isBack)
local plotParams=self.cloudData:getCloudPlotParams(self.plotIdx)
if plotParams then
local costTime=plotParams[5]
if not isBack then
return costTime[1]
else
return costTime[2]
end
else
return self:calculateMoveWayTime(isBack)
end
end

function xjTeamHandle_plot:calculateMoveWayTime(isBack)
local movePath=self:getMyMovePath(isBack)
local speedlist=self:getSpeedList()
local battleTime=self.cloudPlotData.battleTime
return xianjieController:getMovePathWayTime2(movePath,speedlist,isBack,battleTime)
end

function xjTeamHandle_plot:getMyMovePath(isBack)
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
local state=self.cloudData:checkCloudPlotState(self.plotIdx)
if state==xjCloudPlotStateType.eGoto then
isBack=false
else
isBack=true
end
end
local movePath
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

function xjTeamHandle_plot:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_plot:geLerpTime()
local cloudData=self.cloudData
local plotParams=cloudData:getCloudPlotParams(self.plotIdx)
local cloudPlotData=self.cloudPlotData

local bTime=plotParams[1][1].param_1
local state=cloudData:checkCloudPlotState(self.plotIdx)
local endTime
local wayTime
if state==xjCloudPlotStateType.eGoto then
local wayTime1=self:getMoveWayTime(false)
endTime=bTime+wayTime1
wayTime=wayTime1
else
local wayTime1=self:getMoveWayTime(false)
local wayTime2=self:getMoveWayTime(true)
local battleTime=cloudPlotData.battleTime
endTime=bTime+wayTime1+battleTime+wayTime2
wayTime=wayTime2
end
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime,wayTime
end

function xjTeamHandle_plot:getOwnerName()
return playerModel:getActorName()
end

function xjTeamHandle_plot:getTeamEnityKey()
return self.cloudPlotData:getTeamEnityKey()
end

function xjTeamHandle_plot:getTeamState()
local cloudData=self.cloudData
local state=cloudData:checkCloudPlotState(self.plotIdx)
return state
end

function xjTeamHandle_plot:getTargetName(state)
local cloudData=self.cloudData
state=state or cloudData:checkCloudPlotState(self.plotIdx)
if state==xjCloudPlotStateType.eFinishBack or state==xjCloudPlotStateType.eFailBack then
return"返回宗门"
elseif state==xjCloudPlotStateType.eGoto or state==xjCloudPlotStateType.eBattle then
local cloudPlotData=self.cloudPlotData
local pos=cloudPlotData.pos
local cfg=cfgHelper.get2(cfg_fairylandclouddataconfig_get,self.cloudid,self.plotIdx)
local typo=cloudPlotData:getCurType()
local str
if typo==xjCloudPlotType.eMonster then

local monsterGroupId=cfg.data[2]
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroupId)
str=FMT.fmt("{0}({1},{2})",groupcfg.name,pos[1],pos[2])
elseif typo==xjCloudPlotType.eQiYuEvent then

local eventGroupId=cfg.data[2]
local qiyuCfg=MysteryEventModel.get_group_cfg(eventGroupId)
str=FMT.fmt("{0}({1},{2})",qiyuCfg.title,pos[1],pos[2])
elseif typo==xjCloudPlotType.eTask then

local taskId=cfg.data[2]
local name=taskModel:getTaskConfig(taskId).name
str=FMT.fmt("{0}({1},{2})",name,pos[1],pos[2])
end
return str
end
end

function xjTeamHandle_plot:getTargetDesc(state)
local cloudData=self.cloudData
state=state or cloudData:checkCloudPlotState(self.plotIdx)
if state==xjCloudPlotStateType.eFinish then
return"已完成"
elseif state==xjCloudPlotStateType.eNone then
return"未开始"
end
end

function xjTeamHandle_plot:getTargetIconName(state)
local cloudData=self.cloudData
state=state or cloudData:checkCloudPlotState(self.plotIdx)
if state==xjCloudPlotStateType.eFinishBack or state==xjCloudPlotStateType.eFailBack then
return"icon_zjm_duiwu_2"
elseif state==xjCloudPlotStateType.eGoto then
local cloudPlotData=self.cloudPlotData
local typo=cloudPlotData:getCurType()
if typo==xjCloudPlotType.eMonster then
return"icon_zjm_duiwu_4"
else
return"icon_zjm_duiwu_1"
end
elseif state==xjCloudPlotStateType.eBattle then
return"icon_zjm_duiwu_4"
end
end

function xjTeamHandle_plot:getStateIconName(state)
local cloudData=self.cloudData
state=state or cloudData:checkCloudPlotState(self.plotIdx)
if state==xjCloudPlotStateType.eBattle then
return"button_xiangongui_4"
end
end

function xjTeamHandle_plot:checkIsShowProgress(state)
local cloudData=self.cloudData
state=state or cloudData:checkCloudPlotState(self.plotIdx)
if state==xjCloudPlotStateType.eFinishBack or state==xjCloudPlotStateType.eFailBack or state==xjCloudPlotStateType.eGoto or state==xjCloudPlotStateType.eBattle then
return true
end
return false
end

function xjTeamHandle_plot:checkIsOnMove(state,isBack)
local cloudData=self.cloudData
state=state or cloudData:checkCloudPlotState(self.plotIdx)
if state==xjCloudPlotStateType.eGoto then
if isBack==nil or isBack==false then
return true
end
elseif state==xjCloudPlotStateType.eFinishBack or state==xjCloudPlotStateType.eFailBack then
if isBack==nil or isBack==true then
return true
end
end
return false
end


function xjTeamHandle_plot:maskSpeeUp()
return true
end


function xjTeamHandle_plot:checkSpeeUp(isWarning)
if not self:checkSpeeUpOpen(isWarning)then
return false
end
return true
end


function xjTeamHandle_plot:doSpeedUp(itemid)
if not self:checkSpeeUp(true)then
return false
end
xianjieController:reqCloudPlotSpeedUp(self.cloudid,self.plotIdx,itemid)
return true
end


function xjTeamHandle_plot:onSpeedUp()
self.movePath2=nil
self.movePath1=nil
end



function xjTeamHandle_plot:maskRetract()
return true
end


function xjTeamHandle_plot:doRetract()
if not self:checkRetract(true)then
return false
end
xianjieController:reqCloudPlotRetract(self.cloudid,self.plotIdx)
return true
end


function xjTeamHandle_plot:onRetract()
self.movePath2=nil
self.movePath1=nil
end



function xjTeamHandle_plot:onDelete()

end

return xjTeamHandle_plot