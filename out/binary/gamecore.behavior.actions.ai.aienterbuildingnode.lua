





aiEnterBuildingNode=simple_class(baseNode)

function aiEnterBuildingNode:init()
self.isMoving=false
self.bComplete=false
end

function aiEnterBuildingNode:broke()
local args=self:getArgs()
if args and isometricMapSystem:isInNormalMode()then
_MapManager.SetTilemapObjectActive(args.stId,true)
end
end

function aiEnterBuildingNode:update(interval)
if self.isMoving then
return nodeState.running
end

if self.bComplete then
return self.checkState
end


local ubdId=self:getData('bdId')
local bdData=zongmenModel:getBuildingData(ubdId)
if not bdData then
self:print('warring','未找到建筑数据',ubdId)
return nodeState.failure
end

local tpos,dpos=isometricMapSystem:getDoorWayPos(bdData)
if not dpos then
return nodeState.failure
end
local args=self:getArgs()
self.isMoving=true
self.checkState=nodeState.running
aiManager:setMoveCMDToDisciple(args.dzId,dpos,1,eAnimationID.walk,function(isBreak)
self.checkState=isBreak and nodeState.failure or nodeState.success
self.isMoving=false
self.bComplete=true
self:quicklyTick()
end)
_MapManager.SetFadeToColor(args.stId,Color.New(1,1,1,0),1,function()
if isometricMapSystem:isInNormalMode()then
_MapManager.SetTilemapObjectActive(args.stId,false)
end
end)
hudControl:setHUDActiveByTarget(args.stId,false)
return self.checkState
end

function aiEnterBuildingNode:skip()
local args=self:getArgs()
if args and isometricMapSystem:isInNormalMode()then
_MapManager.SetTilemapObjectActive(args.stId,false)
end
end