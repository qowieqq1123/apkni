









local xjEntityData_cloud={}


function xjEntityData_cloud:onInit()

self.sceneidx=xianjienSceneIndexType.eXianJie

local speedlist={}

local singleSearchSpeed=cfgHelper.get2(cfg_fairylandcloudconfig_get,self.cloudid,"singleSearchSpeed")
local baseSpeed=singleSearchSpeed or xianjieModel:getCloudSearchSpeed()
speedlist[1]={param_1=self.beginsec,param_2=baseSpeed}


self.speedlist=speedlist

local cfgs=cfgHelper.get1(cfg_fairylandcloudunlockconfig_get,self.cloudid)
self.maxIndex=#cfgs
local dzLookup={}
local hasDZ=false
if self.discipleList then
for i,vv in ipairs(self.discipleList)do
if vv>int64.zero then
dzLookup[tostring(vv)]=true
hasDZ=true
end
end
end
self.dzLookup=dzLookup
self.hasDZ=hasDZ

local pos_c,pos,size=xianjieModel:caculationCloudSize(self.cloudid)
self.gridWidth=size[1]
self.gridHeight=size[2]
self.gridX_c=pos_c[1]
self.gridZ_c=pos_c[2]
self.gridX=pos[1]
self.gridZ=pos[2]
local backIndex
local explorelp={}
local events={}
local qyevents={}
for i,cfg in ipairs(cfgs)do
explorelp[i]=cfg.explore
local typo=explorelp[i][1]
if typo==xjCloudSearchType.eEvent then
table.insert(events,cfg)
elseif typo==xjCloudSearchType.eBack then
table.insert(events,cfg)
backIndex=i
elseif typo==xjCloudSearchType.eQiYuEvent then
table.insert(qyevents,i)
end
end
self.backIndex=backIndex
self.explorelp=explorelp
self.events=events
self.qyevents=qyevents
self.defaultSpeed=singleSearchSpeed or xianjieModel:getCloudSearchSpeed()
end

function xjEntityData_cloud:initData()
self:initCloudPlot()
self:initTeamHandle()
self:initQiYuEntity(true)
end

function xjEntityData_cloud:getCurType(idx)
idx=idx or self.idx
if self.explorelp[idx]then
return self.explorelp[idx][1]
else
loggerUtil.logErrFMT("获取云雾索引类型失败:{0},{1}",idx,self.cloudid)
end
end

function xjEntityData_cloud:isUnlock()
return self.idx>=self.maxIndex
end

function xjEntityData_cloud:canUnlock()
return self.idx==self.maxIndex-1
end

function xjEntityData_cloud:hasMsg()
return self.idx<self.maxIndex and self.idx>=self.backIndex
end

function xjEntityData_cloud:getUnlockTime()
local teamHandle=self:getTeamHandle()
local wayTime=teamHandle:getMoveWayTime(false)

local unlockTime=self.beginsec+wayTime+self:getEventCostTime()
return unlockTime
end

function xjEntityData_cloud:getEventCostTime()

