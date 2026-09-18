

def_class('fightSkillActionAction',fightBaseAction)

function fightSkillActionAction:__init()
self.typo=fightActionType.CLIENT_SKILL_ACTION
end


local subActionTypo=
{

Paralle=0,

Sequence=1,
}
local defautBTPara={typo=subActionTypo.Paralle}

function fightSkillActionAction:init(_round,_rawData,_srcID)
self.round=_round
self.battle=_round:getBattle()
self.srcID=_srcID
self.actionID=_rawData[fightSkillActionTag.id]
self.rawData=_rawData
self.isComplete=false
self.isExe=false
self.exeTypo=subActionTypo.Paralle
self.multiDelay=0
self.exeIndex=1
return self:initActionList()
end

function fightSkillActionAction:exe(btPara,skillArgs)
if self.isExe then
return
end
self.skillArgs=skillArgs
self.isExe=true
self.partIdx=1

local hasClientActionBt
if self.actionID then
local actionCfg=cfgHelper.get1(cfg_skillaction_get,self.actionID)
local actionType=actionCfg and actionCfg.resultType or nil
if actionType and actionType==78 then

local btSrcID=self.srcID+stagePosWeight.assist
local ent=self.battle:getEntity(btSrcID)
if ent then

self.lsSummonBt=fBTBehaviorTree.get()
self:summonLingShou(ent,function()
return self:exeAfterSelfBt()
end)
hasClientActionBt=true
end
end
end

if not hasClientActionBt then
return self:exeAfterSelfBt(btPara,skillArgs)
end

end

function fightSkillActionAction:exeAfterSelfBt(btPara,skillArgs)
if self.exeTypo==subActionTypo.Paralle then
self.btPara.srcID=self.srcID
self.btPara.dstID=self.dstID
if self.multiDelay>0 then
self.paralleTime=0
self.exeIndex=1
self.maxIndex=#self.actions
self.actions[self.exeIndex]:exe(self.btPara,skillArgs)
else
for i,obj in ipairs(self.actions)do
obj:exe(self.btPara,skillArgs)
end
end
else
self.btPara.srcID=self.srcID
self.curIndexObj=0
self.curObj=nil
end
end

function fightSkillActionAction:logExe(logContent)
self.isExe=true

local actionCfg=cfgHelper.get1(cfg_skillaction_get,self.actionID)
if actionCfg.resultType==9 then
logContent(FMT.fmt("作用{0}：{1}号位发动技能冷却改变",self.actionID,self.srcID))
end

for i,obj in ipairs(self.actions)do
obj:logExe(logContent)
end
self.isComplete=true
end

function fightSkillActionAction:statisticsExe(skillArgs)
self.isExe=true
for i,obj in ipairs(self.actions)do
obj:statisticsExe(skillArgs)
end
self.isComplete=true
end

function fightSkillActionAction:update(deltaTime)
if self.lsSummonBt~=nil then
self.lsSummonBt:update(deltaTime)
end
local ret=false
if self.isExe then

if self.exeTypo==subActionTypo.Paralle then

if self.multiDelay>0 and self.exeIndex<self.maxIndex then
self.paralleTime=self.paralleTime+deltaTime
if self.paralleTime>self.multiDelay then
self.paralleTime=0
self.exeIndex=self.exeIndex+1

self.actions[self.exeIndex]:exe(self.btPara,self.skillArgs)
end
end

local partAction=self.skillActions[self.partIdx]

if partAction then
local partRet=true
for i,v in pairs(partAction)do
local action=self.actions[i]
local subRet=action:update(deltaTime)
partRet=partRet and subRet
end
if partRet then
self.partIdx=self.partIdx+1
end




else
ret=true
end




else
if self.curObj==nil then
self.curObj=self:getNextObj()
if self.curObj==nil then
ret=true
else
self.btPara.dstID=self.curObj.dstID
self.curObj:exe(self.btPara,self.skillArgs)
end
else
local subRet=self.curObj:update(deltaTime)
if subRet then
self.btPara.srcID=self.btPara.dstID
self.curObj=nil
end
end
end

