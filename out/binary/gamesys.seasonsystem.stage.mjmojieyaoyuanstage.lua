mjMoJieYaoYuanStage=simple_class(seasonStage)


function mjMoJieYaoYuanStage:onRefresh(serverData,isInit)
if isInit then

end



self.chapter_scroe=serverData.chapter_scroe or 0
self.pass_rw_flag=serverData.pass_rw_flag or 0
self.stage_rw_idx=serverData.stage_rw_idx or 0

self.chapter_actor_score=serverData.chapter_actor_scroe or 0
self.chapter_guild_score=serverData.chapter_guild_scroe or 0
self.actor_stage_score=serverData.actor_stage_score or 0

local seasonType=self.handle.id
local stageIndex=self.index
if self:isUnlock()and self:isOverEnd()then
if seasonModel:readOpenAnimRecord(seasonType,stageIndex)==0 then
seasonModel:markOpenAnimRecordNoPost(seasonType,stageIndex,2)
seasonModel:markUnlockTabAnimRecord(seasonType,stageIndex,1)
end
end
end


function mjMoJieYaoYuanStage:onDelete()

end


function mjMoJieYaoYuanStage:getReddot()
return self:getTargetReddot()
end


function mjMoJieYaoYuanStage:isFinish()
if self.chapter_scroe==nil then return false end

local passLevelCondition=self:getConfig('passLevelCondition')
return self.chapter_scroe>=passLevelCondition.max
end


function mjMoJieYaoYuanStage:getProgress()
local passLevelCondition=self:getConfig("passLevelCondition")
local max=passLevelCondition.max
local lastNum=max-self.chapter_scroe
return lastNum
end


function mjMoJieYaoYuanStage:isOver()
local stageScoreRewardList=self:getConfig('stageScoreRewardList')
return self.stage_rw_idx>=#stageScoreRewardList and self.pass_rw_flag==1
end


function mjMoJieYaoYuanStage:getTargetReddot()
if not self:checkOpen()then
return false
end

if not self:isOverBegin()then
return false
end

if not self:isOverEnd()and seasonModel:readOpenAnimRecord(self.handle.id,self.index)~=2 then
return false
end


if self:getFinishRewardReddot()then
return true
end


if self:getStageRewardReddot()then
return true
end

return false
end

function mjMoJieYaoYuanStage:getFinishRewardReddot()
if self:isFinish()and self.pass_rw_flag==0 then
return true
end
end

function mjMoJieYaoYuanStage:getStageRewardReddot()
local stageScoreRewardList=self:getConfig('stageScoreRewardList')
local actorStageScoreCond=not xianjieModel:isBeginnerSeason()
and self:getConfig("actorStageScoreCond")
or false

local needIdx=nil
local listCount=#stageScoreRewardList

for index=1,listCount do
local serverWideRewardInfo=stageScoreRewardList[index]

local personalTargetScore=actorStageScoreCond and actorStageScoreCond[index]or-1

local canReceive=self.chapter_scroe>=serverWideRewardInfo[1]
if personalTargetScore~=-1 then
canReceive=canReceive and self.actor_stage_score>=personalTargetScore
end

if canReceive then
needIdx=index
else
break
end
end

if needIdx==nil then return false end

if needIdx>self.stage_rw_idx then return true end

return false
end

function mjMoJieYaoYuanStage:on_39_2(param1,param2,param3)
local reqType=param1
if reqType==1 then
self.pass_rw_flag=1
elseif reqType==2 then
self.stage_rw_idx=param2
end
end

function mjMoJieYaoYuanStage:on_39_3(score,end_time,param1)
self.chapter_scroe=score
self.endTime=end_time
end

return mjMoJieYaoYuanStage