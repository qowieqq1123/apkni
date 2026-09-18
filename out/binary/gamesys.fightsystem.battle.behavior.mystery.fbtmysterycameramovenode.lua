


registry_pool_class(fBTNodeTypo.MysteryCameraMove,'fBTMysteryCameraMoveNode',fBTBaseNode)

function fBTMysteryCameraMoveNode:__init(guid)
self.typo=fBTNodeTypo.MysteryCameraMove
end

function fBTMysteryCameraMoveNode:parser(rawData)
self.eposType=rawData[1]
self.pos=fBTHelper.vector3(rawData,2)
self.moveSpeed=rawData[5]
self.moveToPlayer=rawData[6]
self.mustExt=rawData[7]
end



local _HexMapManager=CS.HexagonMapManagerInterface

local PosType=
{
worldPos=0,
cellPos=1,
}

function fBTMysteryCameraMoveNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end


function fBTMysteryCameraMoveNode:start()


local onFinish=function()
self.state=fBTNodeState.success
self.isMoving=false
end

self.isMoving=true
self.isExe=true

local curPos=mysteryCameraController.GetCamaraPosition()
local roomID=mysteryRoomModel:get_cur_roomID()
local groundLayer=mysteryRoomModel:get_GroundLayer(roomID)
if self.moveToPlayer then
local playerPos=mysteryPlayerModel:get_player_pos()
local dstPos=_HexMapManager.GetCellCenterWorld(playerPos,groundLayer)
if self.moveSpeed<0 then
mysteryCameraController:setCamaraPosition(dstPos)
else
local distance=Vector3.Distance(dstPos,curPos)
self.duration=distance/self.moveSpeed
mysteryCameraController:setCamaraPositionMove(dstPos,self.duration,nil,nil,onFinish,true)
end
else
if self.eposType==PosType.cellPos then
local dstPos=_HexMapManager.GetCellCenterWorld(self.pos,groundLayer)
if self.moveSpeed<0 then
mysteryCameraController:setCamaraPosition(dstPos)
else
local distance=Vector3.Distance(dstPos,curPos)
self.duration=distance/self.moveSpeed
mysteryCameraController:setCamaraPositionMove(dstPos,self.duration,nil,nil,onFinish,true)
end
else
if self.moveSpeed<0 then
mysteryCameraController:setCamaraPosition(self.pos)
else
local distance=Vector3.Distance(self.pos,curPos)
self.duration=distance/self.moveSpeed
mysteryCameraController:setCamaraPositionMove(self.pos,self.duration,nil,nil,onFinish,true)
end
end
end

self.state=fBTNodeState.running
end

function fBTMysteryCameraMoveNode:onComplete()
if self.mustExt and not self.isExe then
self.state=fBTNodeState.success
mysteryCameraController:setCamaraPosition(self.pos)
end

self.isMoving=false
end

function fBTMysteryCameraMoveNode:update(delta)

return self.state
end


function fBTMysteryCameraMoveNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

