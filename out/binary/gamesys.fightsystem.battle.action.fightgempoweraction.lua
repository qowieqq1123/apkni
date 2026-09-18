

def_class('fightGemPowerAction',fightBaseAction)

function fightGemPowerAction:__init()
self.typo=fightActionType.GEM_POWER
end


function fightGemPowerAction:init(_round,_rawData,_srcID)
self.round=_round
self.battle=_round:getBattle()
self.dstID=_rawData[2]
self.value=_rawData[3]
self.isComplete=false
end

function fightGemPowerAction:exe()

local ent=self.battle:getEntity(self.dstID)
if ent~=nil then
ent:onGemPowerChange(self.value)
end
self.isComplete=true
end

function fightGemPowerAction:logExe(logContent)
local ent=self.battle:getEntity(self.dstID)
if ent~=nil then
local max_gem_power=self:getAttribute(entityAttr.gem_pow)
logContent(FMT.fmt('{0}法宝能量变化[{1}:{2}]',ent:logName(),self.value,max_gem_power))
ent:onGemPowerChange(self.value)
else
logContent(FMT.fmt('未知实体[{0}] 法宝能量变化[{0}]',self.dstID,self.value))
end

self.isComplete=true
end

function fightGemPowerAction:update(deltaTime)
return self.isComplete
end

