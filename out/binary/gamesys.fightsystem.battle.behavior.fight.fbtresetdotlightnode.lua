


registry_pool_class(fBTNodeTypo.ResetDotLight,'fBTResetDotLightNode',fBTBaseNode)

function fBTResetDotLightNode:__init(guid)
self.typo=fBTNodeTypo.ResetDotLight
end

function fBTResetDotLightNode:parser(rawData)
self.duraion=rawData[1]
self.waitEnd=rawData[2]
end



function fBTResetDotLightNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end

function fBTResetDotLightNode:start()
self.time=0
fightManager.resetDotLight(self.duraion)
if self.waitEnd then
self.state=fBTNodeState.running
else
self.state=fBTNodeState.success
end
end


function fBTResetDotLightNode:update(delta)
self.time=self.time+delta
if self.time>=self.duraion then
self.state=fBTNodeState.success
end
return self.state
end


