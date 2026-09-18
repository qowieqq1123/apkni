


registry_pool_class(fBTNodeTypo.WorldCameraLookAt,'fBTWorldCameraLookAtNode',fBTBaseNode)

function fBTWorldCameraLookAtNode:__init(guid)
self.typo=fBTNodeTypo.WorldCameraLookAt
end

function fBTWorldCameraLookAtNode:parser(rawData)
self.duration=rawData[1]
self.height=rawData[2]
self.target=fBTHelper.vector3(rawData,3)
self.ease=rawData[6]
self.mustExt=rawData[7]
end



function fBTWorldCameraLookAtNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTWorldCameraLookAtNode:start()


local callback=function()
self.state=fBTNodeState.success
end

worldController:lookAtPosition_Duration(self.target,self.height,self.duration,callback,DG.Tweening.Ease.IntToEnum(self.ease))
self.state=fBTNodeState.running
end


function fBTWorldCameraLookAtNode:update(delta)

return self.state
end


function fBTWorldCameraLookAtNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

function fBTWorldCameraLookAtNode:onComplete()

if self.mustExe and not self.isExe then
self.state=fBTNodeState.success
worldController:lookAtPosition(self.target,self.height,true)
end
end
