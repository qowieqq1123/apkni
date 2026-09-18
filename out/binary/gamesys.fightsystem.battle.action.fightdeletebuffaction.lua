

def_class('fightDeleteBuffAction',fightBaseAction)

function fightDeleteBuffAction:__init()
self.typo=fightActionType.DELETE_BUFF
end

function fightDeleteBuffAction:init(_round,_rawData,_srcID)
self.round=_round
self.battle=_round:getBattle()
self.guid=_rawData[fightBuffActiongTag.guid]
self.buffInfo=self.battle:getBuffInfo(self.guid)
self.waitTime=0
self.isComplete=false
end

function fightDeleteBuffAction:exe()
self.waitTime=0
if self.buffInfo~=nil then
local ent=self.battle:getEntity(self.buffInfo.dstID)
if ent~=nil then
self.waitTime=ent:removeBuff(self.buffInfo)
ent:onRemoveBuffBehave(self.waitTime)
end
else

end

self.isComplete=true

end

function fightDeleteBuffAction:logExe(logContent)
if self.buffInfo~=nil then
local ent=self.battle:getEntity(self.buffInfo.dstID)
if ent~=nil then
logContent(FMT.fmt('[{0}]删除buff[{1}][{2}]{3}',ent:logName(),self.buffInfo.cfg.name,self.buffInfo.cfg.id,fightActionHelper.genBuffRoundInfoStr(self.buffInfo)))
ent:logRemoveBuff(self.buffInfo,logContent)
else
logContent(FMT.fmt('未知实体[{0}]删除buff[{1}][{2}]',self.buffInfo.dstID,self.buffInfo.cfg.name,self.buffInfo.cfg.id))
end
else
logContent(FMT.fmt("找不到BUFF {0}",self.guid))
end

self.isComplete=true
end

function fightDeleteBuffAction:update(deltaTime)
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

