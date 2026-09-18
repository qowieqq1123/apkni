






local _MODULENAME="seasonModel"


def_table(_MODULENAME)
seasonModel.name=_MODULENAME
seasonModel.data={}
seasonModel.openAnim={}
seasonModel.checkMountain={}
seasonModel.unlockAnim={}


function seasonModel:onAppStart()
local cfg=cfg_monijysfconfig()
for sfId,config in pairs(cfg)do
for i,v in ipairs(config.unlock_condition)do
local type=v.type
if type==3 then
self.checkMountain[sfId]={0,v.param,1}
elseif type==4 then
self.checkMountain[sfId]={0,v.param,0}
end
end
end
end


function seasonModel:onEnterState(isReconnect)
self.openAnim=userActorArraySetting.get(ACTOR_SETTING_TYPE.eSeasonSystem,"OpenAnim",{})
self.unlockAnim=userActorArraySetting.get(ACTOR_SETTING_TYPE.eSeasonSystem,"UnlockAnim",{})
end


function seasonModel:onProtocolReq()

end


function seasonModel:onLeaveState(isReconnect)

self.openAnim={}
self.unlockAnim={}
self:clearData()
self:clearRankData()
self:clearTaskData()
self:clearTriggerShowPreview()
end


function seasonModel:removeHandle(sHandleType)
local handle=self:getHandle(sHandleType)
if handle then
handle:deleteSelf()
self.data[sHandleType]=nil
end
end

function seasonModel:setHandle(handleData)
local handle=self:getHandle(handleData.season_id)
if handle then
handle:refreshInfo(handleData)
else
local handle=self:getHandleClass(handleData.season_id)
self.data[handleData.season_id]=handle.New(handleData)
end
end

function seasonModel:clearData()
for i,v in pairs(self.data)do
v:deleteSelf()
end
table.clear(self.data)
end

function seasonModel:getHandle(sHandleType)
return self.data[sHandleType]
end




function seasonModel:getHandleByType(type)
if self.data and next(self.data)then
for index,seasonHandle in pairs(self.data)do
local seasonType=seasonHandle:getConfig('seasonType')
if seasonType==type then
return seasonHandle
end
end
end
end

function seasonModel:isHasSeasonHandleByType(type)
local seasonHandle=self:getHandleByType(type)
return seasonHandle~=nil
end

function seasonModel:isHasOpenSeasonHandleByType(type,seasonID)
local seasonHandle=self:getHandleByType(type)
if seasonHandle==nil then return false end
if seasonHandle.id~=seasonID then return false end

return seasonHandle:isOverBegin()
end

function seasonModel:getStage(sHandleType,stageIdx)
local sHandle=self:getHandle(sHandleType)
if sHandle then
return sHandle:getStage(stageIdx)
end
end

function seasonModel:getHandleLastOpenStage(sHandleType)
local sHandle=self:getHandle(sHandleType)
if sHandle then
local stages=sHandle:getStages()
local count=#stages
for i=count,1,-1 do
local stage=stages[i]
if stage:isOverBegin()and stage:checkOpen()then
return i,stage
end
end
end
end

function seasonModel:getHandleEnterStage(sHandleType)
local sHandle=self:getHandle(sHandleType)
if sHandle then
local stages=sHandle:getStages()
local index=nil
for i,v in ipairs(stages)do
if v:checkOpen()and v:isOverBegin()then
if v:getReddot()then
return i
else
index=i
end
elseif v:isUnlock()then
index=i
end
end
return index or 1
end
return 1
end

function seasonModel:readOpenAnimRecord(handleType,stageIdx)
local key=tostring(handleType)
local seasonRecord=self.openAnim[key]
if seasonRecord then

return tonumber(seasonRecord[stageIdx])or 0
end
return 0
end

function seasonModel:markOpenAnimRecordNoPost(handleType,stageIdx,record)
local key=tostring(handleType)
local seasonRecord=self.openAnim[key]
if not seasonRecord then
seasonRecord={}
self.openAnim[key]=seasonRecord
end
seasonRecord[stageIdx]=record

userActorArraySetting.set(ACTOR_SETTING_TYPE.eSeasonSystem,"OpenAnim",self.openAnim)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSeasonSystem)
end

function seasonModel:markOpenAnimRecord(handleType,stageIdx,record)
local key=tostring(handleType)
local seasonRecord=self.openAnim[key]
if not seasonRecord then
seasonRecord={}
self.openAnim[key]=seasonRecord
end
seasonRecord[stageIdx]=record

