def_class('fightDispelBuffAction',fightBaseAction)



function fightDispelBuffAction:__init()
self.typo=fightActionType.DISPEL_BUFF
end

function fightDispelBuffAction:init(_round,_rawData,_srcID)
self.round=_round
self.battle=_round:getBattle()
self.guid=_rawData[fightBuffActiongTag.guid]
self.buffInfo=self.battle:getBuffInfo(self.guid)
self.waitTime=0
self.isComplete=false
end

function fightDispelBuffAction:exe()

self.waitTime=0
local ent=self.battle:getEntity(self.buffInfo.srcID)
if ent~=nil then
self.waitTime=ent:removeBuff(self.buffInfo)
ent:onRemoveBuffBehave(self.waitTime)
end
self.isComplete=true
end


function fightDispelBuffAction:logExe(logContent)

local ent=self.battle:getEntity(self.buffInfo.srcID)
if ent~=nil then
logContent(FMT.fmt('{0}驱散[{1}]级buff[{2}][{3}]{4}',ent:logName(),self.buffInfo.level,self.buffInfo.cfg.name,self.buffInfo.id,fightActionHelper.genBuffRoundInfoStr(self.buffInfo)))
ent:logRemoveBuff(self.buffInfo,logContent)
else
logContent(FMT.fmt('未知实体{0}驱散[{1}]级buff[{2}][{3}]{4}',self.buffInfo.srcID,self.buffInfo.level,self.buffInfo.cfg.name,self.buffInfo.id,fightActionHelper.genBuffRoundInfoStr(self.buffInfo)))
end
self.isComplete=true
end

function fightDispelBuffAction:update(deltaTime)
if self.waitTime>0 then
self.waitTime=self.waitTime-deltaTime
if self.waitTime<=0 then
return self.isComplete
else
return false
end
end
return self.isComplete
end

