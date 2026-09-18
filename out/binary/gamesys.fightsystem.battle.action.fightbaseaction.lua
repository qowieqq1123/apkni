def_class('fightBaseAction',{})

function fightBaseAction:__init()
self.typo=fightActionType.NONE
end

function fightBaseAction:getTypo()
return self.typo
end



function fightBaseAction:init(_round,_rawData,_srcID,_dstID)

end





function fightBaseAction:fetchData(curIndex,parentRawData)
return 0
end


function fightBaseAction:exe(immediately)
return 0
end

function fightBaseAction:logExe(logContent)

self.isComplete=true
end

function fightBaseAction:statisticsExe()

self.isComplete=true
end

function fightBaseAction:update(deltaTime)

end


function fightBaseAction:onBehaviorEvent(state)

end


function fightBaseAction:onDespwan()
fightActionMrg:recycleAction(self)
end