return self.events[#self.events].begin
end


function xjEntityData_cloud:isSearchBack()

if xianjieController:checkInPlotScene2()then
if self.idx>=self.backIndex then
local teamHandle=self:getTeamHandle()
return not teamHandle:checkMove(true)
else
return false
end
else
return true
end
end

function xjEntityData_cloud:checkDZIn(disguid_str)
return self.dzLookup[disguid_str]==true
end

function xjEntityData_cloud:getDZData()
if self.dzLookup then
for disguid_str,v in pairs(self.dzLookup)do
local netData=UIDiscipleModel:getDiscipleDataByStr(disguid_str)
if netData then
return netData
end
end
end
return nil
end


function xjEntityData_cloud:initBehaviorData()
if self.behaviorData==nil then
self.behaviorData={cloudid=self.cloudid}
end
end


function xjEntityData_cloud:initTeamHandle()

if self.teamHandleID==nil then
self.teamHandleID=xianjieController:addXJTeamHandle(xjTeamHandleType.eSearchTeam,{cloudid=self.cloudid})
end
end



function xjEntityData_cloud:getQiYuData(idx)
if self.c_quIndex then
if idx then
if self.c_quIndex==idx then
return self.qyData
end
else
return self.qyData
end
end
end

function xjEntityData_cloud:initQiYuEntity(isInit)
local quIndex=nil
if self.idx<self.maxIndex and self.idx>=self.backIndex then
local idx=self.idx+1
local typo=self:getCurType(idx)
if typo==xjCloudSearchType.eQiYuEvent then
quIndex=idx
end
end
if quIndex then
if self.c_quIndex~=quIndex then
self:clearQiYuEventEntity()
self.c_quIndex=quIndex
local data={cloudid=self.cloudid,idx=quIndex}
self.qyData=xianjieController:createXJClass(xjDataType.eCloudQiYu,data)
if not isInit then
self:createQiYuEntity(true)


local nextidx=quIndex
local typo=self:getCurType(nextidx)
local isAutoj=cfgHelper.get3(cfg_fairylandcloudunlockconfig_get,self.cloudid,nextidx,'isAutoj')
if typo and typo==xjCloudSearchType.eQiYuEvent and isAutoj then
local cloudData=xianjieModel:getCloudData(self.cloudid)
local cloudEntData=cloudData:getQiYuData()
local cloudPos=cloudEntData:getWorldPos()
local _fun=function()
xianjieModel:CloudjumpqiyuZY(cloudEntData.cloudid,nextidx,cloudEntData)
end
xianjieController:lookAtPositionChangeHeight(cloudPos,25,0.2,_fun,DG.Tweening.Ease.Linear)
end
end
end
else
self:clearQiYuEventEntity()
end
if not isInit then
local cloudEntData=xianjieModel:getCloudEntityData(self.cloudid)
if cloudEntData then
cloudEntData:refreshEnity()
end
notifySystem:postNotify(notifyConfig.onXianJieMsgChange,1)
end
end

function xjEntityData_cloud:createQiYuEntity(needRefreshAOI)
if self.qyData then
self.qyData:createEntity(needRefreshAOI)
end
end

function xjEntityData_cloud:clearQiYuEventEntity()
if self.c_quIndex~=nil then
xianjieController:removeXJClass(self.qyData)
self.qyData=nil
self.c_quIndex=nil

if self:canUnlock()then
local cloudEntData=xianjieModel:getCloudEntityData(self.cloudid)
local cloudPos=cloudEntData:getWorldPos()
local _fun=function()

xianjieModel:CloudjumpqiyuZY(cloudEntData.cloudid,self.idx+1,nil)
end
xianjieController:lookAtPositionChangeHeight(cloudPos,25,0.2,_fun,DG.Tweening.Ease.Linear)
end
end
end


function xjEntityData_cloud:createCloudUnLockEntity()
if not self.CloudUnLockData then
local data={cloudid=self.cloudid,idx=self.idx}
self.CloudUnLockData=xianjieController:createXJClass(xjDataType.eCloudUnLock,data)
end
if self.CloudUnLockData then
local cloudData=xianjieModel:getCloudData(self.cloudid)
if cloudData:canUnlock()then
self.CloudUnLockData:createEntity(true)
end
end
end


function xjEntityData_cloud:CloudUnLockEntityrunAnim()
if self.CloudUnLockData then
self.CloudUnLockData:runAnim()
end
end

function xjEntityData_cloud:clearCloudUnLockEntity()
if self.CloudUnLockData then
xianjieController:removeXJClass(self.CloudUnLockData)
end
self.CloudUnLockData=nil
end




function xjEntityData_cloud:getCloudPlotParams(plotIdx)
local plotIdx_str=tostring(plotIdx)
return self.cloudPlotParamslp[plotIdx_str]
end


function xjEntityData_cloud:checkCloudPlotState(plotIdx)

local plotParams=self:getCloudPlotParams(plotIdx)
if self.cloudPlotFinishlp[plotIdx]==true then
if plotParams~=nil then
local bTime=plotParams[1][1].param_1
local costTime=plotParams[5]
local wayTime1=costTime[1]
local wayTime2=costTime[2]
local battleTime=costTime[3]
local workTime=bTime+wayTime1+battleTime
local backTime=workTime+wayTime2
local curTime=gameUtilityModel.getServerShortTime2()
if curTime<backTime and curTime>=workTime then
return xjCloudPlotStateType.eFinishBack,backTime-curTime
elseif curTime<workTime then
return xjCloudPlotStateType.eBattle,workTime-curTime
end
end
return xjCloudPlotStateType.eFinish,nil,nil
else
if plotParams~=nil then
local retract=plotParams[6]
if retract==nil then
local bTime=plotParams[1][1].param_1
local costTime=plotParams[5]
local wayTime1=costTime[1]
local wayTime2=costTime[2]
local battleTime=costTime[3]
local battleBegin=plotParams[3]
local curTime=gameUtilityModel.getServerShortTime2()
if battleBegin==0 then
local arriveTime=bTime+wayTime1
return xjCloudPlotStateType.eGoto,math.max(0,arriveTime-curTime)
else
local workTime=bTime+wayTime1+battleTime
local backTime=workTime+wayTime2
if curTime<workTime then
return xjCloudPlotStateType.eBattle,workTime-curTime
elseif curTime>=workTime and curTime<backTime then
return xjCloudPlotStateType.eFailBack,backTime-curTime
end
end
else

local bTime=retract[2][1].param_1
local wayTime=retract[1]
local arriveTime=bTime+wayTime
local curTime=gameUtilityModel.getServerShortTime2()
local lerp=arriveTime-curTime
if lerp>0 then
return xjCloudPlotStateType.eRetract,lerp
end
end
end
return xjCloudPlotStateType.eNone,nil,nil
end
end

function xjEntityData_cloud:getCloudPlotData(plotIdx)
return self.cloudPlotlp[plotIdx]
end

function xjEntityData_cloud:checkCloudPlotFinish(plotIdx)
return self.cloudPlotFinishlp[plotIdx]==true
end

function xjEntityData_cloud:finishCloudPlotData(plotIdx)
if not self.cloudPlotFinishlp[plotIdx]then
self.cloudPlotFinishlp[plotIdx]=true
end
end

function xjEntityData_cloud:finishCloudPlotDataEx(plotIdx)
local cloudPlotData=self.cloudPlotlp[plotIdx]
if cloudPlotData then
local typo=cloudPlotData:getCurType()
if typo==xjCloudPlotType.eMonster then
local state=self:checkCloudPlotState(plotIdx)
if state==xjCloudPlotStateType.eFinish then
local teamHandleID=cloudPlotData.teamHandleID
cloudPlotData:removeEntity()
cloudPlotData:clearTeamHandle()
self.cloudPlotlp[plotIdx]=nil

notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eDelete,teamHandleID)
elseif state==xjCloudPlotStateType.eFinishBack then
cloudPlotData:removeEntity()
end
else
if self:checkCloudPlotFinish(plotIdx)then
cloudPlotData:removeEntity()
self.cloudPlotlp[plotIdx]=nil
end
end
end
end

