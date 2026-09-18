registry_pool_class(fBTNodeTypo.Sequence,'fBTSequenceNode',fBTBaseNode)

function fBTSequenceNode:__init(guid)
self.typo=fBTNodeTypo.Sequence
end

function fBTSequenceNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self.kids={}
self.index=0
self.enable=false
for _,data in ipairs(rawData)do
local typo=data[1]
local node=fBTNodePool.get(typo)
if node~=nil then
node:awake(bt,data[2])
self.kids[#self.kids+1]=node
end
end
self.curKid=nil
end

function fBTSequenceNode:start()
self.curKid=self:getNextKid()
if self.curKid then
self.curKid:start()
self.state=fBTNodeState.running
else
self.state=fBTNodeState.success
end
end

function fBTSequenceNode:getNextKid()
self.index=self.index+1
return self.kids[self.index]
end

function fBTSequenceNode:update(delta)

if fBTNodeState.running==self.state then
local ret=self.curKid:update(delta)
if ret~=fBTNodeState.running then
self.curKid:onEnd()
self.curKid=self:getNextKid()
if self.curKid~=nil then
self.curKid:start()
if ret==fBTNodeState.success then
ret=fBTNodeState.running
end
end
self.state=ret
end
end
return self.state
end


function fBTSequenceNode:onComplete(state)
for _,node in ipairs(self.kids)do
node:onComplete(state)
end
end

function fBTSequenceNode:onDespawn()
self.state=fBTNodeState.inactive
self.enable=false
for _,node in ipairs(self.kids)do
node:onDespawn()
end
self.kids=nil
fBTNodePool.recycle(self)
end

