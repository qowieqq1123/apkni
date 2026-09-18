
seasonStage=simple_class()


function seasonStage:__init(handle,serverData)
self.handle=handle

self.index=serverData.chapter_idx
self.beginTime=serverData.begin_time
self.endTime=serverData.end_time
self.type=serverData.chapter_type
self.buff_flag=serverData.buff_flag or eSeasonStageBuffFlagEnum.eNone


local chapter_list=self.handle:getConfig("chapter_list")
self.id=chapter_list[self.index][1]

self:onRefresh(serverData,true)
self:onRefreshBuff()
end


function seasonStage:__delete()
self:onDelete()
end


function seasonStage:onRefresh(serverData,isInit)

end


function seasonStage:onDelete()

end


function seasonStage:refreshInfo(serverData)
self.beginTime=serverData.begin_time
self.endTime=serverData.end_time
self.buff_flag=serverData.buff_flag or eSeasonStageBuffFlagEnum.eNone

self:onRefresh(serverData,false)
self:onRefreshBuff(serverData)
end


function seasonStage:onNewDay()

end


function seasonStage:onNewDay5am()

end


function seasonStage:getReddot()
return false
end


function seasonStage:isFinish()
return false
end


function seasonStage:getProgress()
return 0
end


function seasonStage:isOver()
return false
end

function seasonStage:checkOpen()
local taskId=self:getConfig("main_task_id")
if taskId==nil then return true end
return taskModel:checkTaskFinish(taskId)
end

function seasonStage:isOverBegin()
return self.beginTime~=0 and self.beginTime<=timeHelper.getServerShortTime()
end

function seasonStage:isOverEnd()
return 0<self.endTime and self.endTime<=timeHelper.getServerShortTime()
end


function seasonStage:getConfig(...)
return seasonModel:getStageConfig(self.type,self.id,...)
end


function seasonStage:onBegin()
end


function seasonStage:onEnd()
end

function seasonStage:getState()
if self:isFinish()or self:isOverEnd()then
return eSeasonStageStateEnum.eFinish
end

if self.endTime~=0 and(not self:isOverEnd())and self:getConfig("auto_complete_times")~=nil then
return eSeasonStageStateEnum.ePreFinish
end

if self:isOverBegin()then
return eSeasonStageStateEnum.eDoing
end

if self:isUnlock()then
return eSeasonStageStateEnum.eUnLock
end

return eSeasonStageStateEnum.eLock
end

function seasonStage:isUnlock()
return self.beginTime~=0
end

function seasonStage:onRefreshBuff(serverData)


if self.buff_flag==eSeasonStageBuffFlagEnum.eAllRecv then return end

local start_buff=self:getConfig('start_buff')

if start_buff~=nil and self:isOverBegin()and self:checkOpen()and(self.buff_flag~=eSeasonStageBuffFlagEnum.eStartBuff and self.buff_flag~=eSeasonStageBuffFlagEnum.eAllRecv)then
seasonController:send_39_2(self.handle.id,self.index,5,1)
end

local end_buff=self:getConfig('end_buff')

if end_buff~=nil and self:isOverEnd()and(self.buff_flag~=eSeasonStageBuffFlagEnum.eEndBuff and self.buff_flag~=eSeasonStageBuffFlagEnum.eAllRecv)then
seasonController:send_39_2(self.handle.id,self.index,5,2)
end
end