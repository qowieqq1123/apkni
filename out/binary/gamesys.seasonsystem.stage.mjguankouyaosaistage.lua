mjGuanKouYaoSaiStage=simple_class(seasonStage)


function mjGuanKouYaoSaiStage:onRefresh(serverData,isInit)
if isInit then

end

self.actor_stage_score=serverData.actor_stage_score or 0
self.chapterScore=serverData.chapter_scroe or 0
self.pass_rw_flag=serverData.pass_rw_flag or 0
self.stage_rw_idx=serverData.stage_rw_idx or 0


self.spe_rw_flag=serverData.spe_rw_flag or-1
self.spe_rw_cross_id=serverData.spe_rw_cross_id or 0

local gateListLen=serverData.len
local gateList=serverData.guankou_list
local seasonId=self.handle.id
local stageId=self.id
local stageType=self.type
local stageIndex=self.index
xianjieModel:setMoJieGateDatas(seasonId,stageId,stageType,stageIndex,gateList,isInit)
xianjieModel:setMoJieGateStageInfo(stageId,stageType,seasonId,stageIndex)

if not isInit then
xianjieModel:checkMoJieGateAtkBuff(self.id,self.type,seasonId)
end


if self:isUnlock()and self:isOverEnd()then
if seasonModel:readOpenAnimRecord(seasonId,stageIndex)==0 then
seasonModel:markOpenAnimRecordNoPost(seasonId,stageIndex,2)
seasonModel:markUnlockTabAnimRecord(seasonId,stageIndex,1)
end
end
end


function mjGuanKouYaoSaiStage:onDelete()

end


function mjGuanKouYaoSaiStage:getReddot()
return self:getTargetReddot()
end


function mjGuanKouYaoSaiStage:isFinish()
local passLevelCondition=self:getConfig('passLevelCondition')
return self.chapterScore>=passLevelCondition.max
end


function mjGuanKouYaoSaiStage:getProgress()
local minHpGateId=xianjieModel:getMinHpMoJieGateIdWithSelfXMAttacking()
if minHpGateId==nil then return-1 end
local gateMaxHp=xianjieModel:getMoJieGateMaxHp(self.id,self.type)
local bestLastHpFightGKInfo=xianjieModel:getMoJieGateData(minHpGateId)
local curHp=bestLastHpFightGKInfo.data.hp
return curHp,gateMaxHp
end


function mjGuanKouYaoSaiStage:isOver()
local stageScoreRewardList=self:getConfig('stageScoreRewardList')
return self.stage_rw_idx>=#stageScoreRewardList and self.pass_rw_flag==1 and(self.spe_rw_flag==1 or self.spe_rw_flag==3)
end


function seasonStage:onNewDay5am()

local seasonId=self.handle.id
xianjieModel:checkMoJieGateAtkBuff(self.id,self.type,seasonId)
end

function mjGuanKouYaoSaiStage:on_39_2(param1,param2,param3)
local reqType=param1
if reqType==1 then

local gateId=param2


elseif reqType==2 then

local gateId=param2
local xmGuid=param3

xianjieModel:clearMoJieGateReadAskMark_singleXm(gateId,xmGuid)

elseif reqType==3 then

local gateId=param2
local passTypeStr=param3
local passType=tonumber(passTypeStr)
xianjieModel:setMoJieGateData_passType(gateId,passType)


UIManager:invokeUIMethod("UIMoJieGate_passListWin","refreshAutoApplyBtn",gateId)

elseif reqType==4 then

local gateId=param2
local xmGuid=param3

end

if reqType==11 then
self.pass_rw_flag=1
end
if reqType==22 then
self.stage_rw_idx=param2
end
if reqType==33 then
self.spe_rw_flag=2
end
end


function mjGuanKouYaoSaiStage:on_39_3(score,end_time,param1)
self.chapterScore=score
self.endTime=end_time
end

function mjGuanKouYaoSaiStage:getTargetReddot()
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

function mjGuanKouYaoSaiStage:getFinishRewardReddot()
if self:isFinish()and self.pass_rw_flag==0 then
return true
end
end

function mjGuanKouYaoSaiStage:getStageRewardReddot()
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

return mjGuanKouYaoSaiStage