
def_class('fightBuffAction',fightBaseAction)

function fightBuffAction:__init()
self.typo=fightActionType.BUFF_EFFECT
end


function fightBuffAction:init(_round,_rawData,_srcID,_dstID)
self.round=_round
self.battle=_round:getBattle()
self.guid=_rawData[fightBuffActiongTag.guid]
self.buffInfo=self.battle:getBuffInfo(self.guid)
if self.buffInfo~=nil then
self.srcID=self.buffInfo.srcID
end
self.rawData=_rawData
self.isComplete=false
self:initSubAction()
end

function fightBuffAction:initSubAction()
self.subActions={}
local len=#self.rawData
for i=fightBuffActiongTag.subActions,len do
local subData=self.rawData[i]
local typo=subData[fightCommonTag.typo]
local actionObj=fightActionMrg:getAction(typo)
if actionObj~=nil then
actionObj:init(self.round,subData,self.srcID)
self.subActions[#self.subActions+1]=actionObj
end
end
end

function fightBuffAction:exe()
for i,v in ipairs(self.subActions)do
v:exe()
end
end

function fightBuffAction:logExe(logContent)
local bufCfg=nil
if self.buffInfo~=nil then
bufCfg=self.buffInfo.cfg
if bufCfg~=nil then
local ent=self.battle:getEntity(self.srcID)
if ent~=nil then
logContent(FMT.fmt('Buff[{0}]作用于[{1}]{2}',bufCfg.name,ent:logName(),fightActionHelper.genBuffRoundInfoStr(self.buffInfo)))
else
logContent(FMT.fmt('[{0}]buff作用找不到实体[{1}]',bufCfg.name,self.srcID or-1))
end
else
logContent(FMT.fmt('找不到buff[{0}]配置',self.buffInfo.id))
end
else
logContent(FMT.fmt('找不到[{0}]对应的buff数据',self.guid))
end

for i,v in ipairs(self.subActions)do
v:logExe(logContent)
end
self.isComplete=true
end

function fightBuffAction:statisticsExe()
for i,v in ipairs(self.subActions)do
v:statisticsExe({self.typo,{self.guid,self.srcID}})
end
end

function fightBuffAction:update(deltaTime)
local ret=true
for i,v in ipairs(self.subActions)do
ret=ret and v:update(deltaTime)
end

self.isComplete=ret

return self.isComplete
end

function fightBuffAction:onDespwan()
self.round=nil
self.battle=nil
self.buffInfo=nil
self.rawData=nil
self.isComplete=false

for i,v in ipairs(self.subActions)do
v:onDespwan()
end
fightActionMrg:recycleAction(self)
end