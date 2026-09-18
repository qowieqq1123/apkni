


registry_pool_class(fBTNodeTypo.FightTeamPosOffset,'fBTFightTeamPosOffsetNode',fBTBaseNode)

function fBTFightTeamPosOffsetNode:__init(guid)
self.typo=fBTNodeTypo.FightTeamPosOffset
end

function fBTFightTeamPosOffsetNode:parser(rawData)
self.speed=rawData[1]
self.offset=rawData[2]
self.mustExe=rawData[3]
end



function fBTFightTeamPosOffsetNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTFightTeamPosOffsetNode:start()
self.isExe=true
self:moveImp()
end

function fBTFightTeamPosOffsetNode:moveImp()
local battle=self.entity:getBattle()
local entities=battle:getEntities()
self.moveTime=0
if self.speed==0 then
for i,ent in pairs(entities)do
ent:setBattlePosOffset(self.offset)
if ent.entObj then
local dstPos=ent:getLogicPosition()
ent.entObj.transform.localPosition=dstPos
end
end
self.isMoving=nil
self.state=fBTNodeState.success
else
if self.offset==0 then
for i,ent in pairs(entities)do
ent:setBattlePosOffset(self.offset)
if ent.entObj and ent.name~=eSpEntityName.eEmpty then
local dstPos=ent:getLogicPosition()
local curPos=ent:getPosition()
local distance=Vector3.Distance(dstPos,curPos)
self.duration=distance/self.speed
ent:moveTo(dstPos,false,self.duration,1,nil)
end
end
else
self.duration=self.offset/self.speed
for i,ent in pairs(entities)do
local curPos=ent:getPosition()
local dstPos=Vector3.New(curPos.x,curPos.y,curPos.z)
if ent:isLeft()then
dstPos.x=dstPos.x-self.offset
else
dstPos.x=dstPos.x+self.offset
end
ent:moveTo(dstPos,false,self.duration,1,nil)
end

end
self.isMoving=true
self.state=fBTNodeState.running
end
end


function fBTFightTeamPosOffsetNode:update(delta)

if self.isMoving then
self.moveTime=self.moveTime+delta
if self.moveTime>=self.duration then
self.state=fBTNodeState.success
self.isMoving=false
end
end
return self.state
end

function fBTFightTeamPosOffsetNode:onComplete()
if self.mustExe and not self.isExe then
self.state=fBTNodeState.success
local battle=self.entity:getBattle()
local entities=battle:getEntities()
for i,ent in pairs(entities)do
if ent.entObj then
local dstPos=ent:getLogicPosition()
ent.entObj.transform.localPosition=dstPos
end
end
end

self.isMoving=false
end


function fBTFightTeamPosOffsetNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
self.moveTime=0
self.isMoving=nil
self.duration=nil
fBTNodePool.recycle(self)
end

