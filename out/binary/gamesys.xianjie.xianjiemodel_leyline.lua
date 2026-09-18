local _data=nil
local _repairData=nil
local _repairLog=nil
local _lastReqTime=nil
local _reqInterval=30
local _seasonStage={}

function xianjieModel:initLeyLineConfig()
local cfg=cfg_crossseasonconfig()
for season,config in pairs(cfg)do
for index,info in ipairs(config.chapter_list)do
local stageType=info[2]
if stageType==seasonStageType.eXFXNJZ then
local stageId=info[1]
local stageCfg=cfgHelper.get1(cfg_seasonchapterfixbuildconfig_get,stageId)
if stageCfg.entityID==xjClientBuildType.flcbXianYuLingMai then
table.insert(_seasonStage,{seasonStageType.eXFXNJZ,stageId,season,index})
end
end
end
end
end

function xianjieModel:checkLeyLineSeasonStageOpen()
local names={}
for i,v in ipairs(_seasonStage)do
local stage=seasonModel:findStage(v[1],v[2])
if stage and stage:isOverBegin()and stage:checkOpen()then
return true
else
local handleName=seasonModel:getHandleConfig(v[3],"name")
local stageName=seasonModel:getStageConfig(v[1],v[2],"name")
table.insert(names,{handleName,stageName})
end
end
return false,names
end

function xianjieModel:checkLeyLineSeasonStageFinish()
for i,v in ipairs(_seasonStage)do
local stage=seasonModel:findStage(v[1],v[2])
if stage and stage:checkOpen()and stage:isOverEnd()then
return true
end
end
return false
end

function xianjieModel:isLeyLineSeasonStage(season_id,chapter_idx)
local info=cfgHelper.get3(cfg_crossseasonconfig_get,season_id,"chapter_list",chapter_idx)
if info then
for i,v in ipairs(_seasonStage)do
if v[1]==info[2]and v[2]==info[1]then
return true
end
end
end
return false
end

function xianjieModel:findLeyLineRepairSeasonStage()
local list={}
for i,v in ipairs(_seasonStage)do
local stage=seasonModel:findStage(v[1],v[2])
if stage then
table.insert(list,stage)
end
end
return list
end

function xianjieModel:createLeyLineData()
if not _data and initProControl:isDoneKF()and xianjieModel:checkInit()then
_data=xianjieController:createXJClass(xjDataType.eLeyLine,{})
end
end

function xianjieModel:deleteLeyLineData()
if _data then
xianjieController:removeXJClass(_data)
_data=nil
end
end

function xianjieModel:getLeyLineData()
return _data
end

function xianjieModel:refreshLeyLineEntity()
if _data then
_data:refreshEnity()
end
end

function xianjieModel:checkLeyLineScene(sceneidx)
sceneidx=sceneidx or xianjieModel:getSceneIndex()
return _data~=nil and _data.sceneidx==sceneidx
end

function xianjieModel:isInLeyLineRange(sceneidx,gridX,gridZ)
if _data then
return _data.sceneidx==sceneidx and _data.gridX<=gridX and gridX<=_data.gridX+_data.gridWidth and _data.gridZ<=gridZ and gridZ<=_data.gridZ+_data.gridHeight
end
return false
end

function xianjieModel:clearLeyLineRepairData()
_repairData=nil
_repairLog=nil
end

function xianjieModel:setLeyLineRepairData(serverData)
local oldFlag=_repairData and _repairData.flag or 0
local oldCnt=_repairData and _repairData.count or 0
_repairData={}
_repairData.stage=serverData.stage_idx
_repairData.flag=serverData.stage_rw_flag<0 and oldFlag or serverData.stage_rw_flag
_repairData.score=serverData.score
_repairData.count=serverData.day_times<0 and oldCnt or serverData.day_times
_repairData.items={}
for i=1,serverData.item_len do
local v=serverData.itemList[i]
_repairData.items[v.param_1]=v.param_2
end

_repairLog=serverData.logList or{}
table.sort(_repairLog,self.sortLeyLineLog)
end