if not self.timeout then
self.timeout=0
end
self.timeout=self.timeout+deltaTime
if self.timeout>120 and not ret then
loggerUtil.logWarnFMT("技能作用超时异常:作用id{0},发起方{1},{2},{3}",self.actionID,self.srcID,ret,self.isComplete)
return true
end
end

self.isComplete=ret
return self.isComplete
end

function fightSkillActionAction:onDespwan()
if self.lsSummonBt~=nil then
self.lsSummonBt:stop()
self.lsSummonBt=nil
end
self.round=nil
self.battle=nil
self.rawData=nil
self.srcID=nil
self.isComplete=false
self.timeout=nil
self.multiDelay=0
self.exeIndex=1
for i,v in ipairs(self.actions)do
v:onDespwan()
end
fightActionMrg:recycleAction(self)
end


function fightSkillActionAction:summonLingShou(ent,callback)
if ent:isShow()then
local isTempSummon=true
local btName
if isTempSummon then
btName="summon_lingshou_temp"
end

ent:setSummonLingShouFlag(true)
local onFinish=function()
if isTempSummon then
ent:setTempLingShouFlag(true)
end
if callback then
return callback()
end
end
local orgEnt=self.battle:getEntity(self.srcID)
self.lsSummonBt:start(orgEnt,btName,onFinish)
end
end





function fightSkillActionAction:initActionList()
self.actions={}
local num=#self.rawData
local actionID=self.rawData[fightSkillActionTag.id]
local actionCfg=cfgHelper.get1(cfg_skillaction_get,actionID)
self.btPara=self:initBtPara(actionCfg)
self.exeTypo=self.btPara.typo
if not actionCfg then
logErr(FMT.fmt("没有此技能action的配置：{0}",actionID))
return
end
self.multiDelay=actionCfg.multiDelayEffect or 0


self.skillActions={}

local part=1

local targets={}
for i=fightSkillActionTag.subActions,num do
local data=self.rawData[i]
local dstID=data[fightCommonTag.dstID]
local notTarget=false
if dstID==self.srcID then
notTarget=true
else
for j=fightSkillActionActionTag.actions,#data do
local d2=data[j]
if type(d2)=="table"and d2[fightCommonTag.typo]==fightActionType.CHANGE_HP then
if d2[fightChangeHpTag.demageTypo]==DAMAGE_TYPE_FANSHE then
notTarget=true
end
break
end
end
end

if not notTarget then
targets[#targets+1]=dstID
end
local actionObj=fightActionMrg:getAction(fightActionType.CLIENT_SKILL_ACTION_TARGET)
if actionObj~=nil then
local idx=#self.actions+1
self.actions[idx]=actionObj

self.skillActions[part]=self.skillActions[part]or{}

self.skillActions[part][idx]=true

local hasPassiveSkill=actionObj:init(self.round,data,self.srcID,actionCfg)
if hasPassiveSkill then

part=part+1
end
end
end


if#targets==1 and targets[1]==0 then
return
else
return targets
end
end

function fightSkillActionAction:initBtPara(actionCfg)
if actionCfg~=nil then
local btPara={}
btPara.typo=actionCfg.activeTypo or subActionTypo.Paralle
local dstBT=actionCfg.dstBehavior

local ent=self.battle:getEntity(self.srcID)
if ent then

local baseInfo=ent:getbaseInfo()
if baseInfo and baseInfo.disguise and baseInfo.diziId then
if baseInfo.disguise>0 and baseInfo.disguise~=baseInfo.diziId and actionCfg.dstBehavior2 then
dstBT=actionCfg.dstBehavior2
end
end

local entClothing=ent:getClothing()
if entClothing>0 and actionCfg.clothingDstBehavior and actionCfg.clothingDstBehavior[entClothing]then
dstBT=actionCfg.clothingDstBehavior[entClothing]
end
end
btPara.dstBT=dstBT
return btPara
end

return defautBTPara
end

function fightSkillActionAction:getNextObj()

self.curIndexObj=self.curIndexObj+1
return self.actions[self.curIndexObj]
end