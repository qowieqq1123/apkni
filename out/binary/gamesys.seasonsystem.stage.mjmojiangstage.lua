mjMoJiangStage=simple_class(seasonStage)

function mjMoJiangStage:onInit()

end


function mjMoJiangStage:onRefresh(serverData,isInit)
local seasonType=self.handle.id
local stageIndex=self.index

self.chapterScore=serverData.chapter_score or 0
self.pass_rw_flag=serverData.pass_rw_flag or 0

xianjieModel:setMoJiangDatas(seasonType,stageIndex,serverData.list,isInit)

if self:checkOpen()and self:isOverEnd()and not xianjieModel:checkMoJiangFinishFlag(seasonType,stageIndex,self.beginTime)then
msgWinControl:addMsgWin(msgWinType.eMoJiangFinish,{seasonType=seasonType,stageIndex=stageIndex})
end

if self:isUnlock()and self:isOverEnd()then
if seasonModel:readOpenAnimRecord(seasonType,stageIndex)==0 then
seasonModel:markOpenAnimRecordNoPost(seasonType,stageIndex,2)
seasonModel:markUnlockTabAnimRecord(seasonType,stageIndex,1)
end
end
end


function mjMoJiangStage:onDelete()
xianjieModel:clearMoJiangDatas(self.handle.id,self.index)
xianjieModel:clearMoJiangRanks(self.handle.id,self.index)
xianjieModel:clearMoJiangRecords(self.handle.id,self.index)
end


function mjMoJiangStage:getReddot()
return self:getTargetReddot()
end

function mjMoJiangStage:onNewDay()

end


function mjMoJiangStage:isFinish()
local passLevelCondition=self:getConfig('passLevelCondition')
return self.chapterScore>=passLevelCondition.max
end


function mjMoJiangStage:getProgress()
return self.chapterScore
end


function mjMoJiangStage:isOver()
return self.pass_rw_flag==1
end

function mjMoJiangStage:onEnd()
msgWinControl:addMsgWin(msgWinType.eMoJiangFinish,{seasonType=self.handle.id,stageIndex=self.index})
end

function mjMoJiangStage:getTargetReddot()
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


if self:getMoJiangTodayReward()then
return true
end

return false
end

function mjMoJiangStage:getFinishRewardReddot()
if self:isFinish()and self.pass_rw_flag==0 then
return true
end
end

function mjMoJiangStage:getMoJiangTodayReward()
local mojiang=self:getConfig("mojiang")
local tempMoJiang={}

local curTime=timeHelper.getServerShortTime()
local stageBeginTime=self.beginTime

for index,mjInfo in pairs(mojiang)do
tempMoJiang[#tempMoJiang+1]={bdid=index,mjInfo=mjInfo}
end

table.sort(tempMoJiang,function(a,b)
return a.mjInfo.open<b.mjInfo.open
end)

local isOpenAct=limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eMoJiang)

local reddot=false
for index,mojiang in ipairs(tempMoJiang)do
local isOpen=stageBeginTime+mojiang.mjInfo.open<=curTime
if isOpen then
local bossEntity=xianjieModel:getMoJiangEntity(self.handle.id,self.index,mojiang.bdid)
if bossEntity then
local cnt=math.max(mojiang.mjInfo.times-bossEntity.fightTimes,0)
reddot=(cnt>0 and isOpenAct and bossEntity.killTime<=0)or bossEntity:checkRewardReddot()
if reddot then
break
end
end
end
end

return reddot
end

function mjMoJiangStage:on_39_2(param1,param2,param3)
local reqType=param1
if reqType==1 then
self.pass_rw_flag=1
elseif reqType==6 then
local entityData=xianjieModel:getMoJiangEntity(self.handle.id,self.index,param2)
if entityData then
entityData.damageFlag=tonumber(param3)
entityData:refreshEntity()
end
elseif reqType==7 then
local entityData=xianjieModel:getMoJiangEntity(self.handle.id,self.index,param2)
if entityData then
entityData.dailyFlag=tonumber(param3)
entityData:refreshEntity()
end
end
end

function mjMoJiangStage:on_39_3(score,end_time,param1)
self.chapterScore=score
self.endTime=end_time
end


return mjMoJiangStage