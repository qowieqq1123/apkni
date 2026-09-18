


registry_pool_class(fBTNodeTypo.SetStageMove,'fBTSetStageMoveNode',fBTBaseNode)

function fBTSetStageMoveNode:__init(guid)
self.typo=fBTNodeTypo.SetStageMove
end

function fBTSetStageMoveNode:parser(rawData)
self.stageIndex=rawData[1]
self.points=fBTHelper.listVector3(rawData,2)
self.duration=rawData[3]
self.pathType=rawData[4]
self.mustExt=rawData[5]
self.ease=rawData[6]
end



function fBTSetStageMoveNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTSetStageMoveNode:start()

self.state=fBTNodeState.running
self.transform=fightManager.getStageTransform(self.stageIndex)
self.transform.localPosition=self.points[1]
self.tween=Lua.DOTweenProxyExtensions.DoLocalPath(self.transform,
self.points,self.duration,DG.Tweening.PathType.IntToEnum(self.pathType))
self.tween:SetEase(DG.Tweening.Ease.IntToEnum(self.ease))
self.tween:OnComplete(function()
self:onTweenComplete()
end)
end


function fBTSetStageMoveNode:update(delta)

return self.state
end


function fBTSetStageMoveNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

function fBTSetStageMoveNode:onTweenComplete()
self.state=fBTNodeState.success
end

function fBTSetStageMoveNode:onComplete()
if self.mustExe and not self.isExe then
self.state=fBTNodeState.success
if self.transform then
self.transform.localPosition=self.points[#self.points]
end
end
end