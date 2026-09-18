






local _MODULENAME="zmvisitchallengeModel"

local _ClientSaveFlagName='ActiveVisitorChallengeID'


def_table(_MODULENAME)
zmvisitchallengeModel.name=_MODULENAME
zmvisitchallengeModel.data={}

local oldIsRed=nil


function zmvisitchallengeModel:onAppStart()

end


function zmvisitchallengeModel:onEnterState(isReconnect)
self.data.challengeData={}
self.data.activeChallengeId=0
end


function zmvisitchallengeModel:onProtocolReq()

end


function zmvisitchallengeModel:onLeaveState(isReconnect)

self.data={}
end




function zmvisitchallengeModel:getVisitorChallengeState()
return userActorSetting.get(_ClientSaveFlagName,nil)
end


function zmvisitchallengeModel:setVisitorChallengeState(challenge_id)
userActorSetting.set(_ClientSaveFlagName,challenge_id)
userActorSetting.flush()
end


function zmvisitchallengeModel:checkFirstClickNpc(challenge_id)
local localChallengeId=self:getVisitorChallengeState()

if localChallengeId then
if localChallengeId==challenge_id then
return false
end
elseif zmvisitchallengeModel:checkChallengeFinishByLevelId(1)then

return false
end
return true
end


function zmvisitchallengeModel:getVisitorChallengeId()
return self.data.challengeData.challengeid
end


function zmvisitchallengeModel:setInFight(state)
self.data.inFight=state
end


function zmvisitchallengeModel:getInFight()
return self.data.inFight
end



function zmvisitchallengeModel:getOpenChallengeId()
return self.data.activeChallengeId
end


function zmvisitchallengeModel:checkChallengeFinishByLevelId(level_id)
if self.data.challengeData and self.data.challengeData.maxPassId then
return self.data.challengeData.maxPassId>=level_id
end
return false
end



function zmvisitchallengeModel:setChallengeData(data)
self.data.challengeData=data
self.data.activeChallengeId=data.challengeid
end


function zmvisitchallengeModel:getChallengeData()
return self.data.challengeData
end

function zmvisitchallengeModel:changeChallengeID()
local upChangeId=self.data.challengeData.challengeid+1
local allChanllengeConfig=cfg_visitorchallengeconfig()
if allChanllengeConfig[upChangeId]~=nil then
self.data.challengeData.challengeid=upChangeId
self.data.activeChallengeId=upChangeId
return true
end
return false
end

function zmvisitchallengeModel:resetChallengeData()
self.data.challengeData.maxPassId=0
self.data.challengeData.recvFlag=0
end


function zmvisitchallengeModel:getCurrentLevel()
return self.data.challengeData.maxPassId
end

function zmvisitchallengeModel:addCurrentLevel()
local totalChallengeLevelNum=zmvisitchallengeConfig.getChallengeMaxNum(self.data.challengeData.challengeid)
self.data.challengeData.maxPassId=self.data.challengeData.maxPassId+1
self.data.challengeData.maxPassId=Mathf.Min(totalChallengeLevelNum,self.data.challengeData.maxPassId)
zmvisitchallengeController:freshVisitorHud()
end

function zmvisitchallengeModel:isChallengeFinish(level_id)
return self:getCurrentLevel()>=level_id
end

function zmvisitchallengeModel:checkFinishAllLevel()
local challengeId=self.data.activeChallengeId
if not challengeId or challengeId==0 then
return false
end
local totalLevel=zmvisitchallengeConfig.getChallengeMaxNum(challengeId)
local isFinish=self:checkChallengeFinishByLevelId(totalLevel)
return isFinish
end

function zmvisitchallengeModel:checkNeedReqChallengeOpen()
local challengeData=self.data.challengeData

local checkNextChallengeOpen=function(challenge_id)
local nextChallengeCfg=cfgHelper.get1(cfg_visitorchallengeconfig_get,challenge_id+1)
if nextChallengeCfg then
local zmlv=zongmenModel:getLevel()
if nextChallengeCfg.sect_lv then
if zmlv>=nextChallengeCfg.sect_lv then
zmvisitchallengeController:req_25_32()
end
else
zmvisitchallengeController:req_25_32()
end
end
end

if next(challengeData or{})then
local freshStamp=challengeData.freshStamp
freshStamp=timeHelper.convertLongStamp(freshStamp)
if timeHelper.isOutFiveStamp(freshStamp)then
if self:checkFinishAllLevel()then
checkNextChallengeOpen(self.data.activeChallengeId)
end
end
else
checkNextChallengeOpen(0)
end
end

function zmvisitchallengeModel:getBigRewardFlag()
return self.data.challengeData.recvFlag
end

function zmvisitchallengeModel:setBigRewardFlag()
self.data.challengeData.recvFlag=1
end



function zmvisitchallengeModel:resetVisitor()
self.visitor=nil
end

function zmvisitchallengeModel:setVisitor(mapId,entGuid,entBt,entHud,challengeId)
self.visitor={
entMap=mapId,
entGuid=entGuid,
entBt=entBt,
entHud=entHud,
challengeId=challengeId,
}
end

function zmvisitchallengeModel:getVisitor()
return self.visitor
end



function zmvisitchallengeModel:refreshCheckReddot()
local newIsRed=zmvisitchallengeModel:checkFirstClickReddot()or zmvisitchallengeModel:checkBigRewardReddot()
if newIsRed~=oldIsRed then
oldIsRed=newIsRed
UIManager:invokeUIMethod('UIFuncStorageWin','refreshFastManagerBtn')
end
end

function zmvisitchallengeModel:checkReddot()
return oldIsRed
end

function zmvisitchallengeModel:checkFirstClickReddot()
local challengeId=zmvisitchallengeModel:getOpenChallengeId()
if not challengeId then
return false
end
local isFristClick=zmvisitchallengeModel:checkFirstClickNpc(challengeId)
return isFristClick
end

function zmvisitchallengeModel:checkBigRewardReddot()
local isFinishAllLevel=zmvisitchallengeModel:checkFinishAllLevel()
local isBigRewardFlag=zmvisitchallengeModel:getBigRewardFlag()
return isFinishAllLevel and isBigRewardFlag==0
end
