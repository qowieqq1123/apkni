


registry_pool_class(fBTNodeTypo.CameraShake,'fBTCameraShakeNode',fBTBaseNode)

function fBTCameraShakeNode:__init(guid)
self.typo=fBTNodeTypo.CameraShake
end

function fBTCameraShakeNode:parser(rawData)
self.shakeType=rawData[1]
self.duration=rawData[2]
self.strength=fBTHelper.vector3(rawData,3)
self.vibrato=rawData[6]
self.randomness=rawData[7]
self.fadeOut=rawData[8]
end



function fBTCameraShakeNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end

function fBTCameraShakeNode:start()
if self.shakeType==1 then
fightManager.shakePosition(self.duration,self.strength,self.vibrato,self.randomness,self.fadeOut)
else
fightManager.shakeRotation(self.duration,self.strength,self.vibrato,self.randomness,self.fadeOut)
end
self.state=fBTNodeState.success
end


function fBTCameraShakeNode:update(delta)
return self.state
end



