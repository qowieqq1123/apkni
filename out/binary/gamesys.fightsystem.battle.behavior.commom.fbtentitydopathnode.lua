


registry_pool_class(fBTNodeTypo.EntityDoPath,'fBTEntityDoPathNode',fBTBaseNode)

function fBTEntityDoPathNode:__init(guid)
self.typo=fBTNodeTypo.EntityDoPath
end

function fBTEntityDoPathNode:parser(rawData)
self.points=fBTHelper.listVector3(rawData,1)
self.duration=rawData[2]
self.ease=rawData[3]
self.pathType=rawData[4]
self.mustExt=rawData[5]
end



function fBTEntityDoPathNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTEntityDoPathNode:start()

self.state=fBTNodeState.running
self.entity:setPosition(self.points[1])
self.tween=Lua.DOTweenProxyExtensions.DoPath(self.entity.entObj.transform,
self.points,self.duration,DG.Tweening.PathType.IntToEnum(self.pathType))
self.tween:SetEase(DG.Tweening.Ease.IntToEnum(self.ease))
self.tween:OnComplete(function()
self:onTweenComplete()
end)
end


function fBTEntityDoPathNode:update(delta)

return self.state
end


function fBTEntityDoPathNode:onDespawn()
self.entity=nil
self:killTween()
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

function fBTEntityDoPathNode:onTweenComplete()
self.state=fBTNodeState.success
end

function fBTEntityDoPathNode:onComplete()

if self.mustExe and not self.isExe then
self:killTween()
self.state=fBTNodeState.success
self.entity:setPosition(self.points[#self.points])
end
end

function fBTEntityDoPathNode:killTween()
if self.tween then
self.tween:Kill()
self.tween=nil
end
end
