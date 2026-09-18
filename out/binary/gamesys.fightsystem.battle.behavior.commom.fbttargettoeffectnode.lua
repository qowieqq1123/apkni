


registry_pool_class(fBTNodeTypo.TargetToEffect,'fBTTargetToEffectNode',fBTBaseNode)

function fBTTargetToEffectNode:__init(guid)
self.typo=fBTNodeTypo.TargetToEffect
end

function fBTTargetToEffectNode:parser(rawData)
self.effectID=rawData[1]
self.offset=fBTHelper.vector3(rawData,2)
self.scale=fBTHelper.vector3(rawData,5)
end



function fBTTargetToEffectNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTTargetToEffectNode:start()

self.effectEnt=CS.EntityManager.Instance:Add3DEntity(0,nil)
self.moveEffectHandle=self.effectEnt:PlayEffect(self.effectID,fBTHelper.posOffset,self.scale or Vector3.one,true,true)

local battle=self.entity.battle
local srcEntID=self.behaviorTree:getSharedValue("startEntID")
local srcEnt=battle:getEntity(srcEntID)or self.entity

local dstEntID=self.behaviorTree:getSharedValue("endEntID")
local dstEnt=battle:getEntity(dstEntID)or self.entity
local dstPos=dstEnt:getHitedPos()
local pos=srcEnt:getHitedPos()+dstEnt:fixOffset(self.offset)
self.effectEnt.transform.position=pos








self.effectEnt.transform:LookAt(dstEnt.entObj.transform,Vector3.up)
self.effectEnt.transform:Rotate(self.effectEnt.transform.up,-90)

self.removeTime=5
self.state=fBTNodeState.success
end


function fBTTargetToEffectNode:update(delta)

return self.state
end


function fBTTargetToEffectNode:onDespawn()
if self.effectEnt~=nil then
CS.EntityManager.Instance:RemoveEntity(self.effectEnt.GUID,self.removeTime)
self.effectEnt=nil
end
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

