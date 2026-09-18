worldDispatchTask_Fly_SystemZongMen=simple_class(worldDispatchTask_Fake)
worldDispatchTask_Fly_SystemZongMen.name="worldDispatchTask_Fly_SystemZongMen"


function worldDispatchTask_Fly_SystemZongMen:express()
self.expression={
[eWorldTripProgress.Go]=worldTripProgress_FlyTo.New(self),
[eWorldTripProgress.Work]=worldTripProgress_Base.New(self),
[eWorldTripProgress.Back]=worldTripProgress_FlyBack.New(self),
}
end


function worldDispatchTask_Fly_SystemZongMen:init()
self.progress_state=eWorldTripProgress.Go
self.progress_begin=timeHelper.getServerShortTime()
self.progress_end=0
end