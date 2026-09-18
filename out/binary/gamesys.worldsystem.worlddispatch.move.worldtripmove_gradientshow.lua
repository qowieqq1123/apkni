worldTripMove_GradientShow=simple_class(worldTripMove_Base)
worldTripMove_GradientShow.name="worldTripMove_GradientShow"

local gradientDuration=worldDispatchFactory.fadeDuration
local runEffect=worldDispatchFactory.runEffect
local fadeEffect=worldDispatchFactory.fadeEffect

function worldTripMove_GradientShow:__init(obj,position,show,effect)
self.position=position
self.duration=gradientDuration
self.show=show
self.effect=effect
worldTripMove_Base.__init(self,obj)
end

function worldTripMove_GradientShow:createMoveData(overTime)

if self.effect then
self.object:PlayModelEffect(fadeEffect,Vector3.zero,Vector3.one)
end
self.object:StopModelEffect(runEffect)
self.object:ShowShadow(false)
self.object:ClearModelMount()
local sColor=self.show and 0 or 1
local eColor=self.show and 1 or 0
self.object:ChangeModelColor(Color.New(1,1,1,math.abs(sColor-overTime/gradientDuration)),0)
self.object:ChangeModelColor(Color.New(1,1,1,eColor),gradientDuration-overTime)

local ways={CS.WorldWaitWay.New(self.position,self.duration,Vector3Int(0,0,0))}
local path=CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)
local move=CS.WorldSingelTeam.New(self.key,{path},self.object)
move.onComplete=function(key,pass)
worldTripMove_Base.complete(self,pass-self.duration)
end
return move
end