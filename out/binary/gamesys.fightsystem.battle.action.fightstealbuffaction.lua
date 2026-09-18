

def_class('fightStealBuffAction',fightBaseAction)

function fightStealBuffAction:__init()
self.typo=fightActionType.STEAL_BUFF
end

function fightStealBuffAction:init(_round,_rawData,_srcID)
self.isComplete=false
end

function fightStealBuffAction:exe()

self.isComplete=true
end

function fightStealBuffAction:logExe(logContent)

logContent('偷取buff【待完善功能】')
self.isComplete=true
end

function fightStealBuffAction:update(deltaTime)
return self.isComplete
end

