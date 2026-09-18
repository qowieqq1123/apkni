def_class('fightMoveTargetsSkillAction',fightBaseAction)



function fightMoveTargetsSkillAction:__init()
self.typo=fightActionType.CAST_Move_Target_SKILL
end

function fightMoveTargetsSkillAction:init(_round,_rawData,_srcID)
self.round=_round
self.battle=_round:getBattle()
self.rawData=_rawData

self.srcID=_rawData[fightSkillTag.srcID]
self.id=_rawData[fightSkillTag.id]
self.level=_rawData[fightSkillTag.level]

self.moveToBt=fBTBehaviorTree.get()
self.rangedSkill=false

self.isExeActions=false
self.isComplete=false


self:initActions()
end


function fightMoveTargetsSkillAction:exe()
self.isComplete=false
self.curIndexObj=0
self.curObj=nil
self.canMoveToOrg=true
self.isExeActions=true
self.delayTime=nil
end

function fightMoveTargetsSkillAction:logExe(logContent)
local ent=self.battle:getEntity(self.srcID)
local strSkillStart=''
local strSkillEnd=''
if ent~=nil then
local skillCfg=cfg_skillconfig_get(self.id)
if skillCfg~=nil then
strSkillStart=FMT.fmt('{0}开始使用[{1}]级多段技能[{2}][{3}]',ent:logName(),self.level,skillCfg.name,skillCfg.id)
strSkillEnd=FMT.fmt('{0}使用[{1}]级多段技能[{2}][{3}]结束',ent:logName(),self.level,skillCfg.name,skillCfg.id)
else
strSkillStart=FMT.fmt('【开始】-{0}找不到多段技能配置[{1}]',ent:logName(),self.id)
strSkillEnd=FMT.fmt('【结束】-{0}找不到多段技能配置[{1}]',ent:logName(),self.id)
end
else
strSkillStart=FMT.fmt('【开始】-找不到多段技能的实体[{0}]',self.srcID or-1)
strSkillEnd=FMT.fmt('【结束】-找不到多段技能的实体[{0}]',self.srcID or-1)
end

logContent(strSkillStart)
for i,v in ipairs(self.actions)do
v:logExe(logContent)
end
logContent(strSkillEnd)
end

function fightMoveTargetsSkillAction:statisticsExe()
for i,v in ipairs(self.actions)do
v:statisticsExe()
end
self.isComplete=true
end


function fightMoveTargetsSkillAction:update(deltaTime)
local ret=true
if self.isExeActions then

ret=false
if self.curObj==nil then
self.curObj=self:getNextObj()
if self.curObj==nil then
if self.canMoveToOrg then
self:moveToOrg()
self.canMoveToOrg=nil
end
ret=true
if not self.delayTime then
local ent=self.battle:getEntity(self.srcID)
if ent and ent:isShow()then
self.delayTime=2
self.isComplete=false
else
self.delayTime=0
self.isComplete=true
end
else
self.delayTime=self.delayTime-deltaTime
if self.delayTime<=0 then
self.isComplete=true
end
end
else
self.curObj:exe()
self:update(deltaTime)
end
else
local subRet=self.curObj:update(deltaTime)
if subRet then
self.curObj=nil
end
end
else
ret=false
end
return self.isComplete and ret
end



function fightMoveTargetsSkillAction:onDespwan()
self.moveToBt:stop()
self.round=nil
self.battle=nil
self.rawData=nil
self.activeIndexList=nil
self.curIndexObj=nil
self.isComplete=false
self.isExeActions=false
for i,v in ipairs(self.actions)do
v:onDespwan()
end
fightActionMrg:recycleAction(self)
end



function fightMoveTargetsSkillAction:initActions()
self.skillActions={}
self.runBehaviors={}
self.actions={}
local cfg=cfg_skillconfig_get(self.id)
local defaultBehavior=nil

local targetsBehavior=cfg.targetsBehavior

local ent=self.battle:getEntity(self.srcID)
if ent then
local entClothing=ent:getClothing()
if entClothing>0 and cfg.clothingTargetsBehavior and cfg.clothingTargetsBehavior[entClothing]then
targetsBehavior=cfg.clothingTargetsBehavior[entClothing]
end
end

if not targetsBehavior then
defaultBehavior=cfg.behavior
end

local len=#self.rawData

local skillAction=nil





for i,v in ipairs(targetsBehavior)do
local behaviour=v[1]
local subActionList=v[2]
local haveAction=false
skillAction=
{
[fightSkillTag.typo]=fightActionType.CAST_SKILL,
[fightSkillTag.srcID]=self.srcID,
[fightSkillTag.id]=self.id,
[fightSkillTag.level]=self.level,

}

for i,v in ipairs(subActionList)do
for si=fightSkillTag.subActions,len do
local subActionData=self.rawData[si]
if v==subActionData[fightSkillActionTag.id]then
table.insert(skillAction,subActionData)
haveAction=true
end
end
end
if haveAction then
table.insert(self.skillActions,skillAction)
table.insert(self.runBehaviors,behaviour)
end
end

for i,v in ipairs(self.skillActions)do
local actionObj=fightActionMrg:getAction(fightActionType.CAST_SKILL)
if actionObj~=nil then
local index=#self.actions+1
self.actions[index]=actionObj
actionObj:init(self.round,v,self.srcID)
actionObj:setRunSkillBehavior(self.runBehaviors[i])
end
end

end



function fightMoveTargetsSkillAction:getTargets(subActionData)
local num=#subActionData
local targets={}
for i=fightSkillActionTag.subActions,num do
local data=subActionData[i]
local dstID=data[fightCommonTag.dstID]
targets[#targets+1]=dstID
end
table.sort(targets,function(a,b)return a<b end)
return targets
end

function fightMoveTargetsSkillAction:checkTarget(targets1,targets2)
if targets1==nil then
return false
end
if targets2==nil then
return false
end
if#targets1~=#targets2 then
return false
end

for i,v in pairs(targets1)do
if targets2[i]~=v then
return false
end
end

return true
end

function fightMoveTargetsSkillAction:checkBehavior(targetsBehavior,subActionData)

end

function fightMoveTargetsSkillAction:getNextObj()

self.curIndexObj=self.curIndexObj+1
return self.actions[self.curIndexObj]
end

function fightMoveTargetsSkillAction:moveToOrg()
local ent=self.battle:getEntity(self.srcID)
if ent and ent:isShow()then
ent:runBehavior("fight_range_skill_attack_end",{},function()
self.isComplete=true
end)
else
self.isComplete=true
end
end