def_class('fightSkillAction',fightBaseAction)



function fightSkillAction:__init()
self.typo=fightActionType.CAST_SKILL
end

function fightSkillAction:init(_round,_rawData,_srcID,_dstID,_actionId)
self.round=_round
self.battle=_round:getBattle()
self.rawData=_rawData

self.srcID=_rawData[fightSkillTag.srcID]
self.id=_rawData[fightSkillTag.id]
self.level=_rawData[fightSkillTag.level]

self.actionId=_actionId

self.moveToBt=fBTBehaviorTree.get()
self.lsSummonBt=fBTBehaviorTree.get()
self.sameCampTarget=false
self.rangedSkill=false

self.isExeActions=false
self.isComplete=false
self.tailTime=0.0
self.curIndexObj=0
self.activeExeMode=false
self.activeIndexList={}
self.waittingActiveList={}
self.actingIndex=0
self.checkTimer=nil

self.skillArgs={self.typo,{self.id,self.level,self.srcID}}
self.btSrcID=self:getBtSrcID()

self.targets=self:initActions()
end


function fightSkillAction:exe()
self.isComplete=false
self.isExeBehavior=false
self.curIndexObj=0
self.checkTimer=nil
self.activeIndexList={}
self.waittingActiveList={}
self.haveBrokeAction=false
self.actingIndex=1
local _onBehaviorEvent=function(state,id)
self:onBehaviorEvent(state,id)
end
local ent=self.battle:getEntity(self.btSrcID)


if self.srcID==eSpeSrcID.eSys then
if ent==nil then
local baseData=fightModel:createVirtualInfo(1,1)
ent=self.battle:addEntity(self.srcID,baseData)
end
end

if ent~=nil then
self.hud=ent.hud

local cfg=cfg_skillconfig_get(self.id)
ent:activeOutEffect(false,true)
if cfg~=nil then
self.rangeType=cfg.rangeType or 0
self:moveToCenter(ent,cfg,_onBehaviorEvent)
else
self:onBehaviorEvent(fBTEvent.BehaviorFinish)
end
else
logErr(FMT.fmt("找不到实体{0}",self.btSrcID))
end
end

function fightSkillAction:logExe(logContent)
local ent=self.battle:getEntity(self.btSrcID)
local strSkillStart=''
local strSkillEnd=''
if ent~=nil then
local skillCfg=cfg_skillconfig_get(self.id)
if skillCfg~=nil then
strSkillStart=FMT.fmt('{0}开始使用[{1}]级技能[{2}][{3}]',ent:logName(),self.level,skillCfg.name,skillCfg.id)
strSkillEnd=FMT.fmt('{0}使用[{1}]级技能[{2}][{3}]结束',ent:logName(),self.level,skillCfg.name,skillCfg.id)
else
strSkillStart=FMT.fmt('【开始】-{0}找不到技能配置[{1}]',ent:logName(),self.id)
strSkillEnd=FMT.fmt('【结束】-{0}找不到技能配置[{1}]',ent:logName(),self.id)
end
else
if self.srcID==eSpeSrcID.eSys then
local skillCfg=cfg_skillconfig_get(self.id)
if skillCfg~=nil then
strSkillStart=FMT.fmt('系统开始使用[{0}]级技能[{1}][{2}]',self.level,skillCfg.name,skillCfg.id)
strSkillEnd=FMT.fmt('系统使用[{0}]级技能[{1}][{2}]结束',self.level,skillCfg.name,skillCfg.id)
else
strSkillStart=FMT.fmt('【开始】-系统找不到技能配置[{0}]',self.id)
strSkillEnd=FMT.fmt('【结束】-系统找不到技能配置[{0}]',self.id)
end
else
strSkillStart=FMT.fmt('【开始】-找不到技能的实体[{0}]',self.srcID or-1)
strSkillEnd=FMT.fmt('【结束】-找不到技能的实体[{0}]',self.srcID or-1)
end
end

logContent(strSkillStart)
for i,v in ipairs(self.actions)do
v:logExe(logContent)
end
logContent(strSkillEnd)
end

function fightSkillAction:statisticsExe()
for i,v in ipairs(self.actions)do
v:statisticsExe({self.typo,{self.id,self.level,self.srcID}})
end
self.isComplete=true
end

function fightSkillAction:update(deltaTime)
self.moveToBt:update(deltaTime)
self.lsSummonBt:update(deltaTime)
local ret=true
if self.isExeActions then
if not self.activeExeMode then
ret=false

