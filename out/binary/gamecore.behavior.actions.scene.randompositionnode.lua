









randomPositionNode=simple_class(baseNode)

local _directionList={
cellDirection.Forward,
cellDirection.Right,
cellDirection.Back,
cellDirection.Left,
}

local _directionsLen=#_directionList
local _try_count=4
local _find_radius=5

function randomPositionNode:getBirthPoint()
local args=self:getArgs()
if args==nil then
logErr('getBirthPoint args is nil')
return
end
if aiManager:isDZDying(args.dzId)then
return self:getSharedVar('birthPoint')
else
return _MapManager.GetTilemapObjectPosition(args.stId)
end
end

function randomPositionNode:init()
self.directionIndex=math.random(1,_directionsLen)
self.spos=self:getData('cpos')
if not self.spos then
self.spos=self:getBirthPoint()
end
end

function randomPositionNode:getObjectMapID(stId)
return aiManager:getAIMapID(stId)or _MapManager.GetObjectMapID(stId)
end

function randomPositionNode:getNextPos(cfgId)
if self.directionIndex==0 then
self.directionIndex=self.directionIndex+_directionsLen
end
self.directionIndex=self.directionIndex+math.random(-1,1)
local index=math.fmod(self.directionIndex,_directionsLen)+1
local dir=_directionList[index]
local args=self:getArgs()
local entPos=_MapManager.GetTilemapObjectPosition(args.stId)
local mapId=self:getObjectMapID(args.stId)
local pos=_MapManager.GetNearbyPositionByDirection(mapId,entPos,dir,1,cfgId)
return pos
end

function randomPositionNode:findAPosCanMove(cfgId)
local args=self:getArgs()
if not args or not args.stId then

return nil
end

local mapId=self:getObjectMapID(args.stId)
for i=1,_try_count do
local pos=self:getNextPos(cfgId)
if _MapManager.IsCanMove(mapId,pos,cfgId)then
return pos
end
end
local entPos=_MapManager.GetTilemapObjectPosition(args.stId)
local pathCheckId=self:getData('pathCheckId')or-1
local pos=_MapManager.FindAPositionCanMoveTo(mapId,entPos,_find_radius,pathCheckId)
if not _MapManager.IsPositionEqual(pos,entPos)then
return pos
end
return nil
end

function randomPositionNode:update(interval)
local cfgId=self:getData('checkId')or-1
local pos=self:findAPosCanMove(cfgId)
if pos then
local radius=self:getData('radius')
if radius then
if not _MapManager.IsNearbyPosition(self.spos,pos,radius)then
return nodeState.failure
end
end
self:setSharedVar(self:getDataValue('outPos'),pos)
return nodeState.success
else
return nodeState.failure
end
end
