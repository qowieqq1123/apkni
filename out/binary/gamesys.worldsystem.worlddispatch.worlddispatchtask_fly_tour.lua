worldDispatchTask_Fly_Tour=simple_class(worldDispatchTask_Fake)
worldDispatchTask_Fly_Tour.name="worldDispatchTask_Fly_Tour"


function worldDispatchTask_Fly_Tour:express()
self.expression={
[eWorldTripProgress.Work]=worldTripProgress_FlyTour.New(self),
[eWorldTripProgress.Back]=worldTripProgress_Empty.New(self),
}
end


function worldDispatchTask_Fly_Tour:init()
self.progress_state=eWorldTripProgress.Work
self.progress_begin=timeHelper.getServerShortTime()
self.progress_end=0
end

function worldDispatchTask_Fly_Tour:path()
self.corners={}
self.move_duration=0
self.trip_duration=0
end