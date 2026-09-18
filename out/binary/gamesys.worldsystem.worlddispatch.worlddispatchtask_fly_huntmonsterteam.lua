worldDispatchTask_Fly_HuntMonsterTeam=simple_class(worldDispatchTask)
worldDispatchTask_Fly_HuntMonsterTeam.name="worldDispatchTask_Fly_HuntMonsterTeam"


function worldDispatchTask_Fly_HuntMonsterTeam:express()
self.expression={
[eWorldTripProgress.Work]=worldTripProgress_Fly_HuntMonsterTeam.New(self),
[eWorldTripProgress.Back]=worldTripProgress_FlyBack.New(self),
}
end


function worldDispatchTask_Fly_HuntMonsterTeam:init()
self.progress_state=eWorldTripProgress.Work
self.progress_begin=timeHelper.getServerShortTime()
self.progress_end=0
end