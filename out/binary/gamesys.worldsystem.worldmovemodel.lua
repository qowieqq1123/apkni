






local _MODULENAME="worldMoveModel"




def_table(_MODULENAME)
worldMoveModel.name=_MODULENAME

local _moves={}
local _moves_count=0

local _this=worldMoveModel


function worldMoveModel:onAppStart()

end


function worldMoveModel:onEnterState()

end


function worldMoveModel:onLeaveState()

end


function worldMoveModel:onServerDataInitFinish()

end

function worldMoveModel:convertMoveKey(taskKey,disciple)
return FMT.fmt("{0}_{1}_{2}",worldModel.UNITTYPE.MISSION,taskKey,tostring(disciple))
end

function worldMoveModel:convertResPointKey(guid)
return FMT.fmt("{0}_{1}",worldModel.UNITTYPE.RESPOINT,tostring(guid))
end

function worldMoveModel:convertAnimalKey(path)
return FMT.fmt("{0}_{1}",worldModel.UNITTYPE.ANIMAL,path)
end

function worldMoveModel:getWandarPosition(center,range,interval,position)
math.randomseed(timeHelper.getServerShortTime()+center.x+center.z)
local ox=(position.x-center.x)/interval
local oy=(position.z-center.z)/interval
while range>0 do
local x=math.random(-range,range)
local y=math.random(-range,range)
if not((x==0 and y==0)or(x==ox and y==oy))then
local nx=center.x+x*interval
local ny=center.z+y*interval
local nv={nx,ny}
if worldPositionConfig:getPosition_CurrentWorld(nv,true)then
return mathHelper.convertArrayToVector(nv)
end
end
end
end

function worldMoveModel:wanderGuardianMove(unitKey,moveKey,center,range,interval,simple)

math.randomseed(timeHelper.getServerShortTime())
local obj=worldController:getUnit(unitKey)
local startPos=Vector2.New(obj.Position.x,obj.Position.z)
local endPos=self:getWandarPosition(center,range,interval,obj.Position)
local corners=worldController:calculateNavPathXX({obj.Position.x,obj.Position.z},{endPos.x,endPos.y})
local ways={}
local wanderTime=2
local waitTime=math.random(1,5)
if corners then
table.insert(ways,CS.WorldNavWay.New(corners,wanderTime,Vector3Int(0,11,0)))
table.insert(ways,CS.WorldWaitWay.New(corners[corners.Length-1],waitTime,Vector3Int(0,0,0)))
else
table.insert(ways,CS.WorldWaitWay.New(obj.Position,waitTime,Vector3Int(0,0,0)))
end
local path=CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)
local move=CS.WorldLineTeam.New(moveKey,{path},{obj},0)
move.onComplete=function(key,pass)
worldController:popMove(moveKey)
if not simple then
self:wanderGuardianMove(unitKey,moveKey,center,range,interval,simple)
end
end
worldController:pushMove(move)
end

function worldMoveModel:stopGuardianMove(unitKey,moveKey,center)
local obj=worldController:getUnit(unitKey)
worldController:popMove(moveKey)

local startPos=Vector2.New(obj.Position.x,obj.Position.z)
local endPos=center

worldController:popMove(moveKey)

if endPos~=startPos then
local corners=worldController:calculateNavPathXX({startPos.x,startPos.y},{endPos.x,endPos.y})
local ways={}
table.insert(ways,CS.WorldNavWay.New(corners,1,Vector3Int(0,11,0)))
local path=CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)
local move=CS.WorldLineTeam.New(moveKey,{path},{obj},0)
move.onComplete=function(key,pass)
worldController:popMove(moveKey)
end
worldController:pushMove(move)
end
end