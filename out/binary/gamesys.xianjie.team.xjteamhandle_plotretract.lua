









local xjTeamHandle_plotRetract={}


function xjTeamHandle_plotRetract:onInit()
self.onlykey=FMT.fmt('{0}_{1}_{2}',self.teamType,self.cloudid,self.plotIdx)
self.cloudData=xianjieModel:getCloudData(self.cloudid)
self.cloudPlotData=self.cloudData:getCloudPlotData(self.plotIdx)
end

function xjTeamHandle_plotRetract:getSpeedList()
local plotParams=self.cloudData:getCloudPlotParams(self.plotIdx)
return plotParams[6][2]
end

function xjTeamHandle_plotRetract:getSpeedCnt()
return#self:getSpeedList()
end


function xjTeamHandle_plotRetract:getZongMenPos()
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

function xjTeamHandle_plotRetract:getTargetPos()
local plotParams=self.cloudData:getCloudPlotParams(self.plotIdx)
local cpos=plotParams[6][3]
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(cpos[2],cpos[3],1,1)
return cpos[1],gridX_c,gridZ_c,1,1
end


function xjTeamHandle_plotRetract:getBaseWayTime(speed)
local movePath=self:getMyMovePath(false)
return xianjieController:getMovePathWayTime(movePath,speed)
end


function xjTeamHandle_plotRetract:getMoveWayTime()
local plotParams=self.cloudData:getCloudPlotParams(self.plotIdx)
return plotParams[6][1]
end

function xjTeamHandle_plotRetract:calculateMoveWayTime()
local movePath=self:getMyMovePath()
local speedlist=self:getSpeedList()
return xianjieController:getMovePathWayTime2(movePath,speedlist,false,0)
end

function xjTeamHandle_plotRetract:getMyMovePath()
local movePath=self.movePath
if movePath then
return movePath
end
local movePath
local sceneidx_,gridX_c_,gridZ_c_=self:getTargetPos()
local sceneidx,gridX_c,gridZ_c=self:getZongMenPos()
movePath=xianjieController:getMovePath(sceneidx_,gridX_c_,gridZ_c_,sceneidx,gridX_c,gridZ_c,self.areaTransferSelects)
self.movePath=movePath
return movePath
end

function xjTeamHandle_plotRetract:getMoveTagList(movePath,bTime)
local speedlist=self:getSpeedList()
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end

function xjTeamHandle_plotRetract:geLerpTime()
local plotParams=self.cloudData:getCloudPlotParams(self.plotIdx)
local retract=plotParams[6]
local bTime=retract[2][1].param_1
local wayTime=retract[1]
local arriveTime=bTime+wayTime
local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=arriveTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime,wayTime
end

function xjTeamHandle_plotRetract:getOwnerName()
return playerModel:getActorName()
end

function xjTeamHandle_plotRetract:getTeamEnityKey()
return self.cloudPlotData:getTeamEnityKey()
end

function xjTeamHandle_plotRetract:getTeamState()
local cloudData=self.cloudData
local state=cloudData:checkCloudPlotState(self.plotIdx)
return state
end

function xjTeamHandle_plotRetract:getTargetName(state)
local cloudData=self.cloudData
state=state or cloudData:checkCloudPlotState(self.plotIdx)
if state==xjCloudPlotStateType.eRetract then
return'行军返回中'
end
end

function xjTeamHandle_plotRetract:getTargetDesc(state)
local cloudData=self.cloudData
state=state or cloudData:checkCloudPlotState(self.plotIdx)
if state==xjCloudPlotStateType.eNone then
return"未开始"
end
end

function xjTeamHandle_plotRetract:getTargetIconName(state)
local cloudData=self.cloudData
state=state or cloudData:checkCloudPlotState(self.plotIdx)
if state==xjCloudPlotStateType.eRetract then
return"icon_zjm_duiwu_2"
end
end

function xjTeamHandle_plotRetract:getStateIconName(state)

end

function xjTeamHandle_plotRetract:checkIsShowProgress(state)
local cloudData=self.cloudData
state=state or cloudData:checkCloudPlotState(self.plotIdx)
if state==xjCloudPlotStateType.eRetract then
return true
end
return false
end

function xjTeamHandle_plotRetract:checkIsOnMove(state,isBack)
local cloudData=self.cloudData
state=state or cloudData:checkCloudPlotState(self.plotIdx)
if state==xjCloudPlotStateType.eRetract then
return true
end
return false
end


function xjTeamHandle_plotRetract:maskSpeeUp()
return true
end


function xjTeamHandle_plotRetract:checkSpeeUp(isWarning)
if not self:checkSpeeUpOpen(isWarning)then
return false
end
return true
end


function xjTeamHandle_plotRetract:doSpeedUp(itemid)
if not self:checkSpeeUp(true)then
return false
end
xianjieController:reqCloudPlotSpeedUp(self.cloudid,self.plotIdx,itemid,true)
return true
end


function xjTeamHandle_plotRetract:onSpeedUp()
self.movePath=nil
end



function xjTeamHandle_plotRetract:maskRetract()
return true
end



function xjTeamHandle_plotRetract:onDelete()

end

return xjTeamHandle_plotRetract