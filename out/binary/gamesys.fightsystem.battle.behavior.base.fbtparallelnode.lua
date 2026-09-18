
registry_pool_class(fBTNodeTypo.Parallel,'fBTParallelNode',fBTBaseNode)

function fBTParallelNode:__init(guid)
self.typo=fBTNodeTypo.Parallel
end

function fBTParallelNode:getTypo()
return self.typo
end


function fBTParallelNode:awake(bt,rawData)
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

function fBTParallelNode:start()
if#self.kids==0 then
self.state=fBTNodeState.success
else
for _,node in ipairs(self.kids)do
node:start()
end
self.state=fBTNodeState.running
end

end


function fBTParallelNode:update(delta)
if self.state==fBTNodeState.running then
local runningNun=0
for _,v in ipairs(self.kids)do
if v.state==fBTNodeState.running then
local ret=v:update(delta)
if ret~=fBTNodeState.running then
v:onEnd()
if ret==fBTNodeState.failure then
self.state=fBTNodeState.failure
break
end
else
runningNun=runningNun+1
end
end
end
if self.state~=fBTNodeState.failure and runningNun==0 then
self.state=fBTNodeState.success
end
end

return self.state
end



function fBTParallelNode:onComplete(state)

for _,node in ipairs(self.kids)do
node:onComplete(state)
end
end

function fBTParallelNode:onDespawn()
self.state=fBTNodeState.inactive
self.enable=false
for _,node in ipairs(self.kids)do
node:onDespawn()
end
self.kids=nil
fBTNodePool.recycle(self)
end

