mjMoJingZhenJiStage=simple_class(seasonStage)


function mjMoJingZhenJiStage:onRefresh(serverData,isInit)
local season_id=self.handle.id
local chapter_idx=self.index
if serverData and serverData.len and serverData.len>0 then
for index=1,serverData.len do
local build_id=serverData.dieBuildingList[index]
xianjieModel:setMoJingZhenJiDestroyed(season_id,chapter_idx,build_id)
end
end
if serverData and serverData.len2 and serverData.len2>0 then
for index=1,serverData.len2 do
local attackData=serverData.attackList[index]
local build_id=attackData.param_1
local args={
buildId=attackData.param_1,
tzNum=attackData.param_2 or 0,
buyNum=attackData.param_3 or 0,
}
xianjieModel:setMoJingZhenJiChangellData(season_id,chapter_idx,build_id,args)
end
end

if not xianjieModel:getIsInitBenYuanZhenJiNetData(season_id,chapter_idx)then
xianjieController:reqBenYuanZhenJiList(season_id,chapter_idx)
end

if isInit then
local zjCfg=self:getConfig("byZhenJi")
for build_id,_ in pairs(zjCfg)do
xianjieModel:createBenYuanZhenJiData(season_id,chapter_idx,build_id)
end
end

self.chapter_scroe=serverData.chapter_scroe or 0
self.chapter_stage_scroe=serverData.chapter_stage_scroe or 0
self.pass_rw_flag=serverData.pass_rw_flag or 0
self.stage_rw_idx=serverData.stage_rw_idx or 0

local seasonType=self.handle.id
local stageIndex=self.index
if self:isUnlock()and self:isOverEnd()then
if seasonModel:readOpenAnimRecord(seasonType,stageIndex)==0 then
seasonModel:markOpenAnimRecordNoPost(seasonType,stageIndex,2)
seasonModel:markUnlockTabAnimRecord(seasonType,stageIndex,1)
end
end
end


function mjMoJingZhenJiStage:onDelete()
xianjieModel:clearBenYuanZhenJiDatas(self.handle.id,self.index)
end


function mjMoJingZhenJiStage:getReddot()
return self:getTargetReddot()
end

function mjMoJingZhenJiStage:onNewDay()

end


function mjMoJingZhenJiStage:isFinish()
if self.chapter_scroe==nil then return false end

local passLevelCondition=self:getConfig('passLevelCondition')
return self.chapter_scroe>=passLevelCondition.max
end


function mjMoJingZhenJiStage:getProgress()
local passLevelCondition=self:getConfig("passLevelCondition")
local max=passLevelCondition.max
local lastNum=max-self.chapter_scroe
return lastNum
end


function mjMoJingZhenJiStage:isOver()
return false
end

function mjMoJingZhenJiStage:onEnd()

end

function mjMoJingZhenJiStage:getTargetReddot()
if not self:checkOpen()then
return false
end

if not self:isOverBegin()then
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

function mjMoJingZhenJiStage:getFinishRewardReddot()
if self:isFinish()and self.pass_rw_flag==0 then
return true
end
end

function mjMoJingZhenJiStage:getStageRewardReddot()
local stageScoreRewardList=self:getConfig('stageScoreRewardList')

local needIdx
for index,stageRewardInfo in ipairs(stageScoreRewardList)do
if self.chapter_stage_scroe>=stageRewardInfo[1]then
needIdx=index
else
break
end
end

if needIdx==nil then return false end

if needIdx>self.stage_rw_idx then return true end

return false
end

function mjMoJingZhenJiStage:on_39_2(param1,param2,param3)
local reqType=param1
if reqType==11 then
self.pass_rw_flag=1
elseif reqType==22 then
self.stage_rw_idx=param2
end
end

function mjMoJingZhenJiStage:on_39_3(score,end_time,param1)
self.chapter_scroe=score
self.endTime=end_time
end

return mjMoJingZhenJiStage