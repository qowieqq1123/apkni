


registry_pool_class(fBTNodeTypo.SetStageColor,'fBTSetStageColorNode',fBTBaseNode)

function fBTSetStageColorNode:__init(guid)
self.typo=fBTNodeTypo.SetStageColor
end

function fBTSetStageColorNode:parser(rawData)
self.duration=rawData[1]
self.color=fBTHelper.color4(rawData,2)
end



function fBTSetStageColorNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTSetStageColorNode:start()

fightManager.stageFadeToColor(self.duration,self.color)
self.state=fBTNodeState.success
end


function fBTSetStageColorNode:update(delta)

return self.state
end

function fBTSetStageColorNode:onComplete()
fightManager.stageFadeToColor(0,Color.white)
end


function fBTSetStageColorNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

