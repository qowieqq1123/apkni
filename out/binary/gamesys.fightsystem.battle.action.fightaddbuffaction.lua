def_class('fightAddBuffAction',fightBaseAction)



function fightAddBuffAction:__init()
self.typo=fightActionType.ADD_BUFF
end


function fightAddBuffAction:init(_round,_rawData,_srcID,_dstID)
self.round=_round
self.battle=_round:getBattle()
self.dstID=_dstID
self.buffInfo={}
self.buffInfo.guid=_rawData[fightAddBuffTag.guid]
self.buffInfo.id=_rawData[fightAddBuffTag.buffID]
self.buffInfo.level=_rawData[fightAddBuffTag.level]
self.buffInfo.round=_rawData[fightAddBuffTag.round]
self.buffInfo.layer=_rawData[fightAddBuffTag.layer]
self.buffInfo.srcID=_rawData[fightAddBuffTag.srcID]
self.buffInfo.desID=_rawData[fightAddBuffTag.desID]
self.buffInfo.flag=_rawData[fightAddBuffTag.flag]

local cfg=cfg_buffconfig_get(self.buffInfo.id)

local buffType=cfg.buffType

if buffType==3 then
self.buffInfo.hudun=_rawData[fightAddBuffTag.val]
elseif buffType==58 then
local val=_rawData[fightAddBuffTag.val]
if val and type(val)=='table'then
local buffLookup={}
if val[1]then
for i,v in ipairs(val[1])do
buffLookup[v]=i
end
self.buffInfo.protect_buff_lookup=buffLookup
self.buffInfo.protect_buff=val
end
end
end

self.srcID=self.buffInfo.srcID
self.buffInfo.dstID=self.buffInfo.desID
self.buffInfo.clientID=self.battle:getBuffClientID()
self.buffInfo.cfg=cfg
self.battle:onAddBuff(self.buffInfo)
self.isComplete=false
self.waitTime=0
end

function fightAddBuffAction:exe(btparam,skillArgs)

self.waitTime=0
local ent=self.battle:getEntity(self.buffInfo.desID)
if ent~=nil then
local skillName=''
if skillArgs and skillArgs[1]==fightActionType.CAST_SKILL then

local skill=skillArgs[2][1]
if self.buffInfo.cfg.buffType==38 then
skill=self.buffInfo.cfg.effects[self.buffInfo.level][1]
end
skillName=cfgHelper.get(cfg_skillconfig_get,skill,"name")
end

self.waitTime=ent:addBuff(self.buffInfo,skillName)
end
self.isComplete=true
end

function fightAddBuffAction:logExe(logContent)
local ent=self.battle:getEntity(self.buffInfo.desID)
if ent~=nil then
self.waitTime=ent:addBuff(self.buffInfo,nil,true)
local bufCfg=self.buffInfo.cfg
local info=ent:getBuff(self.buffInfo.guid)
local tag="添加"
if info~=nil then
tag="刷新"
end

if bufCfg~=nil then
logContent(FMT.fmt('{0}{1}[{2}]级buff[{3}][{4}]{5}',ent:logName(),tag,self.buffInfo.level,bufCfg.name,bufCfg.id,fightActionHelper.genBuffRoundInfoStr(self.buffInfo)))
ent:logAddBuff(self.buffInfo,logContent)
if self.buffInfo.protect_buff_lookup then
local str=FMT.fmt("{0}[{1}]",bufCfg.name,bufCfg.id)..'保护以下buff：'
for guid,i in pairs(self.buffInfo.protect_buff_lookup)do
local p_info=ent:getBuff(guid)
if p_info then
str=str..FMT.fmt("{0}[{1}],",p_info.cfg.name,p_info.cfg.id)
end
end
logContent(str)
end
else
logContent(FMT.fmt('{0}{1}找不到buff[{2}]配置',ent:logName(),tag,self.buffInfo.id))
end

else
logContent(FMT.fmt('添加buff 找不到实体[{0}]',self.buffInfo.desID))
end

self.isComplete=true
end

function fightAddBuffAction:update(deltaTime)
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


function fightAddBuffAction:statisticsExe(skillArgs)
local guid=self.buffInfo.guid
local first=not self.battle:hasStatisticsBuff(self.battle.fightIndex,guid)


if eBuffControlType[self.buffInfo.cfg.buffType]and first then
self.battle:addStatisticsTimes(FIGHT_STATISTICS_TYPE.addStateTimes,self.srcID)
end

if skillArgs and skillArgs[1]==fightActionType.CAST_SKILL then

local skill=skillArgs[2][1]
local level=skillArgs[2][2]
local skillSrcID=skillArgs[2][3]
if skillSrcID==self.srcID then
self.battle:addStatisticsSkillBuff(self.srcID,skill,guid,self.buffInfo.id,level)
end
end

if first then
self.battle:addStatisticsBuff(guid)
end


if self.buffInfo.cfg.stateType==19 and self.buffInfo.hudun and self.buffInfo.hudun>0 then
self.battle:updateStatisticsBuffDemage(guid,FIGHT_BUFF_STATISTICS_TYPE.hudun,math.abs(self.buffInfo.hudun))
end

self.isComplete=true
end



function fightAddBuffAction:onDespwan()
self.round=nil
self.battle=nil
self.srcID=nil
self.buffInfo=nil
self.isComplete=false
self.waitTime=nil
fightActionMrg:recycleAction(self)
end
