

parallelNode=simple_class(compositeNode)

function parallelNode:update(interval)
local failed=false
local successCount=0
for i,v in ipairs(self.children)do
if v:canExecute()then
local state=v:tick(interval)
if state==nodeState.success then
successCount=successCount+1
elseif state==nodeState.failure then
failed=true
end
else
successCount=successCount+1
end
end
if failed then
return nodeState.failure
end
if successCount>=#self.children then
return nodeState.success
end
return nodeState.running
end

function parallelNode:skip()
return nodeState.success
end