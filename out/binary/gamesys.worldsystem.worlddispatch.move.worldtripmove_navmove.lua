worldTripMove_NavMove=simple_class(worldTripMove_Base)
worldTripMove_NavMove.name="worldTripMove_NavMove"

local runEffect=worldDispatchFactory.runEffect
local runAnimation=worldDispatchFactory.runAnimation

function worldTripMove_NavMove:__init(obj,corners,speed,duration)
self.corners=corners
self.speed=speed
self.duration=duration
worldTripMove_Base.__init(self,obj)
end

function worldTripMove_NavMove:createMoveData(overTime)

self.object:ChangeModelColor(Color.white,0)
self.object:PlayModelEffect(runEffect,Vector3.zero,Vector3.one)
self.object:ShowShadow(true)

local ways={CS.WorldNavWay.New(self.corners,self.speed,Vector3Int(0,runAnimation,0))}
local path=CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)
local move=CS.WorldSingelTeam.New(self.key,{path},self.object)
move.onComplete=function(key,pass)
worldTripMove_Base.complete(self,pass-self.duration)
end
return move
end