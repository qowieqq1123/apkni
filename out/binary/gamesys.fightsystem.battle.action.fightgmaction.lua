def_class('fightGMAction',fightBaseAction)

function fightGMAction:__init()
self.typo=fightActionType.GM
end

function fightGMAction:getTypo()
return self.typo
end


function fightGMAction:init(_round,_rawData,_srcID,_dstID)

end


function fightGMAction:exe(immediately)
self.isComplete=true
end

function fightGMAction:logExe(logContent)

logContent('GM测试【待完善功能】')
self.isComplete=true
end

function fightGMAction:update(deltaTime)

return self.isComplete
end


function fightGMAction:onDespwan()
fightActionMrg:recycleAction(self)
end

