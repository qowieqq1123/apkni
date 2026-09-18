

def_class('fightActionStartAction',fightBaseAction)

function fightActionStartAction:__init()
self.typo=fightActionType.ACTION_START
end


function fightActionStartAction:init(_round,_rawData,_srcID)
self.round=_round
self.battle=_round:getBattle()
self.dstID=_rawData[2]
self.isComplete=false
self.buffWaitTime=0
end

function fightActionStartAction:exe()

self.buffWaitTime=0
local ent=self.battle:getEntity(self.dstID)
if ent~=nil then
self.buffWaitTime=ent:updateBuffRound(buffCheckType.actionStart)
if ent.hud then
ent.hud:fade(0.6,0)
end
ent:activeOutEffect(false,true)
end
self.isComplete=true
end

function fightActionStartAction:logExe(logContent)
local ent=self.battle:getEntity(self.dstID)
if ent~=nil then
logContent(FMT.fmt('{0}行动开始',ent:logName()))
ent:logUpdateBuffRound(buffCheckType.actionStart,logContent)
else
logContent(FMT.fmt('未知实体{0} 行动开始',self.dstID))
end

self.isComplete=true
end

function fightActionStartAction:update(deltaTime)
if self.buffWaitTime>0 then
self.buffWaitTime=self.buffWaitTime-deltaTime
if self.buffWaitTime<=0 then
return self.isComplete
else
return false
end
end

return self.isComplete
end

