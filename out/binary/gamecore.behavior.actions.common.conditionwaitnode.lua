





conditionWaitNode=simple_class(baseNode)

function conditionWaitNode:init()
self.condition=self:getDataValue('condition')
self.condition=string.format('return %s',self.condition)
end

function conditionWaitNode:update(interval)
local condition=self:replaceData(self.condition)
local checkFunc=loadstring(condition)
if checkFunc()then
return nodeState.success
end
return nodeState.running
end

function conditionWaitNode:skip()
return nodeState.success
end