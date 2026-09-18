worldDispatchTask_HuntMonsterTeam=simple_class(worldDispatchTask)
worldDispatchTask_HuntMonsterTeam.name="worldDispatchTask_HuntMonsterTeam"


function worldDispatchTask_HuntMonsterTeam:express()
self.expression={
[eWorldTripProgress.Work]=worldTripProgress_Base.New(self),
[eWorldTripProgress.Back]=worldTripProgress_Empty.New(self),
}
end


function worldDispatchTask_HuntMonsterTeam:init()
self.progress_state=eWorldTripProgress.Work
self.progress_begin=timeHelper.getServerShortTime()
self.progress_end=0
end

function worldDispatchTask_HuntMonsterTeam:path()
self.corners={}
self.move_duration=0
self.trip_duration=0
end