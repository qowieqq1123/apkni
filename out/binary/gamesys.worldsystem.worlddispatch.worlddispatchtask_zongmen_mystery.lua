worldDispatchTask_ZongMen_Mystery=simple_class(worldDispatchTask)
worldDispatchTask_ZongMen_Mystery.name="worldDispatchTask_ZongMen_Mystery"


function worldDispatchTask_ZongMen_Mystery:express()
self.expression={
[eWorldTripProgress.Work]=worldTripProgress_Mystery.New(self),
[eWorldTripProgress.Back]=worldTripProgress_Empty.New(self),
}
end


function worldDispatchTask_ZongMen_Mystery:init()
self.progress_state=eWorldTripProgress.Work
self.progress_begin=timeHelper.getServerShortTime()
self.progress_end=0
end

function worldDispatchTask_ZongMen_Mystery:path()
self.corners={}
self.move_duration=0
self.trip_duration=0
end