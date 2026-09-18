def_class('fightChangeHpAction',fightBaseAction)



function fightChangeHpAction:__init()
self.typo=fightActionType.CHANGE_HP
end



DAMAGE_TYPE_CRITICAL=1
DAMAGE_TYPE_FANSHE=2



function fightChangeHpAction:init(_round,_rawData,_srcID)
self.round=_round
self.battle=_round:getBattle()
self.dstID=_rawData[fightChangeHpTag.dstID]
self.srcID=_rawData[fightChangeHpTag.srcID]
self.value=_rawData[fightChangeHpTag.value]
self.demageTypo=_rawData[fightChangeHpTag.demageTypo]
self.nowhp=_rawData[fightChangeHpTag.nowhp]


self.critical=bit.band(1,bit.rshift(self.demageTypo,eDamagetype.critical))
self.fanShe=bitHelper.check_pos(self.demageTypo,eDamagetype.fanshe)
self.xixue=bitHelper.check_pos(self.demageTypo,eDamagetype.xixue)
self.isDead=false
self.isRelive=false
self.isExe=false
self.isComplete=false
end

function fightChangeHpAction:exe(dstBtPara)


local srcEnt=self.battle:getEntity(self.srcID)
local dstEnt=self.battle:getEntity(self.dstID)
if self.fanShe and self.battle.isShowWindow then
local cfg=skillShowTypeTag[eSkillShowType.clientFanShe]
if cfg~=nil and dstEnt then
dstEnt:flowText(flowObjTypo.skillEffect,{nunPara=cfg.imageID})
end
end

if self.value>0 then
if dstEnt~=nil then
self.isDead=dstEnt:onRecvDamage(srcEnt,self.value,self.critical,self.nowhp,self.oldProp)

if srcEnt~=nil then
if srcEnt:isLeft()and not dstEnt:isLeft()then
UIManager:callWindowFunc("UIFightMainTop","addDemage",self.value)
end
end
end
else
if dstEnt~=nil then
self.isRelive=dstEnt:onRecvTreated(srcEnt,math.abs(self.value),self.nowhp,self.oldProp,dstBtPara)
end
if srcEnt~=nil then
if srcEnt:isLeft()and dstEnt:isLeft()then
UIManager:callWindowFunc("UIFightMainTop","addHeal",self.value)
end
end
end

self.isExe=true

self.delayTime=0
self.isComplete=true
end

function fightChangeHpAction:logExe(logContent)
local srcEnt=self.battle:getEntity(self.srcID)
local dstEnt=self.battle:getEntity(self.dstID)

local strFmt='{0}对{1}造成[{2}]伤害'
if self.fanShe then
strFmt='{0}对{1}造成[{2}]反射伤害'
end
local srcEntName=nil
if srcEnt~=nil then
srcEntName=srcEnt:getHpInfo()
else
srcEntName=FMT.fmt('[未知实体:{0}]',self.srcID or-1)
end

local dstEntName
if dstEnt~=nil then
dstEntName=dstEnt:getHpInfo()
else
dstEntName=FMT.fmt('[未知实体:{0}]',self.dstID or-1)
end


if self.value>0 then
if dstEnt~=nil then
dstEnt.totalDefend=dstEnt.totalDefend+self.value
end
if srcEnt~=nil and dstEnt~=srcEnt then
srcEnt.totalAttack=srcEnt.totalAttack+self.value
end
logContent(FMT.fmt(strFmt,srcEntName,dstEntName,self.value))
else
if dstEnt~=nil then
local realValue=math.abs(self.value)
dstEnt.totalTreated=dstEnt.totalTreated+realValue
if srcEnt~=nil then
srcEnt.totalCue=srcEnt.totalCue+realValue
end
end
logContent(FMT.fmt('[{0}]治疗[{1}]回血[{2}]',srcEntName,dstEntName,math.abs(self.value)))

end
self.isComplete=true
end

function fightChangeHpAction:statisticsExe(skillArgs)
local srcEnt=self.battle:getEntity(self.srcID)
local dstEnt=self.battle:getEntity(self.dstID)

