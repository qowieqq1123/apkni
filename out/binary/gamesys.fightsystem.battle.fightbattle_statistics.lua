





FIGHT_STATISTICS_TYPE=
{
killTimes=1,
deadTimes=2,
addStateTimes=3,
resistDebuffTimes=4,
resistDemageTimes=5,
dodgeTimes=6,
rebirthTimes=7,
rebirthOtherTimes=8,

hit=9,

shield=10,
nowShield=11,

xixue=12,

fanShe=13,
}


FIGHT_BUFF_STATISTICS_TYPE=
{
demage=1,
heal=2,
xixue=3,
hudun=4,
}

function fightBattle:addStatisticsTimes(sType,id)
local fightIndex=self.fightIndex or 1
if not self.statisticsEntInfo[fightIndex]then
self.statisticsEntInfo[fightIndex]={}
end

self.statisticsEntInfo[fightIndex][id]=self.statisticsEntInfo[fightIndex][id]or{}
self.statisticsEntInfo[fightIndex][id][sType]=(self.statisticsEntInfo[fightIndex][id][sType]or 0)+1
end

function fightBattle:addStatisticsVal(sType,id,val)
local fightIndex=self.fightIndex or 1
if not self.statisticsEntInfo[fightIndex]then
self.statisticsEntInfo[fightIndex]={}
end

self.statisticsEntInfo[fightIndex][id]=self.statisticsEntInfo[fightIndex][id]or{}
self.statisticsEntInfo[fightIndex][id][sType]=(self.statisticsEntInfo[fightIndex][id][sType]or 0)+val
end

function fightBattle:changeStatisticsVal(sType,id,val)
local fightIndex=self.fightIndex or 1
if not self.statisticsEntInfo[fightIndex]then
self.statisticsEntInfo[fightIndex]={}
end

self.statisticsEntInfo[fightIndex][id]=self.statisticsEntInfo[fightIndex][id]or{}
self.statisticsEntInfo[fightIndex][id][sType]=val
end

function fightBattle:getStatisticsTimes(fightIndex,sType,id)
if self.statisticsEntInfo[fightIndex]and self.statisticsEntInfo[fightIndex][id]then return self.statisticsEntInfo[fightIndex][id][sType]or 0 end
return 0
end


function fightBattle:addStatisticsBuff(guid)
local fightIndex=self.fightIndex or 1
if not self.statisticBuffInfo[fightIndex]then self.statisticBuffInfo[fightIndex]={}end

self.statisticBuffInfo[fightIndex][guid]={}
end

function fightBattle:updateStatisticsBuffDemage(guid,bsType,val)
local fightIndex=self.fightIndex or 1
self.statisticBuffInfo[fightIndex]=self.statisticBuffInfo[fightIndex]or{}
self.statisticBuffInfo[fightIndex][guid]=self.statisticBuffInfo[fightIndex][guid]or{}
self.statisticBuffInfo[fightIndex][guid][bsType]=(self.statisticBuffInfo[fightIndex][guid][bsType]or 0)+val
end

function fightBattle:getStatisticsBuffDemage(fightIndex,guid,bsType)
if not self.statisticBuffInfo[fightIndex]then return end
if not self.statisticBuffInfo[fightIndex][guid]then return end
return self.statisticBuffInfo[fightIndex][guid][bsType]
end


function fightBattle:hasStatisticsBuff(fightIndex,guid)
if not self.statisticBuffInfo[fightIndex]then self.statisticBuffInfo[fightIndex]={}end

return self.statisticBuffInfo[fightIndex][guid]
end


function fightBattle:printStatisticsTimes()

end


function fightBattle:addStatisticsSkillDemage(id,skill,level,val)
local fightIndex=self.fightIndex or 1
if not self.statisticsEntSkillDemage[fightIndex]then
self.statisticsEntSkillDemage[fightIndex]={}
end

self.statisticsEntSkillDemage[fightIndex][id]=self.statisticsEntSkillDemage[fightIndex][id]or{}
if self.statisticsEntSkillDemage[fightIndex][id][skill]then
self.statisticsEntSkillDemage[fightIndex][id][skill].val=self.statisticsEntSkillDemage[fightIndex][id][skill].val+val
else
self.statisticsEntSkillDemage[fightIndex][id][skill]={val=val,level=level}
end
end

