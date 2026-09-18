

parallelCompleteNode=simple_class(compositeNode)

function parallelCompleteNode:update(interval)
local complete=false
local cpstate
for i,v in ipairs(self.children)do
if v:canExecute()then
v:tick(interval)
if not complete then
if v:isComplete()then
complete=true
cpstate=v:getState()
end
end
end
end
if complete then
return cpstate
end
return nodeState.running
end