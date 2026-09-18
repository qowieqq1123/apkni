cjxyFinalRewardStage=simple_class(seasonStage)

function cjxyFinalRewardStage:onRefresh(serverData,isInit)
self.free=serverData.free_reward_flag or 0
self.flag=serverData.score_reward_idx or 0

if self:getConfig("free_reward")==nil then
self.free=1
end
end

function cjxyFinalRewardStage:onDelete()

end

function cjxyFinalRewardStage:getReddot()
return self:isOverEnd()and self:checkOpen()and(self.free==0 or self.flag==0)
end

function cjxyFinalRewardStage:isFinish()
return true
end

function cjxyFinalRewardStage:isOver()
return self.free==1 and self.flag==1
end

function cjxyFinalRewardStage:getProgress()
local finishs=self:getConfig("finishConds")
if finishs and#finishs>0 then
local count=0
for i,v in ipairs(finishs)do
local stage=seasonModel:getStage(self.handle.id,v)
if stage~=nil and stage:checkOpen()and stage:isOverEnd()then
count=count+1
end
end
return math.floor(count/(#finishs)*10000)
end
return 10000
end

function cjxyFinalRewardStage:afterHanleRefresh()
self:checkEndTimeSet()
end

function cjxyFinalRewardStage:on_39_2(param1,param2,param3)

if param1==1 then
self.free=1

elseif param1==2 then
self.flag=1
elseif param1==5 then
self.buff_flag=param2
end
end

function cjxyFinalRewardStage:checkEndTimeSet()
if self.endTime>0 then return false end

local finishs=self:getConfig("finishConds")
if finishs and#finishs>0 then
local maxTime=0
for i,v in ipairs(finishs)do

local stage=self.handle.stages[v]
if not(stage~=nil and stage:checkOpen()and stage:isOverEnd())then
return false
else
maxTime=math.max(maxTime,stage.endTime)
end
end
self.endTime=maxTime
else
self.endTime=self.beginTime
end
return true
end

function cjxyFinalRewardStage:checkRelate(chapter_idx)
local finishs=self:getConfig("finishConds")
if finishs and#finishs>0 then
return table.containsValue(finishs,chapter_idx)
end
return false
end

function cjxyFinalRewardStage:relateStageHandle(chapter_idx)
if self:checkRelate(chapter_idx)then
return self:checkEndTimeSet()
end
return false
end

return cjxyFinalRewardStage