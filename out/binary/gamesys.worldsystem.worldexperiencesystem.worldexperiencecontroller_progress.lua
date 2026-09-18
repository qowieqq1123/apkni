local _progress={
[eExperiencePonitState.Init]=function()
worldExperienceController:doInitProgress()
end,
[eExperiencePonitState.PreStory]=function()
worldExperienceController:doPreStoryProgress()
end,
[eExperiencePonitState.Content]=function()
worldExperienceController:doContentProgress()
end,
[eExperiencePonitState.PostStory]=function()
worldExperienceController:doPostStoryProgress()
end,
[eExperiencePonitState.Finish]=function()
worldExperienceController:doFinishProgress()
end,
}
local _content={
[eExperiencePonitType.FIGHT]=function(point,id)
worldExperienceController:doFightContent(point,id)
end,
[eExperiencePonitType.EVENT]=function(point,id)
worldExperienceController:doEventContent(point,id)
end,
[eExperiencePonitType.FAKEBATTLE]=function(point,id)
worldExperienceController:doFakeBattleContent(point,id)
end,
}
local _walkBts={}










local _onMoveStep=function(bt,index)
local dept=bt:getSharedVar("dept")
local dest=bt:getSharedVar("dest")
local model=bt:getSharedVar("model")
local path=bt:getSharedVar("path")
local count=#path
if index<count then
local pathKey=worldExperienceModel:getPathKey(dept,dest,index)
local modelSettings=worldModel:getModelSettings(model,eWorldUnitTpye.EXPERIENCE)
worldController:changeUnitModel(pathKey,modelSettings)
end
end

function worldExperienceController:cleanWalkBt()
if#_walkBts>0 then
for i,v in ipairs(_walkBts)do
behaviorManager:removeBehaviorTree(v)
end
_walkBts={}
end
self.animation=false
end

function worldExperienceController:doContinue()

if self:isAnimationing()or self:isInCommunication()or not worldController:getCameraControl()then
return
end
if worldController:isInWorld()and worldExperienceModel:checkScene()then
local cState=worldExperienceModel:getCurrentState()
_progress[cState]()
end
end

function worldExperienceController:doInitProgress()

local points=worldExperienceModel:getAllPoint()
local cnt=#points
local dept=points[cnt-1]
local dest=points[cnt]
local deptCfg=cfgHelper.get1(cfg_experienceconfig_get,dept)
local destCfg=cfgHelper.get1(cfg_experienceconfig_get,dest)
local pathCfg=cfgHelper.get2(cfg_experiencepathconfig_get,dept,dest)
local model=cfgHelper.get3(cfg_worldglobalconfig_get,"experiencePathModel","value",1)
local height=cfgHelper.get3(cfg_worldglobalconfig_get,"experienceCameraHeight","value",1)
local way=pathCfg.way or 0

local disciplePath={}
local followerPath={deptCfg.disciplinePos}
for i,v in ipairs(pathCfg.points)do
table.insert(disciplePath,v[1])
table.insert(followerPath,v[1])
end
table.insert(disciplePath,destCfg.disciplinePos)

local followers=worldExperienceModel:getAllFollower()
local max=#followers+1
local _onComplete=function(bt)

max=max-1
if max<=0 then
worldController:resumeCameraControl()
local pointKey=worldExperienceModel:getDiscipleKey()
worldController:lookAtUnit(pointKey,height,true)
self:cleanWalkBt()
self:afterInitProgress()
end
end
for i,v in ipairs(followers)do
local followerKey=worldExperienceModel:getFollowerKey(i)
local tempPath=table.deepCopy(followerPath)
table.insert(tempPath,destCfg.followPos[i])
local origin=deptCfg.followPos[i]
local destination=destCfg.followPos[i]
local args1={
unitKey=followerKey,
path=tempPath,
lock=false,
onComplete=_onComplete,
way=way,
origin=origin,
destination=destination,
flip=destination[1]<origin[1],
}
local bt=behaviorManager:addBehaviorTree("bw_discipleexperience",nil,true,args1)
table.insert(_walkBts,bt)
end

local discipleKey=worldExperienceModel:getDiscipleKey()
local origin=deptCfg.disciplinePos
local destination=destCfg.disciplinePos
local args0={
dept=dept,
dest=dest,
model=model,
unitKey=discipleKey,
path=disciplePath,
lock=true,
onMoveStep=_onMoveStep,
onComplete=_onComplete,
way=way,
origin=origin,
destination=destination,
flip=destination[1]<origin[1],
}
local bt=behaviorManager:addBehaviorTree("bw_discipleexperience",nil,true,args0)
table.insert(_walkBts,bt)
worldController:stopCameraControl()
self.animation=true
end

function worldExperienceController:afterInitProgress()








