

randomSelectorNode=simple_class(compositeNode)

function randomSelectorNode:init()
self.randomList=self:getRandomChildList()
end

function randomSelectorNode:update(interval)
for _,v in ipairs(self.randomList)do
if v:canExecute()then
local state=v:tick(interval)
if state~=nodeState.failure then
return state
end
end
end
return nodeState.failure
end