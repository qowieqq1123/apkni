


registry_pool_class(fBTNodeTypo.PlayCommonEffect,'fBTPlayCommonEffectNode',fBTBaseNode)

function fBTPlayCommonEffectNode:__init(guid)
self.typo=fBTNodeTypo.PlayCommonEffect
end

function fBTPlayCommonEffectNode:parser(rawData)
self.effectID=rawData[1]
self.pos=fBTHelper.vector3(rawData,2)
self.lifeTime=rawData[5]
self.delayTime=rawData[6]
self.removeOnComplete=rawData[7]
self.scale=fBTHelper.vector3(rawData,8)
end



local stopEffect=CS.GameInterface.StopEffect
local playEffect=CS.GameInterface.PlayEffect
local SleepEffect=CS.GameInterface.SleepEffect


function fBTPlayCommonEffectNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
self.needRemove=false
end

function fBTPlayCommonEffectNode:start()
self:play()
end


function fBTPlayCommonEffectNode:update(delta)
if self.needRemove then
self.lifeTime=self.lifeTime-delta
if self.lifeTime<0 then
SleepEffect(self.handle,true)
self.handle=nil
self.state=fBTNodeState.success
end
end
return self.state
end

function fBTPlayCommonEffectNode:play()

self.handle=playEffect(self.effectID,self.pos,self.scale or Vector3.one,self.delayTime)
if self.lifeTime>0 then
self.needRemove=true
self.state=fBTNodeState.running
else
self.state=fBTNodeState.success
end
end

function fBTPlayCommonEffectNode:onDespawn()
if self.removeOnComplete and self.handle then
stopEffect(self.handle)
end
self.handle=nil
self.needRemove=false
self.entity=nil
self.effectID=0
self.delayTime=0
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end


