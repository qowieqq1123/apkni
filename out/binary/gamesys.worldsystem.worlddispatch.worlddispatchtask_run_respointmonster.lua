worldDispatchTask_Run_ResPointMonster=simple_class(worldDispatchTask)
worldDispatchTask_Run_ResPointMonster.name="worldDispatchTask_Run_ResPointMonster"


function worldDispatchTask_Run_ResPointMonster:express()
self.expression={
[eWorldTripProgress.Go]=worldTripProgress_RunTo_Monster.New(self),
[eWorldTripProgress.Work]=worldTripProgress_ResPointMonster.New(self),
[eWorldTripProgress.Back]=worldTripProgress_RunBack.New(self),
}
end


function worldDispatchTask_Run_ResPointMonster:init()
self.progress_state=eWorldTripProgress.Go
self.progress_begin=timeHelper.getServerShortTime()
self.progress_end=self.progress_begin+self.trip_duration
end

function worldDispatchTask_Run_ResPointMonster:onProgressChange(cState,oState)
if oState==nil or oState<=eWorldTripProgress.Work then
if cState>=eWorldTripProgress.Back then
if self.show then

else
worldResPointFightModel:clearFightResult(self.target_guid,self.target_id)
end
end
end
end