userActorArraySetting.set(ACTOR_SETTING_TYPE.eSeasonSystem,"OpenAnim",self.openAnim)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSeasonSystem)

notifySystem:postNotify(notifyConfig.onSeasonOpenAnimationChange,handleType,stageIdx,record)
end

function seasonModel:readUnlockTabAnimRecord(handleType,stageIdx)
local key=tostring(handleType)
local seasonRecord=self.unlockAnim[key]
if seasonRecord then
return seasonRecord[stageIdx]or 0
end
return 0
end

function seasonModel:markUnlockTabAnimRecord(handleType,stageIdx,record)
local key=tostring(handleType)
local seasonRecord=self.unlockAnim[key]
if not seasonRecord then
seasonRecord={}
self.unlockAnim[key]=seasonRecord
end
seasonRecord[stageIdx]=record

userActorArraySetting.set(ACTOR_SETTING_TYPE.eSeasonSystem,"UnlockAnim",self.unlockAnim)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSeasonSystem)
end

function seasonModel:getHandleConfig(handleType,...)
return cfgHelper.get(cfg_crossseasonconfig_get,handleType,...)
end

function seasonModel:getStageConfig(stageType,stageId,...)
local cfgName=cfgHelper.get2(cfg_crossseasonchaptertypeconfig_get,stageType,"config")
local getName=cfgHelper.getCofingGetFunction(cfgName)
return cfgHelper.get(getName,stageId,...)
end

function seasonModel:getStageConfigEx(handleType,stageIdx,...)
local chapterCfg=self:getHandleConfig(handleType,"chapter_list",stageIdx)
local stageType=chapterCfg[2]
local stageId=chapterCfg[1]
return self:getStageConfig(stageType,stageId,...)
end

function seasonModel:findStage(type,id)
for handleType,handle in pairs(self.data)do
local stages=handle:getStages()
for stageIdx,stage in ipairs(stages)do
if stage.type==type and(id==nil or stage.id==id)then
return stage
end
end
end
end

function seasonModel:findTaskStages(taskId)
local list={}
for handleType,handle in pairs(self.data)do
local stages=handle:getStages()
for stageIdx,stage in ipairs(stages)do
if stage.containTask and(taskId==nil or stage:containTask(taskId))then
table.insert(list,stage)
end
end
end
return list
end

function seasonModel:findFirstDoingStage(stageType)
local minTime=timeHelper.getServerShortTime()
local _stage=nil
for handleType,handle in pairs(self.data)do
local stages=handle:getStages()
for stageIdx,stage in ipairs(stages)do
if stage.type==stageType and stage:checkOpen()and stage:isOverBegin()and not stage:isOverEnd()then
if stage.beginTime<=minTime then
_stage=stage
minTime=stage.beginTime
end
end
end
end
return _stage
end

function seasonModel:haveDoingStage(stageType)
local minTime=timeHelper.getServerShortTime()
for handleType,handle in pairs(self.data)do
local stages=handle:getStages()
for stageIdx,stage in ipairs(stages)do
if stage.type==stageType and stage:checkOpen()and stage:isOverBegin()and not stage:isOverEnd()then
return true
end
end
end
return false
end

function seasonModel:haveBeginStage(stageType)
local minTime=timeHelper.getServerShortTime()
for handleType,handle in pairs(self.data)do
local stages=handle:getStages()
for stageIdx,stage in ipairs(stages)do
if stage.type==stageType and stage:checkOpen()and stage:isOverBegin()then
return true
end
end
end
return false
end

function seasonModel:getSeasonEnter()
for i,v in pairsBySortKey(self.data)do
if v:checkShowCondition()then
return i
end
end
end

