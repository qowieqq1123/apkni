


registry_pool_class(fBTNodeTypo.WorldCameraZoom,'fBTWorldCameraZoomNode',fBTBaseNode)

function fBTWorldCameraZoomNode:__init(guid)
self.typo=fBTNodeTypo.WorldCameraZoom
end

function fBTWorldCameraZoomNode:parser(rawData)
self.duration=rawData[1]
self.speed=rawData[2]
self.mustExt=rawData[3]
end



function fBTWorldCameraZoomNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTWorldCameraZoomNode:start()


self.tick=0;
self.state=fBTNodeState.running
end


function fBTWorldCameraZoomNode:update(delta)

self.tick=self.tick+delta
if self.tick>=self.duration then
self.state=fBTNodeState.success
local deltaTime=delta-(self.tick-self.duration)
worldController:onZoomHandle_atNormal(self.speed,deltaTime)
else
worldController:onZoomHandle_atNormal(self.speed,delta)
end
return self.state
end


function fBTWorldCameraZoomNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

function fBTWorldCameraZoomNode:onComplete()

if self.mustExe and not self.isExe then
self.state=fBTNodeState.success
local deltaTime=self.duration-self.tick
worldController:onZoomHandle_atNormal(self.speed,deltaTime)
end
end
