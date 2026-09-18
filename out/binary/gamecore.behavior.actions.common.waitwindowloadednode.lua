




waitWindowLoadedNode=simple_class(baseNode)

function waitWindowLoadedNode:init()
self.isWaiting=false
end

function waitWindowLoadedNode:update(interval)
if self.isWaiting then
if UIManager:isActive(self.winName)then
return nodeState.success
else
return nodeState.running
end
end

self.winName=self:getData('winName')
if UIManager:isActive(self.winName)then
return nodeState.success
else
self.isWaiting=true
return nodeState.running
end
end