function xjEntityData_cloud:retractCloudPlotData(plotIdx)
local cloudPlotData=self.cloudPlotlp[plotIdx]
if cloudPlotData then
local typo=cloudPlotData:getCurType()
if typo==xjCloudPlotType.eMonster then
local teamHandleID_retract=cloudPlotData.teamHandleID_retract

notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eDelete,teamHandleID_retract)
end
end
end

function xjEntityData_cloud:retractCloudPlot(plotIdx)

local plotIdx_str=tostring(plotIdx)
local lp=self.cloudPlotParamslp
local plotParams=lp[plotIdx_str]
local curTime=gameUtilityModel.getServerShortTime2()
local cloudPlotData=self:getCloudPlotData(plotIdx)
local teamHandle=cloudPlotData:getTeamHandle()

local movePath=teamHandle:getMyMovePath(false)
local bTime=plotParams[1][1].param_1
local moveTagList=teamHandle:getMoveTagList(movePath,bTime)
local moveTagIndex=xianjieController:getMoveTagListIndex(moveTagList)
local sceneidx,cpos,lerp_time,spos,epos,speed,isLast=xianjieController:getMoveTagLerpMovePos(moveTagList,moveTagIndex)
local gridX,gridZ=xianjieController:worldPos2WorldGridPos(cpos.x,cpos.z,sceneidx)
local retract={}
plotParams[6]=retract
local speedlist={{param_1=curTime,param_2=speed}}
retract[2]=speedlist
local cpos_={sceneidx,gridX,gridZ}
retract[3]=cpos_
local teamHandle_r=cloudPlotData:getTeamHandle_retract()
retract[1]=teamHandle_r:getBaseWayTime(speed)

