


registry_pool_class(fBTNodeTypo.EntityHited,'fBTEntityHitedNode',fBTBaseNode)

function fBTEntityHitedNode:__init(guid)
self.typo=fBTNodeTypo.EntityHited
end

function fBTEntityHitedNode:parser(rawData)
self.speed=rawData[1]
self.ease=rawData[2]
self.offset=fBTHelper.vector3(rawData,3)
end



function fBTEntityHitedNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTEntityHitedNode:start()

self:doMove()
self.state=fBTNodeState.running
end



function fBTEntityHitedNode:update(delta)

return self.state
end


function fBTEntityHitedNode:onDespawn()

if self.entity~=nil and self.state~=fBTNodeState.success then
self.entity:setPosition(self.entity:getLogicPosition())
end
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end



function fBTEntityHitedNode:doMove()
local curPos=self.entity:getLogicPosition()
local dstPos=curPos+self.entity:fixOffset(self.offset)
local distance=Vector3.Distance(dstPos,curPos)
local duration=distance/self.speed

local onMoveOffset=function()

local onFinish=function()
self.state=fBTNodeState.success
end
self.entity:moveTo(curPos,false,duration,1,onFinish)
end
self.entity:moveTo(dstPos,false,duration,self.ease,onMoveOffset)
end