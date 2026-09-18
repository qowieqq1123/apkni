

def_class('fightDispelBuffEffectAction',fightBaseAction)

function fightDispelBuffEffectAction:__init()
self.typo=fightActionType.DISPEL_BUFF_EFFECT
end


function fightDispelBuffEffectAction:init(_round,_rawData,_srcID)
self.isComplete=false
end

function fightDispelBuffEffectAction:exe()

self.isComplete=true
end

function fightDispelBuffEffectAction:logExe(logContent)

logContent('驱散buff时的作用【待完善功能】')
self.isComplete=true
end

function fightDispelBuffEffectAction:update(deltaTime)
return self.isComplete
end

