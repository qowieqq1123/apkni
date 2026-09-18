


registry_pool_class(fBTNodeTypo.SetStageState,'fBTSetStageStateNode',fBTBaseNode)

function fBTSetStageStateNode:__init(guid)
self.typo=fBTNodeTypo.SetStageState
end

function fBTSetStageStateNode:parser(rawData)
self.nStateID=rawData[1]
self.mustExe=rawData[2]
end




function fBTSetStageStateNode:awake(bt,rawData)
self.behaviorTree=bt
self:parser(rawData)
self.hasExe=false
end

function fBTSetStageStateNode:start()
self:doAction()
self.state=fBTNodeState.success
end


function fBTSetStageStateNode:doAction()
if not self.hasExe then
self.hasExe=true
fightManager.setState(self.nStateID)
end
end

function fBTSetStageStateNode:update(delta)

return self.state
end

function fBTSetStageStateNode:onComplete()
if self.mustExe then
self:doAction()
end
end


function fBTSetStageStateNode:onDespawn()
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end


