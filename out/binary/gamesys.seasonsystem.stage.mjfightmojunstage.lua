mjFightMoJunStage=simple_class(seasonStage)

function mjFightMoJunStage:onInit()

end


function mjFightMoJunStage:onRefresh(serverData,isInit)
local seasonType=self.handle.id
local stageIndex=self.index

self.actor_stage_score=serverData.actor_stage_score or 0
self.chapter_scroe=serverData.chapter_scroe or 0
self.pass_rw_flag=serverData.pass_rw_flag or 0
self.stage_rw_idx=serverData.stage_rw_idx or 0
self.chapter_guild_scroe=serverData.chapter_guild_scroe or int64.zero

self.yaomoDieNum=serverData.yaomoDieNum or 0

xianjieModel:setMoJunDatas(seasonType,stageIndex,serverData,isInit)

local mojunDieTime=serverData.mojunDieTime or 0
local finishTip=serverData.finishTip or 0
if isInit and mojunDieTime>0 and finishTip==0 then
xianjieController:reqMoJunFinishData(seasonType,stageIndex)
end

self.total=self:getConfig("yaomoTotalNum")

if self:isUnlock()and self:isOverEnd()then
if seasonModel:readOpenAnimRecord(seasonType,stageIndex)==0 then
seasonModel:markOpenAnimRecordNoPost(seasonType,stageIndex,2)
seasonModel:markUnlockTabAnimRecord(seasonType,stageIndex,1)
end
end
end


function mjFightMoJunStage:onDelete()
xianjieModel:clearMoJunDatas(self.handle.id,self.index)
xianjieModel:clearMoJunRecords(self.handle.id,self.index)
end


function mjFightMoJunStage:getReddot()
return self:getTargetReddot()
end

function mjFightMoJunStage:onNewDay()

end


function mjFightMoJunStage:isFinish()
local passLevelCondition=self:getConfig('passLevelCondition')
return self.chapter_scroe>=passLevelCondition.max
end


function mjFightMoJunStage:getProgress()
local state=self:getStageState()
if state==0 then
return self.total
elseif state==1 then
return self.total-self.yaomoDieNum
elseif state>1 then
return xianjieModel:getMoJunHp()
end
return 0
end

function mjFightMoJunStage:getStageState()
local mojunData=xianjieModel:getMoJunData()
if not mojunData then return 0 end

return mojunData.state
end


function mjFightMoJunStage:isOver()
local stageScoreRewardList=self:getConfig('stageScoreRewardList')
return self.stage_rw_idx>=#stageScoreRewardList and self.pass_rw_flag==1
end

function mjFightMoJunStage:onEnd()
msgWinControl:addMsgWin(msgWinType.eMoJunFinish,{seasonType=self.handle.id,stageIndex=self.index})
end

function mjFightMoJunStage:getTargetReddot()
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

function mjFightMoJunStage:getFinishRewardReddot()
if self:isFinish()and self.pass_rw_flag==0 then
return true
end
end

function mjFightMoJunStage:getStageRewardReddot()
local stageScoreRewardList=self:getConfig('stageScoreRewardList')
local actorStageScoreCond=not xianjieModel:isBeginnerSeason()
and self:getConfig("actorStageScoreCond")
or false

local needIdx=nil
local listCount=#stageScoreRewardList

for index=1,listCount do
local serverWideRewardInfo=stageScoreRewardList[index]

local personalTargetScore=actorStageScoreCond and actorStageScoreCond[index]or-1

local canReceive=self.yaomoDieNum>=serverWideRewardInfo[1]
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


function mjFightMoJunStage:on_39_2(param1,param2,param3)
local reqType=param1
if reqType==1 then
self.pass_rw_flag=1
elseif reqType==2 then
self.stage_rw_idx=param2
end
end

function mjFightMoJunStage:on_39_3(score,end_time,param1)
self.chapter_scroe=score
self.endTime=end_time
if param1 then
self.yaomoDieNum=param1
end
end

return mjFightMoJunStage