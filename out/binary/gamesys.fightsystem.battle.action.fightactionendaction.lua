

def_class('fightActionEndAction',fightBaseAction)

function fightActionEndAction:__init()
self.typo=fightActionType.ACTION_END
end


function fightActionEndAction:init(_round,_rawData,_srcID)
self.round=_round
self.battle=_round:getBattle()
self.dstID=_rawData[2]
self.isComplete=false
self.buffWaitTime=0
end

function fightActionEndAction:exe()

self.buffWaitTime=0
local ent=self.battle:getEntity(self.dstID)
if ent~=nil then
self.buffWaitTime=ent:updateBuffRound(buffCheckType.actionEnd)
if ent.hud then
ent.hud:fade(0.6,1)
end
ent:activeOutEffect(true,true)
ent:rebulidBuffBehave()
end
UIManager:callWindowFunc("UIFightMainTop","hideDemagePanel")
UIManager:callWindowFunc("UIFightMainTop","hideHealPanel")
self.isComplete=true
end

function fightActionEndAction:logExe(logContent)
local ent=self.battle:getEntity(self.dstID)
if ent~=nil then
ent:logUpdateBuffRound(buffCheckType.actionEnd,logContent)
logContent(FMT.fmt('{0}行动结束\n',ent:logName()))
else
logContent(FMT.fmt('未知实体[{0}] 行动结束\n',self.dstID))
end

self.isComplete=true
end

function fightActionEndAction:update(deltaTime)
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

