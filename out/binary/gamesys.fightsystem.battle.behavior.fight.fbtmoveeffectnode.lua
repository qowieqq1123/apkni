


registry_pool_class(fBTNodeTypo.MoveEffect,'fBTMoveEffectNode',fBTBaseNode)

function fBTMoveEffectNode:__init(guid)
self.typo=fBTNodeTypo.MoveEffect
end

function fBTMoveEffectNode:parser(rawData)
self.effectID=rawData[1]
self.offset=fBTHelper.vector3(rawData,2)
self.endEffectID=rawData[5]
self.endOffset=fBTHelper.vector3(rawData,6)
self.speed=rawData[9]
self.flyOut=rawData[10]
self.scale=fBTHelper.vector3(rawData,11)
self.endScale=fBTHelper.vector3(rawData,14)
self.posType=rawData[17]
self.usePosType=rawData[18]
self.isReverse=rawData[19]
end



local stopEffect=CS.GameInterface.StopEffect
local sleepEffect=CS.GameInterface.SleepEffect
function fBTMoveEffectNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
self.removeTime=0
end

function fBTMoveEffectNode:start()


self.effectEnt=CS.EntityManager.Instance:Add3DEntity(0,nil)
self.moveEffectHandle=self.effectEnt:PlayEffect(self.effectID,fBTHelper.posOffset,self.scale or Vector3.one,true,true)

local battle=self.entity.battle
local srcEntID=self.behaviorTree:getSharedValue("startEntID")
local srcEnt=battle:getEntity(srcEntID)or self.entity



local dstEntID=self.behaviorTree:getSharedValue("endEntID")
local dstEnt=battle:getEntity(dstEntID)or self.entity
local dstPos
local pos
if self.isReverse then
dstPos=srcEnt:getHitedPos()
pos=dstEnt:getHitedPos()+srcEnt:fixOffset(self.offset)
else
dstPos=dstEnt:getHitedPos()
pos=srcEnt:getHitedPos()+dstEnt:fixOffset(self.offset)
end

if self.usePosType then
local _pos,isLeft=fBTHelper.getEffectPos(self,self.posType)
dstPos=_pos+fBTHelper.posOffset
end

self.effectEnt.transform.position=pos
local moveEnt=self.effectEnt
local handle=self.moveEffectHandle
local onComplete=function()

if handle~=nil then
sleepEffect(handle,true)
handle=nil
end

if moveEnt~=nil then
CS.EntityManager.Instance:RemoveEntity(moveEnt.GUID,0.2)
moveEnt=nil
end

self.state=fBTNodeState.success
end

local onHit=function()
if self.endEffectID~=-1 and self.endEffectID~=0 then
fightManager.playEffect(self.endEffectID,dstPos+fBTHelper.posOffset+self.endOffset,self.entity:getFlipX(),self.scale)
end

if self.flyOut then
local delta=dstPos-pos
delta=delta:Normalize()
local endPos=dstPos+delta*20+fBTHelper.posOffset
self.removeTime=19/self.speed
self.effectEnt:MoveTo(endPos,false,Vector3.Distance(endPos,dstPos)/self.speed,1,onComplete)
self.state=fBTNodeState.success
else
onComplete()
end
end

self.effectEnt:MoveTo(dstPos,true,Vector3.Distance(pos,dstPos)/self.speed,1,onHit)
self.state=fBTNodeState.running

end


function fBTMoveEffectNode:update(delta)
return self.state
end


function fBTMoveEffectNode:onDespawn()
self.entity=nil
self.effectID=0

if self.moveEffectHandle~=nil and not self.flyOut then
stopEffect(self.moveEffectHandle)
end
self.moveEffectHandle=nil

if self.effectEnt~=nil then
CS.EntityManager.Instance:RemoveEntity(self.effectEnt.GUID,self.removeTime)
self.effectEnt=nil
end
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end


