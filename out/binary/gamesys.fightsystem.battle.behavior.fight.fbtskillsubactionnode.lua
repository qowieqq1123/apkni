


registry_pool_class(fBTNodeTypo.SkillSubAction,'fBTSkillSubActionNode',fBTBaseNode)

function fBTSkillSubActionNode:__init(guid)
self.typo=fBTNodeTypo.SkillSubAction
end

function fBTSkillSubActionNode:parser(rawData)
self.eventTypo=rawData[1]
self.attachPara=rawData[2]
end




function fBTSkillSubActionNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self.eventTypo=rawData[1]
self.attachPara=rawData[2]
self:parser(rawData)
end

function fBTSkillSubActionNode:start()
self.behaviorTree:onBehaviorEvent(self.eventTypo,self.attachPara)
self.state=fBTNodeState.success
end


function fBTSkillSubActionNode:update(delta)
return self.state
end


function fBTSkillSubActionNode:onDespawn()
self.entity=nil
self.behaviorTree=nil

self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end



