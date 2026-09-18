worldDispatchTask_Run_SystemZongMen=simple_class(worldDispatchTask_Fake)
worldDispatchTask_Run_SystemZongMen.name="worldDispatchTask_Run_SystemZongMen"


function worldDispatchTask_Run_SystemZongMen:express()
self.expression={
[eWorldTripProgress.Go]=worldTripProgress_RunTo.New(self),
[eWorldTripProgress.Work]=worldTripProgress_Base.New(self),
[eWorldTripProgress.Back]=worldTripProgress_RunBack.New(self),
}
end


function worldDispatchTask_Run_SystemZongMen:init()
self.progress_state=eWorldTripProgress.Go
self.progress_begin=timeHelper.getServerShortTime()
self.progress_end=0
end