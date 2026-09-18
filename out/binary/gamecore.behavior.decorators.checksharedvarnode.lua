






checkSharedVarNode=simple_class(decoratorNode)

function checkSharedVarNode:checkPass()
local key=self:getDataValue('key')
local sv=self:getSharedVar(key)
local cv=self:getData('value')
self.pass=sv==cv
end

function checkSharedVarNode:update(interval)
if not self.isCheck then
self:checkPass()
self.isCheck=true
end

if self.pass then
local v=self:getChild(1)
if v:canExecute()then
v:tick(interval)
end
return v:getState()
end

return nodeState.failure
end

function checkSharedVarNode:reset()
checkSharedVarNode._base.reset(self)
self.pass=false
self.isCheck=false
end