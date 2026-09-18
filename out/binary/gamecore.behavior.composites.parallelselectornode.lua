

parallelSelectorNode=simple_class(compositeNode)

function parallelSelectorNode:update(interval)
local success=false
local failureCount=0
for i,v in ipairs(self.children)do
if v:canExecute()then
local state=v:tick(interval)
if state==nodeState.failure then
failureCount=failureCount+1
elseif state==nodeState.success then
success=true
end
else
failureCount=failureCount+1
end
end
if success then
return nodeState.success
end
if failureCount>=#self.children then
return nodeState.failure
end
return nodeState.running
end