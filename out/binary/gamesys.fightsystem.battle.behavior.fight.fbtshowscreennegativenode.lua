


registry_pool_class(fBTNodeTypo.ShowScreenNegative,'fBTShowScreenNegativeNode',fBTBaseNode)

function fBTShowScreenNegativeNode:__init(guid)
self.typo=fBTNodeTypo.ShowScreenNegative
end

function fBTShowScreenNegativeNode:parser(rawData)
self.opType=rawData[1]
self.fadeTime=rawData[2]
self.amount=rawData[3]
self.mustExe=rawData[4]
end



function fBTShowScreenNegativeNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end

function fBTShowScreenNegativeNode:doEffect()
local effectObj=fightManager.getScreenEffect()
effectObj:setNegative(self.opType==1,self.amount,self.fadeTime)
end


function fBTShowScreenNegativeNode:start()
self.isExe=true
self:doEffect()
self.state=fBTNodeState.success
end


function fBTShowScreenNegativeNode:update(delta)

return self.state
end

function fBTEntityMoveToNode:onComplete()
if self.mustExe and not self.isExe then
self.state=fBTNodeState.success
effectObj:setNegative(false,1,0)
end
end


function fBTShowScreenNegativeNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

