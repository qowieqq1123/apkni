







childBehaviorNode=simple_class(baseNode)

function childBehaviorNode:start()
childBehaviorNode._base.start(self)
self:setBT()
end

function childBehaviorNode:reset()
childBehaviorNode._base.reset(self)
if self.childBT then
self.childBT:reset()
else
self:setBT()
end
end

function childBehaviorNode:broke()
if self.childBT then
behaviorManager:removeBehaviorTree(self.childBT)
self.childBT=nil
end
end

function childBehaviorNode:setBT()
local name=self:getData('btName')
local initData=self:getData('initData')
self.childBT=behaviorManager:addBehaviorTree(name,self:getArgs(),true,initData)
end

function childBehaviorNode:update(interval)

return self.childBT:getState()
end