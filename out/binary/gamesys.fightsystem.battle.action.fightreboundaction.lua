

def_class('fightReboundAction',fightBaseAction)

function fightReboundAction:__init()
self.typo=fightActionType.REBOUND
end

function fightReboundAction:init(_round,_rawData,_srcID)
self.isComplete=false
end

function fightReboundAction:exe()

self.isComplete=true
end

function fightReboundAction:logExe(logContent)

logContent('伤害反射【待完善功能】')
self.isComplete=true
end

function fightReboundAction:update(deltaTime)
return self.isComplete
end

