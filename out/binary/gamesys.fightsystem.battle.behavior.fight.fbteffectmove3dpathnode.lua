


registry_pool_class(fBTNodeTypo.EffectMove3DPath,'fBTEffectMove3DPathNode',fBTBaseNode)

function fBTEffectMove3DPathNode:__init(guid)
self.typo=fBTNodeTypo.EffectMove3DPath
end

function fBTEffectMove3DPathNode:parser(rawData)
self.effectID=rawData[1]
self.startOffset=fBTHelper.vector3(rawData,2)
self.ease=rawData[5]
self.isRotated=rawData[6]
self.dstPosType=rawData[7]
self.pathType=rawData[8]
self.offsetStartRadiu=rawData[9]
self.offsetEndRadiu=rawData[10]
self.offsetStartPersent=rawData[11]
self.offsetEndPersent=rawData[12]
self.offsetStartAngle=rawData[13]
self.offsetEndAngle=rawData[14]
self.endEffectID=rawData[15]
self.speed=rawData[16]
self.scale=fBTHelper.vector3(rawData,17)
self.endScale=fBTHelper.vector3(rawData,20)
end



local sleepEffect=CS.GameInterface.SleepEffect
function fBTEffectMove3DPathNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)

self.offsetRadiu=math.random(self.offsetStartRadiu*100,self.offsetEndRadiu*100)
self.offsetPersent=math.random(self.offsetStartPersent*100,self.offsetEndPersent*100)

self.offsetAngle=math.random(self.offsetStartAngle,self.offsetEndAngle)
if not self.entity:getFlipX()then
self.offsetAngle=self.offsetAngle-180
end
self.paras={[1]=4,[2]=self.speed*100,[3]=self.ease,[4]=self.isRotated,[5]=self.pathType,[6]=self.offsetRadiu,[7]=self.offsetPersent,[8]=self.offsetAngle}
end

function fBTEffectMove3DPathNode:start()
local battle=self.entity.battle
local srcEntID=self.behaviorTree:getSharedValue("startEntID")

local dstEntID=self.behaviorTree:getSharedValue("endEntID")
if dstEntID==nil then
local targets=self.behaviorTree:getSharedValue('targets')or{}
dstEntID=next(targets)
end

local dstEnt=battle:getEntity(dstEntID)or self.entity
local dstPos=nil
if self.dstPosType==ePosTypo.Hited then
dstPos=dstEnt:getHitedPos()
else
dstPos=fBTHelper.getEffectPos(self,self.dstPosType)
end

local srcEnt=battle:getEntity(srcEntID)or self.entity
local srcPos=srcEnt:getHitedPos()+dstEnt:fixOffset(self.startOffset)
local onComplete=function(pos)
self.state=fBTNodeState.success
if self.endEffectID~=-1 then
if self.dstPosType==ePosTypo.Hited then
fightManager.playEffect(self.endEffectID,dstPos+fBTHelper.posOffset,dstEnt:getFlipX(),self.endScale)
else
dstEnt:playEffect(self.endEffectID,Vector3.zero,true,false,self.endScale)
end
end
end

fightManager.playMoveEffect(self.effectID,self.paras,srcPos,dstPos,onComplete,self.scale)
self.state=fBTNodeState.running
end


function fBTEffectMove3DPathNode:update(delta)
return self.state
end


function fBTEffectMove3DPathNode:onDespawn()
self.entity=nil
self.effectID=0
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end