function fightBattle:getStatisticsSkillDemage(fightIndex,id)
local list={}
if self.statisticsEntSkillDemage[fightIndex]then
list=table.deepCopy(self.statisticsEntSkillDemage[fightIndex][id]or{})
end

local buffDemage=self:getStatisticsAllSkillBuffVal(fightIndex,id,FIGHT_BUFF_STATISTICS_TYPE.demage)
if buffDemage then
for skill,v in pairs(buffDemage)do
if list[skill]then
list[skill].val=v.val+list[skill].val
else
list[skill]=v
end
end
end
return list
end

function fightBattle:getStatisticsSkillAllDemage(fightIndex,id)
local list=self:getStatisticsSkillDemage(fightIndex,id)
local val=0
for s,v in pairs(list)do
val=val+v.val
end
return val+self:getStatisticsTimes(fightIndex,FIGHT_STATISTICS_TYPE.fanShe,id)
end



function fightBattle:addStatisticsSkillBuff(id,skill,guid,buffId,level)
local fightIndex=self.fightIndex or 1
if not self.statisticEntSkillBuff[fightIndex]then self.statisticEntSkillBuff[fightIndex]={}end

self.statisticEntSkillBuff[fightIndex][id]=self.statisticEntSkillBuff[fightIndex][id]or{}
if self.statisticEntSkillBuff[fightIndex][id][skill]then
self.statisticEntSkillBuff[fightIndex][id][skill][guid]=buffId
else
self.statisticEntSkillBuff[fightIndex][id][skill]={level=level,[guid]=buffId}
end
end

function fightBattle:getStatisticsSkillBuff(fightIndex,id,skill)
if not self.statisticEntSkillBuff[fightIndex]then self.statisticEntSkillBuff[fightIndex]={}end
self.statisticEntSkillBuff[fightIndex][id]=self.statisticEntSkillBuff[fightIndex][id]or{}
return self.statisticEntSkillBuff[fightIndex][id][skill]
end

function fightBattle:getStatisticsAllSkillBuffVal(fightIndex,id,bsTpye)
if not self.statisticEntSkillBuff[fightIndex]then return end
if self.statisticEntSkillBuff[fightIndex][id]then
local buffValList={}
local usedBuff={}
for skill,buffInfo in pairs(self.statisticEntSkillBuff[fightIndex][id])do
local demage=0

local buffConfig=cfgHelper.get(cfg_skillconfig_get,skill,"buffList")
for guid,buffId in pairs(buffInfo)do
if guid~='level'and not(usedBuff[buffId..'_'..guid])then
if not buffConfig or buffConfig[buffId]then
local d=self:getStatisticsBuffDemage(fightIndex,guid,bsTpye)
demage=demage+(d or 0)
usedBuff[buffId..'_'..guid]=guid
end
end
end
if demage>0 then
buffValList[skill]={val=demage,level=buffInfo.level}
end
end
return buffValList
end
return nil
end



function fightBattle:getStatisticsSkillBuffDemage(fightIndex,id,skill,bsTpye)
local buffList=self:getStatisticsSkillBuff(fightIndex,id,skill)
local demage=0
if buffList then
local buffConfig=cfgHelper.get(cfg_skillconfig_get,skill,"buffList")
for guid,buffId in pairs(buffList)do
if not buffConfig or buffConfig[buffId]then
local d=self:getStatisticsBuffDemage(fightIndex,guid,bsTpye)
demage=demage+(d or 0)
end
end
end
return demage
end


function fightBattle:addStatisticsSkillHeal(id,skill,level,val)
local fightIndex=self.fightIndex or 1
if not self.statisticsEntSkillHeal[fightIndex]then
self.statisticsEntSkillHeal[fightIndex]={}
end

self.statisticsEntSkillHeal[fightIndex][id]=self.statisticsEntSkillHeal[fightIndex][id]or{}
if self.statisticsEntSkillHeal[fightIndex][id][skill]then
self.statisticsEntSkillHeal[fightIndex][id][skill].val=self.statisticsEntSkillHeal[fightIndex][id][skill].val+val
else
self.statisticsEntSkillHeal[fightIndex][id][skill]={val=val,level=level}
end
end


