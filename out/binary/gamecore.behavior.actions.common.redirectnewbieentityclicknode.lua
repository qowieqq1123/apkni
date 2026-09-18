





redirectNewbieEntityClickNode=simple_class(baseNode)

function redirectNewbieEntityClickNode:init()
self.waiting=false
self.bComplete=false
end

function redirectNewbieEntityClickNode:broke()
if self.waiting then
self:clearAction()
self.waiting=false
end
end

function redirectNewbieEntityClickNode:clearAction()
local stId=self:getData('stId')
newbieEntityControl.registerEntityAction(stId,nil)
end

function redirectNewbieEntityClickNode:update(interval)
if self.waiting then
return nodeState.running
end

if self.bComplete then
self:clearAction()
return nodeState.success
end

local stId=self:getData('stId')
newbieEntityControl.registerEntityAction(stId,function()
self.waiting=false
self.bComplete=true
self:quicklyTick()
end)

self.waiting=true
self.bComplete=false
return nodeState.running
end