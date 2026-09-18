def_class('fightSkillDodgeAction',fightBaseAction)



function fightSkillDodgeAction:__init()
self.typo=fightActionType.SKILL_DODGE
end


function fightSkillDodgeAction:init(_round,_rawData)

self.round=_round
self.battle=_round:getBattle()
self.isComplete=false

self.showTypo=_rawData[fightCommonTag.skillEffectTypo]
self.srcID=_rawData[3]
self.param=_rawData[4]
end

function fightSkillDodgeAction:exe(dstBtPara)
local ent=self.battle:getEntity(self.srcID)

local delay=0
if ent~=nil then
local cfg=skillShowTypeTag[self.showTypo]
if cfg==nil then
logErr(FMT.fmt("为配置 技能特殊表现--纯子作用 {0}",self.skillTypo))
else

if ent:isLeft()then
UIManager:invokeUIMethod("UIFightMainTop","insertSpeEffectLeft",self.showTypo)
else
UIManager:invokeUIMethod("UIFightMainTop","insertSpeEffectRight",self.showTypo)
end

if cfg.imageID then
if self.battle.isShowWindow then
ent:flowText(flowObjTypo.skillEffect,{nunPara=cfg.imageID})
end
end
local cfgDelay=cfg.delay
if cfgDelay then
delay=cfgDelay
end
if cfg.exe then
local exeDelay=cfg.exe(self.battle,ent,dstBtPara,self.param)
if exeDelay then
delay=exeDelay
end
end
end
end
if delay>0 then
self.isExe=true
self.delayTime=delay
self.isComplete=false
else
self.delayTime=0
self.isComplete=true
end
end

function fightSkillDodgeAction:logExe(logContent)
local srcEnt=self.battle:getEntity(self.srcID)

local srcEntName=nil
if srcEnt~=nil then
srcEntName=srcEnt:logName()
else
srcEntName=FMT.fmt('[未知实体:{0}]',self.srcID or-1)
end

local formatStr=skillShowTypeTag[self.showTypo]and skillShowTypeTag[self.showTypo].name
if formatStr~=nil then
logContent(FMT.fmt(formatStr,srcEntName))
else
if not self.showTypo then
logErr(FMT.fmt("showTypo为空"))
else
if type(self.showTypo)~="userdata"then
logContent(FMT.fmt('未定义技能表现类型:{0}',self.showTypo))
else
logErr("showTypo异常")
end
end
end

self.isComplete=true
end

function fightSkillDodgeAction:update(deltaTime)
if self.isExe then
self.delayTime=self.delayTime-deltaTime
if self.delayTime<0 then
self.isComplete=true
end
end
return self.isComplete
end

function fightSkillDodgeAction:statisticsExe(skillArgs)
local cfg=skillShowTypeTag[self.showTypo]
if cfg~=nil then
if self.showTypo==eSkillShowType.shanBi then
self.battle:addStatisticsTimes(FIGHT_STATISTICS_TYPE.dodgeTimes,self.srcID)
elseif self.showTypo==eSkillShowType.debuffShanBi then
self.battle:addStatisticsTimes(FIGHT_STATISTICS_TYPE.resistDebuffTimes,self.srcID)
elseif self.showTypo==eSkillShowType.wudi then
self.battle:addStatisticsTimes(FIGHT_STATISTICS_TYPE.resistDemageTimes,self.srcID)

end
end
end
