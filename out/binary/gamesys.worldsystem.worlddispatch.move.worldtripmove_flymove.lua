worldTripMove_FlyMove=simple_class(worldTripMove_Base)
worldTripMove_FlyMove.name="worldTripMove_FlyMove"





function worldTripMove_FlyMove:__init(obj,corners,speed,duration,flyHeight,horizontal,cloudHigher,mount,animation,mountOffset,mountSlot)
self.corners=corners
self.speed=speed
self.duration=duration
self.flyHeight=flyHeight
self.horizontal=horizontal
self.cloudHigher=cloudHigher
self.mount=mount or worldDispatchFactory.flyMount
self.animation=animation or worldDispatchFactory.flyAnimation
self.mountOffset=mountOffset or Vector3.zero
self.mountSlot=mountSlot or"root"
worldTripMove_Base.__init(self,obj)
end

function worldTripMove_FlyMove:createMoveData(overTime)

self.object:ChangeModelColor(Color.white,0)
self.object:ShowShadow(false)


local cloudCfg=cfgHelper.get1(cfg_dbbodyconfig_get,self.mount)
if cloudCfg then
local cloudScale=cloudCfg.worldScales and cloudCfg.worldScales[1]or 1
self.object:ChangeModelMount(self.mount,{},self.mountSlot,cloudScale,self.mountOffset)
end



local ways={CS.WorldFlyWay.New(self.corners,self.speed,self.flyHeight,self.horizontal,self.cloudHigher,Vector3Int(0,self.animation,0))}
local path=CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)
local move=CS.WorldSingelTeam.New(self.key,{path},self.object)
move.onComplete=function(key,pass)
worldTripMove_Base.complete(self,pass-self.duration)
end
return move
end