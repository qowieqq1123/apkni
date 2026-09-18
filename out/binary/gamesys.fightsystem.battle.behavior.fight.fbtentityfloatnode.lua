


registry_pool_class(fBTNodeTypo.EntityFloat,'fBTEntityFloatNode',fBTBaseNode)

function fBTEntityFloatNode:__init(guid)
self.typo=fBTNodeTypo.EntityFloat
end

function fBTEntityFloatNode:parser(rawData)
self.upTime=rawData[1]
self.upEase=rawData[2]
self.dstPos=fBTHelper.vector3(rawData,3)
self.stayTime=rawData[6]
self.floatAm=fBTHelper.vector3(rawData,7)
self.floatAmSpeed=rawData[10]
self.downTime=rawData[11]
self.downEase=rawData[12]
end




local PosStateType=
{
None=0,
floatUp=1,
flaoting=2,
floatDown=3,
floatEnd=4,
}

function fBTEntityFloatNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
self.orgPos=self.entity:getPosition()
self.targetPos=self.orgPos+self.dstPos
self.floatTime=0
self.posState=PosStateType.None
end


function fBTEntityFloatNode:start()

self.posState=PosStateType.floatUp
self.entity:moveTo(self.targetPos,false,self.upTime,self.upEase,function()
self.posState=PosStateType.flaoting
self.floatTime=0
if self.entity~=nil then
self.entity:localMove(self.floatAm,1/self.floatAmSpeed)
end
end)
self.state=fBTNodeState.running
end

function fBTEntityFloatNode:update(delta)
self.floatTime=self.floatTime+delta
if self.posState==PosStateType.flaoting then
if self.floatTime>self.stayTime then
self.posState=PosStateType.floatDown
self.entity:stopLocalMove()
self.floatTime=0
self.entity:moveTo(self.orgPos,false,self.downTime,self.downEase,function()
self.posState=PosStateType.floatEnd
self.state=fBTNodeState.success
end)
end
elseif self.posState==PosStateType.floatDown then

if self.floatTime>self.downTime+2 then
self.entity:stopMoveTo()
self.entity:stopLocalMove()
self.entity:setPosition(self.orgPos)
self.posState=PosStateType.floatEnd
self.state=fBTNodeState.success
end
end
return self.state
end


function fBTEntityFloatNode:onDespawn()
self.entity:setPosition(self.entity:getLogicPosition())
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

