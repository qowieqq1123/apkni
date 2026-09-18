worldDispatchTask_Run_HuntMonsterTeam=simple_class(worldDispatchTask)
worldDispatchTask_Run_HuntMonsterTeam.name="worldDispatchTask_Run_HuntMonsterTeam"


function worldDispatchTask_Run_HuntMonsterTeam:express()
self.expression={
[eWorldTripProgress.Work]=worldTripProgress_Run_HuntMonsterTeam.New(self),
[eWorldTripProgress.Back]=worldTripProgress_RunBack_Fast.New(self),
}
end


function worldDispatchTask_Run_HuntMonsterTeam:init()
self.progress_state=eWorldTripProgress.Work
self.progress_begin=timeHelper.getServerShortTime()
self.progress_end=0
end

function worldDispatchTask_Run_HuntMonsterTeam:path()
local startPos={self.x/100,self.z/100}
local sPos,block=worldPositionConfig:getPosition(self.world,startPos)
local ePos=worldController:getMainCityPosition(self.world,block)
local distance=Vector3.Distance(sPos,ePos)

self.corners={sPos,ePos}
self.move_duration=distance/self.speed
self.trip_duration=worldDispatchFactory:getTripDuration(self.mode,self.move_duration,#self.disciples)
end