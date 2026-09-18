


registry_pool_class(fBTNodeTypo.SetEntityColor,'fBTSetEntityColorNode',fBTBaseNode)

function fBTSetEntityColorNode:__init(guid)
self.typo=fBTNodeTypo.SetEntityColor
end

function fBTSetEntityColorNode:parser(rawData)
self.fadeColor=fBTHelper.color4(rawData,1)
self.duration=rawData[5]
self.mustExt=rawData[6]
end




function fBTSetEntityColorNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
self.hasExed=false
end

function fBTSetEntityColorNode:start()
self:doAction()
self.state=fBTNodeState.success
end

function fBTSetEntityColorNode:update()
return self.state
end

function fBTSetEntityColorNode:doAction()
if not self.hasExed then
self.hasExed=true
if self.entity~=nil then
self.entity:fadeToColor(self.fadeColor,self.duration)
end
end
end

function fBTSetEntityColorNode:onComplete()

if self.mustExt then
self:doAction()
end
end

function fBTSetEntityColorNode:onDespawn()
self.entity=nil
self.duration=0
self.hasExed=false
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end


