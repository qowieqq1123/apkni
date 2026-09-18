





aiLeaveBuildingNode=simple_class(baseNode)

function aiLeaveBuildingNode:init()
self.isMoving=false
self.bComplete=false
end

function aiLeaveBuildingNode:update(interval)
if self.isMoving then
return nodeState.running
end

if self.bComplete then
return self.checkState
end


local ubdId=self:getData('bdId')
local bdData=zongmenModel:getBuildingData(ubdId)
if not bdData then
self:print('error','未找到建筑数据',ubdId)
return nodeState.failure
end

local tpos,dpos=isometricMapSystem:getDoorWayPos(bdData)
if not tpos then
return nodeState.failure
end
local args=self:getArgs()
self.isMoving=true
self.checkState=nodeState.running
if isometricMapSystem:isInNormalMode()then
_MapManager.SetTilemapObjectActive(args.stId,true)
end
aiManager:setMoveCMDToDisciple(args.dzId,tpos,1,eAnimationID.walk,function(isBreak)
self.checkState=isBreak and nodeState.failure or nodeState.success
self.isMoving=false
self.bComplete=true
self:quicklyTick()
hudControl:setHUDActiveByTarget(args.stId,true)
end)
_MapManager.SetFadeToColor(args.stId,Color.New(1,1,1,1),1,nil)
return self.checkState
end

function aiLeaveBuildingNode:skip()
local args=self:getArgs()
if args and isometricMapSystem:isInNormalMode()then
_MapManager.SetTilemapObjectActive(args.stId,true)
end
end