mojiestageaimHandle=simple_class(seasonHandle)

function mojiestageaimHandle:onInit()

self._onSeasonStageChange=function(...)
self:onSeasonStageChange(...)
end

self._onSeasonStageDataChange=function(...)
self:onSeasonStageDataChange(...)
end

notifySystem:listenNotify(notifyConfig.onSeasonStageChange,self._onSeasonStageChange)

notifySystem:listenNotify(notifyConfig.onSeasonStageDataChange,self._onSeasonStageDataChange)
end

function mojiestageaimHandle:onDelete()
notifySystem:removelistener(notifyConfig.onSeasonStageChange,self._onSeasonStageChange)
notifySystem:removelistener(notifyConfig.onSeasonStageDataChange,self._onSeasonStageDataChange)
end



function mojiestageaimHandle:onSeasonStageChange(season_id,chapter_idx)
if season_id~=self.id then return end

local curTime=timeHelper.getServerShortTime()
local nextChapterIdx=chapter_idx+1
local stageHandle=self:getStage(chapter_idx)
local chapter_list=self:getConfig("chapter_list")
local conf=chapter_list[nextChapterIdx]
local nextStageHandle=self:getStage(nextChapterIdx)
if nextStageHandle~=nil and stageHandle.endTime~=0 and stageHandle:isFinish()and nextStageHandle.beginTime==0 then
local begin_time

if conf[3]~=nil and conf[3]~=-1 then
local preBegin=stageHandle and stageHandle.beginTime or self.beginTime
local stamp=timeHelper.convertLongStamp(preBegin)
local zeroStamp=timeHelper.getServerZeroStamp(stamp)
local zeroTime=timeHelper.convertShortStamp(zeroStamp)

begin_time=zeroTime+conf[3]
end

if conf[4]~=nil and conf[4]~=-1 and(stageHandle and stageHandle.endTime~=0 and curTime>=stageHandle.endTime)then
local preEndTime=stageHandle and stageHandle.endTime or self.beginTime
local stamp=timeHelper.convertLongStamp(preEndTime)
local zeroStamp=timeHelper.getServerZeroStamp(stamp)
local zeroTime=timeHelper.convertShortStamp(zeroStamp)

begin_time=zeroTime+conf[4]
end

if begin_time==nil then




begin_time=0
end



nextStageHandle.beginTime=begin_time
nextStageHandle:onRefresh(defaultT)
return true
end
end

function mojiestageaimHandle:onSeasonStageDataChange(season_id,chapter_idx)
if season_id~=self.id then return end

if self:onSeasonStageChange(season_id,chapter_idx)then
notifySystem:postNotify(notifyConfig.onSeasonStageChange,season_id,chapter_idx+1)
end
end


function mojiestageaimHandle:freshStagesState()
local chapter_list=self:getConfig("chapter_list")

local stages=self:getStages()
local curTime=timeHelper.getServerShortTime()
local preStage,isNeedFresh
for index,stage in ipairs(stages)do
if preStage~=nil then

if preStage.entTime~=0 and stage.beginTime==0 then
local conf=chapter_list[index]

local begin_time

if conf[3]~=nil and conf[3]~=-1 then
local preBegin=preStage and preStage.beginTime or self.beginTime
local stamp=timeHelper.convertLongStamp(preBegin)
local zeroStamp=timeHelper.getServerZeroStamp(stamp)
local zeroTime=timeHelper.convertShortStamp(zeroStamp)

begin_time=zeroTime+conf[3]
end

if conf[4]~=nil and conf[4]~=-1 and(preStage and preStage.endTime~=0 and curTime>=preStage.endTime)then
local preEndTime=preStage and preStage.endTime or self.beginTime
local stamp=timeHelper.convertLongStamp(preEndTime)
local zeroStamp=timeHelper.getServerZeroStamp(stamp)
local zeroTime=timeHelper.convertShortStamp(zeroStamp)

begin_time=zeroTime+conf[4]
end

if begin_time==nil then




begin_time=0
end



stage.beginTime=begin_time
stage:onRefresh(defaultT)
end
end
preStage=stage
end
end


function mojiestageaimHandle:checkShowCondition()
if not self:checkCondition()then

return false
end








if seasonModel:isCanShowPreviewGuide(self.id)then

return false
end
if not xianjieModel:checkCurrentMoJieEnterTime()then

return false
end

return true
end

function mojiestageaimHandle:checkCondition()
local isJoin=xianjieModel:checkJoin()
local isFinishCJXY=seasonController:checkSeasonHandleComplete(0)
return isJoin and isFinishCJXY
end


function mojiestageaimHandle:getReddot()
if not self:checkOpen()or not self:checkCondition()then return false end

for i,v in ipairs(self.stages)do
if v:getReddot()then
return true
end
end
return false
end

return mojiestageaimHandle
