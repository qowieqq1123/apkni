def_class('fightChangePropAction',fightBaseAction)

function fightChangePropAction:__init()
self.typo=fightActionType.CHANGE_PROP
end



function fightChangePropAction:init(_round,_rawData,_srcID,_dstID)
self.round=_round
self.battle=_round:getBattle()
self.dstID=_rawData[fightChangePropTag.dstID]
self.propID=_rawData[fightChangePropTag.propID]
self.value=_rawData[fightChangePropTag.value]

end


function fightChangePropAction:exe(immediately)

local ent=self.battle:getEntity(self.dstID)
if ent~=nil then
ent:onAttributeChange(self.propID,self.value)
end
self.isComplete=true
end

function fightChangePropAction:logExe(logContent)
local ent=self.battle:getEntity(self.dstID)
if ent~=nil then
local propID=self.propID
local oldValue=ent:getAttribute(propID)
local attrName=entityAttrName[propID]or propID
logContent(FMT.fmt('{0}[{1}]变化[{2}]=>[{3}]',ent:logName(),attrName,oldValue,self.value))
ent:onAttributeChange(self.propID,self.value)
if propID==entityAttr.hp then
if self.value-oldValue<0 then
ent.totalDefend=ent.totalDefend+self.value-oldValue
end
end
else
logContent(FMT.fmt('未知实体[{0}] [{1}]变化[{2}]',self.dstID,self.propID,self.value))
end
self.isComplete=true
end

function fightChangePropAction:statisticsExe(skillArgs)
local ent=self.battle:getEntity(self.dstID)
if ent~=nil then
if self.propID==entityAttr.max_hp then
ent.actualMaxHp=self.value
end
end

if self.propID==entityAttr.hudun then
if skillArgs and skillArgs[1]==fightActionType.CAST_SKILL then










end
self.battle:changeStatisticsVal(FIGHT_STATISTICS_TYPE.nowShield,self.dstID,self.value)
end

self.isComplete=true
end

function fightChangePropAction:update(deltaTime)
return self.isComplete
end


function fightChangePropAction:onDespwan()
fightActionMrg:recycleAction(self)
end