local march=jsonHelper.encode(lp)
self.march=march
return march
end

function xjEntityData_cloud:checkDZIn_plot(plotIdx,disguid_str)
local lp=self.cloudPlotDZlp[plotIdx]
if lp and lp[disguid_str]==true then
return true
end
end

function xjEntityData_cloud:checkCloudPlotParam(plotIdx)
local plotIdx_str=tostring(plotIdx)
return self.cloudPlotParamslp[plotIdx_str]~=nil
end

function xjEntityData_cloud:initCloudPlot()

local cloudPlotFinishlp={}
if self.len>0 then


for i,v in ipairs(self.list)do
for j=1,32 do
local plotIdx=(i-1)*32+j
if bitHelper.check_pos(v,j-1)then
cloudPlotFinishlp[plotIdx]=true
end
end
end
end
self.cloudPlotFinishlp=cloudPlotFinishlp

local cloudPlotParamslp
if self.march~=nil and self.march~=''then

end
cloudPlotParamslp=cloudPlotParamslp or{}
self.cloudPlotParamslp=cloudPlotParamslp

self:initCloudPlotDZ()

local cloudPlotlp=self.cloudPlotlp
if cloudPlotlp==nil then
cloudPlotlp={}
self.cloudPlotlp=cloudPlotlp














end
end

function xjEntityData_cloud:initCloudPlotDZ(plotIdx)
if plotIdx==nil then
local cloudPlotDZlp={}
for plotIdx_str,plotParams in pairs(self.cloudPlotParamslp)do
local dzList=plotParams[4]
if dzList then
local dzlp={}
for i,disguid_str in ipairs(dzList)do
if disguid_str~='0'then
dzlp[disguid_str]=true
end
end
local plotIdx=tonumber(plotIdx_str)
cloudPlotDZlp[plotIdx]=dzlp
end
end
self.cloudPlotDZlp=cloudPlotDZlp
else
local plotParams=self.cloudPlotParamslp[plotIdx]
local dzlp=nil
if plotParams then
local dzList=plotParams[4]
if dzList then
dzlp={}
for i,disguid_str in ipairs(dzList)do
if disguid_str~='0'then
dzlp[disguid_str]=true
end
end
end
end
self.cloudPlotDZlp[plotIdx]=dzlp
end
end



function xjEntityData_cloud:onDelete()
self:clearQiYuEventEntity()
self:clearCloudUnLockEntity()
local cloudPlotlp=self.cloudPlotlp
if cloudPlotlp then
for plotIdx,cloudPlotData in pairs(cloudPlotlp)do
xianjieController:removeXJClass(cloudPlotData)
end
self.cloudPlotlp=nil
end
end

return xjEntityData_cloud