if self.isExeMonment then
for i,v in ipairs(self.actions)do
local t=v:update(deltaTime)
ret=ret or t
end
else
if self.curObj==nil then
self.curObj=self:getNextObj()
if self.curObj==nil then
ret=true
else
self.curObj:exe(nil,self.skillArgs)
self:update(deltaTime)
end
else

local subRet=self.curObj:update(deltaTime)
if subRet then
self.curObj=nil
end
end
end

if not next(self.actions)then
ret=true
end
else
if self.checkTimer then
self.checkTimer=self.checkTimer+deltaTime
end
local isShow=false
local ent=self.battle:getEntity(self.btSrcID)
if ent and ent:isShow()then
isShow=true
end
local checkTime=5
local haveBrokeAction=self.haveBrokeAction

if fightModel:isNewFightActionOpen()then
for i,v in ipairs(self.waittingActiveList)do
local actionPrevious=self.actions[v-1]
if actionPrevious~=nil and actionPrevious.isComplete then
self.activeIndexList[v]=true
local action=self.actions[v]
if action~=nil then
action:exe(nil,self.skillArgs)
end
table.remove(self.waittingActiveList,i)
break
end
end

end
local isAllExeComplate=true
local nextExeIdx=nil
for i,v in ipairs(self.actions)do
local t=v:update(deltaTime)

if self.activeIndexList[i]and not t then
isAllExeComplate=false
end
if not self.activeIndexList[i]and not nextExeIdx then
nextExeIdx=i
end

ret=ret and t
end

if isAllExeComplate and nextExeIdx then
if not self.checkTimer then
self.checkTimer=0
end
if self.checkTimer>checkTime then
self.checkTimer=nil
self.activeIndexList[nextExeIdx]=true
self.actions[nextExeIdx]:exe(nil,self.skillArgs)
if isShow and not haveBrokeAction then
logErr(FMT.fmt("技能行为树{0}没有配置该id{1}激活",self.id,nextExeIdx,self.checkTimer))
end
end
end

self.nextExeIdx=nextExeIdx

if not next(self.actions)then
ret=true
end
end

if not self.timeout then
self.timeout=0
end
self.timeout=self.timeout+deltaTime
if self.timeout>120 then
loggerUtil.logWarnFMT("技能超时异常:技能id{0},发起方{1}",self.id,self.btSrcID)
return true
end
else
ret=false
end

local finish=ret and self.isComplete

if finish then
if self.hud~=nil then

self.hud=nil
end
local ent=self.battle:getEntity(self.btSrcID)
if ent then
ent:activeOutEffect(true,true)
end

self.tailTime=self.tailTime-deltaTime
if self.tailTime>0 then
finish=false
end
end



return finish
end

function fightSkillAction:onBehaviorEvent(state,args)
if self.isExeBehavior then

end
self.isExeBehavior=true
if fBTEvent.BehaviorFinish==state then
self:exeActions(args)
local isMoveToOrg=self:moveToOrg()
if not isMoveToOrg then
self:checkEnd()
end
elseif fBTEvent.ActiveSkillActions==state then
self:exeActions(args)

end
end

function fightSkillAction:onDespwan()
self.moveToBt:stop()
self.lsSummonBt:stop()
self.round=nil
self.battle=nil
self.rawData=nil
self.activeIndexList={}
self.curIndexObj=nil
self.isComplete=false
self.isExeActions=false
self.activeExeMode=false
self.runBehavior=nil
self.timeout=nil
self.waittingActiveList={}
self.actingIndex=0
for i,v in ipairs(self.actions)do
v:onDespwan()
end
fightActionMrg:recycleAction(self)
end


function fightSkillAction:initActions()
self.actions={}
local len=#self.rawData
local target=nil
for i=fightSkillTag.subActions,len do
local subActionData=self.rawData[i]

local actionObj=fightActionMrg:getAction(fightActionType.CLIENT_SKILL_ACTION)
if actionObj~=nil then
local index=#self.actions+1
actionObj.qIndex=index
self.actions[index]=actionObj


local tmpActions=self.actions
local t=actionObj:init(self.round,subActionData,self.btSrcID)
self.actions=tmpActions

target=target or t
end
end
return self:checkTarget(target)
end


function fightSkillAction:checkTarget(target)
local targetList={}
if target==nil then
return targetList
end

for i,v in ipairs(target)do
targetList[v]=v
end


local targetID=next(targetList)
if targetID~=nil then
local targetEnt=self.battle:getEntity(targetID)
local ent=self.battle:getEntity(self.srcID)
if targetEnt and ent then
self.sameCampTarget=ent:isLeft()==targetEnt:isLeft()
end
end

return targetList
end

