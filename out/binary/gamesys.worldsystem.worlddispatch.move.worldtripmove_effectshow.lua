worldTripMove_EffectShow=simple_class(worldTripMove_Base)
worldTripMove_EffectShow.name="worldTripMove_EffectShow"

local runEffect=worldDispatchFactory.runEffect

function worldTripMove_EffectShow:__init(obj,position,duration,effect,show)
self.position=position
self.duration=duration
self.effect=effect
self.show=show
worldTripMove_Base.__init(self,obj)
end

function worldTripMove_EffectShow:createMoveData(overTime)


if self.show~=nil then
self.object:ChangeModelColor(self.show and Color.White or Color.clear,0)
self.object:ShowShadow(self.show)
end
self.object:StopModelEffect(runEffect)
self.object:ClearModelMount()
self.object:PlayModelEffect(self.effect,Vector3.zero,Vector3.one)

local ways={CS.WorldWaitWay.New(self.position,self.duration,Vector3Int(0,0,0))}
local path=CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)
local move=CS.WorldSingelTeam.New(self.key,{path},self.object)
move.onComplete=function(key,pass)

self.object:StopModelEffect(self.effect)
worldTripMove_Base.complete(self,pass-self.duration)
end
return move
end
