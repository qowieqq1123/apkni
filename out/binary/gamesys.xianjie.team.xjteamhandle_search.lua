









local xjTeamHandle_search={}


function xjTeamHandle_search:onInit()
self.onlykey=FMT.fmt('{0}_{1}_{2}',self.teamType,self.cloudid)
self.cloudData=xianjieModel:getCloudData(self.cloudid)
end

function xjTeamHandle_search:getBackBeginTime()
if self.beginsec_back==nil then

local cloudData=self.cloudData
local eventTime=cloudData:getEventCostTime()
local wayTime=self:getMoveWayTime(false)
self.beginsec_back=cloudData.beginsec+wayTime+eventTime
end
return self.beginsec_back
end

function xjTeamHandle_search:getTargetPos()
local cloudData=self.cloudData
return cloudData.sceneidx,cloudData.gridX_c,cloudData.gridZ_c,1,1
end


function xjTeamHandle_search:getTargetData()
return self.cloudData
end


function xjTeamHandle_search:getBaseWayTime()
local movePath=self:getMyMovePath(false)
local speed=xianjieModel:getCloudSearchSpeed()
return xianjieController:getMovePathWayTime(movePath,speed)
end



function xjTeamHandle_search:getMoveWayTime(isBack)
local cloudData=self.cloudData
local movePath=self:getMyMovePath(isBack)
local speedlist=cloudData.speedlist
return xianjieController:getMovePathWayTime2(movePath,speedlist,isBack,nil)
end

function xjTeamHandle_search:getMyMovePath(isBack)
local movePath
if isBack then
movePath=self.movePath2
else
movePath=self.movePath1
end
if movePath then
return movePath
end
local cloudData=self.cloudData
if isBack==nil then
local typo=cloudData:getCurType()
if typo==xjCloudSearchType.eBegin then
isBack=false
else
isBack=true
end
end
local zmData=xianjieModel:getMyZongMenData()
local gridX_c_,gridZ_c_=xianjieModel:getZongMenWorldGridCenterPos(zmData)
if not isBack then
movePath=xianjieController:getMovePath(zmData.sceneidx,gridX_c_,gridZ_c_,cloudData.sceneidx,cloudData.gridX_c,cloudData.gridZ_c,self.areaTransferSelects)
self.movePath1=movePath
else
movePath=xianjieController:getMovePath(cloudData.sceneidx,cloudData.gridX_c,cloudData.gridZ_c,zmData.sceneidx,gridX_c_,gridZ_c_,self.areaTransferSelects)
self.movePath2=movePath
end
return movePath
end

function xjTeamHandle_search:getMoveTagList(movePath,isBack)
local cloudData=self.cloudData
local speedlist=cloudData.speedlist
local bTime
if isBack then
bTime=self:getBackBeginTime()
else
bTime=cloudData.beginsec
end
return xianjieController:getMoveTagList(movePath,bTime,speedlist)
end



function xjTeamHandle_search:checkMove(isBack)
local wayTime=self:getMoveWayTime(isBack)

local endTime
if isBack then
endTime=self:getBackBeginTime()+wayTime
else
endTime=self.cloudData.beginsec+wayTime
end
local curTime=gameUtilityModel.getServerShortTime2()
return curTime<endTime
end

function xjTeamHandle_search:geLerpTime()
local cloudData=self.cloudData
local wayTime
local endTime
local typo=cloudData:getCurType()
if typo==xjCloudSearchType.eBegin then

wayTime=self:getMoveWayTime(false)
endTime=cloudData.beginsec+wayTime
elseif typo==xjCloudSearchType.eGoto or typo==xjCloudSearchType.eEvent then

wayTime=cloudData:getEventCostTime()
local beginWayTime=self:getMoveWayTime(false)
endTime=cloudData.beginsec+beginWayTime+wayTime
else

wayTime=self:getMoveWayTime(true)
endTime=self:getBackBeginTime()+wayTime
end

local curTime=gameUtilityModel.getServerShortTime2()
local lerpTime=endTime-curTime
if lerpTime<0 then lerpTime=0 end
return lerpTime,wayTime
end

function xjTeamHandle_search:getOwnerName()
return playerModel:getActorName()
end

function xjTeamHandle_search:getTeamEnityKey()
return self.cloudData:getTeamEnityKey()
end

function xjTeamHandle_search:getTeamState()
local cloudData=self.cloudData
local state=cloudData:getCurType()
return state
end

function xjTeamHandle_search:getTargetName(state)
local cloudData=self.cloudData
state=state or cloudData:getCurType()
if state==xjCloudSearchType.eBegin then
local cfg=cfgHelper.get1(cfg_fairylandcloudconfig_get,self.cloudid)
local str=FMT.fmt("前往仙雾{0}",cfg.name)
return str
elseif state==xjCloudSearchType.eGoto or state==xjCloudSearchType.eEvent then
return"探索仙雾中......"
else
return"返回宗门"
end
end

function xjTeamHandle_search:getTargetIconName(state)
local cloudData=self.cloudData
state=state or cloudData:getCurType()
if state==xjCloudSearchType.eBegin then
return"icon_zjm_duiwu_1"
elseif state==xjCloudSearchType.eGoto or state==xjCloudSearchType.eEvent then
return"icon_zjm_duiwu_3"
else
return"icon_zjm_duiwu_2"
end
end
function xjTeamHandle_search:getTargetDesc(state)
return nil
end

function xjTeamHandle_search:getStateIconName(state)
return nil
end

function xjTeamHandle_search:checkIsShowProgress(state)
return true
end

function xjTeamHandle_search:checkIsOnMove(state,isBack)
local cloudData=self.cloudData
state=state or cloudData:getCurType()
if typo==xjCloudSearchType.eBegin then
if isBack==nil or isBack==false then
return true
end
elseif typo==xjCloudSearchType.eGoto or typo==xjCloudSearchType.eEvent then
return false
else
if self:checkMove(true)then
if isBack==nil or isBack==true then
return true
end
end
end
return false
end


function xjTeamHandle_search:maskSpeeUp()
return true
end


function xjTeamHandle_search:checkSpeeUp(isWarning)
if not self:checkSpeeUpOpen(isWarning)then
return false
end
return true
end


function xjTeamHandle_search:doSpeedUp(itemid)
if not self:checkSpeeUp(true)then
return false
end


return true
end


function xjTeamHandle_search:onSpeedUp()
self.movePath2=nil
self.movePath1=nil
end



function xjTeamHandle_search:maskRetract()
return true
end


function xjTeamHandle_search:doRetract()
if not self:checkRetract(true)then
return false
end


return true
end



function xjTeamHandle_search:onDelete()

end

return xjTeamHandle_search