mjMoZongStage=simple_class(seasonStage)


function mjMoZongStage:onRefresh(serverData,isInit)
self.score=serverData.score
self.idx=serverData.idx
self.chapterScore=serverData.chapter_score or 0
self.stage_rw_idx=serverData.stage_rw_idx or 0
self.pass_rw_flag=serverData.pass_rw_flag or 0
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


function mjMoZongStage:onDelete()

end


function mjMoZongStage:onNewDay()

end


function mjMoZongStage:getReddot()
return self:getTargetReddot()
end


function mjMoZongStage:isFinish()
if self.chapterScore==nil then return false end

if self:isOverEnd()then return true end

local passLevelCondition=self:getConfig('passLevelCondition')
return self.chapterScore>=passLevelCondition.max
end


function mjMoZongStage:getProgress()
local passLevelCondition=self:getConfig("passLevelCondition")
local max=passLevelCondition.max
local lastNum=max-self.chapterScore
return lastNum
end


function mjMoZongStage:isOver()
local stageScoreRewardList=self:getConfig('stageScoreRewardList')
return self.stage_rw_idx>=#stageScoreRewardList and self.pass_rw_flag==1
end

function mjMoZongStage:checkMZStageRewardReddot()
local score=self:getConfig("score")
for i,v in ipairs(score[3])do
if self:getMZStageRewardState(i,v[1])==RewardTempState.eRecv then
return true
end
end
return false
end

function mjMoZongStage:getMZStageRewardState(idx,targetScore)
if idx<=self.idx then
return RewardTempState.eRecved
end
return self.score>=targetScore and RewardTempState.eRecv or RewardTempState.eNotRecv
end

function mjMoZongStage:getTargetReddot()
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

function mjMoZongStage:getFinishRewardReddot()
if self:isFinish()and self.pass_rw_flag==0 then
return true
end
end

function mjMoZongStage:getStageRewardReddot()
local stageScoreRewardList=self:getConfig('stageScoreRewardList')
local actorStageScoreCond=not xianjieModel:isBeginnerSeason()
and self:getConfig("actorStageScoreCond")
or false

local needIdx=nil
local listCount=#stageScoreRewardList

for index=1,listCount do
local serverWideRewardInfo=stageScoreRewardList[index]

local personalTargetScore=actorStageScoreCond and actorStageScoreCond[index]or-1

local canReceive=self.chapterScore>=serverWideRewardInfo[1]
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

function mjMoZongStage:on_39_2(param1,param2,param3)
local reqType=param1
if reqType==1 then
self.pass_rw_flag=1
elseif reqType==2 then
self.stage_rw_idx=param2
end
end

function mjMoZongStage:on_39_3(score,end_time,param1)
self.chapterScore=score
self.endTime=end_time
end

return mjMoZongStage