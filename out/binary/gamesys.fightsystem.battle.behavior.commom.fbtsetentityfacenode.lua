


registry_pool_class(fBTNodeTypo.SetEntityFace,'fBTSetEntityFaceNode',fBTBaseNode)

function fBTSetEntityFaceNode:__init(guid)
self.typo=fBTNodeTypo.SetEntityFace
end

function fBTSetEntityFaceNode:parser(rawData)
self.faceId=rawData[1]
self.duration=rawData[2]
self.isWait=rawData[3]
self.completedStop=rawData[4]
end



function fBTSetEntityFaceNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTSetEntityFaceNode:start()

if self.duration>0 then
self.state=self.isWait and fBTNodeState.running or fBTNodeState.success
local callback=function()
self:onShowCompleted()
end
self.entity:showExpression(self.faceId,self.duration,self.isWait and callback or nil)
else
self.state=fBTNodeState.success
self.entity:setExpression(self.faceId)
end
end


function fBTSetEntityFaceNode:update(delta)

return self.state
end


function fBTSetEntityFaceNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

function fBTSetEntityFaceNode:onShowCompleted()
self.state=fBTNodeState.success
end

function fBTSetEntityFaceNode:onComplete()
if self.duration>0 and self.isWait and self.completedStop then
self.entity:shopExpressionTimer()
end
end