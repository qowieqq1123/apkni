

sequenceNode=simple_class(compositeNode)

function sequenceNode:update(interval)
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

function sequenceNode:skip()
return nodeState.success
end