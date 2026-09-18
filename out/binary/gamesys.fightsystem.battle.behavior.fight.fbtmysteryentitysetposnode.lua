


registry_pool_class(fBTNodeTypo.MysteryEntitySetPos,'fBTMysteryEntitySetPosNode',fBTBaseNode)

function fBTMysteryEntitySetPosNode:__init(guid)
self.typo=fBTNodeTypo.MysteryEntitySetPos
end

function fBTMysteryEntitySetPosNode:parser(rawData)
self.dstPos=fBTHelper.vector3(rawData,1)
self.speed=rawData[4]
self.posType=rawData[5]
self.mustExe=rawData[6]
end



local posType=
{
localPos=1,
grid=2,
relativePlayer=3,
}

function fBTMysteryEntitySetPosNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTMysteryEntitySetPosNode:start()

self.state=fBTNodeState.success


end



function fBTMysteryEntitySetPosNode:start()
local onFinish=function()
self.state=fBTNodeState.success
self.isMoving=false
self.isExe=false
end
self.state=fBTNodeState.running
self.isMoving=true
self.isExe=true
local roomId=mysteryRoomModel:get_cur_roomID()
local ground=mysteryRoomModel:get_GroundLayer(roomId)
local guid=self.entity.guid
local oriWorldPos=Vector3.zero
local entity=mysteryEntityBase:get_entity_all(guid)

if entity then
local pos=entity.pos
oriWorldPos=_HexMapManager.GetCellCenterWorld(pos,ground,false)
else
return
end

if self.posType==posType.localPos then
local curPos=oriWorldPos
self.dstPos=oriWorldPos+self.dstPos
if self.speed>0 then
local distance=Vector3.Distance(self.dstPos,curPos)
self.duration=distance/self.speed

self.tween=Lua.DOTweenProxyExtensions.DOMove(self.entity.entObj.transform,
self.dstPos,self.duration)
self.tween:SetEase(DG.Tweening.Ease.IntToEnum(self.ease))
self.tween:OnComplete(onFinish)
else
self.entity.entObj.transform.position=self.dstPos
self.isExe=false
self.state=fBTNodeState.success
end

elseif self.posType==posType.grid then


local gridWorldPos=_HexMapManager.GetCellCenterWorld(self.dstPos,ground,false)

if self.speed>0 then
local curPos=self.entity.entObj.transform.position
local distance=Vector3.Distance(gridWorldPos,curPos)
self.duration=distance/self.speed

self.tween=Lua.DOTweenProxyExtensions.DOLocalMove(self.entity.entObj.transform,
gridWorldPos,self.duration)
self.tween:SetEase(DG.Tweening.Ease.IntToEnum(self.ease))
self.tween:OnComplete(onFinish)
else
self.entity.entObj.transform.position=gridWorldPos
self.isExe=false
self.state=fBTNodeState.success
end
end

local curPos=self.entity:getPosition()
local distance=Vector3.Distance(self.dstPos,curPos)
self.duration=distance/self.speed
self.entity:moveTo(self.dstPos,false,self.duration,1,onFinish)
if self.faceTo then
local pos=self.entity:getPosition()
self.entity:flipX(pos.x<self.dstPos.x)
end


end

function fBTMysteryEntitySetPosNode:update(delta)
return self.state
end

function fBTMysteryEntitySetPosNode:onComplete()
if self.mustExe and not self.isExe then
self.state=fBTNodeState.success
self.entity:moveTo(self.dstPos,false,0.1,1,nil)
end

self.isMoving=false
end


function fBTMysteryEntitySetPosNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

