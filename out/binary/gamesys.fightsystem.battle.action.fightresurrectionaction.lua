

def_class('fightResurrectionAction',fightBaseAction)

function fightResurrectionAction:__init()
self.typo=fightActionType.RESURRECTION
end

function fightResurrectionAction:init(_round,_rawData,_srcID)
self.isComplete=false
end

function fightResurrectionAction:exe()

self.isComplete=true
end

function fightResurrectionAction:logExe(logContent)

logContent('复生【待完善功能】')
self.isComplete=true
end

function fightResurrectionAction:update(deltaTime)
return self.isComplete
end

