


registry_pool_class(fBTNodeTypo.EntityMovePath,'fBTEntityMovePathNode',fBTBaseNode)

function fBTEntityMovePathNode:__init(guid)
self.typo=fBTNodeTypo.EntityMovePath
end

function fBTEntityMovePathNode:parser(rawData)
self.points=fBTHelper.listVector3(rawData,1)
self.speed=rawData[2]
self.pathType=rawData[3]
self.ease=rawData[4]
self.mustExt=rawData[5]
self.faceTo=rawData[6]
end



function fBTEntityMovePathNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTEntityMovePathNode:start()


local onFinish=function()
self.state=fBTNodeState.success
self.isMoving=false
end
self.isMoving=true
self.isExe=true
self.state=fBTNodeState.running

if self.entity then
local logicPos=self.entity:getLogicPosition()
if self.entity.entObj~=nil then
self.transform=self.entity.entObj.transform
self.transform.localPosition=self.points[1]+logicPos


self.duration=0
for i=1,#self.points do
self.points[i]=self.points[i]+logicPos
if self.points[i+1]then
local distance=Vector3.Distance(self.points[i],self.points[i+1]+logicPos)
self.duration=self.duration+distance/self.speed
end
end

self.tween=Lua.DOTweenProxyExtensions.DoLocalPath(self.transform,
self.points,self.duration,DG.Tweening.PathType.IntToEnum(self.pathType))
self.tween:SetEase(DG.Tweening.Ease.IntToEnum(self.ease))
self.tween:OnComplete(onFinish)
if self.faceTo then
local pos=self.entity:getPosition()
self.entity:flipX(pos.x<self.points[#self.points].x)
end
else
self.state=fBTNodeState.success
end
else
self.state=fBTNodeState.success
end

end


function fBTEntityMovePathNode:update(delta)

return self.state
end

function fBTEntityMovePathNode:onComplete()
if self.mustExe and not self.isExe then
self.state=fBTNodeState.success
if self.entity.entObj then
self.entity.entObj.transform.localPosition=self.points[#self.points]
end
end

self.isMoving=false
end


function fBTEntityMovePathNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

