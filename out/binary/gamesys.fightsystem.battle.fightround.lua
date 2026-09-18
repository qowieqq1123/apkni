def_class('fightRound',{})

function fightRound:__init(_battle)
self.battle=_battle
self.skillIndex=0
self.buffIndex=0
end


function fightRound:onStart()

end


function fightRound:onEnd()

end


function fightRound:init(index,_roundData)
self.roundIndex=index
self.roundData=_roundData
self.stageIndex=fightRoundTag.first
self.curStageData=nil
self.curIndex=0
end

function fightRound:play(index,_roundData)

self:init(index,_roundData)
self.actionObj=nil
self:onStart()
self:getNextStage()
end

local StrTag=
{
[fightRoundTag.beidong]='被动',
[fightRoundTag.skill]='技能',
[fightRoundTag.buff]='Buff',
[fightRoundTag.yuanjun]='援军',
}

function fightRound:logPlay(index,_roundData,logContent)
self:init(index,_roundData)
logContent(FMT.fmt("回合{0}开始",index))
for i,roundStageData in ipairs(self.roundData)do
logContent(FMT.fmt("{0}开始",StrTag[i]))
local ii=1
local roundStageDataLen=#roundStageData
while(ii<=roundStageDataLen)
do
local actionData=roundStageData[ii]
local typo=actionData[fightCommonTag.typo]
self.actionObj=fightActionMrg:getAction(typo)
if self.actionObj~=nil then
self.actionObj:init(self,actionData)
local indexOffset=self.actionObj:fetchData(ii,roundStageData)
ii=ii+indexOffset
self.actionObj:logExe(logContent)
self.actionObj:onDespwan()
self.actionObj=nil
end
ii=ii+1
end
logContent(FMT.fmt("{0}结束",StrTag[i]))
end

logContent(FMT.fmt("回合{0}结束\n",index))
end

function fightRound:playStatistics(index,_roundData)
self:init(index,_roundData)
for i,roundStageData in ipairs(self.roundData)do
local ii=1
local roundStageDataLen=#roundStageData
while(ii<=roundStageDataLen)
do
local actionData=roundStageData[ii]
local typo=actionData[fightCommonTag.typo]
self.actionObj=fightActionMrg:getAction(typo)
if self.actionObj~=nil then
self.actionObj:init(self,actionData)
local indexOffset=self.actionObj:fetchData(ii,roundStageData)
ii=ii+indexOffset
self.actionObj:statisticsExe()
self.actionObj:onDespwan()
self.actionObj=nil
end
ii=ii+1
end
end
end

function fightRound:stop()
if self.actionObj~=nil then
self.actionObj:onDespwan()
self.actionObj=nil
end
end



function fightRound:update(deltaTime)
if self.actionObj~=nil then
local ret=self.actionObj:update(deltaTime)
if ret then
self.actionObj:onDespwan()
self.actionObj=nil
self:getNextObj()
end
end
end

function fightRound:getNextObj()
self.curIndex=self.curIndex+1
local objData=self.curStageData[self.curIndex]
if self.actionObj~=nil then
self.actionObj:onDespwan()
self.actionObj=nil
end
if objData~=nil then
local typo=objData[fightCommonTag.typo]
self.actionObj=fightActionMrg:getAction(typo)
if self.actionObj~=nil then
self.actionObj:init(self,objData)
local indexOffset=self.actionObj:fetchData(self.curIndex,self.curStageData)
self.curIndex=self.curIndex+indexOffset
self.actionObj:exe()
else
self:getNextObj()
end
else
self:getNextStage()
end
end


function fightRound:getNextStage()
self.stageIndex=self.stageIndex+1
if self.stageIndex<=fightRoundTag.max then
self.curIndex=0
self.curStageData=self.roundData[self.stageIndex]
if self.curStageData==nil then
self:getNextStage()
else
self:getNextObj()
end
else
self:onEnd()
if self.battle.fightMode==fightPlayModeType.eJunZhen then
self.battle:playJunZhenNextRound()
else
self.battle:playNextRound()
end
end
end


function fightRound:getBattle()
return self.battle
end
