worldTripMove_JumpShow=simple_class(worldTripMove_Base)
worldTripMove_JumpShow.name="worldTripMove_JumpShow"

local jumpDuration=worldDispatchFactory.flyJumpDuration
local animation=worldDispatchFactory.flyAnimation
local fadeEffect=worldDispatchFactory.fadeEffect

function worldTripMove_JumpShow:__init(obj,position,height,flipX,nofade,noEffect,mount,animation,mountOffset,mountSlot,duration)
self.position=position
self.height=height
self.flipX=flipX
self.duration=duration or jumpDuration
self.nofade=nofade or false
self.noEffect=noEffect or false
self.mount=mount or worldDispatchFactory.flyMount
self.animation=animation or worldDispatchFactory.flyAnimation
self.mountOffset=mountOffset or Vector3.zero
self.mountSlot=mountSlot or"root"
worldTripMove_Base.__init(self,obj)
end

function worldTripMove_JumpShow:createMoveData(overTime)

if not self.noEffect then
self.object:PlayModelEffect(fadeEffect,Vector3.zero,Vector3.one)
end
self.object:ShowShadow(false)

local cloudCfg=cfgHelper.get1(cfg_dbbodyconfig_get,self.mount)
if cloudCfg then
local cloudScale=cloudCfg.worldScales and cloudCfg.worldScales[1]or 1
self.object:ChangeModelMount(self.mount,{},self.mountSlot,cloudScale,self.mountOffset)
end

if not self.nofade then
self.object:ChangeModelColor(Color.New(1,1,1,overTime/jumpDuration),0)
self.object:ChangeModelColor(Color.New(1,1,1,1),jumpDuration-overTime)
end

local sPos=self.position
local ePos=self.position+Vector3.up*self.height
local ways={CS.WorldLineWay.New(sPos,ePos,self.flipX,self.height/self.duration,Vector3Int(0,self.animation,0))}
local path=CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)
local move=CS.WorldSingelTeam.New(self.key,{path},self.object)
move.onComplete=function(key,pass)
worldTripMove_Base.complete(self,pass-self.duration)
end
return move
end