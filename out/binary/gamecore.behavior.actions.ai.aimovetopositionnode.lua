











aiMoveToPositionNode=simple_class(baseNode)

function aiMoveToPositionNode:init()
self.isMoving=false
self.bComplete=false
self.check=false
self.mapId=nil
end

function aiMoveToPositionNode:broke()
if self.moveBT then
behaviorManager:removeBehaviorTree(self.moveBT)
self.moveBT=nil
end
end

function aiMoveToPositionNode:skip()
local args=self:getArgs()
if self:isRuning()then
_MapManager.StopMove(args.stId,true,false)

_MapManager.RunAnimator(args.stId,eAnimationID.stand)
end
local pos=self:getMoveToPos()
if pos then
if self.moveBT then
aiManager:teleportToMap(args.stId,self.mapId,pos)
else
_MapManager.SetPosition(args.stId,pos)
end
end
return nodeState.success
end

function aiMoveToPositionNode:getMoveToPos()
return self:getSharedVar(self:getDataValue('inPos'))
end

function aiMoveToPositionNode:checkMoveMode(tpos)
local mapId=self:getData('mapId')
if mapId then
local args=self:getArgs()
local smapId=_MapManager.GetObjectMapID(args.stId)
if smapId~=mapId then

self.moveBT=aiManager:createTeleportBT2(args,smapId,mapId,tpos)
end
end
self.mapId=mapId
self.check=true
end

function aiMoveToPositionNode:update(interval)
if not self.check then
local tpos=self:getMoveToPos()
if tpos then
self:checkMoveMode(tpos)
else
self:print('wraning','移动目标位置不存在')
return nodeState.failure
end
end
if self.moveBT then


return self.moveBT:getState()
else
return self:normalMove()
end
end

function aiMoveToPositionNode:normalMove()
if self.isMoving then
if Time.time>self.timeOut then
self:skip()
local args=self:getArgs()
self:print('error',FMT.fmt('移动超时，实体将被直接转移到目标地点，dzId:{0} stId:{1}',tostring(args.dzId),args.stId))
return nodeState.success
end
return nodeState.running
end

if self.bComplete then
self.bComplete=false
return self.checkState or nodeState.inactive
end

local pos=self:getMoveToPos()
if pos then
self.checkState=nodeState.running
self.isMoving=true
local speed=self:getData('speed')or 1

local animId=self:getData('animId')

if not animId then
local name=self:getData('animName')
animId=eAnimationID[name]
end

local cfgId=self:getData('cfgId')

if not cfgId then
local flag=aiManager:getAutoToFlyFlag()
if api_Available_SetRoleMoveArgs()and flag==1 then
cfgId=8
end
end

local moveType=self:getData('moveType')
if moveType then
moveType=eAIMoveType[moveType]
end

local args=self:getArgs()

if _MapManager.IsInNullCell(args.stId)then
moveType=eAIMoveType.eFly
end

local time=cfgHelper.get2(cfg_discipleaiconfig_get,1,'move_time_out')
self.timeOut=Time.time+time

aiManager:setMoveCMDToDisciple(args.dzId,pos,speed,animId,function(isBreak,cbType)
if cbType==2 then
local posArr=_MapManager.Vector3IntToArray(pos)
self:print('error','未找到路径到达目标地点',posArr[1],posArr[2],posArr[3])
end
self.checkState=isBreak and nodeState.failure or nodeState.success
self.isMoving=false
self.bComplete=true
self:quicklyTick()
end,cfgId,moveType)
return self.checkState
else
return nodeState.failure
end
end