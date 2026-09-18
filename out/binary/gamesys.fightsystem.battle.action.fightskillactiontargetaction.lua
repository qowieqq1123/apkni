def_class('fightSkillActionTargetAction',fightBaseAction)

function fightSkillActionTargetAction:__init()
self.typo=fightActionType.CLIENT_SKILL_ACTION_TARGET
end

function fightSkillActionTargetAction:getTypo()
return self.typo
end


local subActionTypo=
{

Paralle=0,

Sequence=1,
}


function fightSkillActionTargetAction:init(_round,_rawData,_srcID,actionCfg)
self.round=_round
self.battle=_round:getBattle()
self.isExe=false
self.btExeOver=false
self.isActiveAction=false
local actionNums=#_rawData
self.actionObjs={}
self.srcID=_srcID
self.dstID=_rawData[fightSkillActionActionTag.dstID]
self.exeTypo=subActionTypo.Paralle
local offset=0

local hasPassiveSkill=false

for j=fightSkillActionActionTag.actions,actionNums do
repeat
if offset>0 then
offset=offset-1
break
end

local actionData=_rawData[j]

local typo=actionData[fightCommonTag.typo]

if typo==fightActionType.CAST_SKILL then
hasPassiveSkill=true
end
if typo==fightActionType.FIGHT_LOG_CARD_CHANGE then
self.exeTypo=subActionTypo.Sequence
end

local actionObj=fightActionMrg:getAction(typo)
if actionObj~=nil then
local delay=actionCfg and actionCfg.delayEffect or 0
local actionId=actionCfg and actionCfg.id or nil
self.actionObjs[#self.actionObjs+1]={obj=actionObj,delay=delay}
actionObj:init(self.round,actionData,self.srcID,self.dstID,actionId)
offset=actionObj:fetchData(j+1,_rawData)
end

until true
end
return hasPassiveSkill
end

function fightSkillActionTargetAction:getNextObj()
self.curIndexObj=self.curIndexObj+1
return self.actionObjs[self.curIndexObj]
end

function fightSkillActionTargetAction:exe(btPara,skillArgs)
self.btPara=btPara
self.skillArgs=skillArgs


self.curIndexObj=0
self.curObj=nil

self:activeActions()

end

function fightSkillActionTargetAction:logExe(logContent)

for i,v in ipairs(self.actionObjs)do
v.obj:logExe(logContent)
end
self.isComplete=true
end

function fightSkillActionTargetAction:statisticsExe(skillArgs)
for i,v in ipairs(self.actionObjs)do
v.obj:statisticsExe(skillArgs)
end
self.isComplete=true
end

function fightSkillActionTargetAction:update(deltaTime)
if self.dstBTree~=nil then
self.dstBTree:update(deltaTime)
end

local ret=false
if self.isExe then
if self.exeTypo==subActionTypo.Sequence then
if self.curObj==nil then
self.curObj=self:getNextObj()
if self.curObj==nil then
ret=true
else
self.curObj.obj:exe(self.btPara,self.skillArgs)
end
else
local subRet=self.curObj.obj:update(deltaTime)
if subRet then
self.curObj=nil
end
end
else
ret=true
for i,v in ipairs(self.actionObjs)do
if v.hasExe then
ret=ret and v.obj:update(deltaTime)

else
v.delay=v.delay-deltaTime
if v.delay<0 then
v.hasExe=true
v.obj:exe(self.btPara,self.skillArgs)
v.obj:update(deltaTime)
end
ret=false
end
end
end









end
self.isComplete=ret
if self.isComplete then
local dstEnt=self.battle:getEntity(self.dstID)
if dstEnt~=nil and not dstEnt:isShow()then
self.btExeOver=true
end
end

return self.isComplete and self.btExeOver
end

function fightSkillActionTargetAction:onDespwan()
if self.dstBTree~=nil then
self.dstBTree:stop()
self.dstBTree=nil
end
self.timeout=nil
fightActionMrg:recycleAction(self)
end


function fightSkillActionTargetAction:activeActions()
if not self.isActiveAction then
self.isActiveAction=true

if self.btPara.dstBT~=nil then
local dstEnt=self.battle:getEntity(self.dstID)
if dstEnt~=nil and dstEnt:isShow()then
local onEventListen=function(eventTypo,args)
if fBTEvent.BehaviorFinish==eventTypo then
self.btExeOver=true
self:doExeSub()
elseif fBTEvent.ActiveTargetActions==eventTypo then

self:doExeSub()
end
end
self.dstBTree=self:createBT(dstEnt,self.btPara.dstBT,{self.btPara.dstID},self.btPara.srcID,self.dstID,onEventListen)
else
self.btExeOver=true
self:doExeSub()
end
else
self.btExeOver=true

self:doExeSub()
end
end
end

function fightSkillActionTargetAction:createBT(ent,btName,targets,srcID,dstID,onEventListen)
local bt=fBTBehaviorTree.get()
bt:setSharedValue('targets',targets)
bt:setSharedValue('startEntID',srcID)
bt:setSharedValue('endEntID',dstID)
bt:start(ent,btName,onEventListen)
return bt
end

function fightSkillActionTargetAction:doExeSub()
if not self.isExe then
self.isExe=true
end
end