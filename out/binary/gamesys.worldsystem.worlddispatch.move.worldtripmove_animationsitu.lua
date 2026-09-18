worldTripMove_AnimationSitu=simple_class(worldTripMove_Base)
worldTripMove_AnimationSitu.name="worldTripMove_AnimationSitu"

local runEffect=worldDispatchFactory.runEffect

function worldTripMove_AnimationSitu:__init(obj,position,duration,animation)
self.position=position
self.duration=duration
self.animation=animation
worldTripMove_Base.__init(self,obj)
end

function worldTripMove_AnimationSitu:createMoveData(overTime)

self.object:ChangeModelColor(Color.white,0)
self.object:StopModelEffect(runEffect)
self.object:ShowShadow(false)
self.object:ClearModelMount()
self.object:SetAnimation(self.animation)

local ways={CS.WorldWaitWay.New(self.position,self.duration,Vector3Int(0,self.animation,0))}
local path=CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)
local move=CS.WorldSingelTeam.New(self.key,{path},self.object)
move.onComplete=function(key,pass)
worldTripMove_Base.complete(self,pass-self.duration)
end
return move
end