local point=worldExperienceModel:getCurrentPoint()
self:changeToFightUnit(point)


self:send_5_12(point,eExperiencePonitState.PreStory)




end

function worldExperienceController:doPreStoryProgress()

local point=worldExperienceModel:getCurrentPoint()
local pointCfg=cfgHelper.get1(cfg_experienceconfig_get,point)
newbieManager.startNewbie(NEW_BIE_CND_TYPE.eStartExperience,point)
if pointCfg.preStory then
if pointCfg.preCamera then
local cTF=worldController:getCameraTransform()
if pointCfg.preCamera[1]then
cTF.position=mathHelper.convertArrayToVector(pointCfg.preCamera[1])
end
if pointCfg.preCamera[2]then
cTF.rotation=Quaternion.Euler(pointCfg.preCamera[2],0,0)
end
end
worldStoryController:showStoryTree(pointCfg.preStory,function()
self:afterPreStoryProgress()
end)
else
self:afterPreStoryProgress()
end
end

function worldExperienceController:afterPreStoryProgress()

local point=worldExperienceModel:getCurrentPoint()


self:send_5_12(point,eExperiencePonitState.Content)




end

function worldExperienceController:doContentProgress()

local point=worldExperienceModel:getCurrentPoint()
local pointCfg=cfgHelper.get1(cfg_experienceconfig_get,point)
if pointCfg.param then
local typo=pointCfg.param[1]
if _content[typo]then
_content[typo](point,pointCfg.param[2])
return
end
end
self:afterContentProgress()
end

function worldExperienceController:afterContentProgress()
local point=worldExperienceModel:getCurrentPoint()


self:send_5_12(point,eExperiencePonitState.PostStory)




end

function worldExperienceController:doPostStoryProgress()

local point=worldExperienceModel:getCurrentPoint()
local pointCfg=cfgHelper.get1(cfg_experienceconfig_get,point)
if pointCfg.postStory then
if pointCfg.postCamera then
local cTF=worldController:getCameraTransform()
if pointCfg.postCamera[1]then
cTF.position=mathHelper.convertArrayToVector(pointCfg.postCamera[1])
end
if pointCfg.postCamera[2]then
cTF.rotation=Quaternion.Euler(pointCfg.postCamera[2],0,0)
end
end
worldStoryController:showStoryTree(pointCfg.postStory,function()
self:afterPostStoryProgress()
end)
else
self:afterPostStoryProgress()
end
end

function worldExperienceController:afterPostStoryProgress()
local point=worldExperienceModel:getCurrentPoint()


self:send_5_12(point,eExperiencePonitState.Finish)



end

function worldExperienceController:doFinishProgress()

local point=worldExperienceModel:getCurrentPoint()
local pointCfg=cfgHelper.get1(cfg_experienceconfig_get,point)

local csIndex=worldExperienceModel:handleFollower(pointCfg.followInfo)

if csIndex then
self:refreshFollowUnitList(csIndex)
end
newbieManager.startNewbie(NEW_BIE_CND_TYPE.eEndExperience,point)
notifySystem:postNotify(notifyConfig.onExperiencePointCompleted,point)
self:afterFinishProgress()
end

function worldExperienceController:afterFinishProgress()
local point=worldExperienceModel:getCurrentPoint()
local pointCfg=cfgHelper.get1(cfg_experienceconfig_get,point)

if pointCfg.next and#pointCfg.next==1 then
self:send_5_12(pointCfg.next[1],eExperiencePonitState.Init)
end
end


function worldExperienceController:doFightContent(point,id)

self:showFightWin(point,id)
end

function worldExperienceController:doEventContent(point,id)

local cWorld=worldExperienceModel:getCurrentWorld()
local cBlock=worldExperienceModel:getCurrentBlock()
local targetKey=worldExperienceModel:convertTaskTargetKey(cWorld,cBlock)
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(targetKey)
local task=worldTaskModel:getTask(taskKey)
local guidList=fightPreSelectModel.convertDisciple2FightStruct2(task.team)
local param={MysteryEventSendType.eLiLian,point}
MysteryEventSystem.event_start(SYSTEM_DEFINE.eLiLian,id,guidList,param)
end

function worldExperienceController:doFakeBattleContent(point,id)

local report=fightModel:getFightReport(id)
local closeCB=function(b)
if worldExperienceModel:checkBattle(b)then
worldExperienceModel:setBattle()
self:afterContentProgress()
end
end
local completeCB=function(b)
if worldExperienceModel:checkBattle(b)then
fightController:closeBattle(b)
end
end

local startCB=function()
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
local battleId=fightController:startBallte(report,true,completeCB,closeCB,{hideExitWatch=false})
worldExperienceModel:setBattle(battleId)
UIManager:hideWindow("UIWorldExperienceWin")
worldController:displayHUD(false)
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCB})
end