function xianjieModel:getLeyLineRepairData()
return _repairData
end

function xianjieModel:updateLeyLineRepairFlag(flag)
if _repairData then
_repairData.flag=flag
end
end

function xianjieModel.sortLeyLineLog(a,b)
if a.times~=b.times then
return a.times>b.times
else
return a.log_type>b.log_type
end
end

function xianjieModel:getLeyLineRepairStage()
if _repairData then
return _repairData.stage
end
return 0
end

function xianjieModel:getLeyLineRepairScore()
if _repairData then
return _repairData.score
end
return 0
end

function xianjieModel:getLeyLineRepairFlag()
if _repairData then
return _repairData.flag
end
return 0
end

function xianjieModel:getLeyLineRepairFlagEx()
if _repairData then
local fixed_build_conf=cfgHelper.get3(cfg_fairylandclientbuildconfig_get,xjClientBuildType.flcbXianYuLingMai,"param","fixed_build_conf")
local count=#fixed_build_conf
return mathHelper.cntbit(_repairData.flag,0,count)
end
return 0
end

function xianjieModel:getLeyLineRepairCount()
if _repairData then
return _repairData.count
end
return 0
end

function xianjieModel:resetLeyLineRepairCount()
if _repairData then
_repairData.count=0
end
end

function xianjieModel:checkLeyLineRepairCount()
if _repairData then
local day_cnt=cfgHelper.get3(cfg_fairylandclientbuildconfig_get,xjClientBuildType.flcbXianYuLingMai,"param","day_cnt")
local march_cnt=xianjieModel:getRepairLeyLineMarchCount()
local warnTips=nil
local check=(_repairData.count+march_cnt)<day_cnt
if not check then
warnTips=_repairData.count>=day_cnt and"今日派遣次数已用完"or FMT.fmt("今日已成功派遣{0}次，当前已有{1}队前往中的派遣，派遣失败",_repairData.count,march_cnt)
end
return check,warnTips
end
return false
end

function xianjieModel:getRepairLeyLineMarchCount()
local list=xianjieModel:findMatrchTeamData(xjServerMarchType.eCarry,function(data)
if data.isMyWaiPai then
local teamHandle=data:getTeamHandle()
local state=teamHandle:getTeamState()
return state==xjMarchTeamStateType.eGoto or state==xjMarchTeamStateType.eBattle
end
return false
end)
return#list
end

function xianjieModel:isLeyLineRepairFinish()
if _repairData then
local fixed_build_conf=cfgHelper.get3(cfg_fairylandclientbuildconfig_get,xjClientBuildType.flcbXianYuLingMai,"param","fixed_build_conf")
local count=#fixed_build_conf
return _repairData.stage>=count and _repairData.score>=fixed_build_conf[count][1]
end
return false
end

function xianjieModel:getLeyLineRepairProgress()
if _repairData then
local fixed_build_conf=cfgHelper.get3(cfg_fairylandclientbuildconfig_get,xjClientBuildType.flcbXianYuLingMai,"param","fixed_build_conf")
local stage=self:getLeyLineRepairStage()
local total=0
local current=0
for i,v in ipairs(fixed_build_conf)do
total=total+v[1]
if i<stage then
current=current+v[1]
elseif i==stage then
current=current+self:getLeyLineRepairScore()
end
end
return math.floor(current/total*10000)
end
return 0
end

function xianjieModel:getLeyLineRepairItemCount(index)
if _repairData then
return _repairData.items[index]or 0
end
return 0
end

function xianjieModel:getLeyLineRepairLogs()
return _repairLog or{}
end

function xianjieModel:checkLeyLineRepairReqTime()
if _lastReqTime then
local nowTime=timeHelper.getServerShortTime()
return nowTime>=_lastReqTime+_reqInterval
end
return true
end

function xianjieModel:markLeyLineRepairReqTime()
_lastReqTime=timeHelper.getServerShortTime()
end

function xianjieModel:clearLeyLineRepairReqTime()
_lastReqTime=nil
end