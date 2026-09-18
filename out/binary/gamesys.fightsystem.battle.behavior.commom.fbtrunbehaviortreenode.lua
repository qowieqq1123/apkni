


registry_pool_class(fBTNodeTypo.RunBehaviorTree,'fBTRunBehaviorTreeNode',fBTBaseNode)

function fBTRunBehaviorTreeNode:__init(guid)
self.typo=fBTNodeTypo.RunBehaviorTree
end

function fBTRunBehaviorTreeNode:parser(rawData)
self.entName=rawData[1]
self.btName=rawData[2]
self.wait=rawData[3]
end




function fBTRunBehaviorTreeNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end

function fBTRunBehaviorTreeNode:start()
local ent=self.behaviorTree:getSharedValue(FMT.fmt("entity_{0}",self.entName))
if ent~=nil then
self.dstTree=fBTBehaviorTree.get()
local ret=self.dstTree:start(ent,self.btName,function(eventTypo)
self.state=fBTNodeState.success
end)
if not ret then
self.state=fBTNodeState.success
else
self.state=fBTNodeState.running
end
else
self.state=fBTNodeState.success
end

end

function fBTRunBehaviorTreeNode:update(delta)
if self.dstTree~=nil then
self.dstTree:update(delta)
end
return self.state
end

function fBTRunBehaviorTreeNode:onComplete()
if self.dstTree~=nil then
self.dstTree:onComplete()
end
end

function fBTRunBehaviorTreeNode:onDespawn()
if self.dstTree~=nil then
self.dstTree:delete()
self.dstTree=nil
end
self.behaviorTree=nil
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end