function fightBattle:getStatisticsSkillHeal(fightIndex,id)
local list={}
if self.statisticsEntSkillHeal[fightIndex]then
list=table.deepCopy(self.statisticsEntSkillHeal[fightIndex][id]or{})
end

local buffDemage=self:getStatisticsAllSkillBuffVal(fightIndex,id,FIGHT_BUFF_STATISTICS_TYPE.heal)
if buffDemage then
for skill,v in pairs(buffDemage)do
if list[skill]then
list[skill].val=v.val+list[skill].val
else
list[skill]=v
end
end
end
return list
end

function fightBattle:getStatisticsSkillAllHeal(fightIndex,id)
local list=self:getStatisticsSkillHeal(fightIndex,id)
local val=0
for s,v in pairs(list)do
val=val+v.val
end
return val+self:getStatisticsTimes(fightIndex,FIGHT_STATISTICS_TYPE.xixue,id)
end



function fightBattle:addStatisticsSkillShield(id,skill,level,val)
local fightIndex=self.fightIndex or 1
if not self.statisticsEntSkillShield[fightIndex]then
self.statisticsEntSkillShield[fightIndex]={}
end

self.statisticsEntSkillShield[fightIndex][id]=self.statisticsEntSkillShield[fightIndex][id]or{}
if self.statisticsEntSkillShield[fightIndex][id][skill]then
self.statisticsEntSkillShield[fightIndex][id][skill].val=self.statisticsEntSkillShield[fightIndex][id][skill].val+val
else
self.statisticsEntSkillShield[fightIndex][id][skill]={val=val,level=level}
end
end

function fightBattle:getStatisticsSkillShield(fightIndex,id)
local list={}
if self.statisticsEntSkillShield[fightIndex]then
list=table.deepCopy(self.statisticsEntSkillShield[fightIndex][id]or{})
end
local buffDemage=self:getStatisticsAllSkillBuffVal(fightIndex,id,FIGHT_BUFF_STATISTICS_TYPE.hudun)
if buffDemage then
for skill,v in pairs(buffDemage)do
if list[skill]then
list[skill].val=v.val+list[skill].val
else
list[skill]=v
end
end
end
return list
end

function fightBattle:getStatisticsSkillAllShield(fightIndex,id)
local list=self:getStatisticsSkillShield(fightIndex,id)
local val=0
for s,v in pairs(list)do
val=val+v.val
end
return val
end



function fightBattle:copyStatisticsDataToOtherId(id,otherId)
local fightIndex=self.fightIndex or 1
if not self.statisticsEntInfo[fightIndex]then
self.statisticsEntInfo[fightIndex]={}
end
if not self.statisticsEntSkillDemage[fightIndex]then
self.statisticsEntSkillDemage[fightIndex]={}
end
if not self.statisticsEntSkillHeal[fightIndex]then
self.statisticsEntSkillHeal[fightIndex]={}
end
if not self.statisticsEntSkillShield[fightIndex]then
self.statisticsEntSkillShield[fightIndex]={}
end

self.statisticsEntInfo[fightIndex][otherId]=self.statisticsEntInfo[fightIndex][id]
self.statisticsEntSkillDemage[fightIndex][otherId]=self.statisticsEntSkillDemage[fightIndex][id]
self.statisticsEntSkillHeal[fightIndex][otherId]=self.statisticsEntSkillHeal[fightIndex][id]
self.statisticsEntSkillShield[fightIndex][otherId]=self.statisticsEntSkillShield[fightIndex][id]
end


function fightBattle:resetStatisticsData(id)
local fightIndex=self.fightIndex or 1
if self.statisticsEntInfo[fightIndex]then
self.statisticsEntInfo[fightIndex][id]=nil
end
if self.statisticsEntSkillDemage[fightIndex]then
self.statisticsEntSkillDemage[fightIndex][id]=nil
end
if self.statisticsEntSkillHeal[fightIndex]then
self.statisticsEntSkillHeal[fightIndex][id]=nil
end
if self.statisticsEntSkillShield[fightIndex]then
self.statisticsEntSkillShield[fightIndex][id]=nil
end
end