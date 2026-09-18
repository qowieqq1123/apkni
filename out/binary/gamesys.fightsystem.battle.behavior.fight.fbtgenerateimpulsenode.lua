


registry_pool_class(fBTNodeTypo.GenerateImpulse,'fBTGenerateImpulseNode',fBTBaseNode)

function fBTGenerateImpulseNode:__init(guid)
self.typo=fBTNodeTypo.GenerateImpulse
end

function fBTGenerateImpulseNode:parser(rawData)
self.shakeTypo=rawData[1]
self.velocity=fBTHelper.vector3(rawData,2)
self.frequency=rawData[5]
self.randomize=rawData[6]
self.attackTime=rawData[7]
self.sustainTime=rawData[8]
self.decayTime=rawData[9]
self.stopOnComplete=rawData[10]
end



function fBTGenerateImpulseNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
self.time=0
end

function fBTGenerateImpulseNode:start()
if self.entity~=nil then
self.velocity=self.entity:fixOffset(self.velocity)
end
self.time=0
fightManager.genImpulse(self.shakeTypo,self.velocity,1.0,self.frequency,self.randomize,self.attackTime,self.sustainTime,self.decayTime)
self.state=fBTNodeState.success
end


function fBTGenerateImpulseNode:update(delta)
self.time=self.time+delta
return self.state
end

function fBTGenerateImpulseNode:onComplete()
if self.stopOnComplete then
local total=self.attackTime+self.sustainTime+self.decayTime
local leftTime=total-self.time

if leftTime>0 then
fightManager.genImpulse(self.shakeTypo,self.velocity,0,self.frequency,self.randomize,0,0,0)
end
end

end