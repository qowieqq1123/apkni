


registry_pool_class(fBTNodeTypo.ShowScreenEffect,'fBTShowScreenEffectNode',fBTBaseNode)

function fBTShowScreenEffectNode:__init(guid)
self.typo=fBTNodeTypo.ShowScreenEffect
end

function fBTShowScreenEffectNode:parser(rawData)
self.opType=rawData[1]
self.speed=rawData[2]
self.fre=rawData[3]
self.am=rawData[4]
self.mustExe=rawData[5]
end



function fBTShowScreenEffectNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTShowScreenEffectNode:doEffect()
local effectObj=fightManager.getScreenEffect()
if self.opType==1 then
effectObj:setWiggle(true,self.speed,self.fre,self.am)
elseif self.opType==2 then
effectObj:enableIndexEffect(false,fBTScreenEffectTypo.Wiggle)
end
end


function fBTShowScreenEffectNode:start()

self.isExe=true
self:doEffect()
self.state=fBTNodeState.success
end


function fBTShowScreenEffectNode:update(delta)

return self.state
end

function fBTEntityMoveToNode:onComplete()
if self.mustExe and not self.isExe then
self.state=fBTNodeState.success
self:doEffect()
end
end


function fBTShowScreenEffectNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

