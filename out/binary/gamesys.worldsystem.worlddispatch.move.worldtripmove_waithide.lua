worldTripMove_WaitHide=simple_class(worldTripMove_Base)
worldTripMove_WaitHide.name="worldTripMove_WaitHide"

local waitInterval=worldDispatchFactory.runWaitInterval
local runEffect=worldDispatchFactory.runEffect

function worldTripMove_WaitHide:__init(obj,position,interval)
self.position=position
self.interval=interval
self.duration=waitInterval*self.interval
worldTripMove_Base.__init(self,obj)
end

function worldTripMove_WaitHide:createMoveData(overTime)

self.object:ChangeModelColor(Color.clear,0)
self.object:ShowShadow(false)
self.object:StopModelEffect(runEffect)
self.object:ClearModelMount()

local ways={CS.WorldWaitWay.New(self.position,self.duration,Vector3Int(0,0,0))}
local path=CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)
local move=CS.WorldSingelTeam.New(self.key,{path},self.object)
move.onComplete=function(key,pass)
worldTripMove_Base.complete(self,pass-self.duration)
end
return move
end