def_class('fightCounterChangeAction',fightBaseAction)

function fightCounterChangeAction:__init()
self.typo=fightActionType.LJD_CHANGE
end

function fightCounterChangeAction:getTypo()
return self.typo
end



function fightCounterChangeAction:init(_round,_rawData,_srcID,_dstID)
self.round=_round
self.battle=_round:getBattle()
self.dstID=_rawData[2]

self.counterId=_rawData[3]
self.counterNum=_rawData[4]
end


function fightCounterChangeAction:exe(immediately)
local ent=self.battle:getEntity(self.dstID)
if ent~=nil then
ent:changeATKPoint(self.counterId,self.counterNum)
ent:flushATKPoint()
end
self.isComplete=true
end



function fightCounterChangeAction:logExe(logContent)
local dstEnt=self.battle:getEntity(self.dstID)
local dstName=dstEnt and dstEnt:logName()or'未定义'
local logStr=''

logStr=FMT.fmt('{0} [连击点刷新][{1}][连击点id:{2}变化为{3}]',logStr,dstName,self.counterId,self.counterNum)
logContent(logStr)
self.isComplete=true
end

function fightCounterChangeAction:update(deltaTime)

return self.isComplete
end


function fightCounterChangeAction:onDespwan()
fightActionMrg:recycleAction(self)
end

