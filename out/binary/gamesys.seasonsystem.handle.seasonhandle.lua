
seasonHandle=simple_class()


function seasonHandle:__init(serverData)
self.id=serverData.season_id
self.beginTime=serverData.begin_time
self.endTime=serverData.end_time
self.updateTime=timeHelper.getServerShortTime()

local chapter_list=self:getConfig("chapter_list")
self.stages={}
if serverData.chapter_list_len>0 then
for i,v in ipairs(serverData.chapterList)do
xpcall(function()
self:setStage(v)
end,function(err)
logErr(FMT.fmt('season - {0} stage - {1},new stage has err:{2}',self.id,i,err))
end)
end
end

local curTime=timeHelper.getServerShortTime()

for index,conf in ipairs(chapter_list)do
local stageData=self.stages[index]
if stageData==nil then
local preStage=self.stages[index-1]
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



local fakeData={
chapter_idx=index,
begin_time=begin_time,
end_time=0,
chapter_type=conf[2]
}
xpcall(function()
self:setStage(fakeData)
end,function(err)
logErr(FMT.fmt('season - {0} stage - {1},new default stage has err:{2}',self.id,index,err))
end)
end
end


self:afterRefresh()

self:onInit()
self:onRefresh(serverData)
end


function seasonHandle:__delete()
for i,v in ipairs(self.stages)do
v:deleteSelf()
end
table.clear(self.stages)

self:onDelete()
end


function seasonHandle:onInit()
end


function seasonHandle:onRefresh(serverData)

end


function seasonHandle:onDelete()

end


function seasonHandle:refreshInfo(serverData)
self.beginTime=serverData.begin_time
self.endTime=serverData.end_time

for i=1,serverData.chapter_list_len do
local stageData=serverData.chapterList[i]
self:setStage(stageData)
end

self:afterRefresh()


self:onRefresh(serverData)
end



































function seasonHandle:afterRefresh()
for i,v in ipairs(self.stages)do
if v.afterHanleRefresh then
v:afterHanleRefresh()
end
end
self:handleEndTime(self.id)
end


function seasonHandle:setStage(stageData)
local stageIdx=stageData.chapter_idx
local stage=self.stages[stageIdx]
if stage then
stage:refreshInfo(stageData)
else
local stageClass=seasonModel:getStageClass(stageData.chapter_type)
stage=stageClass.New(self,stageData)
self.stages[stageIdx]=stage
end
end


function seasonHandle:onNewDay()
for i,v in ipairs(self.stages)do
v:onNewDay()
end
end


function seasonHandle:onNewDay5am()
for i,v in ipairs(self.stages)do
v:onNewDay5am()
end
end


function seasonHandle:getReddot()
if not self:checkOpen()or not self:checkCondition()then return false end

for i,v in ipairs(self.stages)do
if v:checkOpen()and v:isOverBegin()and(seasonModel:readOpenAnimRecord(self.id,i)~=2 or v:getReddot())then
return true
end
end
return false
end


function seasonHandle:isFinish()
local chapter_list=self:getConfig("chapter_list")
if#chapter_list>#self.stages then
return false
end

for i,v in ipairs(self.stages)do
if not v:isFinish()then
return false
end
end
return true
end


function seasonHandle:isOver()
local chapter_list=self:getConfig("chapter_list")
if#chapter_list>#self.stages then
return false
end

for i,v in ipairs(self.stages)do
if not v:isOver()then
return false
end
end
return true
end

function seasonHandle:checkOpen()
local nowTime=timeHelper.getServerShortTime()
return nowTime>=self.beginTime
end

function seasonHandle:checkComplete()
local nowTime=timeHelper.getServerShortTime()
if self.endTime>0 and nowTime>=self.endTime then
local chapter_list=self:getConfig("chapter_list")
for i,v in ipairs(chapter_list)do
local stage=self:getStage(i)
if stage==nil or not stage:checkOpen()or not stage:isOverEnd()then
return false
end
end
return true
end
return false
end

function seasonHandle:checkShowCondition()
return self:checkCondition()and not self:isOver()
end

function seasonHandle:checkCondition()
local config=self:getConfig("time_conf")
if config then
local type=config[1]
if type==1 then
return xianjieController:checkXianJieSystemOpen()and not xianjieController:checkInPlotScene2()
end
end
return true
end


function seasonHandle:getStages()
return self.stages
end


function seasonHandle:getStage(index)
return self.stages[index]
end


function seasonHandle:getConfig(...)
return seasonModel:getHandleConfig(self.id,...)
end

function seasonHandle:onUpdate()

for i,v in ipairs(self.stages)do
local check=false
if self.updateTime<v.beginTime and v:isOverBegin()and v:checkOpen()then
v:onBegin()
v:onRefreshBuff()
check=true
end
if self.updateTime<v.endTime and v:isOverEnd()and v:checkOpen()then
v:onEnd()
v:onRefreshBuff()
check=true

end
if check then
notifySystem:postNotify(notifyConfig.onSeasonStageChange,self.id,i)
end
end





self.updateTime=timeHelper.getServerShortTime()

end

function seasonHandle:onTaskFinish(taskId)
for i,v in ipairs(self.stages)do
if taskId==v:getConfig("main_task_id")and v:isOverBegin()then
v:onBegin()
notifySystem:postNotify(notifyConfig.onSeasonStageChange,self.id,i)
end
end
end

function seasonHandle:relateHandle(season_id,chapter_idx)
local list={}
if season_id==self.id then
for index,stage in ipairs(self.stages)do
if stage.relateStageHandle and stage:relateStageHandle(chapter_idx)then
table.insert(list,chapter_idx)
end
end
end
return list
end

function seasonHandle:handleEndTime(season_id)
if season_id==self.id then
local chapter_list=self:getConfig("chapter_list")
local endTime=0
for i,v in ipairs(chapter_list)do
local stage=self.stages[i]
if stage and stage.endTime>0 then
endTime=math.max(endTime,stage.endTime)
else
return
end
end
if self.endTime<=0 or endTime<self.endTime then
self.endTime=endTime
end
end
end

function seasonHandle:getCurStageIdx()
local stages=self.stages
local stageNo=#stages
for i,v in ipairs(stages)do
if not v:checkOpen()or not v:isOverEnd()then
stageNo=i
break
end
end
self.curStageIdx=stageNo
return stageNo
end

function seasonHandle:getCurStageHandle()
local curStageIdx=self:getCurStageIdx()
return self.stages and self.stages[curStageIdx]
end

function seasonHandle:getCurDoingStageIdx()
local stageNo=0
for i,v in ipairs(self.stages)do
if v:isOverBegin()and self:checkOpen()then
stageNo=i
else
break
end
end
return stageNo
end

function seasonHandle:isOverBegin()
return self.beginTime~=0 and self.beginTime<=timeHelper.getServerShortTime()
end

function seasonHandle:isOverEnd()
return self.endTime~=0 and self.endTime<=timeHelper.getServerShortTime()
end

function seasonHandle:isCanShowEnter()
return false
end
