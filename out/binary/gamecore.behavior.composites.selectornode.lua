

selectorNode=simple_class(compositeNode)

function selectorNode:update(interval)
for _,v in ipairs(self.children)do
if v:canExecute()then
local state=v:tick(interval)
if state~=nodeState.failure then
return state
end
end
end
return nodeState.failure
end