

randomSequenceNode=simple_class(compositeNode)

function randomSequenceNode:init()
self.randomList=self:getRandomChildList()
end

function randomSequenceNode:update(interval)
for _,v in ipairs(self.children)do
if v:canExecute()then
local state=v:tick(interval)
if state~=nodeState.success then
return state
end
end
end
return nodeState.success
end