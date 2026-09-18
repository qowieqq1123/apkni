


registry_pool_class(fBTNodeTypo.PlayCommonMoveEffect,'fBTPlayCommonMoveEffectNode',fBTBaseNode)

function fBTPlayCommonMoveEffectNode:__init(guid)
self.typo=fBTNodeTypo.PlayCommonMoveEffect
end

function fBTPlayCommonMoveEffectNode:parser(rawData)
self.effectID=rawData[1]
self.startPos=fBTHelper.vector3(rawData,2)
self.endPos=fBTHelper.vector3(rawData,5)
self.speed=rawData[8]
self.lifeTime=rawData[9]
self.removeOnComplete=rawData[10]
self.scale=fBTHelper.vector3(rawData,11)
end



local stopEffect=CS.GameInterface.StopEffect
local playEffect=CS.GameInterface.PlayEffect
local SleepEffect=CS.GameInterface.SleepEffect

function fBTPlayCommonMoveEffectNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTPlayCommonMoveEffectNode:start()

self:play()
end


function fBTPlayCommonMoveEffectNode:update(delta)
if self.needRemove then
self.lifeTime=self.lifeTime-delta
if self.lifeTime<0 then
SleepEffect(self.moveEffectHandle,true)
self.moveEffectHandle=nil
self.state=fBTNodeState.success
end
end
return self.state
end


function fBTPlayCommonMoveEffectNode:play()
self.effectEnt=CS.EntityManager.Instance:Add3DEntity(0,nil)
self.effectEnt.transform.position=self.startPos
self.removeTime=Vector3.Distance(self.startPos,self.endPos)/self.speed+0.5
self.moveEffectHandle=self.effectEnt:PlayEffect(self.effectID,Vector3.zero,self.scale or Vector3.one,true,true)
self.effectEnt:MoveTo(self.endPos,false,Vector3.Distance(self.startPos,self.endPos)/self.speed,1,nil)

if self.lifeTime>0 then
self.needRemove=true
self.state=fBTNodeState.running
else
self.state=fBTNodeState.success
end
end


function fBTPlayCommonMoveEffectNode:onDespawn()
if self.removeOnComplete and self.moveEffectHandle then
SleepEffect(self.moveEffectHandle,true)
end

if self.effectEnt~=nil then
CS.EntityManager.Instance:RemoveEntity(self.effectEnt.GUID,self.removeTime)
self.effectEnt=nil
end
self.moveEffectHandle=nil
self.needRemove=false
self.entity=nil
self.effectID=0
self.delayTime=0
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

