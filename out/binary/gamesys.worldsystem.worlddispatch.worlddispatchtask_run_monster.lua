worldDispatchTask_Run_Monster=simple_class(worldDispatchTask)
worldDispatchTask_Run_Monster.name="worldDispatchTask_Run_Monster"


function worldDispatchTask_Run_Monster:express()
self.expression={
[eWorldTripProgress.Go]=worldTripProgress_RunTo_Monster.New(self),
[eWorldTripProgress.Work]=worldTripProgress_Monster.New(self),
[eWorldTripProgress.Back]=worldTripProgress_RunBack.New(self),
}
end


function worldDispatchTask_Run_Monster:init()
self.progress_state=eWorldTripProgress.Go
self.progress_begin=timeHelper.getServerShortTime()
self.progress_end=self.progress_begin+self.trip_duration
end

function worldDispatchTask_Run_Monster:onProgressChange(cState,oState)
if oState==nil or oState<=eWorldTripProgress.Work then
if cState>=eWorldTripProgress.Back then
if self.show then

else

worldMonsterModel:remove_fighting_monster(self.target_guid)
worldMonsterModel:set_task_result(self.target_guid)
end
end
end
end