function fightSkillAction:exeActions(id)
self.isExeActions=true
if id~=nil and id~=0 then
if not self.activeIndexList then
loggerUtil.debugErrFMT("技能已结束 id{0} 步骤{1} 状态{2}",self.id,id,self.isComplete)
return
end

self.activeExeMode=true


local actionPrevious=self.actions[id-1]
if actionPrevious~=nil and not actionPrevious.isComplete and fightModel:isNewFightActionOpen()then
table.insert(self.waittingActiveList,id)
self.haveBrokeAction=true
else

self.activeIndexList[id]=true
local action=self.actions[id]
if action~=nil then
action:exe(nil,self.skillArgs)
end

if self.nextExeIdx==id and self.checkTimer~=nil then
self.nextExeIdx=nil
self.checkTimer=nil
end
end
else
self.curIndexObj=0
self.curObj=nil

if self.isExeMonment then
for i,v in ipairs(self.actions)do
v:exe(nil,self.skillArgs)
end
end
end
end

function fightSkillAction:setRunSkillBehavior(behavior)
self.runBehavior=behavior
end

function fightSkillAction:runSkillBehavior(ent,cfg,onEvent)
self.tailTime=cfg.tailTime or 0
if cfg.showName==fightCommonTag.showName then
if ent then
ent:flowText(flowObjTypo.skill,{strPara=cfg.name})
end
end
if cfg.skillClass==fightSkillClass.fabao then
self.battle:insertWitnessBehavior(eFightWitnessEventType.useFaBao,{left=ent:isLeft(),immediately=true})















end

local behaviourBase=cfg.behavior

local baseInfo=ent:getbaseInfo()
if baseInfo and baseInfo.disguise and baseInfo.diziId then
if baseInfo.disguise>0 and baseInfo.disguise~=baseInfo.diziId and cfg.behavior2 then
behaviourBase=cfg.behavior2
end
end

local entClothing=ent:getClothing()
if entClothing>0 and cfg.clothingBehavior and cfg.clothingBehavior[entClothing]then
behaviourBase=cfg.clothingBehavior[entClothing]
end

local behaviour=self.runBehavior or behaviourBase
self.isExeMonment=cfg.isExeMonment and not behaviour

if behaviour then
if ent then
ent:runBehavior(behaviour,self.targets,onEvent)
end
else
self:onBehaviorEvent(fBTEvent.BehaviorFinish)
end
end

function fightSkillAction:isMoveToCenter(ent)
return self.sameCampTarget and self.rangeType==eSkillRangeType.yuancheng and ent:checkState(eBuffEffectType.hunLuan)
end

function fightSkillAction:moveToCenter(ent,cfg,onEvent)
if self:isMoveToCenter(ent)and ent:isShow()then
local behaviour=self.runBehavior or cfg.behavior
if behaviour then
local onFinish=function()
ent:flipX(not ent:isLeft())
self:runSkillBehavior(ent,cfg,onEvent)
end
self.moveToBt:start(ent,"fight_range_skill_attack_start",onFinish)
self.isMoveingCenter=true
else
self:runSkillBehavior(ent,cfg,onEvent)
end
else
self:runSkillBehavior(ent,cfg,onEvent)
end
end

function fightSkillAction:moveToOrg()

if not self.battle then
return false
end
local ent=self.battle:getEntity(self.btSrcID)
if ent and ent:isShow()then
if self.isMoveingCenter then
self.isMoveingCenter=false
local onFinish=function()
ent:flipX(ent:isLeft())
return self:checkEnd()
end
self.moveToBt:start(ent,"fight_range_skill_attack_end",onFinish)
return true
end

end
return false
end

function fightSkillAction:getNextObj()

self.curIndexObj=self.curIndexObj+1
return self.actions[self.curIndexObj]
end


function fightSkillAction:getBtSrcID()
local btSrcID=self.srcID

local cfg=cfg_skillconfig_get(self.id)
if cfg.isLingShou==1 then

btSrcID=self.srcID+stagePosWeight.assist
end
return btSrcID
end

function fightSkillAction:isTempLingShou(ent)
return ent:checkIsTempLingShou()
end

function fightSkillAction:isSummonLingShou(ent)
return ent:checkIsSummonLingShou()
end

function fightSkillAction:checkEnd()
if not self.battle then



self.isComplete=true
return
end
local ent=self.battle:getEntity(self.btSrcID)
if ent and ent:isShow()then

if self:isTempLingShou(ent)then

local onFinish=function()
ent:setTempLingShouFlag(nil)
self.isComplete=true
end
self.lsSummonBt:start(ent,"summon_lingshou_temp_end",onFinish)
ent:setSummonLingShouFlag(nil)
else
self.isComplete=true
end
else
self.isComplete=true
end

end
