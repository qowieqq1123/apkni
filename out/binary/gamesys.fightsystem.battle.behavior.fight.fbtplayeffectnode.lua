


registry_pool_class(fBTNodeTypo.PlayEffect,'fBTPlayEffectNode',fBTBaseNode)

function fBTPlayEffectNode:__init(guid)
self.typo=fBTNodeTypo.PlayEffect
end

function fBTPlayEffectNode:parser(rawData)
self.effectID=rawData[1]
self.posType=rawData[2]
self.offset=fBTHelper.vector3(rawData,3)
self.delayTime=rawData[6]
self.attach=rawData[7]
self.removeOnComplete=rawData[8]
self.scale=fBTHelper.vector3(rawData,9)
self.hangPoint=rawData[12]
end



local stopEffect=CS.GameInterface.StopEffect
function fBTPlayEffectNode:awake(bt,rawData)

self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end

function fBTPlayEffectNode:start()
self.state=fBTNodeState.running
end


function fBTPlayEffectNode:update(delta)
self.delayTime=self.delayTime-delta
if self.delayTime<=0 then
self:play()
end
return self.state
end

function fBTPlayEffectNode:play()

if self.entity~=nil and self.entity.battle~=nil then
self.battle=self.entity.battle
end
if self.hangPoint~=nil and self.hangPoint~=""then
self.handle=self.entity:playEffectOnActor(self.effectID,self.hangPoint,self.offset,self.scale)
elseif self.attach and self.posType==ePosTypo.Self then
self.handle=self.entity:playEffect(self.effectID,self.offset,self.attach,false,self.scale)
else

if self.posType==ePosTypo.TargetTeamUnit then
self.handleList={}
local posList,isLeft=fBTHelper.getEffectPos(self,self.posType)
for i,pos in ipairs(posList)do
pos=pos+fBTHelper.fixOffset(self.entity:getFlipX(),self.offset)+fBTHelper.posOffset
self.handleList[i]=fightManager.playEffect(self.effectID,pos,self.entity:getFlipX(),self.scale)

if self.battle then
self.battle.effectHandleList[self.handleList[i]]=self.handleList[i]
end
end
else
local pos,isLeft=fBTHelper.getEffectPos(self,self.posType)
pos=pos+fBTHelper.fixOffset(self.entity:getFlipX(),self.offset)+fBTHelper.posOffset
self.handle=fightManager.playEffect(self.effectID,pos,self.entity:getFlipX(),self.scale)

if self.battle then
self.battle.effectHandleList[self.handle]=self.handle
end
end
end



self.state=fBTNodeState.success
end

function fBTPlayEffectNode:onDespawn()
if self.removeOnComplete then
if self.handle then
if self.hangPoint~=nil and self.hangPoint~=""then
self.entity:removeEffectOnActor(self.handle)
else
stopEffect(self.handle)
end

if self.battle~=nil then
self.battle.effectHandleList[self.handle]=nil
end
end

if self.handleList then
for i,handle in pairs(self.handleList)do
stopEffect(handle)
if self.battle~=nil then
self.battle.effectHandleList[handle]=nil
end
end
end


end
self.entity=nil
self.battle=nil
self.effectID=0
self.delayTime=0
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end