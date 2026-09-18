mjZhenTaiStage=simple_class(seasonStage)

function mjZhenTaiStage:onInit()

end


function mjZhenTaiStage:onRefresh(serverData,isInit)
local seasonType=self.handle.id
local stageIndex=self.index

self.chapter_scroe=serverData.chapter_scroe or 0
self.pass_rw_flag=serverData.pass_rw_flag or 0

xianjieModel:setZhenTaiDatas(seasonType,stageIndex,serverData.zhenTaiList,isInit)

if self:checkOpen()and self:isOverEnd()and not xianjieModel:checkZhenTaiFinishFlag(seasonType,stageIndex,self.beginTime)then
msgWinControl:addMsgWin(msgWinType.eZhenTaiFinish,{seasonType=seasonType,stageIndex=stageIndex})
end

if self:isUnlock()and self:isOverEnd()then
if seasonModel:readOpenAnimRecord(seasonType,stageIndex)==0 then
seasonModel:markOpenAnimRecordNoPost(seasonType,stageIndex,2)
seasonModel:markUnlockTabAnimRecord(seasonType,stageIndex,1)
end
end
end


function mjZhenTaiStage:onDelete()


end


function mjZhenTaiStage:getReddot()
return self:getTargetReddot()
end

function mjZhenTaiStage:onNewDay()

end


function mjZhenTaiStage:isFinish()
if self.chapter_scroe==nil then return false end

if self:isOverEnd()then return true end

local passLevelCondition=self:getConfig('passLevelCondition')
return self.chapter_scroe>=passLevelCondition.max
end


function mjZhenTaiStage:getProgress()
return self.chapter_scroe
end


function mjZhenTaiStage:isOver()
return self.pass_rw_flag==1
end

function mjZhenTaiStage:onEnd()
msgWinControl:addMsgWin(msgWinType.eZhenTaiFinish,{seasonType=self.handle.id,stageIndex=self.index})
end

function mjZhenTaiStage:getTargetReddot()
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

return false
end

function mjZhenTaiStage:getFinishRewardReddot()
if self:isFinish()and self.pass_rw_flag==0 then
return true
end
end

function mjZhenTaiStage:on_39_2(param1,param2,param3)
local reqType=param1
if reqType==1 then
self.pass_rw_flag=1
elseif reqType==3 then
local build_id=param2
local fixNum=tonumber(param3)
if fixNum>0 then
local seasonType=self.handle.id
local stageIndex=self.index
local entityData=xianjieModel:getZhenTaiEntity(seasonType,stageIndex,build_id)
if entityData then
local stageCfg=seasonModel:getStageConfigEx(seasonType,stageIndex)
local fix_cost=stageCfg.fix_cost[build_id]
local finish_item_id=stageCfg.finish_item_id[build_id]
local finish_item_count=0
for i,v in ipairs(fix_cost)do
if finish_item_id==v[1]then
finish_item_count=v[2]
break
end
end
entityData.finish_cnt=entityData.finish_cnt+(fixNum*finish_item_count)
entityData:refreshEntity()
end
end
elseif reqType==4 then
local build_id=param2
local seasonType=self.handle.id
local stageIndex=self.index
xianjieModel:setZhenTaiBuffBeginTime(seasonType,stageIndex,build_id)
end
end

function mjZhenTaiStage:on_39_3(score,end_time,param1)
self.chapter_scroe=score
self.endTime=end_time
end


return mjZhenTaiStage