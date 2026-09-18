







function xianjieModel:initData_mojie(attend)
local isInit=false
if self.data_mj==nil then
self.data_mj={}
isInit=true
end
self.data_mj.attend=attend
self.historySeason={}
return isInit
end

function xianjieModel:clearData_mojie(isReconnet)
self.data_mj=nil
self.baseData_mj=nil
self.historySeason=nil
end

function xianjieModel:clearDataGM_mojie()
self.data_mj={}
self.baseData_mj=nil
end

function xianjieModel:checkInit_mojie()
return self.data_mj~=nil
end

function xianjieModel:initBaseData_mojie()
if self.baseData_mj==nil then
self.baseData_mj={}
end
end

function xianjieModel:setJoin_mojie()
if self.data_mj then
self.data_mj.attend=1
end
end

function xianjieModel:checkJoin_mojie()
if self.data_mj then
return self.data_mj.attend==1
end
return false
end


local _enterData=nil

function xianjieModel:setMoJieEnterData(sId,sTime,eTime)
_enterData=_enterData or{}
_enterData.sId=sId
_enterData.sTime=sTime
_enterData.eTime=eTime
end

function xianjieModel:getMoJieEnterData()
return _enterData
end

function xianjieModel:clearMoJieEnterData()
_enterData=nil
end

function xianjieModel:getMoJieEnterConfig(...)
if _enterData then
return cfgHelper.get(cfg_devildomseasonconfig_get,_enterData.sId,...)
end
end

function xianjieModel:checkMoJieEnterTime(sceneType)
if _enterData then
local sceneCfg=cfgHelper.get1(cfg_xianjiesceneconfig_get,sceneType)
local seasonCfg=cfgHelper.get1(cfg_devildomseasonconfig_get,_enterData.sId)
if seasonCfg.sceneidx==sceneCfg.mapIndex then
local nowTime=timeHelper.getServerShortTime()
return _enterData.sTime<=nowTime and nowTime<_enterData.eTime
end
end
return false
end

function xianjieModel:checkCurrentMoJieEnterTime()
if _enterData then
local nowTime=timeHelper.getServerShortTime()

return _enterData.sTime<=nowTime and nowTime<_enterData.eTime
end
return false
end

function xianjieModel:checkTriggerSeasonStageBehaivour()
local sceneidx=self:getCurrentMoJieSceneIndex()
local _sceneidx=self:getSceneIndex()
if _sceneidx==sceneidx then
local seasonType=self:getMoJieEnterConfig("csid")
local seasonCfg=seasonModel:getHandleConfig(seasonType)
for stageIndex,stageInfo in ipairs(seasonCfg.chapter_list)do

if seasonController:checkSeasonStageOpenButNotBegined(seasonType,stageIndex)then
if stageIndex<=1 or seasonController:checkSeasonStageEnded(seasonType,stageIndex-1)then
local behavier=seasonModel:getStageConfigEx(seasonType,stageIndex,"enterSceneGuide2")
if behavier and seasonModel:checkOtherAnim(behavier)then
seasonModel:markOtherAnim(behavier)
xianjieStoryAIManager:startStoryBehavior(behavier)
return true
end
end
end

if seasonController:checkSeasonStageBeginedButNotEnded(seasonType,stageIndex)then
local behavier=seasonModel:getStageConfigEx(seasonType,stageIndex,"enterSceneGuide")
if behavier and seasonModel:checkOtherAnim(behavier)then
seasonModel:markOtherAnim(behavier)
seasonModel:markOpenAnimRecord(seasonType,stageIndex,2)
xianjieStoryAIManager:startStoryBehavior(behavier)
return true
end
end

end
end
end

function xianjieModel:getCurrentMoJieSceneType()
local cfg=self:getMoJieEnterConfig()
if cfg then
return xianjieModel:sceneIndex2SceneType(cfg.sceneidx)
end
end

function xianjieModel:getCurrentMoJieSceneIndex()
local cfg=self:getMoJieEnterConfig()
if cfg then
return cfg.sceneidx
end
end

local _finishPreview=nil
function xianjieModel:clearFinishPreview()
_finishPreview=nil
end

function xianjieModel:saveFinishPreview()
local stamp=timeHelper.getTodayZeroStamp()
_finishPreview=timeHelper.convertShortStamp(stamp)
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eMoJie,"finishPreview",_finishPreview,0)
end

function xianjieModel:checkFinishPreview()
_finishPreview=_finishPreview or userActorArraySetting.get(ACTOR_SETTING_TYPE.eMoJie,"finishPreview",0)
return(timeHelper.getServerShortTime()-_finishPreview)>=86400
end

local _recordData=nil
local _recordTime=nil
local _recordReward=nil
function xianjieModel:setMoJieRecordData(list)
_recordData={}
_recordReward={}
_recordTime=timeHelper.getServerShortTime()
if list then
local enterData=xianjieModel:getMoJieEnterData()
if enterData then
local mjSeasonCfg=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
local config=mjSeasonCfg.record
for i,v in ipairs(list)do
_recordData[v.recordtype]=v
v.numEx=mathHelper.int64_to_number(v.num)
local cfg=config[v.recordtype]
local temp=cfg[0]
for j,w in ipairs(cfg)do
if w[1]<=v.rank and v.rank<=w[2]then
temp=w[3]
break
end
end
_recordReward[v.recordtype]=temp
end
end
end
end

function xianjieModel:getMoJieAllRecordData()
return _recordData
end

function xianjieModel:getMoJieRecordData(type)
if _recordData then
return _recordData[type]
end
end

function xianjieModel:clearMoJiRecordData()
_recordData=nil
_recordTime=nil
_recordReward=nil
end

function xianjieModel:haveMoJiRecordData()
return _recordTime~=nil
end

function xianjieModel:checkMoJieRecordData()
for i,v in pairs(_recordData)do
if v.numEx>0 then
return true
end
end
return false
end

function xianjieModel:getMoJieRecordReward(type)
return _recordReward[type]
end

function xianjieModel:setMoJieHistorySeason(list)
self.historySeason=list or{}
ServerTransferController.onSeasonStageDataChange()
end

function xianjieModel:getMoJieHistorySeason()
return self.historySeason
end

function xianjieModel:isBeginnerSeason()
return xianjieModel:getMoJieEnterData().sId==0
end




function xianjieModel:getSgMonsterTypeName(nameType)
nameType=nameType or 1
local seasonHandle=seasonModel:getHandleByType(eSeasonType.eMJMB)
local seasonId=seasonHandle and seasonHandle.id or-1
return xianjieModel:getSgMonsterTypeNameEx(nameType,seasonId)
end


function xianjieModel:getSgMonsterTypeNameEx(nameType,seasonId)
nameType=nameType or 1
local list=cfgHelper.get(cfg_devildombaseconfig_get,1,"sgMonsterTypeName")
local nameList=list[seasonId]or list[-1]
local name=nameList[nameType]
return name
end