if dstEnt~=nil then
local maxHp=dstEnt:getAttribute(entityAttr.max_hp)
if not dstEnt.finalHpPercentList then
dstEnt.finalHpPercentList={}
end
local actualMaxHp=dstEnt.actualMaxHp or maxHp
local entSelectIndex=#dstEnt.finalHpPercentList>0 and#dstEnt.finalHpPercentList or 1
dstEnt.finalHpPercentList[entSelectIndex]=self.nowhp/actualMaxHp
else

end



if self.value>0 then
if dstEnt~=nil then
dstEnt.totalDefend=dstEnt.totalDefend+self.value
end
if srcEnt~=nil and dstEnt~=srcEnt then
srcEnt.totalAttack=srcEnt.totalAttack+self.value
end
else
local realValue=math.abs(self.value)
if dstEnt~=nil then
dstEnt.totalTreated=dstEnt.totalTreated+realValue
end

if srcEnt~=nil then
srcEnt.totalCue=srcEnt.totalCue+realValue
end
end




if self.nowhp<=0 then
self.battle:addStatisticsTimes(FIGHT_STATISTICS_TYPE.killTimes,self.srcID)
end

if skillArgs then
if skillArgs[1]==fightActionType.CAST_SKILL then

local skill=skillArgs[2][1]
local skilllv=skillArgs[2][2]
local srcID=skillArgs[2][3]

if srcID==self.srcID then
if self.value>0 then
if not self.battle:isEntitySameTeam(self.srcID,self.dstID)then
self.battle:addStatisticsSkillDemage(srcID,skill,skilllv,self.value)
end
else
if self.xixue then

self.battle:addStatisticsVal(FIGHT_STATISTICS_TYPE.xixue,srcID,math.abs(self.value))
else

self.battle:addStatisticsSkillHeal(srcID,skill,skilllv,math.abs(self.value))
end
end
else
if self.value>0 and self.fanShe then

self.battle:addStatisticsVal(FIGHT_STATISTICS_TYPE.fanShe,self.srcID,math.abs(self.value))
else

end
end

elseif skillArgs[1]==fightActionType.BUFF_EFFECT then
local buffguid=skillArgs[2][1]
if self.value>0 then
if not self.battle:isEntitySameTeam(self.srcID,self.dstID)then
self.battle:updateStatisticsBuffDemage(buffguid,FIGHT_BUFF_STATISTICS_TYPE.demage,self.value)
end
else
if self.xixue then

self.battle:updateStatisticsBuffDemage(buffguid,FIGHT_BUFF_STATISTICS_TYPE.xixue,math.abs(self.value))
else

self.battle:updateStatisticsBuffDemage(buffguid,FIGHT_BUFF_STATISTICS_TYPE.heal,math.abs(self.value))
end
end
end
end

if self.value>0 then
self.battle:addStatisticsVal(FIGHT_STATISTICS_TYPE.hit,self.dstID,self.value)
end


if self.nowhp<=0 then
self.battle:addStatisticsTimes(FIGHT_STATISTICS_TYPE.deadTimes,self.dstID)
end


if self.value<0 and self.nowhp>0 and self.nowhp==math.abs(self.value)then
self.battle:addStatisticsTimes(FIGHT_STATISTICS_TYPE.rebirthTimes,self.dstID)
self.battle:addStatisticsTimes(FIGHT_STATISTICS_TYPE.rebirthOtherTimes,self.srcID)
end

self.isComplete=true
end

function fightChangeHpAction:update(deltaTime)
if self.isExe then
self.delayTime=self.delayTime-deltaTime
if self.delayTime<0 then
self.isComplete=true
end
end

return self.isComplete
end

function fightChangeHpAction:onDespwan()
self.round=nil
self.battle=nil
self.srcID=nil
self.dstID=nil
self.value=nil
self.delayTime=0
self.isComplete=false
fightActionMrg:recycleAction(self)
end