function seasonModel:getSeasonEnterList()
local list={}
for i,v in pairsBySortKey(self.data)do
local isCanShow=v:checkShowCondition()
if isCanShow then
list[#list+1]={1,i}
end
end

if seasonModel:checkShowMoJieSeasonPreview()then
local enterData=xianjieModel:getMoJieEnterData()
list[#list+1]={2,enterData.sId}
end

table.sort(list,function(a,b)
if a[1]==b[1]then
return a[2]<b[2]
else
return a[1]<b[1]
end
end)
return list
end

function seasonModel:checkHandleShowCondition(season_id)
local handle=seasonModel:getHandle(season_id)
if handle then
return handle:checkShowCondition()
end
return false
end

function seasonModel:checkMountainOpen(season_id,chapter_idx)
local sf={}
for i,v in pairs(self.checkMountain)do
if v[1]==season_id and v[2]==chapter_idx then
local handle=seasonModel:getHandle(season_id)
if handle and handle:checkCondition()then
local stage=seasonModel:getStage(season_id,chapter_idx)
if stage and stage:checkOpen()then
if v[3]==1 and stage:isOverEnd()and mountainControl:isOpen(i)and not zongmenModel:isMountainUnlock(i)then
table.insert(sf,i)
elseif v[3]==0 and stage:isOverBegin()and mountainControl:isOpen(i)and not zongmenModel:isMountainUnlock(i)then
local stageCfg=stage:getConfig()
if stageCfg.storyMountain then
if seasonModel:readOpenAnimRecord(season_id,chapter_idx)==2 then
table.insert(sf,i)
end
else
table.insert(sf,i)
end
end
end
end
end
end
return sf
end

function seasonModel:checkAllMountainOpen()
local sf={}
for i,v in pairs(self.checkMountain)do
local handle=seasonModel:getHandle(v[1])
if handle and handle:checkCondition()then
local stage=seasonModel:getStage(v[1],v[2])
if stage and stage:checkOpen()and stage:isOverEnd()and mountainControl:isOpen(i)and not zongmenModel:isMountainUnlock(i)then
table.insert(sf,i)
end
end
end
return sf
end

function seasonModel:isCanShowPreviewGuide()
return not MojiePreviewExtendController.checkPoKaiMoJieFlag()
end


function seasonModel:getStageIdx(seasonID,stageType)
local chapter_list=self:getHandleConfig(seasonID,"chapter_list")
for index,cfg in ipairs(chapter_list)do
local _stageType=cfg[2]
if _stageType==stageType then
return index
end
end
end

function seasonModel:getStageSegementProgressVal(seasonID,stageIdx,curVal)
local stageScoreRewardList=self:getStageConfigEx(seasonID,stageIdx,'stageScoreRewardList')

local maxSegement=#stageScoreRewardList
local singleSegement=1/maxSegement

local pre=0
local cur=0
local curSe=0
local boundVal=0

for index,segement in ipairs(stageScoreRewardList)do
boundVal=segement[1]
cur=boundVal
if boundVal>curVal then
break
end
pre=cur
curSe=index
end

if maxSegement==curSe then
return 1
end

local v_dur=curVal-pre
local b_dur=cur-pre

return curSe*singleSegement+(v_dur/b_dur)*singleSegement
end

function seasonModel:checkOtherAnim(behavier)
return userActorArraySetting.get(ACTOR_SETTING_TYPE.eSeasonSystem,behavier,0)==0
end

function seasonModel:markOtherAnim(behavier)
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eSeasonSystem,behavier,1,0)
end

function seasonModel:resetRecord_GM()
userActorArraySetting.clear(ACTOR_SETTING_TYPE.eSeasonSystem)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSeasonSystem)
end

function seasonModel:recvCJXYAllReward_GM()
local handle=self:getHandleByType(eSeasonType.eCJXY)
if handle==nil then return end
if handle.stages==nil then return end

seasonModel:markOpenAnimRecord(handle.id,1,2)
seasonModel:markOpenAnimRecord(handle.id,2,2)
seasonModel:markOpenAnimRecord(handle.id,3,2)
seasonModel:markOpenAnimRecord(handle.id,4,2)
seasonModel:markOpenAnimRecord(handle.id,5,2)
seasonModel:markOpenAnimRecord(handle.id,6,2)
seasonModel:markOpenAnimRecord(handle.id,7,2)

seasonController:send_39_2(handle.id,1,1)
seasonController:send_39_2(handle.id,1,2)

seasonController:send_39_2(handle.id,2,1)
seasonController:send_39_2(handle.id,2,2)

seasonController:send_39_2(handle.id,3,1)

seasonController:send_39_2(handle.id,4,1)
seasonController:send_39_2(handle.id,4,2)


seasonController:send_39_2(handle.id,5,1)
seasonController:send_39_2(handle.id,5,2)

seasonController:send_39_2(handle.id,6,1)
seasonController:send_39_2(handle.id,6,2)

seasonController:send_39_2(handle.id,7,1)
seasonController:send_39_2(handle.id,7,2)

end